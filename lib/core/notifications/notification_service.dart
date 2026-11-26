import '../storage/local_storage.dart';
import '../../features/auth/data/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import '../routing/app_router.dart';
import '../storage/storage_keys.dart';

class NotificationService {
  NotificationService._();
  String? _pendingRoute;

  String? get pendingRoute => _pendingRoute;

  void clearPendingRoute() {
    _pendingRoute = null;
  }
  static final NotificationService instance = NotificationService._();

  final FlutterLocalNotificationsPlugin _notifications =
  FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    // Initialize timezone database.
    tz.initializeTimeZones();

    // Get the device's actual timezone.
    final timezoneName = await FlutterTimezone.getLocalTimezone();

    tz.setLocalLocation(
      tz.getLocation(timezoneName),
    );
    debugPrint('Device timezone: ${timezoneName}');


    // Initialize Android notifications.
    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );

    const settings = InitializationSettings(
      android: androidSettings,
    );

    await _notifications.initialize(
      settings,
      onDidReceiveNotificationResponse: _onNotificationTapped,
    );
    final launchDetails =
    await _notifications.getNotificationAppLaunchDetails();

    if (launchDetails?.didNotificationLaunchApp ?? false) {
      _pendingRoute = launchDetails?.notificationResponse?.payload;

      debugPrint('Notification launch route: $_pendingRoute');
    }
  }
  String? takePendingRoute() {
    final route = _pendingRoute;
    _pendingRoute = null;

    if (!_isAllowedRoute(route)) return null;

    return route;
  }
  void _onNotificationTapped(NotificationResponse response) {
    final route = response.payload;

    if (!_isAllowedRoute(route)) return;

    if (!LocalStorage.instance.onboardingSeen) {
      AppRouter.router.go('/onboarding');
      return;
    }

    if (!AuthRepository.instance.isLoggedIn) {
      AppRouter.router.go('/login');
      return;
    }

    if (AuthRepository.instance.isPasswordResetPending) {
      AppRouter.router.go('/reset-password');
      return;
    }

    AppRouter.router.go(route!);
  }
  bool _isAllowedRoute(String? route) {
    const allowedRoutes = {
      '/home',
      '/home/scenarios',
      '/add-situation',
      '/journey',
      '/journey/reflections',
      '/insights',
      '/insights/growth',
    };

    return allowedRoutes.contains(route);
  }

  Future<bool> showTestNotification() async {
    // Request notification permission on Android 13+.
    final androidPlugin = _notifications
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();

    final granted =
    await androidPlugin?.requestNotificationsPermission();

    if (granted == false) {
      debugPrint('Notification permission denied.');
      return false;
    }

    const androidDetails = AndroidNotificationDetails(
      'you_notifications',
      'YOU Notifications',
      channelDescription: 'Personal growth reminders from YOU',
      importance: Importance.max,
      priority: Priority.high,
    );

    const details = NotificationDetails(
      android: androidDetails,
    );

    await _notifications.show(
      900001,
      'A little moment for yourself 🌱',
      'Take a moment to reflect on your day.',
      details,
      payload: '/journey/reflections',
    );

    debugPrint('Test notification sent.');

    return true;
  }

  Future<void> scheduleDailyReminder() async {
    final now = tz.TZDateTime.now(tz.local);

    final reflectionTime =
        LocalStorage.instance.getString(StorageKeys.reflectionTime) ??
            'anytime';

    final hour = reflectionTime == 'evening' ? 20 : 9;
    final minute = reflectionTime == 'evening' ? 27 : 0;

    var scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );

    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    const androidDetails = AndroidNotificationDetails(
      'you_notifications',
      'YOU Notifications',
      channelDescription: 'Personal growth reminders from YOU',
      importance: Importance.max,
      priority: Priority.high,
    );

    const details = NotificationDetails(android: androidDetails);

    await _notifications.zonedSchedule(
      900010,
      'Your daily moment 🌱',
      'Take a moment to reflect on your day.',
      scheduledDate,
      details,
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
      payload: '/journey/reflections',
    );

    // Check AFTER scheduling.
    final pending = await _notifications.pendingNotificationRequests();

    debugPrint('Current time: $now');
    debugPrint('Scheduled date: $scheduledDate');
    debugPrint('Pending count: ${pending.length}');

    for (final notification in pending) {
      debugPrint('Pending ID: ${notification.id}');
    }
  }

  Future<void> cancelDailyReminder() async {
    await _notifications.cancel(900010);
    debugPrint('Daily reminder cancelled.');
  }
  Future<void> scheduleMotivationalReminder() async {
    final now = tz.TZDateTime.now(tz.local);

    var scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      20,23,
    );
    final pending = await _notifications.pendingNotificationRequests();

    debugPrint('Scheduled date: $scheduledDate');
    debugPrint('Pending notifications: ${pending.map((e) => '${e.id}: ${e.title}').toList()}');
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    const androidDetails = AndroidNotificationDetails(
      'you_motivation',
      'Motivational Reminders',
      channelDescription: 'Daily motivational messages from YOU',
      importance: Importance.max,
      priority: Priority.high,
    );

    const details = NotificationDetails(android: androidDetails);

    await _notifications.zonedSchedule(
      900020,
      'A reminder for you ✨',
      'Small steps still move you forward. Keep going!',
      scheduledDate,
      details,
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
      payload: '/journey',
    );
  }

  Future<void> cancelMotivationalReminder() async {
    await _notifications.cancel(900020);
  }
  Future<void> scheduleHabitReminder() async {
    final now = tz.TZDateTime.now(tz.local);

    var scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      20,
    );

    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    const androidDetails = AndroidNotificationDetails(
      'you_habit',
      'Habit Reminders',
      channelDescription: 'Daily habit reminders from YOU',
      importance: Importance.max,
      priority: Priority.high,
    );

    const details = NotificationDetails(android: androidDetails);

    await _notifications.zonedSchedule(
      900030,
      'Your habits matter 🌱',
      'Have you taken a small step toward your goals today?',
      scheduledDate,
      details,
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
      payload: '/journey',
    );
  }

  Future<void> cancelHabitReminder() async {
    await _notifications.cancel(900030);
  }
  Future<void> scheduleWeeklySummary() async {
    final now = tz.TZDateTime.now(tz.local);

    var scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      19,
    );

    // Find the next Sunday.
    var daysUntilSunday = DateTime.sunday - now.weekday;

    if (daysUntilSunday < 0 ||
        (daysUntilSunday == 0 && !scheduledDate.isAfter(now))) {
      daysUntilSunday += 7;
    }

    scheduledDate = scheduledDate.add(
      Duration(days: daysUntilSunday),
    );

    const androidDetails = AndroidNotificationDetails(
      'you_weekly_summary',
      'Weekly Summary',
      channelDescription: 'Weekly progress summaries from YOU',
      importance: Importance.max,
      priority: Priority.high,
    );

    const details = NotificationDetails(android: androidDetails);

    await _notifications.zonedSchedule(
      900040,
      'Your weekly reflection 🌱',
      'Take a moment to look back at your progress this week.',
      scheduledDate,
      details,
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
      payload: '/insights/growth',
    );

    debugPrint('Weekly summary scheduled for Sunday at 7:00 PM.');
  }

  Future<void> cancelWeeklySummary() async {
    await _notifications.cancel(900040);
  }
}

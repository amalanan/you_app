import 'package:flutter/material.dart' hide Text;

import '../../../core/l10n/text.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/helpers/extensions.dart';
import '../../../core/storage/local_storage.dart';
import '../../../core/storage/storage_keys.dart';
import '../../../core/widgets/sub_page.dart';
import '../../../core/notifications/notification_service.dart';

/// On/off switches. Saved on the device; real push notifications come later.
class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  static const _items = [
    (StorageKeys.notifDaily, AppStrings.notifDaily),
    (StorageKeys.notifMotivation, AppStrings.notifMotivation),
    (StorageKeys.notifHabit, AppStrings.notifHabit),
    (StorageKeys.notifWeekly, AppStrings.notifWeekly),
    (StorageKeys.notifNewFeatures, AppStrings.notifNewFeatures),
  ];

  late final Map<String, bool> _values = {
    for (final (key, _) in _items) key: LocalStorage.instance.getBool(key),
  };

  // void _toggle(String key, bool value) {
  //   setState(() => _values[key] = value);
  //   LocalStorage.instance.setBool(key, value);
  //   // TODO: schedule / cancel the real notifications.
  // }
  Future<void> _toggle(String key, bool value) async {
    setState(() => _values[key] = value);
    await LocalStorage.instance.setBool(key, value);

    if (key == StorageKeys.notifDaily) {
      if (value) {
        await NotificationService.instance.scheduleDailyReminder();
      } else {
        await NotificationService.instance.cancelDailyReminder();
      }
    }
    if (key == StorageKeys.notifMotivation) {
      if (value) {
        await NotificationService.instance
            .scheduleMotivationalReminder();
      } else {
        await NotificationService.instance
            .cancelMotivationalReminder();
      }
    }
    if (key == StorageKeys.notifHabit) {
      if (value) {
        await NotificationService.instance.scheduleHabitReminder();
      } else {
        await NotificationService.instance.cancelHabitReminder();
      }
    }
    if (key == StorageKeys.notifWeekly) {
      if (value) {
        await NotificationService.instance.scheduleWeeklySummary();
      } else {
        await NotificationService.instance.cancelWeeklySummary();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SubPage(
      title: AppStrings.menuNotifications,
      child: Column(
        children: [
          for (final (key, label) in _items) ...[
            Row(
              children: [
                Expanded(
                  child: Text(
                    label,
                    style: context.text.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Switch(value: _values[key]!, onChanged: (v) => _toggle(key, v)),
              ],
            ),
            Divider(height: 1, color: context.borderColor),
          ],
          // const SizedBox(height: 24),
          //
          // OutlinedButton.icon(
          //   onPressed: () async {
          //     final success = await NotificationService.instance
          //         .showTestNotification();
          //
          //     if (!mounted) return;
          //
          //     ScaffoldMessenger.of(context).showSnackBar(
          //       SnackBar(
          //         content: Text(
          //           success
          //               ? 'Test notification sent!'
          //               : 'Notification permission denied.',
          //         ),
          //       ),
          //     );
          //   },
          //   icon: const Icon(Icons.notifications_active_outlined),
          //   label: const Text('Test Notification'),
          // ),
        ],
      ),
    );
  }
}

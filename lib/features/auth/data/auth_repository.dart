/// What the app needs from "auth". The UI only talks to this class,
/// so Firebase can be swapped for another backend without touching screens.
abstract class AuthRepository {
  /// Set once in main(): AuthRepository.instance = FirebaseAuthRepository();
  static late AuthRepository instance;

  bool get isLoggedIn;
  String? get currentName;
  String? get currentEmail;

  /// When the account was created (null if unknown).
  DateTime? get memberSince;

  Future<void> signIn({required String email, required String password});

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  });

  /// Sends the confirmation email (with the link) again.
  Future<void> resendConfirmationEmail(String email);

  Future<void> signInWithGoogle();

  Future<void> sendPasswordReset(String email);

  Future<void> signOut();

  /// Removes the account and its saved data, then signs out.
  Future<void> deleteAccount();
}

/// Which day of the journey it is: 1 on the day the account was made, then 2, 3...
/// Same rule as the server (UTC dates), so Home, Journey and Profile always agree.
int journeyDayFrom(DateTime? memberSince) {
  if (memberSince == null) return 1;
  final start = memberSince.toUtc();
  final now = DateTime.now().toUtc();
  final days = DateTime.utc(now.year, now.month, now.day)
      .difference(DateTime.utc(start.year, start.month, start.day))
      .inDays;
  return days < 0 ? 1 : days + 1;
}

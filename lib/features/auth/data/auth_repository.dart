/// What the app needs from "auth". The UI only talks to this class,
/// so Firebase can be swapped for another backend without touching screens.
abstract class AuthRepository {
  /// Set once in main(): AuthRepository.instance = FirebaseAuthRepository();
  static late AuthRepository instance;

  bool get isLoggedIn;
  String? get currentName;
  String? get currentEmail;

  Future<void> signIn({required String email, required String password});

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  });

  Future<void> signInWithGoogle();

  Future<void> sendPasswordReset(String email);

  Future<void> signOut();
}

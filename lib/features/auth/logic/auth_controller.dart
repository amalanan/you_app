import 'package:flutter/foundation.dart';

import '../../../core/errors/error_handler.dart';
import '../../../core/errors/exceptions.dart';
import '../../../core/errors/failures.dart';
import '../data/auth_repository.dart';

/// Loading + error state for the login / sign-up screens.
/// Every action returns true on success. On failure, read [errorMessage]
/// (null when the user just cancelled, e.g. closed the Google sheet).
class AuthController extends ChangeNotifier {
  AuthController(this._repo);

  final AuthRepository _repo;

  bool _isLoading = false;
  String? _errorMessage;
  bool _disposed = false;
  String? _pendingEmail;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  /// Set after signUp / signIn when the email still has to be confirmed (she must
  /// tap the link we emailed): the screen then opens "Check your email".
  String? get pendingEmail => _pendingEmail;

  Future<bool> signIn({required String email, required String password}) =>
      _run(() => _repo.signIn(email: email, password: password));

  Future<bool> signUp({
    required String name,
    required String email,
    required String password,
  }) =>
      _run(() => _repo.signUp(name: name, email: email, password: password));

  Future<bool> updatePassword(String newPassword) =>
      _run(() => _repo.updatePassword(newPassword));

  Future<bool> resendConfirmationEmail(String email) =>
      _run(() => _repo.resendConfirmationEmail(email));

  Future<bool> signInWithGoogle() => _run(_repo.signInWithGoogle);

  Future<bool> sendPasswordReset(String email) =>
      _run(() => _repo.sendPasswordReset(email));

  Future<bool> _run(Future<void> Function() action) async {
    _isLoading = true;
    _errorMessage = null;
    _pendingEmail = null;
    _notify();
    try {
      await action();
      _isLoading = false;
      _notify();
      return true;
    } on EmailNotConfirmedException catch (e) {
      // not an error: the next step is opening the email
      _pendingEmail = e.email;
      _isLoading = false;
      _notify();
      return true;
    } catch (e) {
      final failure = ErrorHandler.handle(e);
      _isLoading = false;
      _errorMessage =
      (failure is AuthFailure && failure.cancelled) ? null : failure.message;
      _notify();
      return false;
    }
  }

  void _notify() {
    if (!_disposed) notifyListeners();
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }
}

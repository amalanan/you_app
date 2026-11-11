import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as sb;

import '../../../core/routing/app_routes.dart';
import '../data/auth_repository.dart';

/// Links in emails open the app and Supabase signs her in:
///  - confirmation email  -> Home
///  - "forgot password" email -> the Reset password screen
/// (If the app was closed, the splash screen makes the same decision.)
void listenForEmailLinkSignIn(GoRouter router) {
  sb.Supabase.instance.client.auth.onAuthStateChange.listen((data) {
    final path = router.routeInformationProvider.value.uri.path;

    // the reset link: Supabase says "password recovery" (or just "signed in",
    // in which case we know it from her request a moment ago)
    final isRecovery = data.event == sb.AuthChangeEvent.passwordRecovery ||
        (data.event == sb.AuthChangeEvent.signedIn &&
            AuthRepository.instance.isPasswordResetPending);
    if (isRecovery) {
      if (path != AppRoutes.resetPassword) router.go(AppRoutes.resetPassword);
      return;
    }

    if (data.event != sb.AuthChangeEvent.signedIn) return;
    const waiting = {AppRoutes.login, AppRoutes.signUp, AppRoutes.checkEmail};
    if (waiting.contains(path)) router.go(AppRoutes.home);
  });
}

import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as sb;

import '../../../core/routing/app_routes.dart';

/// She taps the confirmation link in her email -> the phone opens the app with a
/// deep link -> Supabase signs her in -> this sends her straight to Home.
///
/// (If the app was closed, the splash screen already sends a signed-in user to Home.)
void listenForEmailLinkSignIn(GoRouter router) {
  sb.Supabase.instance.client.auth.onAuthStateChange.listen((data) {
    if (data.event != sb.AuthChangeEvent.signedIn) return;

    final path = router.routeInformationProvider.value.uri.path;
    const waiting = {AppRoutes.login, AppRoutes.signUp, AppRoutes.checkEmail};
    if (waiting.contains(path)) router.go(AppRoutes.home);
  });
}

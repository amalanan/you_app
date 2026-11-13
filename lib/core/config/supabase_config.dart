// /// Supabase dashboard > Project Settings > API.
// ///
// /// The URL and the "anon" key are PUBLIC by design (they are safe inside the app,
// /// the database is protected by the security rules in schema.sql).
// /// NEVER put the "service_role" key here or anywhere in the app.
// abstract final class SupabaseConfig {
//   static const url = 'https://YOUR-PROJECT-ID.supabase.co';
//   static const anonKey = 'YOUR-ANON-KEY';
//
//   /// While the two values above are not filled, the app keeps using the
//   /// device-only accounts (LocalAuthRepository), so nothing breaks.
//   static bool get isConfigured =>
//       !url.contains('YOUR-') && !anonKey.contains('YOUR-');
// }

abstract final class SupabaseConfig {
  static const url = 'https://mtyoxjfznlhqawvgolgj.supabase.co';

  static const anonKey = 'sb_publishable_5sLZSMrmJU15ADa8o2Fxog_0M3sxkc5';
  static const authRedirectUrl = 'youapp://login-callback/';

  static bool get isConfigured =>
      !url.contains('YOUR-') && !anonKey.contains('YOUR-');
}

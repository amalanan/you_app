/// Thrown by the data layer (API / storage). Converted to Failures before the UI.
class ServerException implements Exception {
  const ServerException([this.message = '', this.statusCode]);
  final String message;
  final int? statusCode;
}

class NetworkException implements Exception {
  const NetworkException();
}

class CacheException implements Exception {
  const CacheException([this.message = '']);
  final String message;
}

/// Thrown by an AuthRepository. [message] is already user-friendly.
/// [cancelled] = the user closed the sign-in sheet (not an error to show).
class AuthException implements Exception {
  const AuthException(this.message, {this.cancelled = false});
  final String message;
  final bool cancelled;
}

import 'package:dio/dio.dart';

import 'exceptions.dart';
import 'failures.dart';

abstract final class ErrorHandler {
  /// Turn anything thrown into a [Failure].
  static Failure handle(Object error) {
    if (error is DioException) return _fromDio(error);
    if (error is AuthException) {
      return AuthFailure(error.message, cancelled: error.cancelled);
    }
    if (error is NetworkException) return const NetworkFailure();
    if (error is ServerException) {
      return ServerFailure(
        error.message.isEmpty ? null : error.message,
        error.statusCode,
      );
    }
    if (error is CacheException) return const CacheFailure();
    return const UnknownFailure();
  }

  static Failure _fromDio(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionError:
        return const NetworkFailure();
      case DioExceptionType.badResponse:
        return ServerFailure(e.response?.statusMessage, e.response?.statusCode);
      default:
        return const UnknownFailure();
    }
  }
}

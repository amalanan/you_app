import '../constants/app_strings.dart';

/// What the UI sees: a safe, displayable error.
sealed class Failure {
  const Failure(this.message);
  final String message;
}

class NetworkFailure extends Failure {
  const NetworkFailure() : super(AppStrings.networkError);
}

class ServerFailure extends Failure {
  const ServerFailure([String? message, this.statusCode])
      : super(message ?? AppStrings.serverError);
  final int? statusCode;
}

class CacheFailure extends Failure {
  const CacheFailure() : super(AppStrings.unknownError);
}

class UnknownFailure extends Failure {
  const UnknownFailure() : super(AppStrings.unknownError);
}

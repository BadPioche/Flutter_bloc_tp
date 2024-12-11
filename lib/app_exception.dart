class AppException implements Exception {
  static AppException from(dynamic exception) {
    if (exception is AppException) return exception;
    return UnknownException();
  }
}

class UnknownException extends AppException {}

class NotImplementedException extends AppException {}

class ApiException extends AppException {
final Object error;

ApiException({required this.error});
}

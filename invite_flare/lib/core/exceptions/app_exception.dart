// Base Exception
abstract class AppException implements Exception {
  final String message;
  final String prefix;

  AppException(this.message, this.prefix);

  @override
  String toString() => '$prefix $message';
}

// Client-side Exceptions
class ClientException extends AppException {
  ClientException([String message = 'Invalid request']) : super(message, '');
}

// Client-side Exceptions
class NetworkException extends AppException {
  NetworkException([String message = 'No Internet Connection'])
      : super(message, 'Network Error');
}

class TimeoutException extends AppException {
  TimeoutException([String message = 'Request Timed Out'])
      : super(message, 'Timeout Error');
}

// Server-side Exceptions
class BadRequestException extends AppException {
  BadRequestException([String message = 'Invalid Request'])
      : super(message, 'Bad Request');
}

class UnauthorizedException extends AppException {
  UnauthorizedException([String message = 'Unauthorized Access'])
      : super(message, 'Unauthorized');
}

class InternalServerException extends AppException {
  InternalServerException([String message = 'Server Error'])
      : super(message, '');
}

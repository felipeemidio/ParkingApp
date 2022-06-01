import 'dart:core';

class ParkingException implements Exception {
  final String message;
  final dynamic error;
  final StackTrace? stackTrace;

  ParkingException(this.message, {this.error, this.stackTrace});

  @override
  String toString() {
    return '$runtimeType - $message \n${stackTrace?.toString()}';
  }
}

class DatasourceException extends ParkingException {
  DatasourceException(
    String message, {dynamic error, StackTrace? stackTrace}
  ) : super(message, error: error, stackTrace: stackTrace);
}

class RepositoryException extends ParkingException {
  RepositoryException(
      String message, {dynamic error, StackTrace? stackTrace}
      ) : super(message, error: error, stackTrace: stackTrace);
}

class UsecaseException extends ParkingException {
  UsecaseException(
      String message, {dynamic error, StackTrace? stackTrace}
      ) : super(message, error: error, stackTrace: stackTrace);
}

class CubitException extends ParkingException {
  CubitException(
      String message, {dynamic error, StackTrace? stackTrace}
      ) : super(message, error: error, stackTrace: stackTrace);
}
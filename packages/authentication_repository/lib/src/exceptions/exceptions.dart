import 'package:equatable/equatable.dart';

class ApiException extends Equatable implements Exception {
  const ApiException({required this.errorMessage, this.statusCode = null});
  final String errorMessage;
  final int? statusCode;

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [errorMessage, statusCode];
}

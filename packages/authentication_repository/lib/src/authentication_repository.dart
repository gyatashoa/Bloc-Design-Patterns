import 'dart:async';

import 'package:authentication_repository/src/exceptions/exceptions.dart';
import 'package:authentication_repository/src/models/token.dart';
import 'package:authentication_repository/src/services/authentication_service.dart';
import 'package:authentication_repository/src/typedef/typedefs.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationRepository {
  AuthenticationRepository({required AuthenticationService service})
      : _authenticationService = service;

  final AuthenticationService _authenticationService;

  Future<ApiResponse> login(
      {required String email, required String password}) async {
    var response =
        await _authenticationService.login(email: email, password: password);

    if (response is String) {
      return (null, ApiException(errorMessage: response));
    }

    return (response as Token, null);
  }

  Future<ApiResponse> logout() async {
    var response = await _authenticationService.logout();

    if (response is String) {
      return (null, ApiException(errorMessage: response));
    }

    return (null, null);
  }

  void close() {}
}

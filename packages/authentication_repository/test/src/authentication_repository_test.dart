import 'package:authentication_repository/authentication_repository.dart';
import 'package:authentication_repository/src/exceptions/exceptions.dart';
import 'package:authentication_repository/src/models/token.dart';
import 'package:authentication_repository/src/services/authentication_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class AuthenticationServiceMock extends Mock implements AuthenticationService {}

void main() {
  group('----- Authentication Respository Class Test---------', () {
    late AuthenticationRepository authenticationRepository;
    late AuthenticationService authenticationService;
    late Token token;
    String email = 'email@gmail.com';
    String password = 'password';
    setUpAll(() {
      authenticationService = AuthenticationServiceMock();
      authenticationRepository =
          AuthenticationRepository(service: authenticationService);

      token = Token(accessToken: 'accessToken', refreshToken: 'refreshToken');
    });

    test('test if user login is successfull with right credentials', () async {
      when(() => authenticationService.login(email: email, password: password))
          .thenAnswer((_) async => token);
      var response = await authenticationRepository.login(
          email: email, password: password);
      expect(response, (token, null));

      verify(() =>
              authenticationService.login(email: email, password: password))
          .called(1);
    });

    test('test if user login is unsuccessfull with wrong credentials',
        () async {
      when(() => authenticationService.login(email: '', password: ''))
          .thenAnswer((_) async => ('Invalid credentials'));
      var response =
          await authenticationRepository.login(email: '', password: '');
      expect(
          response, (null, ApiException(errorMessage: 'Invalid credentials')));

      verify(() => authenticationService.login(email: '', password: ''))
          .called(1);
    });

    test('test if user logout is successfull', () async {
      when(() => authenticationService.logout()).thenAnswer((_) async => null);
      var response = await authenticationRepository.logout();
      expect(response, (null, null));

      verify(() => authenticationService.logout()).called(1);
    });

    test('test if user logout is unsuccessfull', () async {
      when(() => authenticationService.logout())
          .thenAnswer((_) async => 'Logout unsuccessfull');
      var response = await authenticationRepository.logout();
      expect(
          response, (null, ApiException(errorMessage: 'Logout unsuccessfull')));

      verify(() => authenticationService.logout()).called(1);
    });

    test(
        'test if authentication repository throw Exception when service class returns an invalid type',
        () async {
      when(() => authenticationService.login(email: email, password: password))
          .thenAnswer((_) async => 1);

      expect(
          () async => await authenticationRepository.login(
              email: email, password: password),
          throwsA(isA<TypeError>()));
      verify(() =>
              authenticationService.login(email: email, password: password))
          .called(1);
    });

    tearDownAll(() {
      authenticationRepository.close();
    });
  });
}

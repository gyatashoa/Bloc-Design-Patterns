abstract class AuthenticationService {
  Future login({
    required String email,
    required String password,
  });
  Future logout();
  Future refreshToken({
    required String token,
  });
}

class ApiEndPoints{
  static const String BASE_URL = "http://test.uyjoybaraka.uz/api/";
  static _AuthEndPoints authEndPoints = _AuthEndPoints();
}

class _AuthEndPoints {
  final String register = "users/signup";
  final String login = "users/login";
  final String phoneCheck = "users/send-code";
  final String checkCode = "users/validate-code";
  final String resetPassword = "users/edit-password";
}
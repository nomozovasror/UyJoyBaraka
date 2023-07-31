class ApiEndPoints{
  static const String BASE_URL = "https://test.uyjoybaraka.uz";
  static _AuthEndPoints authEndPoints = _AuthEndPoints();
}

class _AuthEndPoints {
  final String register = "/api/users/signup";
  final String login = "/api/users/login";
  final String phoneCheck = "/api/users/send-code";
  final String checkCode = "/api/users/validate-code";
  final String resetPassword = "/api/users/edit-password";
  final String home = "/api/home";
  final String slugCall = "/api/posts/";
  final String createPost = "/api/announcements/create";
  final String viewCounter = "/api/posts/view/";
  final String likeCounter = "/api/announcements/";
  final String getLikedPosts = "/api/announcements/liked";
}
// ignore_for_file: library_private_types_in_public_api, constant_identifier_names

class ApiEndPoints{
  static const String BASE_URL = "https://api.uyjoybaraka.uz";
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
  final String search = "/api/search";
  final String userData = "/api/users/profile";
  final String editUserName = "/api/users/edit-full-name";
  final String editUserPhone = "/api/users/edit-phone";
  final String checkPhone = "/api/users/check-phone";

  final String editUserAvatar = "/api/users/avatar";

  final String activePost = "/api/announcements/active";
  final String inactivePost = "/api/announcements/inactive";
  final String activePatch = "/api/announcements/activation/";
  final String deletePost = "/api/announcements/delete/";
  final String updatePost = "/api/announcements/update/";
  final String getChats = "/api/chats";
  final String getAdvert = "/ads/app";

  final String telegramBotUrl = "https://t.me/uyjoybarakauz_bot";
  final String phone = "tel:+998992435577";
}
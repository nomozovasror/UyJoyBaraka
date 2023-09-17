import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LocalizationController extends GetxController {
  final _selectedLanguage = ''.obs;
  String get selectedLanguage => _selectedLanguage.value;

  set selectedLanguage(String language) {
    _selectedLanguage.value = language;
    GetStorage().write('selectedLanguage', language);
  }

  void initSelectedLanguage() {
    _selectedLanguage.value = GetStorage().read('selectedLanguage') ?? 'uz'; // Default language: English
  }
}

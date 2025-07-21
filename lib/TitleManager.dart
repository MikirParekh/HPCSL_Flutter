import 'SharedPreference.dart';

class TitleManager {
  static Future<String> getTitle() async {
    final title = await StorageManager.readData('TitleName');
    return title?.toString() ?? 'AIA ENGINEERING LTD';
  }
}

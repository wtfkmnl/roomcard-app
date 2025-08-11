import 'package:shared_preferences/shared_preferences.dart';

/// 存储key
class StorageKey{
  ///用户id
  static const String userId="userId";
  ///弹框公告数据list
  static const String popGameNotice="popGameNotice";

}

///存储相关
class StorageUtil {
  static late SharedPreferences _prefs;

  // 初始化（必须在 main() 中调用）
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // 存储数据
  static Future<bool> setString(String key, String value) =>
      _prefs.setString(key, value);
  static Future<bool> setStringList(String key, List<String> value) =>
      _prefs.setStringList(key, value);
  static Future<bool> setInt(String key, int value) =>
      _prefs.setInt(key, value);
  static Future<bool> setBool(String key, bool value) =>
      _prefs.setBool(key, value);

  // 读取数据
  static String getString(String key, [String defaultValue = '']) =>
      _prefs.getString(key) ?? defaultValue;
  static int getInt(String key, [int defaultValue = 0]) =>
      _prefs.getInt(key) ?? defaultValue;
  static bool getBool(String key, [bool defaultValue = false]) =>
      _prefs.getBool(key) ?? defaultValue;
  static List<String> getStringList(String key) =>
      _prefs.getStringList(key) ?? [];

  // 删除数据
  static Future<bool> remove(String key) => _prefs.remove(key);

  // 删除prefs
  static Future<bool> clear() => _prefs.clear();




}

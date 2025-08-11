import 'package:pub_semver/pub_semver.dart';

class VersionUtil {
  /// 判断当前版本是否大于目标版本
  static bool isVersionGreaterThan(String current, String target) {
    try {
      final currentVersion = Version.parse(_normalize(current));
      final targetVersion = Version.parse(_normalize(target));
      return currentVersion > targetVersion;
    } catch (e) {
      print('Version parse error: $e');
      return false;
    }
  }

  /// 判断当前版本是否等于目标版本
  static bool isVersionEqual(String current, String target) {
    try {
      final currentVersion = Version.parse(_normalize(current));
      final targetVersion = Version.parse(_normalize(target));
      return currentVersion == targetVersion;
    } catch (e) {
      print('Version parse error: $e');
      return false;
    }
  }

  /// 判断当前版本是否小于目标版本
  static bool isVersionLessThan(String current, String target) {
    try {
      final currentVersion = Version.parse(_normalize(current));
      final targetVersion = Version.parse(_normalize(target));
      return currentVersion < targetVersion;
    } catch (e) {
      print('Version parse error: $e');
      return false;
    }
  }

  /// 补全不规范的版本字符串（如只写了 3.2 → 3.2.0）
  static String _normalize(String version) {
    final segments = version.split('.');
    while (segments.length < 3) {
      segments.add('0');
    }
    return segments.take(3).join('.');
  }
}

import 'package:url_launcher/url_launcher.dart';

class LaunchUrlUtil {
  ///打开外部链接url地址。
  static Future<bool> openUrl(String url) async {
    Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      return await launchUrl(uri);
    }
    return false;
  }
}

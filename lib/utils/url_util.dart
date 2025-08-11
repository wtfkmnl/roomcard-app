import '../manager/app_manager.dart';

class UrlUtil {
  //https://test202html.btest4wohjelay.com/about?platformName=test4
  static String getNewUrl(String url,) {
    if (url.isEmpty) {
      return "";
    } else {
      var platformName =
          AppManager.companyCode.isNotEmpty ? AppManager.companyCode : "test4";
      if (url.startsWith("?")) {
        return "$url&platformName=$platformName";
       //  return "$url&code=$code&themeStyle=${AppManager.themeID}&themeColor=$currentColor&classId=${getClassificationId()}";
      } else {
        return "$url?&platformName=$platformName";
      }
    }
  }

  // static String getClassificationId() {
  //   return AppManager.classificationId;
  // }

// public static String getNewUrl(Context context, String url, String currentColor) {
//   if (TextUtils.isEmpty(url)) return "";
//   if (url.contains("?")) {
//     return url + "&themeColor=" + currentColor + "&code=" + context.getResources().getString(R.string.companycode)
//         + "&themeStyle=" + context.getResources().getString(R.string.appThemeStyle) + "&classId=" + Utils.getClassificationId();
//   } else {
//     return url + "?themeColor=" + currentColor + "&code=" + context.getResources().getString(R.string.companycode)
//         + "&themeStyle=" + context.getResources().getString(R.string.appThemeStyle) + "&classId=" + Utils.getClassificationId();
//   }
// }
//
// public static String getClassificationId() {
//   return context.getResources().getString(R.string.classificationId);
// }
}

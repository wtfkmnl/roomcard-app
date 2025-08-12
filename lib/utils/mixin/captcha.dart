import 'package:captcha_plugin_flutter/captcha_plugin_flutter.dart';

mixin CaptchaMixin {
  final CaptchaPluginFlutter captchaPlugin = CaptchaPluginFlutter();

  void initCaptchaPlugin({String languageCode = 'zh'}) {
    CaptchaPluginConfig styleConfig = CaptchaPluginConfig(
      radius: 10,
      capBarTextColor: "#25D4D0",
      capBarTextSize: 18,
      capBarTextWeight: "bold",
      borderColor: "#25D4D0",
      borderRadius: 10,
      backgroundMoving: "#DC143C",
      executeBorderRadius: 10,
      executeBackground: "#DC143C",
      capBarTextAlign: "center",
      capPaddingTop: 10,
      capPaddingRight: 10,
      capPaddingBottom: 10,
      capPaddingLeft: 10,
      paddingTop: 15,
      paddingBottom: 15,
    );

    captchaPlugin.init({
      "captcha_id": '',
      "is_debug": false,
      "dimAmount": 0.8,
      "is_touch_outside_disappear": true,
      "timeout": 8000,
      "is_hide_close_button": true,
      "use_default_fallback": true,
      "failed_max_retry_count": 4,
      "language_type": languageCode,
      "is_close_button_bottom": true,
      "styleConfig": styleConfig.toJson(),
    });
  }
}

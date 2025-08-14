import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:roomcard/global.dart';
import 'package:roomcard/manager/app_manager.dart';
import 'package:roomcard/models/acct_info_model.dart';
import 'package:roomcard/models/archive_config_model.dart';
import 'package:roomcard/routes/app_pages.dart';
import 'package:roomcard/routes/app_router.dart';
import 'package:roomcard/services/am_http.dart';
import 'package:roomcard/services/config.dart';
import 'package:roomcard/services/global_data_service.dart';
import 'package:roomcard/services/sp_http.dart';
import 'package:roomcard/utils/Tools.dart';
import 'package:roomcard/utils/app_font_style.dart';
import 'package:roomcard/utils/commonUtils.dart';
import 'package:roomcard/utils/storage_util.dart';
import 'package:roomcard/utils/values/constants.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'observer/getx_router_observer.dart';
import 'observer/keyboard_observer.dart';
import 'theme/app_theme.dart';
import 'theme/font_theme_extension.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // FlutterError.onError = (FlutterErrorDetails details) {
  //   // 可以选择只打印非 image 相关错误
  //   if (details.exceptionAsString().contains('Invalid image data')) {
  //     debugPrint('图片加载失败');
  //     // 忽略
  //     return;
  //   }

  //   // 默认处理其他错误
  //   FlutterError.dumpErrorToConsole(details);
  // };

  await initializeApp();
  runApp(const MyApp());
}

///一些APP提前初始化的操作，比如国际化，主题，和其他的配置信息
Future<void> initializeApp() async {
  await StorageUtil.init();
  await AppManager().init();
  tz.initializeTimeZones();
  await getArchiveConfig();
  Get.put(GlobalDataService());
  await Future.wait([
    Get.putAsync<ConfigService>(() async => await ConfigService().init()),
  ]).whenComplete(() async {
    await Tools.getTraceId();
    Get.put<AMHttpService>(AMHttpService());
    Get.put<SPHttpService>(SPHttpService());
  });

  if (AMHttpService.amApiBaseUrl.isEmpty) {
    await AMHttpService.to.initApiUrl(null);
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          title: 'roomCard',
          theme: ThemeData(
            extensions: [AppTheme().current, FontThemeExtension.defaultTheme()],
            fontFamily: AppFontStyle.defaultFont,
            scaffoldBackgroundColor: const Color(
              0xFF0A1C26,
            ), // 设置APP主题背景色为 #1C2C36
            textTheme: TextTheme(
              bodyLarge: TextStyle(
                fontWeight: FontWeight.w400,
                height: 1.36,
                fontFamily: AppFontStyle.defaultFont,
              ),
              bodyMedium: TextStyle(
                fontWeight: FontWeight.w400,
                height: 1.36,
                fontFamily: AppFontStyle.defaultFont,
              ),
              bodySmall: TextStyle(
                fontWeight: FontWeight.w400,
                height: 1.36,
                fontFamily: AppFontStyle.defaultFont,
              ),
              titleLarge: TextStyle(
                fontWeight: FontWeight.w400,
                height: 1.36,
                fontFamily: AppFontStyle.defaultFont,
              ),
              titleMedium: TextStyle(
                fontWeight: FontWeight.w400,
                height: 1.36,
                fontFamily: AppFontStyle.defaultFont,
              ),
              titleSmall: TextStyle(
                fontWeight: FontWeight.w400,
                height: 1.36,
                fontFamily: AppFontStyle.defaultFont,
              ),
              labelLarge: TextStyle(
                fontWeight: FontWeight.w400,
                height: 1.36,
                fontFamily: AppFontStyle.defaultFont,
              ),
              labelMedium: TextStyle(
                fontWeight: FontWeight.w400,
                height: 1.36,
                fontFamily: AppFontStyle.defaultFont,
              ),
              labelSmall: TextStyle(
                fontWeight: FontWeight.w400,
                height: 1.36,
                fontFamily: AppFontStyle.defaultFont,
              ),
              displayLarge: TextStyle(
                fontWeight: FontWeight.w400,
                height: 1.36,
                fontFamily: AppFontStyle.defaultFont,
              ),
              displayMedium: TextStyle(
                fontWeight: FontWeight.w400,
                height: 1.36,
                fontFamily: AppFontStyle.defaultFont,
              ),
              displaySmall: TextStyle(
                fontWeight: FontWeight.w400,
                height: 1.36,
                fontFamily: AppFontStyle.defaultFont,
              ),
              headlineLarge: TextStyle(
                fontWeight: FontWeight.w400,
                height: 1.36,
                fontFamily: AppFontStyle.defaultFont,
              ),
              headlineMedium: TextStyle(
                fontWeight: FontWeight.w400,
                height: 1.36,
                fontFamily: AppFontStyle.defaultFont,
              ),
              headlineSmall: TextStyle(
                fontWeight: FontWeight.w400,
                height: 1.36,
                fontFamily: AppFontStyle.defaultFont,
              ),
            ),
            textSelectionTheme: TextSelectionThemeData(
              cursorColor: AppTheme().current.themeColor1,
            ),
          ),
          localizationsDelegates: const [RefreshLocalizations.delegate],
          // supportedLocales: const [
          //   Locale('zh', 'CN'),
          //   Locale('en', 'US'),
          // ],

          // locale: Locale(code), // 默认语言
          // translations: AppTranslate(), //语言翻译
          debugShowCheckedModeBanner: false,
          navigatorObservers: [
            GetXRouterObserver(), //监听路由
            KeyboardObserver(), //路由监听键盘收起来
            // ChuckerFlutter.navigatorObserver,
          ],
          unknownRoute: AppPages.unknownPage,
          initialRoute: AppRouter.welcome.path,
          getPages: AppPages.pages,
          builder: (context, child) {
            return EasyLoading.init()(
              context,
              GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: child,
              ),
            );
          },
          defaultTransition: Transition.cupertino,
        );
      },
    );
  }
}

Future getArchiveConfig() async {
  var v = StorageUtil.getString(Constants.storageAppInfoData);
  if (v.isNotEmpty) {
    var appInfo = AppInfo.fromJson(jsonDecode(v));
    Global.instance.appInfo = appInfo;
  }

  var data = await rootBundle.loadString(
    kReleaseMode
        ? "assets/archive_config.json"
        : "assets/archive_config_test.json",
  );
  var model = ArchiveConfigModel.fromJson(jsonDecode(data));
  if (model.siteType != "V1") {
    model.siteType = "V3";
  }
  Global.instance.archiveModel = model;

  printSome("站点 ${model.sIte}");
}

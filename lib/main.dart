
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:roomcard/manager/app_manager.dart';
import 'package:roomcard/routes/app_pages.dart';
import 'package:roomcard/routes/app_router.dart';
import 'package:roomcard/utils/app_font_style.dart';
import 'package:roomcard/utils/storage_util.dart';
import 'observer/getx_router_observer.dart';
import 'observer/keyboard_observer.dart';
import 'theme/app_theme.dart';

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
            extensions: [AppTheme().current],
            fontFamily: AppFontStyle.regular,
            scaffoldBackgroundColor: const Color(0xFF1C2C36), // 设置APP主题背景色为 #1C2C36
            textTheme: const TextTheme(
              bodyLarge: TextStyle(fontWeight: FontWeight.w400, height: 1.36),
              bodyMedium: TextStyle(fontWeight: FontWeight.w400, height: 1.36),
              bodySmall: TextStyle(fontWeight: FontWeight.w400, height: 1.36),
              titleLarge: TextStyle(fontWeight: FontWeight.w400, height: 1.36),
              titleMedium: TextStyle(fontWeight: FontWeight.w400, height: 1.36),
              titleSmall: TextStyle(fontWeight: FontWeight.w400, height: 1.36),
              labelLarge: TextStyle(fontWeight: FontWeight.w400, height: 1.36),
              labelMedium: TextStyle(fontWeight: FontWeight.w400, height: 1.36),
              labelSmall: TextStyle(fontWeight: FontWeight.w400, height: 1.36),
              displayLarge: TextStyle(
                fontWeight: FontWeight.w400,
                height: 1.36,
              ),
              displayMedium: TextStyle(
                fontWeight: FontWeight.w400,
                height: 1.36,
              ),
              displaySmall: TextStyle(
                fontWeight: FontWeight.w400,
                height: 1.36,
              ),
              headlineLarge: TextStyle(
                fontWeight: FontWeight.w400,
                height: 1.36,
              ),
              headlineMedium: TextStyle(
                fontWeight: FontWeight.w400,
                height: 1.36,
              ),
              headlineSmall: TextStyle(
                fontWeight: FontWeight.w400,
                height: 1.36,
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

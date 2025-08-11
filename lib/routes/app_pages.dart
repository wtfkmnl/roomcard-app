import 'package:roomcard/pages/main/main_binding.dart';
import 'package:roomcard/pages/main/main_view.dart';
import 'package:roomcard/pages/unknown/unknown_binding.dart';
import 'package:roomcard/pages/unknown/unknown_view.dart';
import 'package:get/get.dart';
import 'package:roomcard/pages/welcome/welcome_binding.dart';
import 'package:roomcard/pages/welcome/welcome_view.dart';
import 'package:roomcard/routes/app_router.dart';

/// # 页面注册表，绑定页面与 binding
class AppPages {
  ///所有页面
  static List<GetPage> pages = [
      GetPage(
      name: AppRouter.welcome.path,
      page: () => const WelcomePage(),
      bindings: [WelcomeBinding()],
    ),
    GetPage(
      name: '/main',
      page: () => const MainPage(),
      binding: MainBinding(),
    ),
  ];

  ///未知页面
  static GetPage unknownPage = GetPage(
    name: '/unknown',
    page: () => const UnknownPage(),
    binding: UnknownBinding(),
  );
}

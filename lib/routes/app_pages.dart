import 'package:roomcard/pages/main/main_binding.dart';
import 'package:roomcard/pages/main/main_view.dart';
import 'package:roomcard/pages/my/about/about_view.dart';
import 'package:roomcard/pages/my/business/business_view.dart';
import 'package:roomcard/pages/my/profile/profile_binding.dart';
import 'package:roomcard/pages/my/profile/profile_view.dart';
import 'package:roomcard/pages/my/safe_manager/safe_manager_binding.dart';
import 'package:roomcard/pages/my/safe_manager/safe_manager_view.dart';
import 'package:roomcard/pages/my/setting/setting_binding.dart';
import 'package:roomcard/pages/my/setting/setting_view.dart';
import 'package:roomcard/pages/unknown/unknown_binding.dart';
import 'package:roomcard/pages/unknown/unknown_view.dart';
import 'package:get/get.dart';
import 'package:roomcard/pages/welcome/welcome_binding.dart';
import 'package:roomcard/pages/welcome/welcome_view.dart';
import 'package:roomcard/pages/create_room/create_room_binding.dart';
import 'package:roomcard/pages/create_room/create_room_view.dart';
import 'package:roomcard/pages/club/create_club_logic.dart';
import 'package:roomcard/pages/club/create_club_view.dart';
import 'package:roomcard/pages/club/join_club_logic.dart';
import 'package:roomcard/pages/club/join_club_view.dart';
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
    GetPage(
      name: AppRouter.createRoom.path,
      page: () => const CreateRoomPage(),
      binding: CreateRoomBinding(),
    ),
    GetPage(
      name: AppRouter.createClub.path,
      page: () => const CreateClubPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut<CreateClubLogic>(() => CreateClubLogic());
      }),
    ),
    GetPage(
      name: AppRouter.joinClub.path,
      page: () => const JoinClubPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut<JoinClubLogic>(() => JoinClubLogic());
      }),
    ),
    GetPage(
      name: AppRouter.mineBusiness.path,
      page: () => const BusinessPage(),
    ),
    GetPage(
      name: AppRouter.mineSetting.path,
      page: () => const SettingPage(),
      binding: SettingBinding(),
    ),
    GetPage(
      name: AppRouter.mineProfile.path,
      page: () => const ProfilePage(),
      binding: ProfileBinding(),
    ),
    GetPage(name: AppRouter.mineAbout.path, page: () => const AboutPage()),
    GetPage(
      name: AppRouter.mineSafeManager.path,
      page: () => SafeManagerPage(),
      binding: SafeManagerBinding(),
    ),
  ];

  ///未知页面
  static GetPage unknownPage = GetPage(
    name: '/unknown',
    page: () => const UnknownPage(),
    binding: UnknownBinding(),
  );
}

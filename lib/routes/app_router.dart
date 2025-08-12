
import 'package:get/get.dart';
import 'package:roomcard/manager/app_manager.dart';

enum AppRouter<T> {
  ///主页
  main<void>('/main'),

  ///欢迎页面
  welcome('/welcome'),

  ///创建牌局页面
  createRoom('/create-room'),
  
  ///创建俱乐部页面
  createClub('/create-club'),
  
  ///加入俱乐部页面
  joinClub('/join-club');
  ///商务合作
  mineBusiness('/mine_business'),
  ///设置
  mineSetting('/mine_setting'),
  ///个人资料
  mineProfile('/mine_profile'),
  ///关于我们
  mineAbout('/mine_about'),
  ///安全管理
  mineSafeManager('/mine_safe_manager');
 ///路由路劲
  final String path;

  ///是否登录验证
  final bool loginAuth;

  ///返回上一个路由
  static void back<T>({T? result}) {
    Get.back<T>(result: result);
  }

  ///返回到指定路由
  static void backToRoute<T>(AppRouter router) {
    Get.until((route) => route.settings.name == router.path);
  }

  ///返回到第一个路由
  static void backToFirst<T>() {
    Get.until((route) => route.isFirst);
  }

  ///上一个路由path
  static String previousRoute() {
    return Get.previousRoute;
  }

  const AppRouter(this.path, {this.loginAuth = false});
}

extension RouterExtension<T> on AppRouter<T> {
  ///push到路由页面 带参数，
  Future<E?>? toPage<E>({T? arg}) {
    if (loginAuth) {
      if (AppManager().isLogin == false) {
        // return null;
      }
    }

    return Get.toNamed<E>(path, arguments: arg);
  }

  ///关闭所有页面，指定到当前路由。
  Future<E?>? offAll<E>({T? args}) {
    return Get.offAllNamed<E>(path);
  }

  ///获取这个路由的参数
  T? get arg {
    return Get.arguments;
  }

  ///获取这个路由的参数
  T get argsNotNull {
    final res = arg;
    if (res == null) {
      throw ArgumentError('路由参数不能为空，请传递参数类型: $T');
    }
    return res;
  }
}

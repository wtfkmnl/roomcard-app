import 'package:event_bus/event_bus.dart';

class EventsUtil {
  ///change main tab,传递参数， int 类型， tab 的 index
  static final changeMainTab = EventBus();

  ///通知我的界面个人信息刷新
  static final memberInformationUpdate = EventBus();

  ///路由已经push
  static final routerDidPush = EventBus();

  ///路由已经pop
  static final routerDidPop = EventBus();

  ///路由已经切换， push or pop
  static final routerDidChange = EventBus();
}

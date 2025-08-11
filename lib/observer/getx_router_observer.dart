import 'package:roomcard/utils/events_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_navigation/src/router_report.dart';

class GetXRouterObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    RouterReportManager.reportCurrentRoute(route);
    EventsUtil.routerDidPush.fire(route);
    EventsUtil.routerDidChange.fire(route);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) async {
    RouterReportManager.reportRouteDispose(route);
    EventsUtil.routerDidPop.fire(route);
    EventsUtil.routerDidChange.fire(route);
  }
}

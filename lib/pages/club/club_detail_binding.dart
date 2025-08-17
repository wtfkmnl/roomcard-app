import 'package:get/get.dart';
import 'club_detail_logic.dart';

/// 俱乐部详情页面绑定
class ClubDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ClubDetailLogic>(() => ClubDetailLogic());
  }
} 
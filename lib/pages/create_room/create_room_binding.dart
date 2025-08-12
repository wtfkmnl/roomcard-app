import 'package:get/get.dart';
import 'create_room_logic.dart';

class CreateRoomBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CreateRoomLogic());
  }
} 
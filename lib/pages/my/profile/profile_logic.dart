import 'package:get/get.dart';
import 'package:roomcard/base/base_controller.dart';
import 'profile_state.dart';

class ProfileLogic extends BaseController<ProfileState> {
  @override
  ProfileState initState() {
    return ProfileState();
  }

  @override
  void onInit() {
    super.onInit();
    _loadUserProfile();
  }

  /// 加载用户资料
  void _loadUserProfile() {
    state.avatar.value = 'https://example.com/avatar.jpg';
    state.nickname.value = 'Poker';
    state.userId.value = '93651';
    state.birthday.value = '未设置';
    state.gender.value = 1;
  }

  /// 点击头像
  void onAvatarTap() {
    print('点击头像');
  }

  /// 点击昵称
  void onNicknameTap() {
    print('点击昵称');
  }

  /// 点击用户ID
  void onUserIdTap() {
    print('点击用户ID');
  }

  /// 点击生日
  void onBirthdayTap() {
    print('点击生日');
  }

  /// 选择性别
  void onGenderChanged(int gender) {
    print('选择性别: $gender');
    state.gender.value = gender;
  }
}
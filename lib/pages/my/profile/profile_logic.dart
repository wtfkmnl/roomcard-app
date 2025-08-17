import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:roomcard/base/base_controller.dart';
import '../../../routes/app_router.dart';
import 'profile_state.dart';

class ProfileLogic extends BaseController<ProfileState> {
  @override
  ProfileState initState() {
    return ProfileState();
  }

  @override
  void onInit() {
    super.onInit();
    // _loadUserProfile();
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
  void onAvatarTap(BuildContext context) {
    print('点击头像');
    _showOptions(context);
  }

  /// 点击昵称
  void onNicknameTap() {
    print('点击昵称');
    AppRouter.mineNameEdit.toPage();
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

  void _showOptions(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return CupertinoActionSheet(
          actions: [
            CupertinoActionSheetAction(
              onPressed: () {
                Get.back();
                _takePhoto();
              },
              child: Text(
                '拍照',
                style: TextStyle(
                  color: CupertinoColors.systemBlue,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            CupertinoActionSheetAction(
              onPressed: () {
                Get.back();
                _pickFromGallery();
              },
              child: Text(
                '从手机相册选取',
                style: TextStyle(
                  color: CupertinoColors.systemBlue,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
          cancelButton: CupertinoActionSheetAction(
            onPressed: () {
              Get.back();
            },
            isDefaultAction: true,
            child: Text(
              '取消',
              style: TextStyle(
                color: CupertinoColors.systemBlue,
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        );
      },
    );
  }

  /// 拍照
  void _takePhoto() {
    print('拍照');
    _pickImage(ImageSource.camera);
  }

  /// 从相册选择
  void _pickFromGallery() {
    print('从相册选择');
    _pickImage(ImageSource.gallery);
  }

  Future<void> _pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? imageXFile = await picker.pickImage(source: source);
    if (imageXFile == null) {
      return;
    }
  }
}

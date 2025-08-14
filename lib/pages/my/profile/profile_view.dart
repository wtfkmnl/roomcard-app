import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../global.dart';
import '../../../r.dart';
import '../../../utils/image_extension.dart';
import 'profile_logic.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Get.find<ProfileLogic>();
    final state = logic.state;

    return Scaffold(
      backgroundColor: const Color(0xFF1A2332),
      appBar: AppBar(
        title: Text(
          '个人资料',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Color(0xFF283D49),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Image.asset(R.assetsImagesIconTitleBack),
          onPressed: () => Get.back(),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // 头像、用户昵称、用户名ID
          _buildUserInfoGroup(context, logic, state),
          16.verticalSpace,
          // 生日、性别
          _buildPersonalInfoGroup(logic, state),
        ],
      ),
    );
  }

  /// 头像、昵称、用户ID
  Widget _buildUserInfoGroup(BuildContext context, ProfileLogic logic, state) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF2A3441),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Color(0xFF37505E), width: 1),
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: () => logic.onAvatarTap(context),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    '头像',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Container(
                      width: 34.w,
                      height: 34.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: const LinearGradient(
                          colors: [Color(0xFFFF6B9D), Color(0xFFC44569)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: imageView(
                        '${Global.instance.dicModel?.baseSiteConfig?.ossDomain}/${state.avatar}',
                      ),
                    ),
                    16.horizontalSpace,
                    Image.asset(R.assetsImagesIconArrowNext, width: 20.w),
                  ],
                ),
              ],
            ),
          ),
          24.verticalSpace,
          Obx(
            () => GestureDetector(
              onTap: logic.onNicknameTap,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      '用户昵称',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        state.nickname.value,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      16.horizontalSpace,
                      Image.asset(R.assetsImagesIconArrowNext, width: 20.w),
                    ],
                  ),
                ],
              ),
            ),
          ),
          24.verticalSpace,
          Obx(
            () => Row(
              children: [
                Text(
                  '用户名ID',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: logic.onUserIdTap,
                  child: Row(
                    children: [
                      Text(
                        state.userId.value,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      4.horizontalSpace,
                      Image.asset(R.assetsImagesIconTextCopy),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// 生日、性别
  Widget _buildPersonalInfoGroup(ProfileLogic logic, state) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF2A3441),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Color(0xFF37505E), width: 1),
      ),
      child: Column(
        children: [
          Obx(
            () => Row(
              children: [
                Text(
                  '生日',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: logic.onBirthdayTap,
                  child: Row(
                    children: [
                      Text(
                        state.birthday.value,
                        style: TextStyle(
                          color: Color(0xFFB3BEC1),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      8.horizontalSpace,
                      Image.asset(R.assetsImagesIconArrowNext, width: 20.w),
                    ],
                  ),
                ),
              ],
            ),
          ),
          24.verticalSpace,
          Row(
            children: [
              Text(
                '性别',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              Obx(
                () => Row(
                  children: [
                    _buildGenderOption(
                      title: '男生',
                      isSelected: state.gender.value == 1,
                      onTap: () => logic.onGenderChanged(1),
                    ),
                    24.horizontalSpace,
                    _buildGenderOption(
                      title: '女生',
                      isSelected: state.gender.value == 2,
                      onTap: () => logic.onGenderChanged(2),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// 性别
  Widget _buildGenderOption({
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            width: 20.w,
            height: 20.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected ? Color(0xFFFF6B9D) : Color(0xFF666666),
                width: 2,
              ),
              color: isSelected ? Color(0xFFFF6B9D) : Colors.transparent,
            ),
            child: isSelected
                ? Center(
                    child: Container(
                      width: 8.w,
                      height: 8.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                    ),
                  )
                : null,
          ),
          8.horizontalSpace,
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

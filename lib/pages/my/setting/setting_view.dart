import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../r.dart';
import '../../../widgets/custom_switch.dart';
import 'setting_logic.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Get.find<SettingLogic>();
    final state = logic.state;

    return Scaffold(
      backgroundColor: const Color(0xFF1A2332),
      appBar: AppBar(
        title: const Text(
          '设置',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Color(0xFF283D49),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Image.asset(R.assetsImagesIconTitleBack, width: 28.w),
          onPressed: () => Get.back(),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // 切换账号
          _buildMenuItem(
            icon: R.assetsImagesIconSettingMenuAccount,
            title: '切换账号',
            onTap: logic.onSwitchAccountTap,
            showArrow: true,
          ),

          16.verticalSpace,

          // 多语言
          Obx(
            () => _buildMenuItemWithValue(
              icon: R.assetsImagesIconSettingMenuLanguage,
              title: '多语言',
              value: state.language.value,
              onTap: logic.onLanguageTap,
              showArrow: true,
            ),
          ),

          16.verticalSpace,

          // 安全管理
          _buildMenuItem(
            icon: R.assetsImagesIconSettingMenuSafe,
            title: '安全管理',
            onTap: logic.onSecurityTap,
            showArrow: true,
          ),

          16.verticalSpace,

          // 游戏音效
          Obx(
            () => _buildSwitchItem(
              icon: R.assetsImagesIconSettingMenuGameVoice,
              title: '游戏音效',
              value: state.gameSound.value,
              onChanged: logic.onGameSoundToggle,
            ),
          ),

          16.verticalSpace,

          // 消息声音
          Obx(
            () => _buildSwitchItem(
              icon: R.assetsImagesIconSettingMenuMessageVoice,
              title: '消息声音',
              value: state.messageSound.value,
              onChanged: logic.onMessageSoundToggle,
            ),
          ),

          16.verticalSpace,

          // 消息震动
          Obx(
            () => _buildSwitchItem(
              icon: R.assetsImagesIconSettingMenuVibrate,
              title: '消息震动',
              value: state.messageVibration.value,
              onChanged: logic.onMessageVibrationToggle,
            ),
          ),

          16.verticalSpace,

          // 关于我们
          _buildMenuItem(
            icon: R.assetsImagesIconSettingMenuAbout,
            title: '关于我们',
            onTap: logic.onAboutUsTap,
            showArrow: true,
          ),
          16.verticalSpace,
          // 版本号
          Obx(
            () => _buildMenuItemWithValue(
              icon: R.assetsImagesIconSettingMenuVersion,
              title: '版本号',
              value: state.version.value,
              onTap: logic.onVersionTap,
              showArrow: false,
            ),
          ),
        ],
      ),
    );
  }

  /// 构建普通菜单项
  Widget _buildMenuItem({
    required String icon,
    required String title,
    required VoidCallback onTap,
    bool showArrow = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF2A3441),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Color(0xFF37505E), width: 1),
      ),
      child: ListTile(
        horizontalTitleGap: 6.w,
        leading: Image.asset(icon, width: 20.w),
        title: Text(
          title,
          style: const TextStyle(
            color: Color(0xFFB3BEC1),
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: showArrow
            ? Image.asset(R.assetsImagesIconArrowNext, width: 20.w)
            : null,
        onTap: onTap,
      ),
    );
  }

  /// 构建带值的菜单项
  Widget _buildMenuItemWithValue({
    required String icon,
    required String title,
    required String value,
    required VoidCallback onTap,
    bool showArrow = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF2A3441),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Color(0xFF37505E), width: 1),
      ),
      child: ListTile(
        horizontalTitleGap: 6.w,
        leading: Image.asset(icon, width: 20.w),
        title: Text(
          title,
          style: const TextStyle(
            color: Color(0xFFB3BEC1),
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              value,
              style: const TextStyle(
                color: Colors.white54,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (showArrow) ...[
              const SizedBox(width: 8),
              Image.asset(R.assetsImagesIconArrowNext, width: 20.w),
            ],
          ],
        ),
        onTap: onTap,
      ),
    );
  }

  /// 构建开关项
  Widget _buildSwitchItem({
    required String icon,
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF2A3441),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Color(0xFF37505E), width: 1),
      ),
      child: ListTile(
        horizontalTitleGap: 6.w,
        leading: Image.asset(icon, width: 20.w),
        title: Text(
          title,
          style: const TextStyle(
            color: Color(0xFFB3BEC1),
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: CustomSwitch(value: value, onChanged: onChanged),
      ),
    );
  }
}

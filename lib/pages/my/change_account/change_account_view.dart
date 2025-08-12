import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../r.dart';
import '../../../widgets/buttons/yellow_button.dart';
import 'change_account_logic.dart';
import 'change_account_state.dart';

class ChangeAccountPage extends StatelessWidget {
  const ChangeAccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Get.find<ChangeAccountLogic>();
    final state = logic.state;

    return Scaffold(
      backgroundColor: const Color(0xFF1C2C36),
      appBar: AppBar(
        backgroundColor: const Color(0xFF283D49),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Image.asset(R.assetsIconArrowBack),
          onPressed: logic.onBackPressed,
        ),
        actions: [
          Obx(
            () => !state.isManageMode.value
                ? TextButton(
                    onPressed: logic.toggleManageMode,
                    child: Text(
                      '管理',
                      style: TextStyle(color: Colors.white, fontSize: 16.sp),
                    ),
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
      body: Column(
        children: [
          72.verticalSpace,
          Obx(
            () => Text(
              state.isManageMode.value ? '清除登录痕迹' : '轻触头像以切换账号',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          72.verticalSpace,
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [Obx(() => _buildAccountList(logic, state))],
            ),
          ),

          Obx(
            () => !state.isManageMode.value
                ? GestureDetector(
                    onTap: logic.onLogout,
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 16.h),
                      width: double.infinity,
                      height: 43.h,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFFBF9048), Color(0xFFF9C678)],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xFFBD8742).withOpacity(0.3),
                            offset: const Offset(0, 2), // 底部2像素阴影
                            blurRadius: 4,
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          '退出登录',
                          style: TextStyle(
                            color: Color(0XFF703E00),
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
          ),
          135.verticalSpace,
        ],
      ),
    );
  }

  /// 构建账号列表
  Widget _buildAccountList(ChangeAccountLogic logic, state) {
    if (state.isManageMode.value) {
      // 管理模式
      final validAccounts = state.validAccounts;
      return Column(
        children: validAccounts.asMap().entries.map<Widget>((entry) {
          final index = entry.key;
          final account = entry.value;
          final originalIndex = state.accounts.indexOf(account);
          return Padding(
            padding: EdgeInsets.only(bottom: 16.h),
            child: _buildAccountItem(
              account: account,
              index: originalIndex,
              onTap: () => logic.onAccountTap(originalIndex),
              isManageMode: true,
              onClearTap: () => logic.onClearTap(originalIndex),
            ),
          );
        }).toList(),
      );
    } else {
      // 非管理模式
      return Column(
        children: state.accounts.asMap().entries.map<Widget>((entry) {
          final index = entry.key;
          final account = entry.value;
          return Padding(
            padding: EdgeInsets.only(bottom: 16.h),
            child: _buildAccountItem(
              account: account,
              index: index,
              onTap: () => logic.onAccountTap(index),
              isManageMode: false,
            ),
          );
        }).toList(),
      );
    }
  }

  Widget _buildAccountItem({
    required AccountInfo? account,
    required int index,
    required VoidCallback onTap,
    required bool isManageMode,
    VoidCallback? onClearTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0XFF283D49),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF37505E), width: 1),
      ),
      child: ListTile(
        horizontalTitleGap: 12.w,
        leading: _buildAvatar(account, isManageMode),
        title: _buildTitle(account),
        subtitle: _buildSubtitle(account),
        trailing: _buildTrailing(account, isManageMode, onClearTap),
        onTap: onTap,
      ),
    );
  }

  /// 头像
  Widget _buildAvatar(AccountInfo? account, bool isManageMode) {
    if (account == null) {
      return Image.asset(R.assetsIconAddAccount, width: 36.w, height: 36.w);
    } else {
      // 有账号，显示头像
      return Container(
        width: 50.w,
        height: 50.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.w),
          border: Border.all(
            color: account.isCurrent
                ? const Color(0xFFFFD700)
                : Colors.transparent,
            width: 2,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(23.w),
          child: account.avatar.startsWith('http')
              ? Image.network(
                  account.avatar,
                  width: 46.w,
                  height: 46.w,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 46.w,
                      height: 46.w,
                      color: const Color(0xFF37505E),
                      child: Icon(
                        Icons.person,
                        color: Colors.white54,
                        size: 24.w,
                      ),
                    );
                  },
                )
              : Container(
                  width: 46.w,
                  height: 46.w,
                  color: const Color(0xFF37505E),
                  child: Icon(Icons.person, color: Colors.white54, size: 24.w),
                ),
        ),
      );
    }
  }

  Widget _buildTitle(AccountInfo? account) {
    if (account == null) {
      return Text(
        '添加账号',
        style: TextStyle(
          color: Colors.white,
          fontSize: 14.sp,
          fontWeight: FontWeight.bold,
        ),
      );
    } else {
      return Text(
        account.nickname,
        style: TextStyle(
          color: Colors.white,
          fontSize: 14.sp,
          fontWeight: FontWeight.bold,
        ),
      );
    }
  }

  Widget _buildSubtitle(AccountInfo? account) {
    if (account == null) {
      return const SizedBox.shrink();
    } else {
      return Text(
        account.id,
        style: TextStyle(color: Colors.white, fontSize: 12.sp),
      );
    }
  }

  Widget _buildTrailing(
    AccountInfo? account,
    bool isManageMode,
    VoidCallback? onClearTap,
  ) {
    if (account == null) {
      return const SizedBox.shrink();
    }

    if (isManageMode) {
      // 管理模式，清除按钮
      if (!account.isCurrent) {
        return GestureDetector(
          onTap: onClearTap,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: const Color(0xFFFF6B6B),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              '清除',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      } else {
        return Text(
          '当前使用',
          style: TextStyle(
            color: const Color(0xFFFFD700),
            fontSize: 12.sp,
            fontWeight: FontWeight.bold,
          ),
        );
      }
    } else {
      // 非管理模式"当前使用"
      if (account.isCurrent) {
        return Text(
          '当前使用',
          style: TextStyle(
            color: const Color(0xFFFFD700),
            fontSize: 12.sp,
            fontWeight: FontWeight.bold,
          ),
        );
      }
    }

    return const SizedBox.shrink();
  }
}

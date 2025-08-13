import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../r.dart';
import '../../../widgets/buttons/gradient_button.dart';
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
          icon: Image.asset(R.assetsImagesIconTitleBack),
          onPressed: logic.onBackPressed,
        ),
        actions: [
          Obx(
            () =>
                !state.isManageMode.value
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
            () =>
                !state.isManageMode.value
                    ? GradientButton(text: '退出登录', onTap: logic.onLogout)
                    : const SizedBox.shrink(),
          ),
          135.verticalSpace,
        ],
      ),
    );
  }

  /// 账号列表
  Widget _buildAccountList(ChangeAccountLogic logic, state) {
    if (state.isManageMode.value) {
      // 管理模式
      final validAccounts = state.validAccounts;
      return Column(
        children:
            validAccounts.asMap().entries.map<Widget>((entry) {
              final index = entry.key;
              final account = entry.value;
              final originalIndex = state.accounts.indexOf(account);
              return _buildAccountItem(
                account: account,
                index: originalIndex,
                onTap: () => logic.onAccountTap(originalIndex),
                isManageMode: true,
                onClearTap: () => logic.onClearTap(originalIndex),
              );
            }).toList(),
      );
    } else {
      // 非管理模式
      return Column(
        children:
            state.accounts.asMap().entries.map<Widget>((entry) {
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
      height: 80.h,
      decoration: BoxDecoration(
        color: const Color(0XFF283D49),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF37505E), width: 1),
      ),
      child: Center(
        child: ListTile(
          horizontalTitleGap: 12.w,
          leading: _buildAvatar(account, isManageMode),
          title: _buildTitle(account),
          subtitle: _buildSubtitle(account),
          trailing: _buildTrailing(account, isManageMode, onClearTap),
          onTap: onTap,
        ),
      ),
    );
  }

  /// 头像
  Widget _buildAvatar(AccountInfo? account, bool isManageMode) {
    if (account == null) {
      return SizedBox(
        width: 48.w,
        height: 48.w,
        child: Image.asset(
          R.assetsImagesIconAddAccount,
          width: 48.w,
          height: 48.w,
        ),
      );
    } else {
      // 有账号，显示头像
      return Container(
        width: 48.w,
        height: 48.w,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(24.w)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24.w),
          child:
              account.avatar.startsWith('http')
                  ? Image.network(
                    account.avatar,
                    width: 48.w,
                    height: 48.w,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 48.w,
                        height: 48.w,
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
                    width: 48.w,
                    height: 48.w,
                    color: const Color(0xFF37505E),
                    child: Icon(
                      Icons.person,
                      color: Colors.white54,
                      size: 24.w,
                    ),
                  ),
        ),
      );
    }
  }

  Widget _buildTitle(AccountInfo? account) {
    if (account == null) {
      return Container(
        height: 48.h,
        alignment: Alignment.centerLeft,
        child: Text(
          '添加账号',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
          ),
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

  Widget? _buildSubtitle(AccountInfo? account) {
    if (account == null) {
      return null;
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

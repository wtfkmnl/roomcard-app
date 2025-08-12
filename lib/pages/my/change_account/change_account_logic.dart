import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:roomcard/base/base_controller.dart';
import 'change_account_state.dart';

class ChangeAccountLogic extends BaseController<ChangeAccountState> {
  @override
  ChangeAccountState initState() {
    return ChangeAccountState();
  }

  @override
  void onInit() {
    super.onInit();
    _loadAccountData();
  }

  /// 加载账号数据
  void _loadAccountData() {
    // TODO: 从本地存储或服务器加载账号数据
    print('加载账号数据');
  }

  /// 切换管理模式
  void toggleManageMode() {
    state.isManageMode.value = !state.isManageMode.value;
    print('管理模式: ${state.isManageMode.value}');
  }

  /// 退出管理模式
  void exitManageMode() {
    state.isManageMode.value = false;
  }

  /// 返回按钮点击
  void onBackPressed() {
    if (state.isManageMode.value) {
      // 管理模式下，返回到非管理状态
      exitManageMode();
    } else {
      // 非管理状态下，返回上一页
      Get.back();
    }
  }

  /// 账号项点击
  void onAccountTap(int index) {
    final account = state.accounts[index];
    
    if (account == null) {
      // 空位置，添加账号
      _addAccount();
    } else {
      if (state.isManageMode.value) {
        // 管理模式下，清除登录痕迹
        _clearAccountTrace(index);
      } else {
        // 非管理模式下，切换账号
        _switchAccount(account);
      }
    }
  }

  /// 清除按钮点击（管理模式下）
  void onClearTap(int index) {
    _clearAccountTrace(index);
  }

  /// 退出登录
  void onLogout() {
    Get.dialog(
      AlertDialog(
        title: const Text('确认退出'),
        content: const Text('确定要退出当前账号吗？'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              _performLogout();
            },
            child: const Text('确定'),
          ),
        ],
      ),
    );
  }

  /// 添加账号
  void _addAccount() {
    print('添加账号');
    // TODO: 实现添加账号功能
    Get.snackbar('提示', '添加账号功能开发中...');
  }

  /// 切换账号
  void _switchAccount(AccountInfo account) {
    if (account.id == state.currentAccountId.value) {
      // 已经是当前账号，不需要切换
      return;
    }

    print('切换到账号: ${account.nickname} (${account.id})');
    
    // 更新当前账号
    state.currentAccountId.value = account.id;
    
    // 更新账号列表中的当前状态
    final updatedAccounts = <AccountInfo?>[];
    for (var acc in state.accounts) {
      if (acc != null) {
        updatedAccounts.add(acc.copyWith(isCurrent: acc.id == account.id));
      } else {
        updatedAccounts.add(null);
      }
    }
    state.accounts.value = updatedAccounts;
    
    // TODO: 执行账号切换逻辑，如重新登录等
  }

  /// 清除账号登录痕迹
  void _clearAccountTrace(int index) {
    final account = state.accounts[index];
    if (account == null) return;

    Get.dialog(
      AlertDialog(
        title: const Text('清除登录痕迹'),
        content: Text('确定要清除账号 ${account.nickname} 的登录痕迹吗？'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              _performClearTrace(index);
            },
            child: const Text('确定'),
          ),
        ],
      ),
    );
  }

  /// 执行清除登录痕迹
  void _performClearTrace(int index) {
    final account = state.accounts[index];
    if (account == null) return;

    print('清除账号登录痕迹: ${account.nickname}');
    
    // 如果清除的是当前账号，需要特殊处理
    if (account.isCurrent) {
      // TODO: 处理当前账号被清除的情况
      Get.snackbar('提示', '不能清除当前使用的账号');
      return;
    }
    
    // 从列表中移除该账号
    final updatedAccounts = List<AccountInfo?>.from(state.accounts);
    updatedAccounts[index] = null;
    state.accounts.value = updatedAccounts;
    
    // TODO: 清除本地存储的账号信息
    Get.snackbar('成功', '已清除账号 ${account.nickname} 的登录痕迹');
  }

  /// 执行退出登录
  void _performLogout() {
    print('退出登录');
    // TODO: 执行退出登录逻辑
    Get.back(); // 返回上一页
    Get.snackbar('成功', '已退出登录');
  }
}
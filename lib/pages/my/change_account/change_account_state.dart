import 'package:roomcard/base/base_state.dart';
import 'package:get/get.dart';

/// 账号信息模型
class AccountInfo {
  final String id;
  final String nickname;
  final String avatar;
  final bool isCurrent;

  AccountInfo({
    required this.id,
    required this.nickname,
    required this.avatar,
    this.isCurrent = false,
  });

  AccountInfo copyWith({
    String? id,
    String? nickname,
    String? avatar,
    bool? isCurrent,
  }) {
    return AccountInfo(
      id: id ?? this.id,
      nickname: nickname ?? this.nickname,
      avatar: avatar ?? this.avatar,
      isCurrent: isCurrent ?? this.isCurrent,
    );
  }
}

class ChangeAccountState extends BaseState with StateAutoManager {
  /// 是否处于管理模式
  final isManageMode = false.obs;
  
  /// 账号列表（最多3个位置）
  final accounts = <AccountInfo?>[].obs;
  
  /// 当前登录的账号ID
  final currentAccountId = ''.obs;

  ChangeAccountState() {
    /// 初始化账号数据
    _initAccountData();
  }

  /// 初始化账号数据
  void _initAccountData() {
    // 固定3个位置
    accounts.value = [
      AccountInfo(
        id: '7Q2S1MD7',
        nickname: 'psycho',
        avatar: 'https://example.com/avatar1.jpg',
        isCurrent: true,
      ),
      null, // 空位置，显示添加账号
      null, // 空位置，显示添加账号
    ];
    currentAccountId.value = '7Q2S1MD7';
  }

  /// 获取有效账号列表（非空账号）
  List<AccountInfo> get validAccounts {
    return accounts.where((account) => account != null).cast<AccountInfo>().toList();
  }

  /// 获取空位置数量
  int get emptySlotCount {
    return accounts.where((account) => account == null).length;
  }
}
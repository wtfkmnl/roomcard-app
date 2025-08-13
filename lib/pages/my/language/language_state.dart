import 'package:roomcard/base/base_state.dart';
import 'package:get/get.dart';

class LanguageState extends BaseState with StateAutoManager {
  /// 当前选中的语言
  final selectedLanguage = '简体中文'.obs;
  
  /// 支持的语言列表 - 设为响应式
  final languages = <LanguageItem>[
    LanguageItem(
      name: '简体中文',
      code: 'zh_CN',
      isSelected: true,
    ),
    LanguageItem(
      name: '繁体中文',
      code: 'zh_TW',
      isSelected: false,
    ),
    LanguageItem(
      name: 'English',
      code: 'en_US',
      isSelected: false,
    ),
    LanguageItem(
      name: '日本語',
      code: 'ja_JP',
      isSelected: false,
    ),
  ].obs;
}

/// 语言项模型
class LanguageItem {
  final String name;
  final String code;
  bool isSelected;

  LanguageItem({
    required this.name,
    required this.code,
    required this.isSelected,
  });
}
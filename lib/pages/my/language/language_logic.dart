import 'package:get/get.dart';
import 'package:roomcard/base/base_controller.dart';
import 'language_state.dart';

class LanguageLogic extends BaseController<LanguageState> {
  @override
  LanguageState initState() {
    return LanguageState();
  }

  @override
  void onInit() {
    super.onInit();
    _loadCurrentLanguage();
  }

  /// 加载当前语言设置
  void _loadCurrentLanguage() {
    // TODO: 从本地存储或服务器获取当前语言设置
    final currentLanguage = '简体中文';
    state.selectedLanguage.value = currentLanguage;

    // 更新语言列表的选中状态
    for (var language in state.languages) {
      language.isSelected = language.name == currentLanguage;
    }
    // 触发列表更新
    state.languages.refresh();
  }

  /// 选择语言
  void onLanguageSelected(LanguageItem selectedItem) {
    print('选择语言: ${selectedItem.name} (${selectedItem.code})');

    // 更新选中状态
    for (var language in state.languages) {
      language.isSelected = language.code == selectedItem.code;
    }

    // 触发列表更新，确保界面立即刷新
    state.languages.refresh();

    // 更新当前选中的语言
    state.selectedLanguage.value = selectedItem.name;

    // 保存语言设置
    _saveLanguageSetting(selectedItem);

    // 应用语言设置
    _applyLanguageSetting(selectedItem);

  }

  /// 保存语言设置到本地
  void _saveLanguageSetting(LanguageItem language) {
    // TODO: 保存到本地存储
    print('保存语言设置: ${language.name} (${language.code})');
  }

  /// 应用语言设置
  void _applyLanguageSetting(LanguageItem language) {
    // TODO: 应用语言设置，更新应用的语言环境
    print('应用语言设置: ${language.name} (${language.code})');

    // 这里可以调用国际化相关的方法
    // 例如：Get.updateLocale(Locale(language.code.split('_')[0], language.code.split('_')[1]));
  }

  /// 获取当前选中的语言项
  LanguageItem? getCurrentLanguageItem() {
    return state.languages.firstWhereOrNull((item) => item.isSelected);
  }
}

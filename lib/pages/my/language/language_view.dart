import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:roomcard/widgets/common_app_bar.dart';
import '../../../r.dart';
import 'language_logic.dart';
import 'language_state.dart';

class LanguagePage extends StatelessWidget {
  const LanguagePage({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Get.find<LanguageLogic>();
    final state = logic.state;

    return Scaffold(
      backgroundColor: const Color(0xFF1C2C36),
      appBar: CommonAppBar(title: '多语言'),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFF283D49),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFF37505E), width: 1.w),
          ),
          child: Obx(
            () => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (int i = 0; i < state.languages.length; i++) ...[
                  _buildLanguageItem(state.languages[i], logic),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// 构建语言选项
  Widget _buildLanguageItem(LanguageItem language, LanguageLogic logic) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => logic.onLanguageSelected(language),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  language.name,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              language.isSelected
                  ? Container(
                      width: 16.w,
                      height: 16.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Color(0xffF9C678),
                          width: 3.w,
                        ),
                      ),
                    )
                  : Container(
                      width: 16.w,
                      height: 16.w,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color(0xFF395466),
                          width: 1.w,
                        ),
                        shape: BoxShape.circle,
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

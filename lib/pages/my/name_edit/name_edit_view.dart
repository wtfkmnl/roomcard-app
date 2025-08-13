import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:roomcard/r.dart';
import 'name_edit_logic.dart';

class NameEditPage extends StatelessWidget {
  const NameEditPage({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Get.find<NameEditLogic>();
    final state = logic.state;

    return Scaffold(
      backgroundColor: const Color(0xFF1A2332),
      appBar: AppBar(
        title: Text(
          '用户昵称',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: const Color(0xFF283D49),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Image.asset(R.assetsImagesIconTitleBack),
          onPressed: logic.goBack,
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.w, top: 8.h, bottom: 8.h),
            child: Obx(
              () => Container(
                decoration: BoxDecoration(
                  color:
                      state.canSave.value
                          ? const Color(0xFFF9C678)
                          : const Color(0xFFB3BEC1).withOpacity(0.3),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(8),
                    onTap: state.canSave.value ? logic.saveNickname : null,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 6.h,
                      ),
                      child: Text(
                        '完成',
                        style: TextStyle(
                          color:
                              state.canSave.value
                                  ? const Color(0xFF703E00)
                                  : const Color(0xFFB3BEC1),
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 输入框容器
            Container(
              height: 48.h,
              decoration: BoxDecoration(
                color: const Color(0XFF0F212E),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFF37505E), width: 1),
              ),
              child: Row(
                children: [
                  14.horizontalSpace,
                  Image.asset(R.assetsImagesIconNameEdit),
                  4.horizontalSpace,
                  Expanded(
                    child: TextField(
                      controller: state.nicknameController,
                      focusNode: state.nicknameFocusNode,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      decoration: InputDecoration(
                        hintText: '请输入昵称',
                        hintStyle: TextStyle(
                          color: const Color(0xFF57646D),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                        border: InputBorder.none,
                      ),
                      maxLength: 15,
                      buildCounter: (
                        context, {
                        required currentLength,
                        required isFocused,
                        maxLength,
                      }) {
                        return null; // 隐藏默认计数器
                      },
                    ),
                  ),
                ],
              ),
            ),

            6.verticalSpace,

            Text(
              '玩家昵称修改后，15日内不能重复修改',
              style: TextStyle(
                color: const Color(0xFFB3BEC1),
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
              ),
            ),

            Obx(
              () =>
                  state.isSaving.value
                      ? Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Center(
                          child: CircularProgressIndicator(
                            valueColor: const AlwaysStoppedAnimation<Color>(
                              Color(0xFFFFB800),
                            ),
                          ),
                        ),
                      )
                      : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}

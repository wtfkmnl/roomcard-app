import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:roomcard/base/base_controller.dart';
import 'package:roomcard/api/user.dart';
import 'package:roomcard/models/business_model.dart';
import 'package:roomcard/utils/launch_url_util.dart';
import 'business_state.dart';

class BusinessLogic extends BaseController<BusinessState> {
  @override
  BusinessState initState() {
    return BusinessState();
  }

  @override
  void onInit() {
    super.onInit();
    loadBusinessList();
  }

  /// 加载商务合作列表
  Future<void> loadBusinessList() async {
    try {
      state.isLoading.value = true;
      state.hasError.value = false;
      state.errorMessage.value = '';

      final result = await UserApi.getBusinessList();

      if (result != null && result.code == 'C2' && result.result != null) {
        // 解析result中的数组数据
        List<dynamic> dataList = result.result as List<dynamic>;
        List<BusinessModel> businessList = dataList
            .map((item) => BusinessModel.fromJson(item as Map<String, dynamic>))
            .toList();

        // 按sort字段排序
        businessList.sort((a, b) => (a.sort ?? 0).compareTo(b.sort ?? 0));
        state.businessList.value = businessList;
      } else {
        state.businessList.clear();
        if (result?.message != null) {
          state.errorMessage.value = result!.message!;
        }
      }
    } catch (e) {
      state.hasError.value = true;
      state.errorMessage.value = e.toString();
      Get.snackbar(
        '错误',
        '加载商务合作信息失败：${e.toString()}',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
      );
    } finally {
      state.isLoading.value = false;
    }
  }

  /// 点击商务合作项目
  void onBusinessItemTap(BusinessModel business) {
    if (business.link != null && business.link!.isNotEmpty) {
      // LaunchUrlUtil.launchURL(business.link!);
    } else {
      Get.snackbar(
        '提示',
        '链接地址无效',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.orange.withOpacity(0.8),
        colorText: Colors.white,
      );
    }
  }

  /// 刷新数据
  Future<void> onRefresh() async {
    await loadBusinessList();
  }

  /// 返回上一页
  void goBack() {
    Get.back();
  }
}

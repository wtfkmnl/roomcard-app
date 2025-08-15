import 'package:get/get.dart';
import 'package:roomcard/base/base_state.dart';
import 'package:roomcard/models/business_model.dart';

class BusinessState extends BaseState with StateAutoManager {
  /// 商务合作列表
  final businessList = <BusinessModel>[].obs;
  
  /// 是否正在加载
  final isLoading = false.obs;
  
  /// 是否加载失败
  final hasError = false.obs;
  
  /// 错误信息
  final errorMessage = ''.obs;

  BusinessState() {
    /// Initialize variables
  }
}
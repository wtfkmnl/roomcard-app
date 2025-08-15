import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:roomcard/utils/image_extension.dart';
import 'package:roomcard/widgets/common_app_bar.dart';
import 'package:roomcard/models/business_model.dart';
import 'business_logic.dart';

class BusinessPage extends StatelessWidget {
  const BusinessPage({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Get.find<BusinessLogic>();
    final state = logic.state;

    return Scaffold(
      backgroundColor: const Color(0xFF1C2C36),
      appBar: CommonAppBar(title: '商务合作'),
      body: Obx(() {
        if (state.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFFFD700)),
            ),
          );
        }

        if (state.businessList.isEmpty) {
          return Text('');
        }

        return Container(
          padding: EdgeInsets.all(16.w),
          child: Column(
            children: [
              // 商务合作列表容器
              Container(
                padding: EdgeInsets.symmetric(vertical: 6.h),
                decoration: BoxDecoration(
                  color: const Color(0xFF283D49),
                  border: Border.all(color: Color(0xFF37505E), width: 1.w),
                  borderRadius: BorderRadius.circular(14.r),
                ),
                child: Column(
                  children: state.businessList
                      .map((business) => _buildBusinessItem(business, logic))
                      .toList(),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildBusinessItem(BusinessModel business, BusinessLogic logic) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
      child: InkWell(
        onTap: () => logic.onBusinessItemTap(business),
        borderRadius: BorderRadius.circular(8.r),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 10.w),
          decoration: BoxDecoration(
            color: const Color(0xFF21333D),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Row(
            children: [
              // 图标
              Container(
                width: 30.w,
                height: 30.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.r),
                  color: Color(0xFF314754),
                ),
                child:
                    business.domainImage != null &&
                        business.domainImage!.isNotEmpty
                    ? imageView(
                        business.domainImage!,
                        width: 20.w,
                        height: 16.w,
                        fit: BoxFit.cover,
                      )
                    : Icon(Icons.business, color: Colors.white, size: 24.w),
              ),
              14.horizontalSpace,
              // 名称
              Expanded(
                child: Text(
                  business.name ?? '-',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

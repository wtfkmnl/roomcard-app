import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:roomcard/r.dart';
import 'package:roomcard/utils/common_extension/common_extension.dart';
import 'package:roomcard/utils/image_extension.dart';
import 'package:roomcard/utils/my_font_family.dart';
import 'package:roomcard/utils/values/country.dart';

typedef SelectareaCodeCallback = void Function(int index);

class AreaPhoneBottomSheet extends StatefulWidget {
  final String titles;
  final List<Country> countryData;
  final SelectareaCodeCallback callback;

  const AreaPhoneBottomSheet({
    super.key,
    required this.titles,
    required this.countryData,
    required this.callback,
  });

  @override
  State<AreaPhoneBottomSheet> createState() => _AreaPhoneBottomSheetState();
}

class _AreaPhoneBottomSheetState extends State<AreaPhoneBottomSheet> {
  final textEditingController = TextEditingController();

  var displayCountryList = <Country>[];

  var isSearched = true;

  @override
  Widget build(BuildContext context) {
    return KeyboardDismissOnTap(
      dismissOnCapturedTaps: true,
      child: Column(
        children: [
          Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(width: 42.w, height: 42.w).paddingLeft(42.w),
                  Text(
                    widget.titles,
                    style: TextStyle(
                      fontSize: 51.sp,
                      color: Color(0xFF2D2D2D),
                      fontFamily: MyFontFamily.miSans,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  imageView(
                    R.assetsImagesIconAboutUsLogo,
                    width: 42.w,
                    height: 42.w,
                  ).gestureTap(onTap: () => Get.back()).paddingRight(42.w),
                ],
              )
              .sized(height: 132.h, width: ScreenUtil().screenWidth)
              .backgroundColor(Color(0xFFFFFFFF)),
          Column(
                children: [
                  SizedBox(height: 42.h),
                  Row(
                        children: [
                          imageView(
                            R.assetsImagesIconAboutUsLogo,
                            width: 37.w,
                            height: 37.w,
                          ).paddingOnly(left: 44.w, right: 32.w),
                          TextField(
                            style: TextStyle(
                              color: Color(0xFF2D2D2D),
                              fontSize: 42.sp,
                              fontFamily: MyFontFamily.miSans,
                              fontWeight: FontWeight.w400,
                            ),
                            cursorColor: Color(0xFF43BC9B),
                            controller: textEditingController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintStyle: TextStyle(
                                color: Color(0xFFB3B8B),
                                fontWeight: FontWeight.w400,
                                fontSize: 42.sp,
                              ),
                              hintText: "输入区号或名称搜索",
                            ),
                            onSubmitted: (value) {
                              setState(() {
                                if (value.isNotEmpty) {
                                  bool isCheck = true;

                                  displayCountryList = <Country>[];

                                  // isCheck = value.isMatchReg(
                                  //   RegularUtil.DIGIT_REGEX,
                                  // );

                                  for (var element in widget.countryData) {
                                    if (isCheck) {
                                      if (element.code.contains(value)) {
                                        displayCountryList.add(element);
                                      }
                                    } else {
                                      if (element.name.contains(value)) {
                                        displayCountryList.add(element);
                                      }
                                    }
                                  }
                                  isSearched = displayCountryList.isNotEmpty;
                                } else {
                                  displayCountryList = <Country>[];

                                  isSearched = true;
                                }
                              });
                            },
                            onChanged: (text) {
                              if (text == "") {
                                debugPrint("------");
                              }
                            },
                          ).paddingBottom(5).fill(),
                        ],
                      )
                      .sized(height: 109.h)
                      .backgroundColor(Colors.white)
                      .cornerRadiusCircularAll(109.h)
                      .paddingOnly(left: 42.w, right: 42.w),
                  SizedBox(height: 42.h),
                  isSearched == true
                      ? ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount:
                            displayCountryList.isNotEmpty
                                ? displayCountryList.length
                                : widget.countryData.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "+ ${displayCountryList.isNotEmpty ? displayCountryList[index].code : widget.countryData[index].code}",
                                        style: TextStyle(
                                          fontSize: 42.sp,
                                          color: Color(0xFF2D2D2D),
                                          fontFamily: MyFontFamily.miSans,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ).sized(width: 150.w).paddingRight(78.w),
                                      Text(
                                        displayCountryList.isNotEmpty
                                            ? displayCountryList[index].name
                                            : widget.countryData[index].name,
                                        style: TextStyle(
                                          fontSize: 42.sp,
                                          color: Color(0xFF2D2D2D),
                                          fontFamily: MyFontFamily.miSans,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  )
                                  .sized(height: 137.h)
                                  .gestureTap(
                                    onTap: () {
                                      widget.callback(index);
                                      Get.back();
                                    },
                                  ),
                              Divider(
                                height: 0.5, // 分割线的高度
                                color: Color(0xFFEBEDEF), // 分割线的颜色
                              ),
                            ],
                          ).paddingOnly(left: 42.w, right: 42.w);
                        },
                      ).fill()
                      : Center(
                        child: Text(
                          "暂无数据",
                          style: TextStyle(
                            fontSize: 42.sp,
                            color: Color(0xFFB3B8BD),
                            fontFamily: MyFontFamily.miSans,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ).fill(),
                  SizedBox(height: 160.h),
                ],
              )
              .backgroundColor(Color(0xFFF4F6F9))
              .cornerRadiusCircularOnly(topLeft: 60.w, topRight: 60.w)
              .fill(),
        ],
      ).sized(height: 1595.h),
    ).backgroundColor(Colors.white);
  }
}

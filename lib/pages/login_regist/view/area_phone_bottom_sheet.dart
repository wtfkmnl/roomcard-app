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
  final int cuIndex;
  final SelectareaCodeCallback callback;

  const AreaPhoneBottomSheet({
    super.key,
    required this.titles,
    required this.countryData,
    required this.callback,
    required this.cuIndex,
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
                  SizedBox(width: 28.w, height: 28.w).paddingLeft(18.w),
                  Text(
                    widget.titles,
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Color(0xFFFFFFFF),
                      fontFamily: MyFontFamily.miSans,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  imageView(
                    R.assetsImagesLoginAreaChoseClose,
                    width: 28.w,
                    height: 28.w,
                  ).gestureTap(onTap: () => Get.back()).paddingRight(18.w),
                ],
              )
              .sized(height: 75.h, width: ScreenUtil().screenWidth)
              .backgroundColor(Color(0xFF213743)),
          Column(
                children: [
                  SizedBox(height: 0.h),
                  Row(
                        children: [
                          imageView(
                            R.assetsImagesLoginTextfieldSearch,
                            width: 24.w,
                            height: 24.w,
                          ).paddingOnly(left: 12.w, right: 12.w),
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
                      .sized(height: 44.h)
                      .withBorder(
                        color: Color(0xFF2F4553),
                        width: 2.w,
                        radius: 14.h,
                      )
                      .backgroundColor(Color(0xFF0F212E))
                      .cornerRadiusCircularAll(14.h)
                      .paddingOnly(left: 16.w, right: 16.w),
                  SizedBox(height: 12.h),
                  isSearched == true
                      ? ListView.builder(
                        padding: EdgeInsets.only(left: 16.w, right: 16.w),
                        itemCount:
                            displayCountryList.isNotEmpty
                                ? displayCountryList.length
                                : widget.countryData.length,
                        itemBuilder: (context, index) {
                          return Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "+ ${displayCountryList.isNotEmpty ? displayCountryList[index].code : widget.countryData[index].code}",
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color: Color(0xFFFFFFFF),
                                      fontFamily: MyFontFamily.miSans,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ).sized(width: 44.w),
                                  Text(
                                    displayCountryList.isNotEmpty
                                        ? displayCountryList[index].name
                                        : widget.countryData[index].name,
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color: Color(0xFFFFFFFF),
                                      fontFamily: MyFontFamily.miSans,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ).fill(),
                                  imageView(
                                    widget.countryData[index].name ==
                                            widget
                                                .countryData[widget.cuIndex]
                                                .name
                                        ? R.assetsImagesLoginAreaChoseS
                                        : R.assetsImagesLoginAreaChoseU,
                                    width: 20.w,
                                  ),
                                ],
                              )
                              .sized(height: 40.h)
                              .gestureTap(
                                onTap: () {
                                  widget.callback(index);
                                  Get.back();
                                },
                              )
                              .paddingOnly(left: 10.w, right: 12.w)
                              .backgroundColor(
                                widget.countryData[index].name ==
                                        widget.countryData[widget.cuIndex].name
                                    ? Color(0xFF375061)
                                    : Colors.transparent,
                              )
                              .cornerRadiusCircularAll(8.w);
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
                  SizedBox(height: 30.h),
                ],
              )
              .backgroundColor(Color(0xFF213743))
              .cornerRadiusCircularOnly(topLeft: 0.w, topRight: 0.w)
              .fill(),
        ],
      ).sized(height: 472.h),
    ).backgroundColor(Colors.white);
  }
}

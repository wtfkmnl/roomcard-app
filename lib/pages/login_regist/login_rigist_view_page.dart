import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'dart:math' as math;

import 'package:roomcard/pages/login_regist/login_rigist_controller.dart';
import 'package:roomcard/pages/login_regist/login_text_filed/login_text_filed.dart';
import 'package:roomcard/r.dart';
import 'package:roomcard/utils/common_extension/common_extension.dart';
import 'package:roomcard/utils/image_extension.dart';
import 'package:roomcard/utils/my_font_family.dart';
import 'package:roomcard/utils/storage_util.dart'; // 导入数学库以使用 pi

class LoginRigistViewPage extends StatefulWidget {
  final int? selectIndex;
  const LoginRigistViewPage({super.key, this.selectIndex});
  static bool isShow = false;
  @override
  State<LoginRigistViewPage> createState() => _LoginRigistViewPageState();
}

class _LoginRigistViewPageState extends State<LoginRigistViewPage> {
  final controller = Get.put(LoginRigistController());
  PageController pageController = PageController();

  @override
  void initState() {
    super.initState();
    LoginRigistViewPage.isShow = true;

    if (widget.selectIndex != null) {
      controller.update();
    }
  }

  @override
  void dispose() {
    super.dispose();
    LoginRigistViewPage.isShow = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder(
        init: controller,
        builder: (context) {
          return Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(R.assetsImagesLoginBg),
                fit: BoxFit.fill,
              ),
            ),

            child: Column(
              children: [_topWdiget(), _tabWidget(), _subTabWidget()],
            ),
          );
        },
      ),
    );
  }

  Widget _topWdiget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        imageView(R.assetsImagesIconTitleBack, width: 28.w, height: 28.w),
        imageView(R.assetsImagesLoginService, width: 24.w, height: 24.w),
      ],
    ).marginOnly(left: 16.w, right: 16.w, top: 54.h);
  }

  Widget _tabWidget() {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF0F212E),
        borderRadius: BorderRadius.all(Radius.circular(24.h)),
      ),
      width: 344.w,
      height: 45.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children:
            controller.tabs.map((e) {
              return _tabItem(e).onTap(() {
                List<TabItem> tabs = controller.tabs;
                for (var i = 0; i < tabs.length; i++) {
                  tabs[i].isSelected = false;
                  if (tabs[i].name == e.name) {
                    tabs[i].isSelected = true;
                  }
                }
                controller.tabs = tabs;
                controller.update();
              });
            }).toList(),
      ),
    ).marginOnly(top: 160.h);
  }

  Widget _tabItem(TabItem tabItem) {
    return Container(
      width: 166.w,
      height: 38.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(19.h)),
        color: tabItem.isSelected! ? Color(0xFF283D49) : Colors.transparent,
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            imageView(
              tabItem.images,
              width: 16.w,
              color: tabItem.isSelected! ? Colors.white : Color(0xFFB3BEC1),
            ).marginOnly(right: 12.w),
            Text(
              tabItem.name ?? '',
              style: TextStyle(
                fontSize: 16.sp,
                color: tabItem.isSelected! ? Colors.white : Color(0xFFB3BEC1),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _subTabWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children:
          controller.loginTitle.map((e) {
            return _subTabItem(e).onTap(() {
              List<LoginTabItem> tabs = controller.loginTitle;
              for (var i = 0; i < tabs.length; i++) {
                tabs[i].isSelected = false;
                if (tabs[i].name == e.name) {
                  tabs[i].isSelected = true;
                }
              }
              controller.loginTitle = tabs;
              controller.update();
            });
          }).toList(),
    ).marginOnly(top: 34.h, left: 32.w, right: 32.w);
  }

  Widget _subTabItem(LoginTabItem tabItem) {
    return Container(
      width: 96.w,
      child: Column(
        children: [
          Text(
            tabItem.name ?? '',
            style: TextStyle(
              fontSize: 15.sp,
              color: tabItem.isSelected! ? Colors.white : Color(0xFFB3BEC1),
            ),
          ),
          SizedBox(height: 10.h),
          tabItem.isSelected!
              ? Container(width: 96.w, height: 2.h, color: Color(0xFFF9C678))
              : SizedBox(height: 2.h),
        ],
      ),
    );
  }

  Widget _accountTextView() {
    return Column(
      children: [
        CusTomTextField(
          keyboardType: TextInputType.emailAddress,
          height: 48.h,
          onChange: (val) {
            controller.setSubmitState();
          },
          boardColor: Color(0xFFFC3C3C),
          noboardColor: Color(0xFF2F4553),
          allRadius: 6.w,
          leftIcon: Row(
            children: [
              // imageView(
              //   icon,
              //   width: 48.w,
              //   height: 48.w,
              // ).paddingOnly(left: 40.w, right: 40.w),
              // Visibility(
              //     visible: title.isNotEmpty,
              //     child: Text(title,
              //         style: TextStyle(
              //           fontSize: 45.sp,
              //           color: ColorManager.getColor(name: ColorsType.C_2D2D2D),
              //           fontFamily: MyFontFamily.miSans,
              //           fontWeight: FontWeight.w600,
              //         )).paddingRight(30.w)),
              Container(
                width: 2.w,
                height: 60.w,
                // color: ColorManager.getColor(name: ColorsType.C_D9D9D9),
              ).marginOnly(right: 40.w),
            ],
          ),
          controller: TextEditingController(),
          placeholder: '',
          usedInPassword: true,
          hintTextColor: Color(0xFFB3B7BD),
          textColor: Color(0xFF2D2D2D),
          textFontSize: 45.sp,
          hintTextFontSize: 36.sp,
          fontFamily: MyFontFamily.miSans,
          fontWeight: FontWeight.w600,
          hintFontWeight: FontWeight.w500,
        ),
      ],
    );
  }

  Widget _bottomButton({String? imgPath, String? name, Function? onTap}) {
    return Row(
      children: [
        imageView(imgPath, width: 48.w),
        SizedBox(width: 8.w),
        Text(
          name ?? "",
          style: TextStyle(
            // color: ColorManager.getColor(name: ColorsType.C_B3B7BD),
          ),
        ),
      ],
    ).onTap(() {
      onTap?.call();
    });
  }

  Widget loginTabView() {
    return Obx(
      () => SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: SizedBox(
          height: Get.height * 0.6 - 100.h - 180.h,
          child: Column(
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "支持账号/手机号登录",
                        style: TextStyle(
                          fontSize: 18.sp,
                          // color: ColorManager.getColor(
                          //   name: ColorsType.C_2D2D2D,
                          // ),
                        ),
                      ),
                    ],
                  ).paddingOnly(left: 80.w, right: 80.w),
                  SizedBox(height: 10.h),
                  _textFliedview(
                    editingController: controller.accountTEC,
                    icon: R.assetsImagesApokerLoginClear,
                    title: "",
                    placeholder: "请输入账号或手机号",
                    // obscure: false,
                    tag: 0,
                  ),
                  SizedBox(height: 30.h),
                  _textFliedview(
                    editingController: controller.psdTEC,
                    icon: R.assetsImagesApokerLoginClear,
                    title: "",
                    placeholder: "请输入登录密码",
                    // obscure: obscureText,
                    tag: 1,
                  ),
                ],
              ),
              SizedBox(height: 40.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      controller.isRememberPwd.value
                          ? imageView(
                            R.assetsImagesApokerLoginClear,
                            width: 36.w,
                            height: 36.w,
                          ).marginOnly(right: 20.w)
                          : Container(
                            width: 36.w,
                            height: 36.w,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(36.w),
                              border: Border.all(
                                width: 1,
                                // color: ColorManager.getColor(
                                //   name: ColorsType.C_7C9991,
                                // ),
                              ),
                            ),
                          ).marginOnly(right: 10.w),
                      Text(
                        "记住密码",
                        style: TextStyle(
                          fontSize: 36.sp,
                          // color: ColorManager.getColor(
                          //   name: ColorsType.C_696D74,
                          // ),
                          fontFamily: MyFontFamily.miSans,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ).gestureTap(
                    onTap: () {
                      controller.remberMemberAccountAndPassWord();
                    },
                  ),
                  Text(
                    "忘记密码？",
                    style: TextStyle(
                      fontSize: 36.sp,
                      // color: ColorManager.getColor(name: ColorsType.C_696D74),
                      fontFamily: MyFontFamily.miSans,
                      fontWeight: FontWeight.w400,
                    ),
                  ).gestureTap(
                    onTap: () {
                      // showCustomDialog(
                      //   ForgetLoginPassWordPage(
                      //     areaCode:
                      //         controller
                      //             .countryData[controller.codeIndexs.value]
                      //             .code,
                      //   ),
                      //   barrierDismissible: true,
                      // );
                    },
                  ),
                ],
              ).marginSymmetric(horizontal: 80.w),
              SizedBox(height: 42.h),
              _actionButton("立即登录", controller.loginCanSubmit.value),
              Spacer(),
              _bottomMenu(),
            ],
          ),
        ),
      ),
    );
  }

  Widget registerTabView() {
    return Obx(
      () => SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: SizedBox(
          height: Get.height * 0.6 - 100.h - 180.h,
          child: Column(
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "支持账号/手机号注册",
                        style: TextStyle(
                          fontSize: 18.sp,
                          // color: ColorManager.getColor(
                          //   name: ColorsType.C_2D2D2D,
                          // ),
                        ),
                      ),
                    ],
                  ).paddingOnly(left: 80.w, right: 80.w),
                  SizedBox(height: 10.h),
                  _textFliedview(
                    editingController: controller.accountRegistTEC,
                    icon: R.assetsImagesApokerLoginClear,
                    title: "",
                    placeholder: "请输入账号或手机号",
                    // obscure: false,
                    tag: 2,
                  ),
                  SizedBox(height: 30.h),
                  _textFliedview(
                    editingController: controller.psdRegistTEC,
                    icon: R.assetsImagesApokerLoginClear,
                    title: "",
                    placeholder: "设置登录密码",
                    // obscure: obscureText1,
                    tag: 3,
                  ),
                  SizedBox(height: 30.h),
                  _textFliedview(
                    editingController: controller.configPsdTEC,
                    icon: R.assetsImagesApokerLoginClear,
                    title: "",
                    placeholder: "请再次输入密码",
                    // obscure: obscureText2,
                    tag: 4,
                  ),
                ],
              ),
              _phoneNumberView(
                controller.accountPhoneTEC,
                R.assetsImagesIconAboutUsLogo,
                "请输入电话号码",
                0,
              ).paddingTop(42.h).hide(!controller.accountPhoneEnable()),
              _textFliedview(
                editingController: controller.inviteCodeTEC,
                icon: R.assetsImagesIconAboutUsLogo,
                title: "",
                placeholder: "请输入邀请码",
                tag: 2,
              ).paddingTop(42.h).hide(!controller.invitationCodeEnable()),
              _textFliedview(
                editingController: controller.memberNameTEC,
                icon: R.assetsImagesIconAboutUsLogo,
                title: "",
                placeholder: "请输入姓名",
                tag: 2,
              ).hide(!controller.memberNameEnable()),
              SizedBox(height: 100.h),
              _actionButton("立即注册", controller.registerCanSubmit.value),
              Spacer(),
              _bottomMenu(),
            ],
          ),
        ),
      ),
    );
  }

  Widget clickRegisterTabView() {
    return SingleChildScrollView(
      physics: ClampingScrollPhysics(),
      child: SizedBox(
        height: Get.height * 0.6 - 100.h - 175.h,
        child: Column(
          children: [
            SizedBox(height: 30.h),
            Container(
              height: 637.h,
              decoration: BoxDecoration(
                // color: ColorManager.getColor(name: ColorsType.C_FFFFFF),
                borderRadius: BorderRadius.circular(42.w),
                // border: Border.all(
                //   color: ColorManager.getColor(name: ColorsType.C_43BC9B),
                //   width: 0.5,
                // ),
              ),
              child: Column(
                children: [
                  imageView(
                    R.assetsImagesIconAboutUsLogo,
                    width: 294.w,
                    height: 280.h,
                  ).paddingTop(40.h),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      imageView(
                        R.assetsImagesIconAboutUsLogo,
                        width: 42.w,
                        height: 42.h,
                      ).paddingOnly(top: 10.h, right: 10.w),
                      SizedBox(height: 10.w),
                      Text(
                        "无需填写任何信息，点击一键注册；系统自主给您生成账户。",
                        style: TextStyle(
                          fontSize: 36.sp,
                          // color: ColorManager.getColor(
                          //   name: ColorsType.C_6C8A82,
                          // ),
                          fontFamily: MyFontFamily.miSans,
                          fontWeight: FontWeight.w400,
                        ),
                      ).fill(),
                    ],
                  ).paddingOnly(left: 60.w, right: 60.w, top: 0.h),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      imageView(
                        R.assetsImagesIconAboutUsLogo,
                        width: 42.w,
                        height: 42.h,
                      ).paddingOnly(top: 10.h, right: 10.w),
                      Text(
                        "一键生成的账户，安全且唯一;您可放心使用",
                        style: TextStyle(
                          fontSize: 36.sp,
                          // color: ColorManager.getColor(
                          //   name: ColorsType.C_6C8A82,
                          // ),
                          fontFamily: MyFontFamily.miSans,
                          fontWeight: FontWeight.w400,
                        ),
                      ).fill(),
                    ],
                  ).paddingOnly(left: 60.w, right: 60.w, top: 40.h),
                ],
              ),
            ).paddingOnly(left: 66.w, right: 66.w),
            SizedBox(height: 100.h),
            _actionButton("一键注册", true),
            Spacer(),
            _bottomMenu(),
          ],
        ),
      ),
    );
  }

  Widget _actionButton(String title, bool canSubmit) {
    return Expanded(
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: 80.w),
            height: 132.h,
            padding: EdgeInsets.symmetric(horizontal: 80.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(1322.h),
              boxShadow: [
                BoxShadow(
                  // color: ColorManager.getColor(
                  //   name: ColorsType.C_3ACDA5,
                  // ).withOpacity(0.2), // 阴影颜色
                  spreadRadius: 1, // 扩散范围
                  blurRadius: 10, // 模糊程度
                  offset: Offset(0, 5), // 阴影偏移量 (x, y)
                ),
              ],
              // color:
              //     canSubmit
              //         ? ColorManager.getColor(name: ColorsType.C_3ACDA5)
              //         : ColorManager.getColor(
              //           name: ColorsType.C_3ACDA5,
              //         ).withOpacity(0.36),
            ),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 51.sp,
                // color: ColorManager.getColor(name: ColorsType.C_FFFFFF),
                fontFamily: MyFontFamily.miSans,
                fontWeight: FontWeight.w600,
              ),
            ),
          ).gestureTap(
            onTap: () async {
              if (!canSubmit) {
                return;
              }
              // await audioManager.playLocal(type: AudioType.touch);
              controller.memberWithloginOrregist();
            },
          ),
        ],
      ),
    );
  }

  Widget _bottomMenu() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _bottomButton(
          imgPath: R.assetsImagesIconAboutUsLogo,
          name: "先去逛逛",
          onTap: () {
            Get.back();
            // var controller = Get.find<MainTabController>();
            // controller.selectIndex(0);
          },
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 60.w),
          height: 48.w,
          width: 1.w,
          // color: ColorManager.getColor(name: ColorsType.C_B3B7BD),
        ),
        _bottomButton(
          imgPath: R.assetsImagesIconAboutUsLogo,
          name: "在线客服",
          onTap: () {
            // CommonUtils.openOnlineCustomServerPage();
          },
        ),
      ],
    );
  }

  Widget _buildTabBarItem(LoginTabItem item) {
    return Text(
      "${item.name}",
      // style: TextStyle(
      //   fontSize: 51.sp,
      //   fontFamily: MyFontFamily.miSans,
      //   fontWeight: FontWeight.w600,
      // ),
    );
  }

  Widget _textFliedview({
    required TextEditingController editingController,
    required String icon,
    required String title,
    required String placeholder,
    required int tag,
  }) {
    return Container(
      decoration: BoxDecoration(
        // color: ColorManager.getColor(name: ColorsType.C_FFFFFF),
        borderRadius: BorderRadius.circular(6.w),
      ),
      margin: EdgeInsets.only(top: 5.w, bottom: 5.w, left: 80.w, right: 80.w),
      height: 48.h,
      child: CusTomTextField(
        keyboardType: TextInputType.emailAddress,
        height: 145.h,
        onChange: (val) {
          controller.setSubmitState();
        },
        // boardColor: ColorManager.getColor(name: ColorsType.C_43BC9B),
        // noboardColor: ColorManager.getColor(name: ColorsType.C_CEDAD7),
        allRadius: 30.w,
        leftIcon: Row(
          children: [
            imageView(
              icon,
              width: 48.w,
              height: 48.w,
            ).paddingOnly(left: 40.w, right: 40.w),
            // Visibility(
            //     visible: title.isNotEmpty,
            //     child: Text(title,
            //         style: TextStyle(
            //           fontSize: 45.sp,
            //           color: ColorManager.getColor(name: ColorsType.C_2D2D2D),
            //           fontFamily: MyFontFamily.miSans,
            //           fontWeight: FontWeight.w600,
            //         )).paddingRight(30.w)),
            Container(
              width: 2.w,
              height: 60.w,
              // color: ColorManager.getColor(name: ColorsType.C_D9D9D9),
            ).marginOnly(right: 40.w),
          ],
        ),
        otherIcon:
            tag == 0
                ? CustomPopupMenu(
                  // barrierColor: clearColor(),
                  position: PreferredPosition.bottom,
                  verticalMargin: 0,
                  horizontalMargin: 0,
                  controller: controller.decimalMemuController,
                  pressType: PressType.singleClick,
                  showArrow: false,
                  arrowSize: 36.w,
                  menuOnChange: (v) {
                    controller.statusFilterOpen.value = v;
                  },
                  menuBuilder: () {
                    return Obx(
                      () => Container(
                        decoration: BoxDecoration(
                          // color: clearColor(),
                          borderRadius: BorderRadius.circular(12.w),
                        ),
                        child:
                            controller.accountList.isEmpty
                                ? Center(
                                      child: Text(
                                        "暂无账号数据",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                          fontFamily: MyFontFamily.miSans,
                                          fontSize: 45.sp,
                                          // color: ColorManager.getColor(
                                          //   name: ColorsType.C_2D2D2D,
                                          // ),
                                        ),
                                      ),
                                    )
                                    .alignCenter()
                                    .sized(
                                      width: double.infinity,
                                      height: 156.h,
                                    )
                                    .backgroundImage(
                                      DecorationImage(
                                        fit: BoxFit.fill,
                                        alignment: Alignment.center,
                                        image: AssetImage(
                                          R.assetsImagesIconAboutUsLogo,
                                        ),
                                      ),
                                    )
                                    .marginOnly(right: 10.w, left: 70.w)
                                : ListView.builder(
                                      padding: EdgeInsets.all(0),
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: controller.accountList.length,
                                      itemBuilder: (context, index) {
                                        var count =
                                            controller.accountList.length;
                                        var heightList = [
                                          40.h,
                                          40.h,
                                          50.h,
                                          55.h,
                                          65.h,
                                          75.h,
                                        ];

                                        return Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  controller
                                                      .accountList[index]["account"],
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontFamily:
                                                        MyFontFamily.miSans,
                                                    fontSize: 45.sp,
                                                    // color:
                                                    //     ColorManager.getColor(
                                                    //       name:
                                                    //           ColorsType
                                                    //               .C_2D2D2D,
                                                    //     ),
                                                  ),
                                                ).paddingLeft(30.w),
                                                Center(
                                                      child: imageView(
                                                        R.assetsImagesIconAboutUsLogo,
                                                        height: 16.w,
                                                        width: 16.w,
                                                        // color:
                                                        //     ColorManager.getColor(
                                                        //       name:
                                                        //           ColorsType
                                                        //               .C_FFFFFF,
                                                        //     ),
                                                      ),
                                                    )
                                                    .sized(
                                                      height: 42.w,
                                                      width: 42.w,
                                                    )
                                                    .backgroundColor(
                                                      Colors.black,
                                                      // ColorManager.getColor(
                                                      //   name:
                                                      //       ColorsType.C_000000,
                                                      // ).withAlpha(31),
                                                    )
                                                    .cornerRadiusCircularAll(
                                                      42.w,
                                                    )
                                                    .paddingRight(30.w)
                                                    .gestureTap(
                                                      onTap: () async {
                                                        // controller.decimalMemuController
                                                        //     .hideMenu();
                                                        // await StorageUtil
                                                        //     .delectMemberAccountPsd(
                                                        //       controller
                                                        //           .accountList[index]["account"],
                                                        //     );
                                                        // controller
                                                        //     .placeStorgeAccountPassword(
                                                        //       removeInView:
                                                        //           true,
                                                        //     );
                                                        // printSome(
                                                        //   "controller.accountList---${controller.accountList.length}",
                                                        // );
                                                      },
                                                    ),
                                              ],
                                            )
                                            .sized(height: 105.h)
                                            .backgroundColor(
                                              Colors.black,
                                              // controller.accountIndex.value ==
                                              //         index
                                              //     ? ColorManager.getColor(
                                              //       name: ColorsType.C_7FE3C7,
                                              //     )
                                              //     : ColorManager.getColor(
                                              //       name: ColorsType.C_F4F6F9,
                                              //     ),
                                            )
                                            .cornerRadiusCircularAll(15.w)
                                            .paddingOnly(
                                              bottom: 30.w,
                                              top:
                                                  index == 0
                                                      ? (heightList[count - 1])
                                                      : 0,
                                            )
                                            .gestureTap(
                                              onTap: () {
                                                controller.decimalMemuController
                                                    .hideMenu();
                                                controller.selectAccountIndex(
                                                  index,
                                                );
                                              },
                                            );
                                      },
                                    )
                                    .sized(width: double.infinity)
                                    .paddingOnly(left: 30.w, right: 30.w)
                                    .backgroundColor(Colors.cyan)
                                    .backgroundImage(
                                      DecorationImage(
                                        fit: BoxFit.fill,
                                        alignment: Alignment.topCenter,
                                        image: AssetImage(
                                          R.assetsImagesIconAboutUsLogo,
                                        ),
                                      ),
                                    )
                                    .marginOnly(left: 70.w),
                      ).paddingRight(60.w),
                    );
                  },
                  child: Center(
                    child:
                        !controller.statusFilterOpen.value
                            ? Transform.rotate(
                              angle: 0,
                              child: imageView(
                                R.assetsImagesIconAboutUsLogo,
                                width: 36.w,
                                height: 22.h,
                              ),
                            )
                            : Transform.rotate(
                              angle: math.pi,
                              child: imageView(
                                R.assetsImagesIconAboutUsLogo,
                                width: 36.w,
                                height: 22.h,
                              ),
                            ),
                  ).gestureTap(
                    onTap: () {
                      controller.decimalMemuController.showMenu();
                    },
                  ),
                ).backgroundColor(Colors.transparent)
                : SizedBox(),
        controller: editingController,
        placeholder: placeholder,
        usedInPassword: (tag == 0 || tag == 2) ? false : true,
        hintTextColor: Color(0xFFB3B7BD),
        textColor: Color(0xFF2D2D2D),
        textFontSize: 45.sp,
        hintTextFontSize: 36.sp,
        fontFamily: MyFontFamily.miSans,
        fontWeight: FontWeight.w600,
        hintFontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _phoneNumberView(
    TextEditingController editingController,
    String icon,
    String placeholder,
    int tag,
  ) {
    return Container(
      decoration: BoxDecoration(
        // color: ColorManager.getColor(name: ColorsType.C_FFFFFF),
        borderRadius: BorderRadius.circular(30.w),
      ),
      margin: EdgeInsets.only(top: 5.w, bottom: 5.w, left: 80.w, right: 80.w),
      height: 145.h,
      child: CusTomTextField(
        keyboardType: TextInputType.number,
        height: 145.h,
        hintTextColor: Color(0xFF43BC9B),
        textColor: Color(0xFFCEDAD7),
        allRadius: 30.w,
        leftIcon: Row(
          children: [
            imageView(
              icon,
              width: 48.w,
              height: 48.w,
            ).paddingOnly(left: 30.w, right: 30.w),
            Row(
              children: [
                Text(
                  "+ ${controller.countryData[controller.codeIndexs.value].code}",
                  style: TextStyle(
                    fontSize: 45.sp,
                    // color: ColorManager.getColor(name: ColorsType.C_2D2D2D),
                    fontFamily: MyFontFamily.miSans,
                    fontWeight: FontWeight.w600,
                  ),
                ).paddingRight(30.w),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(36.w),
                    // color: ColorManager.getColor(name: ColorsType.C_E2F5F0),
                  ),
                  height: 36.w,
                  width: 36.w,
                  child: imageView(
                    R.assetsImagesIconAboutUsLogo,
                    width: 20.w,
                    height: 14.h,
                    fit: BoxFit.fitWidth,
                  ),
                ).paddingRight(30.w),
              ],
            ).gestureTap(
              onTap: () {
                return;
                // showAmBottomSheet(
                //   backgroundColor: ColorManager.getColor(
                //     name: ColorsType.C_F4F6F9,
                //   ),
                //   content: AreaPhoneBottomSheet(
                //     titles: "选择区号",
                //     countryData: controller.countryData,
                //     callback: (index) {
                //       controller.codeIndexs.value = index;
                //       controller.update();
                //     },
                //   ),
                // );
              },
            ),
          ],
        ),
        controller: editingController,
        placeholder: placeholder,
        usedInPassword: false,
        textFontSize: 45.sp,
        hintTextFontSize: 36.sp,
        fontFamily: MyFontFamily.miSans,
        fontWeight: FontWeight.w600,
        hintFontWeight: FontWeight.w500,
      ),
    );
  }

  var codeKey = GlobalKey();
}

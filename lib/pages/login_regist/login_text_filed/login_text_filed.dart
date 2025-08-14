import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:roomcard/r.dart';
import 'package:roomcard/utils/common_extension/common_extension.dart';
import 'package:roomcard/utils/image_extension.dart';
import 'package:roomcard/utils/my_font_family.dart';

class CusTomTextField extends StatefulWidget {
  final double height;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final String? placeholder;
  final bool usedInPassword;
  final int? maxLength;
  final Function? onChange;
  final Widget? leftIcon;
  final Color? cursorColor;
  final Color hintTextColor;
  final Color textColor;
  final double textFontSize;
  final double hintTextFontSize;
  final String? fontFamily;
  final FontWeight? fontWeight;
  final FontWeight? hintFontWeight;
  final double? cleanIconRight;
  final double? cleanIconleft;
  final double? colseIconIconRight;
  final double? colseIconIconleft;
  final Color? boardColor;
  final Color? noboardColor;
  final double? allRadius;
  final Widget? otherIcon;
  final double? textFieldPaddingLeft;
  final bool? isLineShow;
  final bool? showEyesWhenInput;
  final Color? bgColor;
  final VoidCallback? callback;

  const CusTomTextField({
    super.key,
    required this.controller,
    required this.hintTextColor,
    required this.textColor,
    required this.textFontSize,
    required this.hintTextFontSize,
    required this.height,
    this.leftIcon,
    this.keyboardType,
    this.placeholder,
    this.callback,
    this.usedInPassword = false,
    this.maxLength,
    this.onChange,
    this.cursorColor,
    this.fontFamily,
    this.fontWeight,
    this.hintFontWeight,
    this.cleanIconRight,
    this.cleanIconleft,
    this.colseIconIconRight,
    this.colseIconIconleft,
    this.boardColor,
    this.allRadius,
    this.bgColor,
    this.otherIcon,
    this.noboardColor,
    this.textFieldPaddingLeft,
    this.isLineShow = false,
    this.showEyesWhenInput = false,
  });

  @override
  State<CusTomTextField> createState() => _LoginTextFieldState();
}

class _LoginTextFieldState extends State<CusTomTextField> {
  var _showClearIcon = false;
  late bool _obscurePassword;
  final FocusNode _focusNode = FocusNode();
  bool _isFocus = false;
  bool _showEyesWhenInput = false;
  @override
  void initState() {
    super.initState();
    _obscurePassword =
        widget.usedInPassword || (widget.showEyesWhenInput ?? false);
    _showEyesWhenInput = false;

    //输入框变化时
    widget.controller.addListener(() {
      var isNotEmpty = widget.controller.text.isNotEmpty && _focusNode.hasFocus;

      setState(() {
        _showClearIcon = isNotEmpty;
      });
    });

    //光标变化时
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        setState(() {
          _isFocus = true;
        });
      } else {
        if (widget.callback != null) {
          widget.callback!();
        }
        setState(() {
          _isFocus = false;
        });
      }

      var isNotEmpty = widget.controller.text.isNotEmpty && _focusNode.hasFocus;
      setState(() {
        _showClearIcon = isNotEmpty;
        if (widget.showEyesWhenInput == true) {
          _showEyesWhenInput = isNotEmpty;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      decoration: BoxDecoration(
        color: widget.bgColor ?? Color(0xFF0F212E),
        borderRadius: BorderRadius.circular(widget.allRadius ?? 24.w),
        border: Border.all(
          color:
              widget.isLineShow == true
                  ? Colors.transparent
                  : (_isFocus == true
                      ? widget.boardColor ?? Colors.transparent
                      : widget.noboardColor ?? Colors.transparent),
          width: 2.w,
        ),
      ),
      child:
          widget.isLineShow == false
              ? tetxFiledView()
              : Column(
                children: [
                  tetxFiledView(),
                  SizedBox(height: 0.5, width: double.infinity)
                      .backgroundColor(
                        widget.isLineShow == false
                            ? Colors.transparent
                            : (_isFocus == true
                                ? widget.boardColor ?? Colors.transparent
                                : widget.noboardColor ?? Colors.transparent),
                      )
                      .paddingOnly(left: 42.w, right: 42.w, top: 30.h),
                ],
              ),
    ).marginOnly(top: 12.h);
  }

  Widget tetxFiledView() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(flex: 0, child: Container(child: widget.leftIcon)),
        Expanded(
          flex: 1,
          child: TextField(
            focusNode: _focusNode,
            cursorColor: widget.cursorColor ?? Color(0xFF1bc69c),
            keyboardType: widget.keyboardType,
            controller: widget.controller,
            obscureText: _obscurePassword,
            obscuringCharacter: "*",
            style: TextStyle(
              fontSize: widget.textFontSize,
              color: widget.textColor,
              fontFamily: widget.fontFamily ?? MyFontFamily.miSans,
              fontWeight: widget.fontWeight ?? FontWeight.w400,
              letterSpacing: 0.5,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              isCollapsed: true,
              hintText: widget.placeholder,
              hintStyle: TextStyle(
                fontSize: widget.hintTextFontSize,
                color: widget.hintTextColor,
                fontFamily: widget.fontFamily ?? MyFontFamily.miSans,
                fontWeight: widget.hintFontWeight ?? FontWeight.normal,
              ),
            ),
            inputFormatters: [
              LengthLimitingTextInputFormatter(widget.maxLength), //限制长度
            ],
            onChanged: (value) {
              setState(() {
                _showClearIcon = value.isNotEmpty;
                _showEyesWhenInput = value.isNotEmpty;
              });
              if (widget.onChange != null) {
                widget.onChange!(value);
              }
            },
          ).paddingLeft(widget.textFieldPaddingLeft ?? 0),
        ),
        _buildClearIcon(),
        _buildPasswordEyeIcon(),
        widget.otherIcon ?? SizedBox(),
        SizedBox(width: 8.w),
      ],
    );
  }

  Widget _buildClearIcon() {
    return _showClearIcon
        ? Center(
              child: imageView(
                R.assetsImagesApokerLoginClear,
                width: 16.w,
                height: 16.h,
                fit: BoxFit.fitHeight,
              ),
            )
            .paddingOnly(
              left: widget.cleanIconleft ?? 4.w,
              right: widget.cleanIconRight ?? 4.w,
            )
            .gestureTap(
              onTap: () {
                widget.controller.clear();

                widget.onChange?.call("");
              },
            )
        : SizedBox(width: widget.usedInPassword ? 5.0 : 0);
  }

  Widget _buildPasswordEyeIcon() {
    return _shouldShowEye()
        ? InkWell(
          child: Center(
            child:
                _obscurePassword
                    ? imageView(
                      R.assetsImagesApokerLoginCloseEyes,
                      width: 20.w,
                      fit: BoxFit.fitWidth,
                    )
                    : imageView(
                      R.assetsImagesApokerLoginOpenEyes,
                      width: 20.w,
                      fit: BoxFit.fitWidth,
                    ),
          ).paddingOnly(right: widget.colseIconIconRight ?? 0.w),
          onTap: () => {setState(() => _obscurePassword = !_obscurePassword)},
        )
        : SizedBox();
  }

  bool _shouldShowEye() {
    if (widget.showEyesWhenInput == true) {
      return _showEyesWhenInput;
    }
    return widget.usedInPassword;
  }
}

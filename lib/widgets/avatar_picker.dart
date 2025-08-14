import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:roomcard/utils/num_px.dart';
import 'package:roomcard/widgets/buttons/confirm_button.dart';

class AvatarPicker extends StatelessWidget {
  final String currentAvatar;
  final Function(String) onAvatarSelected;
  final List<String> avatarOptions;

  const AvatarPicker({
    Key? key,
    required this.currentAvatar,
    required this.onAvatarSelected,
    this.avatarOptions = const [],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showAvatarPicker(context),
      child: Container(
        width: 32.pxw,
        height: 32.pxh,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.pxw),
          image: const DecorationImage(
            image: AssetImage('assets/images/edit_icon.png'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  void _showAvatarPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1C2C36),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      builder: (context) => _AvatarPickerContent(
        currentAvatar: currentAvatar,
        onAvatarSelected: onAvatarSelected,
        avatarOptions: avatarOptions,
      ),
    );
  }
}

class _AvatarPickerContent extends StatefulWidget {
  final String currentAvatar;
  final Function(String) onAvatarSelected;
  final List<String> avatarOptions;

  const _AvatarPickerContent({
    required this.currentAvatar,
    required this.onAvatarSelected,
    required this.avatarOptions,
  });

  @override
  State<_AvatarPickerContent> createState() => _AvatarPickerContentState();
}

class _AvatarPickerContentState extends State<_AvatarPickerContent> {
  late String selectedAvatar;

  @override
  void initState() {
    super.initState();
    selectedAvatar = widget.currentAvatar;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20.pxh,left: 16.pxw, right: 16.pxw),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [


          // 头像选择区域
          SizedBox(
            height: 60.pxh,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widget.avatarOptions.length,
              itemBuilder: (context, index) {
                final avatarPath = widget.avatarOptions[index];
                final isSelected = selectedAvatar == avatarPath;
                
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedAvatar = avatarPath;
                    });
                  },
                  child: Container(
                    width: 60.pxw,
                    height: 60.pxh,
                    margin: EdgeInsets.only(right: 35.pxw),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isSelected 
                          ? const Color(0xFFF9C678) 
                          : Colors.transparent,
                        width: 2.pxw,
                      ),
                      image: DecorationImage(
                        image: AssetImage(avatarPath),
                        fit: BoxFit.cover,
                      ),
                    ),

                  ),
                );
              },
            ),
          ),
          
          Gap(32.pxh),
          
          // 确认按钮
          ConfirmButton(text: '确定',onTap:  () {
            widget.onAvatarSelected(selectedAvatar);
            Navigator.pop(context);
          }),

          Gap(32.pxh),
        ],
      ),
    );
  }
} 
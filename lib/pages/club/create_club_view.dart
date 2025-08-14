import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gap/gap.dart';
import 'package:roomcard/utils/num_px.dart';
import 'package:roomcard/theme/app_theme.dart';
import '../../widgets/common_app_bar.dart';
import '../../widgets/buttons/confirm_button.dart';
import '../../widgets/avatar_picker.dart';
import 'create_club_logic.dart';

/// 创建俱乐部页面
class CreateClubPage extends StatefulWidget {
  const CreateClubPage({super.key});

  @override
  State<CreateClubPage> createState() => _CreateClubPageState();
}

class _CreateClubPageState extends State<CreateClubPage> {
  final logic = Get.put(CreateClubLogic());
  final state = Get.find<CreateClubLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(title: '创建俱乐部'),
      backgroundColor: const Color(0xFF1C2C36),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom + 20.pxh,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.pxw),
            child: Column(
              children: [
                Gap(58.pxh),
                
                // 俱乐部标志区域
                _buildClubLogoSection(),
                
                Gap(32.pxh),
                
                // 输入字段区域
                Column(
                  children: [
                    // 俱乐部名称
                    _buildInputField(
                      label: '俱乐部名称',
                      placeholder: '请输入俱乐部名称',
                      maxLength: 4,
                      controller: state.clubNameController,
                      onChanged: (value) => state.clubNameLength.value = value.length,
                    ),
                    
                    Gap(24.pxh),
                    
                    // 所在地区
                    _buildLocationField(),
                    
                    Gap(24.pxh),
                    
                    // 俱乐部公告
                    _buildAnnouncementField(),
                    
                    Gap(48.pxh),
                    
                    // 创建按钮
                    _buildCreateButton(),
                    
                    Gap(32.pxh),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// 构建俱乐部标志区域
  Widget _buildClubLogoSection() {
    return Column(
      children: [
        // 标志容器
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            Obx(() => Container(
              width: 100.pxw,
              height: 100.pxh,
              decoration: BoxDecoration(
                color: const Color(0x2ED9D9D9),
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage(state.selectedAvatar.value),
                  fit: BoxFit.cover,
                ),
              ),
            )),
            // 头像选择器
            AvatarPicker(
              currentAvatar: state.selectedAvatar.value,
              onAvatarSelected: (avatarPath) => logic.selectAvatar(avatarPath),
              avatarOptions: state.avatarOptions,
            ),
          ],
        ),
        
        Gap(16.pxh),
        
        // 选择俱乐部标志文字
        Text(
          '选择俱乐部标志',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14.pxSp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  /// 构建输入字段
  Widget _buildInputField({
    required String label,
    required String placeholder,
    required int maxLength,
    required TextEditingController controller,
    required Function(String) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 标签
        Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontSize: 14.pxSp,
            fontWeight: FontWeight.w500,
          ),
        ),
        
        Gap(8.pxh),
        
        // 输入框
        Container(
          height: 48.pxh,
          decoration: BoxDecoration(
            color: const Color(0xFF0F212E),
            borderRadius: BorderRadius.circular(8.pxw),
            border: Border.all(color: const Color(0xFF2F4553), width: 2.pxw),
            boxShadow: [
              BoxShadow(
                color: Color(0x33000000), // 对应 #00000033
                offset: Offset(0, 1),
                blurRadius: 3,
                spreadRadius: 0,
              ),
              BoxShadow(
                color: Color(0x1F000000), // 对应 #0000001F
                offset: Offset(0, 1),
                blurRadius: 2,
                spreadRadius: 0,
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  onChanged: onChanged,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.pxSp,
                  ),
                  decoration: InputDecoration(
                    hintText: placeholder,
                    hintStyle: TextStyle(
                      color: AppTheme().current.textColor4,
                      fontSize: 14.pxSp,
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 16.pxw),
                  ),
                ),
              ),
              // 字符计数
              Padding(
                padding: EdgeInsets.only(right: 16.pxw),
                child: Obx(() => Text(
                  '${state.clubNameLength.value}/$maxLength',
                  style: TextStyle(
                    color: AppTheme().current.textColor4,
                    fontSize: 12.pxSp,
                  ),
                )),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// 构建地区选择字段
  Widget _buildLocationField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 标签
        Text(
          '所在地区',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14.pxSp,
            fontWeight: FontWeight.w500,
          ),
        ),
        
        Gap(8.pxh),
        
        // 地区选择框
        GestureDetector(
          onTap: () {
            // TODO: 显示地区选择器
            print('选择地区');
          },
          child: Container(
            height: 48.pxh,
            padding: EdgeInsets.symmetric(horizontal: 16.pxw),
            decoration: BoxDecoration(
              color: const Color(0xFF0F212E),
              borderRadius: BorderRadius.circular(8.pxw),
              border: Border.all(color: const Color(0xFF2F4553), width: 2.pxw),
              boxShadow: [
                BoxShadow(
                  color: Color(0x33000000), // 对应 #00000033
                  offset: Offset(0, 1),
                  blurRadius: 3,
                  spreadRadius: 0,
                ),
                BoxShadow(
                  color: Color(0x1F000000), // 对应 #0000001F
                  offset: Offset(0, 1),
                  blurRadius: 2,
                  spreadRadius: 0,
                ),
              ],
            ),
            child: Row(
              children: [
                // 国旗图标
                Icon(
                  Icons.flag,
                  color: Colors.red,
                  size: 20.pxw,
                ),
                
                Gap(12.pxw),
                
                // 地区名称
                Text(
                  '中国',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.pxSp,
                  ),
                ),
                
                const Spacer(),
                
                // 下拉箭头
                Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.white,
                  size: 20.pxw,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// 构建公告字段
  Widget _buildAnnouncementField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 标签
        Text(
          '俱乐部公告',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14.pxSp,
            fontWeight: FontWeight.w500,
          ),
        ),
        
        Gap(8.pxh),
        
        // 公告输入框
        Container(
          height: 120.pxh,
          decoration: BoxDecoration(
            color: const Color(0xFF0F212E),
            borderRadius: BorderRadius.circular(8.pxw),
            border: Border.all(color: const Color(0xFF2F4553), width: 2.pxw),
            boxShadow: [
              BoxShadow(
                color: Color(0x33000000), // 对应 #00000033
                offset: Offset(0, 1),
                blurRadius: 3,
                spreadRadius: 0,
              ),
              BoxShadow(
                color: Color(0x1F000000), // 对应 #0000001F
                offset: Offset(0, 1),
                blurRadius: 2,
                spreadRadius: 0,
              ),
            ],
          ),
          child: Stack(
            children: [
              // 文本输入框
              TextField(
                controller: state.announcementController,
                onChanged: (value) => state.announcementLength.value = value.length,
                maxLines: null,
                expands: true,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.multiline,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.pxSp,
                ),
                decoration: InputDecoration(
                  hintText: '请输入俱乐部公告',
                  hintStyle: TextStyle(
                    color: AppTheme().current.textColor4,
                    fontSize: 14.pxSp,
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(16.pxw),
                ),
              ),
              
              // 字符计数
              Positioned(
                bottom: 16.pxh,
                right: 16.pxw,
                child: Obx(() => Text(
                  '${state.announcementLength.value}/100',
                  style: TextStyle(
                    color: AppTheme().current.textColor4,
                    fontSize: 12.pxSp,
                  ),
                )),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// 构建创建按钮
  Widget _buildCreateButton() {
    return ConfirmButton(
      text: '创建',
      onTap: () => logic.createClub(),
    );
  }
} 
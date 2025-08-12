import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gap/gap.dart';
import 'package:roomcard/utils/num_px.dart';
import 'package:roomcard/theme/app_theme.dart';
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
      backgroundColor: const Color(0xFF1A1A1A),
      body: SafeArea(
        child: Column(
          children: [
            // 头部
            _buildHeader(),
            
            Gap(32.pxh),
            
            // 俱乐部标志区域
            _buildClubLogoSection(),
            
            Gap(32.pxh),
            
            // 输入字段区域
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 18.pxw),
                child: Column(
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
                    
                    const Spacer(),
                    
                    // 创建按钮
                    _buildCreateButton(),
                    
                    Gap(32.pxh),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 构建头部
  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18.pxw, vertical: 16.pxh),
      child: Row(
        children: [
          // 返回按钮
          GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              width: 40.pxw,
              height: 40.pxh,
              decoration: BoxDecoration(
                color: const Color(0xFF3A3A3A),
                borderRadius: BorderRadius.circular(8.pxw),
              ),
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
                size: 20.pxw,
              ),
            ),
          ),
          
          const Spacer(),
          
          // 标题
          Text(
            '创建俱乐部',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.pxSp,
              fontWeight: FontWeight.w600,
            ),
          ),
          
          const Spacer(),
          
          // 占位，保持标题居中
          SizedBox(width: 40.pxw),
        ],
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
            Container(
              width: 120.pxw,
              height: 120.pxh,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage('assets/images/home/俱乐部.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // 编辑图标
            Container(
              width: 32.pxw,
              height: 32.pxh,
              decoration: BoxDecoration(
                color: const Color(0xFFFF6B35),
                borderRadius: BorderRadius.circular(6.pxw),
              ),
              child: Icon(
                Icons.edit,
                color: Colors.white,
                size: 18.pxw,
              ),
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
            color: const Color(0xFF2A2A2A),
            borderRadius: BorderRadius.circular(8.pxw),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  onChanged: onChanged,
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
              color: const Color(0xFF2A2A2A),
              borderRadius: BorderRadius.circular(8.pxw),
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
            color: const Color(0xFF2A2A2A),
            borderRadius: BorderRadius.circular(8.pxw),
          ),
          child: Stack(
            children: [
              // 文本输入框
              TextField(
                controller: state.announcementController,
                onChanged: (value) => state.announcementLength.value = value.length,
                maxLines: null,
                expands: true,
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
    return Container(
      width: double.infinity,
      height: 48.pxh,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFFD700), Color(0xFFDAA520)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(8.pxw),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => logic.createClub(),
          borderRadius: BorderRadius.circular(8.pxw),
          child: Center(
            child: Text(
              '创建',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.pxSp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
} 
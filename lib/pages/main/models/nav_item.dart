import 'package:flutter/material.dart';

class NavItem {
  final String iconPath; // SVG图标路径
  final String activeIconPath; // 激活状态SVG图标路径
  final String label;
  final Widget page;

  const NavItem({
    required this.label,
    required this.page,
    required this.iconPath,
    required this.activeIconPath,
  });
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:roomcard/widgets/common_app_bar.dart';

import '../../../r.dart';

class BusinessPage extends StatefulWidget {
  const BusinessPage({super.key});

  @override
  State<BusinessPage> createState() => _BusinessPageState();
}

class _BusinessPageState extends State<BusinessPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(extendBody: true, appBar: CommonAppBar(title: '商务合作'));
  }

  @override
  void dispose() {
    super.dispose();
  }
}

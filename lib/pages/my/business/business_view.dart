import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../r.dart';

class BusinessPage extends StatefulWidget {
  const BusinessPage({super.key});

  @override
  State<BusinessPage> createState() => _BusinessPageState();
}

class _BusinessPageState extends State<BusinessPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: const Text(
          '商务合作',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Image.asset(R.assetsIconArrowBack),
          onPressed: () => Get.back(),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

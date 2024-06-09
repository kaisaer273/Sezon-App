import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sezon_app/app/modules/home/controllers/main_nav.controller.dart';
import 'package:sezon_app/app/routes/app_pages.dart';
import 'package:sezon_app/generated/assets.dart';

class LogoutAvatar extends StatelessWidget {
  const LogoutAvatar({
    super.key,
    required this.controller,
  });

  final MainNavController controller;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: (value) {
        if (value == 'logout') {
          controller.signOut();
        } else if (value == 'profile') {
          Get.toNamed(AppPages.USER_PROFILE);
        }
      },
      itemBuilder: (BuildContext context) {
        return <PopupMenuEntry<String>>[
          PopupMenuItem<String>(
            value: 'logout',
            textStyle: TextStyle(
              color: Colors.black,
              fontSize: 15.sp,
              fontWeight: FontWeight.bold,
            ),
            child: const Center(child: Text('تسجيل خروج')),
          ),
          PopupMenuItem<String>(
            value: 'profile',
            textStyle: TextStyle(
              color: Colors.black,
              fontSize: 15.sp,
              fontWeight: FontWeight.bold,
            ),
            child: const Center(child: Text('بيانات الحساب')),
          ),
        ];
      },
      child: Obx(() {
        final storedImage = controller.storedImage.value;
        return storedImage != null
            ? CircleAvatar(
                backgroundColor: Colors.grey.shade300,
                backgroundImage: FileImage(File(storedImage.path)),
              )
            : CircleAvatar(
                backgroundColor: Colors.grey.shade300,
                backgroundImage: const AssetImage(Assets.imagesPerson1),
              );
      }),
    );
  }
}

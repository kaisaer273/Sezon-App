import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PaymentAppBar extends StatelessWidget implements PreferredSizeWidget {
  const PaymentAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,

      title: Text(
        'اتمام عملية الشراء',
        style: TextStyle(
          color: Colors.black,
          fontSize: 20.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
      leading: IconButton(
        onPressed: () => Get.back(),
        icon: const Icon(
          Icons.arrow_back_ios,
          color: Colors.black,
          size: 28,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56.0.h);
}
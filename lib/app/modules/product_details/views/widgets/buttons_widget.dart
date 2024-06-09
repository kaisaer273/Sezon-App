import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sezon_app/app/modules/product_details/controllers/product_details_controller.dart';
import 'package:sezon_app/app/routes/app_pages.dart';
import 'package:sezon_app/utils/colors.dart';

class ButtonsWidget extends StatelessWidget {
  const ButtonsWidget({
    super.key,
    required this.controller,
  });

  final ProductDetailsController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.h),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: AppColors.customRed),
        ),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () => controller.addProductToCart(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  minimumSize: Size(155.w, 45.h),
                  shape: const RoundedRectangleBorder(side: BorderSide.none),
                ),
                child: const Text(
                  'إضافة إلى سلة الطلبات',
                  style: TextStyle(color: AppColors.customRed),
                ),
              ),
            ),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  Get.toNamed(AppPages.PAYMENT);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.customRed,
                  minimumSize: Size(160.w, 45.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8.r),
                      bottomLeft: Radius.circular(8.r),
                    ),
                  ),
                ),
                child: const Text('شراء الان'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

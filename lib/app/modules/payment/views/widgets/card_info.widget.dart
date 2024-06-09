import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sezon_app/app/modules/payment/views/widgets/text_field_widget.dart';
import 'package:sezon_app/utils/colors.dart';

class CardInfo extends StatelessWidget {
  const CardInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: ListView(
        shrinkWrap: true,
        children: [
          Row(
            children: [
              Container(
                width: 3.w,
                height: 25.h,
                color: AppColors.customRed,
              ),
              SizedBox(width: 10.w),
              Text(
                'بيانات البطاقة',
                style: TextStyle(
                  fontSize: 17.sp,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
          SizedBox(height: 40.h),
          const PaymentTextField(
            labelText: 'الاسم في البطاقة',
            hint: 'وسيم الجندي',
          ),
          SizedBox(height: 40.h),
          const PaymentTextField(
            labelText: 'رقم البطاقة',
            hint: '4523 8951 6314 8952',
          ),
          SizedBox(height: 40.h),
          Row(
            children: [
              const Expanded(
                child: PaymentTextField(
                  labelText: 'تاريخ الانتهاء',
                  hint: '25/7',
                ),
              ),
              SizedBox(width: 10.h),
              const Expanded(
                child: PaymentTextField(
                  labelText: 'رمز cvv',
                  hint: '0000',
                ),
              ),
            ],
          ),
          SizedBox(height: 40.h),
          ElevatedButton(
            onPressed: () => Get.back(),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.customRed,
            ),
            child: const Text('حفظ'),
          ),
        ],
      ),
    );
  }
}

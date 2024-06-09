import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sezon_app/app/modules/payment/controllers/payment.controller.dart';
import 'package:sezon_app/app/modules/payment/views/widgets/app_bar_widget.dart';
import 'package:sezon_app/app/modules/payment/views/widgets/payment_details.card.dart';
import 'package:sezon_app/app/modules/payment/views/widgets/product_details.card.dart';
import 'package:sezon_app/app/modules/payment/views/widgets/summary_widget.dart';
import 'package:sezon_app/app/modules/stripe_payment/payment_manager.dart';
import 'package:sezon_app/utils/colors.dart';

class PaymentConfirmation extends GetView<PaymentController> {
  const PaymentConfirmation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PaymentAppBar(),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        children: [
          const PaymentDetailsCard(
            leadingIcon: Icons.location_on,
            title:
                'الامارات، محافظة الشمال، الشيخ زايد شارع الجامعات، الطابق الثالث، 872 +9720592072429',
          ),
          SizedBox(height: 20.h),
          PaymentDetailsCard(
            title: 'بطاقة فيزا',
            fontSize: 16.sp,
            leadingIcon: Icons.credit_card,
          ),
          SizedBox(height: 20.h),
          const ProductDetailsCard(),
          SizedBox(height: 20.h),
          Text(
            'الملخص',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18.sp,
            ),
          ),
          SizedBox(height: 10.h),
          const SummaryWidget(title: 'مدة الشحن', subTitle: '5 ايام'),
          SizedBox(height: 10.h),
          const SummaryWidget(title: 'إجمالي تكلفة المنتج', subTitle: '130ر.س'),
          SizedBox(height: 10.h),
          const SummaryWidget(title: 'إجمالي تكلفة الشحن', subTitle: '90ر.س'),
          SizedBox(height: 10.h),
          const SummaryWidget(title: 'المجموع الكلي', subTitle: '210ر.س'),
          SizedBox(height: 20.h),
          ElevatedButton(
            onPressed: () => PaymentManager.makePayment(100, 'USD'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.customRed,
              minimumSize: Size(double.infinity, 50.h),
            ),
            child: const Text('تأكيد الطلب'),
          ),
        ],
      ),
    );
  }
}

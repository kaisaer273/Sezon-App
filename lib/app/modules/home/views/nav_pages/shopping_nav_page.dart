import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sezon_app/app/modules/home/controllers/shopping_controller.dart';
import 'package:sezon_app/app/modules/home/views/widgets/product_cart_list.widget.dart';
import 'package:sezon_app/utils/colors.dart';

class ShoppingNavPage extends GetView<ShoppingController> {
  const ShoppingNavPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          const SizedBox(height: 20),
          TabBar(
            labelStyle: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.bold),
            indicatorColor: AppColors.customRed,
            onTap: (index) => controller.changeTabIndex(index),
            tabs: const [
              Tab(
                text: 'طلبات قيد التنفيذ',
              ),
              Tab(
                text: 'طلبات مستلمة',
              ),
            ],
          ),
          Expanded(
            child: Obx(
              () => IndexedStack(
                index: controller.selectedIndex.value,
                children: [
                  const ProductCartList(),
                  Center(
                    child: Text(
                      'لا توجد طلبات تم تسليمها 🥲',
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

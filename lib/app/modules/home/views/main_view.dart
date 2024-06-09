import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sezon_app/app/components/logout_avatar.widget.dart';
import 'package:sezon_app/app/modules/home/controllers/main_nav.controller.dart';
import 'package:sezon_app/app/modules/home/views/nav_pages/category_nav_page.dart';
import 'package:sezon_app/app/modules/home/views/nav_pages/favourite_nav_page.dart';
import 'package:sezon_app/app/modules/home/views/nav_pages/home_nav_page.dart';
import 'package:sezon_app/app/modules/home/views/nav_pages/shopping_nav_page.dart';
import 'package:sezon_app/app/modules/home/views/widgets/bottom_nav_bar.dart';
import 'package:sezon_app/app/components/custom_app_bar.dart';
import 'package:sezon_app/app/routes/app_pages.dart';
import 'package:sezon_app/utils/colors.dart';

class MainView extends GetView<MainNavController> {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Obx(
            () => Text(
              controller.homeController.changeTabTitle(),
              style: TextStyle(
                color: Colors.black,
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        leadingWidget: LogoutAvatar(controller: controller),
        trailingWidget: IconButton(
          onPressed: () => Get.toNamed(AppPages.NOTIFICATION),
          icon: const Icon(
            Icons.notifications,
            color: Colors.grey,
            size: 28,
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(controller: controller),
      body: Obx(
        () => IndexedStack(
          index: controller.homeController.tabIndex.value,
          children: const [
            HomeNavPage(),
            CategoryNavPage(),
            ShoppingNavPage(),
            FavouriteNavPage(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(Routes.ADMIN_ADD_PRODUCTS),
        backgroundColor: AppColors.customRed,
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }
}

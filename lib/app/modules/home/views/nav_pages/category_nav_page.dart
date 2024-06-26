import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sezon_app/app/modules/home/controllers/category_controller.dart';
import 'package:sezon_app/app/modules/home/views/widgets/category_nav_list.dart';
import 'package:sezon_app/app/modules/home/views/widgets/category_products.dart';

class CategoryNavPage extends GetView<CategoryController> {
  const CategoryNavPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Obx(
        () {
          return controller.isLoading.value
              ? const Center(
                  child: CupertinoActivityIndicator(),
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CategoryNavList(controller: controller),
                    CategoryProducts(controller: controller),
                  ],
                );
        },
      ),
    );
  }
}

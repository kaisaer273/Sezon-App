import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sezon_app/app/modules/home/controllers/home_controller.dart';
import 'package:sezon_app/app/routes/app_pages.dart';
import 'package:sezon_app/utils/colors.dart';

class ProductItemsList extends StatelessWidget {
  const ProductItemsList({super.key, required this.controller});

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const CupertinoActivityIndicator();
      } else {
        return controller.productsList.isEmpty
            ? Center(
                child: Text(
                  'لا توجد عناصر لعرضها 🙁',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 17.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            : GridView.builder(
                padding: EdgeInsets.symmetric(
                  horizontal: 10.w,
                  vertical: 10.h,
                ),
                itemCount: controller.productsList.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Get.toNamed(
                        AppPages.PRODUCT_DETAILS,
                        arguments: controller.productsList[index]
                            ['product_name'],
                      );
                    },
                    child: Card(
                      elevation: 4,
                      clipBehavior: Clip.antiAlias,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Stack(
                        children: [
                          Image.network(
                            controller.productsList[index]['product_image'],
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: 110.h,
                          ),
                          Positioned(
                            top: 10.h,
                            right: 110.w,
                            child: Container(
                              width: 30.w,
                              height: 30.h,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white30,
                              ),
                              child: InkWell(
                                onTap: () {
                                  controller.performFavourite(controller
                                      .productsList[index]['product_name']);
                                },
                                child: Icon(
                                  controller.productsList[index]
                                              ['is_favourite'] ==
                                          true
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: Colors.white70,
                                ),
                              ),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Center(
                                child: Text(
                                  controller.productsList[index]
                                      ['product_name'],
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                  ),
                                ),
                              ),
                              Text(
                                controller.productsList[index]['product_price'],
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  color: AppColors.customRed,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
      }
    });
  }
}

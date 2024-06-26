import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:sezon_app/app/components/custom_snackbar.dart';
import 'package:sezon_app/app/modules/home/controllers/favourite_controller.dart';

class HomeController extends GetxController {
  late List<dynamic> users;
  final formKey = GlobalKey<FormState>();
  final editController = TextEditingController();
  final tabIndex = 0.obs;
  var product;
  RxString selectedProduct = ''.obs;
  RxBool isLoading = false.obs;
  List<Map<String, dynamic>> categoriesList = [];
  RxList<dynamic> productsList = [].obs;
  RxList<dynamic> searchedProducts = RxList<Map<String, dynamic>>([]);

  void changeTabIndex(int index) {
    tabIndex.value = index;
  }

  void setFavouriteProduct(String productName) {
    selectedProduct.value = productName;
  }

  String changeTabTitle() {
    if (tabIndex.value == 0) {
      return 'الرئيسية';
    } else if (tabIndex.value == 1) {
      return 'الفئات';
    } else if (tabIndex.value == 2) {
      return 'طلباتي';
    } else if (tabIndex.value == 3) {
      return 'المفضلة';
    }
    return 'بدون عنوان';
  }

  Future<dynamic> searchProducts(String keyword) async {
    if (keyword.isNotEmpty) {
      final QuerySnapshot query = await FirebaseFirestore.instance
          .collection('products')
          .where('product_name', isGreaterThanOrEqualTo: keyword)
          .where('product_name', isLessThanOrEqualTo: '$keyword\uf8ff')
          .get();

      searchedProducts.value =
          query.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
      return searchedProducts;
    } else {
      searchedProducts.clear();
    }
  }

  Future<List<Map<String, dynamic>>> getCategoriesList() async {
    isLoading.value = true;
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('categories').get();
      for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
        Map<String, dynamic> categoryData =
            (documentSnapshot.data() as Map<String, dynamic>);
        categoriesList.add(categoryData);
        isLoading.value = false;
      }
    } catch (e) {
      Logger().e(e);
    }
    return categoriesList;
  }

  Future<RxList> getProductsList() async {
    isLoading.value = true;
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('products').get();
      for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
        Map<String, dynamic> productData =
            (documentSnapshot.data() as Map<String, dynamic>);
        productsList.add(productData);
        isLoading.value = false;
      }
    } catch (e) {
      Logger().e(e);
    }
    return productsList;
  }

  Future<DocumentSnapshot?> getProductByName() async {
    isLoading.value = true;
    try {
      CollectionReference collection =
          FirebaseFirestore.instance.collection('products');

      QuerySnapshot querySnapshot = await collection
          .where('product_name', isEqualTo: selectedProduct.value)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        isLoading.value = false;
        return querySnapshot.docs.first;
      } else {
        return null;
      }
    } catch (e) {
      Logger().e(e);
      isLoading.value = false;
      return null;
    }
  }

  fetchProduct() async {
    isLoading.value = true;
    DocumentSnapshot? document = await getProductByName();
    if (document != null) {
      product = document.data();
      isLoading.value = false;
    } else {
      Logger().e('Document not found');
    }
  }

  void addProductToFavourites() async {
    isLoading.value = true;
    var userId = FirebaseAuth.instance.currentUser!.uid;

    if (product != null) {
      final productName = product['product_name'];

      try {
        final productQuery = await FirebaseFirestore.instance
            .collection('products')
            .where('product_name', isEqualTo: productName)
            .get();

        if (productQuery.docs.isNotEmpty) {
          final productDocRef = productQuery.docs.first.reference;
          await productDocRef.update({
            'is_favourite': true,
          });

          final productIndex = productsList.indexWhere(
            (product) => product['product_name'] == productName,
          );
          if (productIndex != -1) {
            productsList[productIndex]['is_favourite'] = true;
          }

          final cartRef = FirebaseFirestore.instance
              .collection('user_favourites')
              .doc(userId);

          await cartRef.set({
            'favouriteItems': FieldValue.arrayUnion([
              {
                'product_name': productName,
                'product_description': product['product_description'],
                'product_price': product['product_price'],
                'product_image': product['product_image'],
                'category_name': product['category_name'],
                'is_favourite': true,
              }
            ])
          }, SetOptions(merge: true));

          isLoading.value = false;
          Get.find<FavouriteController>().fetchFavouriteItems();
          CustomSnackBar.showCustomSnackBar(
            title: 'تمت الاضافة بنجاح',
            message: 'تم اضافة هذا المنتج الى المفضلات ❤️',
          );
        } else {
          CustomSnackBar.showCustomErrorSnackBar(
            title: 'المنتج غير موجود',
            message:
                'عذرًا، المنتج الذي تحاول اضافته غير موجود في قاعدة البيانات.',
          );
        }
      } catch (e) {
        CustomSnackBar.showCustomErrorSnackBar(
          title: 'حدث خطأ ما',
          message: 'لم تنجح عملية الاضافة ، يرجى اعادة المحاولة 🙁',
        );
        print('Error: $e');
      }
    } else {
      CustomSnackBar.showCustomErrorSnackBar(
        title: 'حدث خطأ ما',
        message: 'لم تنجح عملية الاضافة ، يرجى اعادة المحاولة 🙁',
      );
    }
  }

  void performFavourite(String productName) async {
    setFavouriteProduct(productName);
    await fetchProduct();
    addProductToFavourites();
  }

  @override
  void onInit() {
    getCategoriesList();
    getProductsList();
    super.onInit();
  }
}

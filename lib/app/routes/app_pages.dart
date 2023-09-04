import 'package:get/get.dart';
import 'package:sezon_app/app/modules/code_check/bindings/register_code_binding.dart';
import 'package:sezon_app/app/modules/code_check/views/register_code_view.dart';
import 'package:sezon_app/app/modules/home/views/main_view.dart';
import 'package:sezon_app/app/modules/launch_view.dart';
import 'package:sezon_app/app/modules/login/bindings/login_binding.dart';
import 'package:sezon_app/app/modules/login/views/login_view.dart';
import 'package:sezon_app/app/modules/payment/bindings/payment_bindings.dart';
import 'package:sezon_app/app/modules/payment/views/payment_view.dart';
import 'package:sezon_app/app/modules/product_details/bindings/product_details_binding.dart';
import 'package:sezon_app/app/modules/product_details/views/product_details_view.dart';
import 'package:sezon_app/app/modules/register/bindings/register_binding.dart';
import 'package:sezon_app/app/modules/register/views/register_view.dart';
import '../modules/home/bindings/home_binding.dart';
part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.INITIAL;
  static const HOME = Routes.HOME;
  static const LOGIN = Routes.LOGIN;
  static const REGISTER = Routes.REGISTER;
  static const REGISTER_CODE = Routes.REGISTER_CODE;
  static const PRODUCT_DETAILS = Routes.PRODUCT_DETAILS;
  static const PAYMENT = Routes.PAYMENT;

  static final routes = [
    GetPage(
      name: _Paths.INITIAL,
      page: () => const LaunchView(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () =>  MainView(),
      binding: MainBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER_CODE,
      page: () => const RegisterCodeView(),
      binding: RegisterCodeBinding(),
    ),
    GetPage(
      name: _Paths.PRODUCT_DETAILS,
      page: () => ProductDetailsView(),
      binding: ProductsDetailsBinding(),
    ),
    GetPage(
      name: _Paths.PAYMENT,
      page: () => PaymentView(),
      binding: PaymentBindings(),
    ),
  ];
}

import 'package:ecommarce/modules/home/view/cart_view.dart';
import 'package:ecommarce/modules/home/binding/home_binding.dart';
import 'package:ecommarce/modules/home/view/details_view.dart';
import 'package:ecommarce/modules/home/view/home_view.dart';
import 'package:flutter/animation.dart';
import 'package:get/get.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.DETAILS,
      page: () => DetailsView(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: _Paths.CART,
      page: () => const CartView(),
      transition: Transition.rightToLeft,
      curve: Curves.easeIn,
      transitionDuration: const Duration(milliseconds: 300),
    ),
  ];
}

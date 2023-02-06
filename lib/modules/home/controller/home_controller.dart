import 'package:ecommarce/data/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/services/product_service.dart';

class HomeController extends GetxController {
  var productList = <ProductModel>[].obs;
  var filterProductList = <ProductModel>[].obs;
  var searchController = TextEditingController().obs;
  var cartList = <ProductModel>[].obs;
  var isFavourite = false.obs;
  var isLoading = false.obs;
  var subtotal = 0.0.obs;

  @override
  void onInit() {
    getProduct();
    super.onInit();
  }

  void getProduct() {
    isLoading.value = true;
    ProductService().getProduct(onSuccess: (data) {
      productList.assignAll(data);
      filterProductList.assignAll(productList);
      isLoading.value = false;
    }, onError: (error) {
      isLoading.value = false;
      debugPrint('------------- Product loading failed $error');
    });
  }

  void filter() {
    filterProductList.assignAll(productList);
    if (searchController.value.text.isNotEmpty) {
      filterProductList.assignAll(filterProductList
          .where((e) => e.title!
          .toLowerCase()
          .contains(searchController.value.text.toLowerCase()))
          .toList());
    }
  }

  void addToCart({required ProductModel productModel}) {
    cartList.add(productModel);
    cartCalculation();
  }

  /// [tag] 1 for increase 2 for decrease
  void updateQuantity({required int id, required int tag}) {

    final ProductModel productModel = cartList.where((e) => e.id == id).first;
    tag == 1
        ? productModel.quantity = productModel.quantity! + 1
        : productModel.quantity! > 1
        ? productModel.quantity = productModel.quantity! - 1
        : cartList.remove(productModel);
    cartCalculation();
    update();
  }

  void cartCalculation(){
    subtotal.value = cartList.fold(0, (previousValue, element) => previousValue + (element.quantity! * element.price!));
  }

}

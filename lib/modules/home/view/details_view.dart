import 'package:ecommarce/modules/home/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math' as math;

import '../../../data/models/product_model.dart';
import '../../../data/resources/colors.dart';
import '../../../routes/app_pages.dart';

class DetailsView extends GetView<HomeController> {
  DetailsView({Key? key}) : super(key: key);

  final productModel = Get.arguments;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery
        .of(context)
        .size
        .width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            width: width,
            height: 320,
            decoration: const BoxDecoration(
                color: AppColors.productBg,
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20))),
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: const Icon(
                            Icons.keyboard_arrow_left_outlined,
                            size: 25,
                          )),
                      Obx(() {
                        return GestureDetector(
                            onTap: () {
                              controller.isFavourite.value =
                              !controller.isFavourite.value;
                            },
                            child: controller.isFavourite.value
                                ? const Icon(
                              Icons.favorite_outlined,
                              size: 25,
                              color: Colors.red,
                            )
                                : const Icon(
                              Icons.favorite_border,
                              size: 25,
                            ));
                      }),
                    ],
                  ),
                ),
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Transform.rotate(
                      angle: (math.pi / 180) * -15,
                      child: Container(
                        height: 200,
                        width: 200,
                        decoration: BoxDecoration(
                            color: AppColors.itemBg,
                            borderRadius: BorderRadius.circular(15)),
                      ),
                    ),
                    Positioned.fill(
                      child: Image.network(
                        productModel.image.toString(),
                        fit: BoxFit.contain,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            productModel.category.toString(),
                            style: GoogleFonts.roboto(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: Colors.black),
                          ),
                          const SizedBox(
                            height: 8.0,
                          ),
                          Text(productModel.title.toString(),
                              style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  color: Colors.black)),
                        ],
                      ),
                    ),
                    Text("\$ ${productModel.price}",
                        style: GoogleFonts.lato(
                            fontWeight: FontWeight.w600,
                            fontSize: 24,
                            color: AppColors.detailsPriceColor)),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Obx(() {
                  return ElevatedButton(
                      onPressed: () {
                        controller.cartList.any((element) =>
                        element.id == productModel.id) ? null : controller.addToCart(
                            productModel: ProductModel(
                                id: productModel
                                    .id,
                                image: productModel
                                    .image,
                                price: productModel
                                    .price,
                                title: productModel
                                    .title,
                                quantity: 1));
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: controller.cartList.any((element) =>
                          element.id == productModel.id) ? AppColors.productBg : AppColors.buttonBg,
                          fixedSize: Size(width * 0.7, 50),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15))),
                      child:
                      Text(
                          controller.cartList.any((element) =>
                          element.id == productModel.id) ?
                          'Already added to cart' : 'Add to cart',
                          style: GoogleFonts.lato(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              color: Colors.black54)));
                }),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  productModel.description.toString(),
                  style:
                  GoogleFonts.roboto(fontSize: 12, color: Colors.black45),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: Obx(() {
        return Visibility(
          visible: controller.cartList.isNotEmpty,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              FloatingActionButton(
                onPressed: () {
                  Get.toNamed(Routes.CART);
                },
                backgroundColor: AppColors.floatingBtnColor,
                child: const Icon(
                  Icons.shopping_cart_outlined,
                  color: AppColors.primary,
                ),
              ),
              Positioned(
                  top: -10,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.detailsPriceColor),
                    child: Text(
                      "${controller.cartList.length}",
                      style: GoogleFonts.lato(
                          fontSize: 14,
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600),
                    ),
                  ))
            ],
          ),
        );
      }),
    );
  }
}

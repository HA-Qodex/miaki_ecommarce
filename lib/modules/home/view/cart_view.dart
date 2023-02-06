import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommarce/modules/home/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math' as math;

import '../../../data/resources/colors.dart';

class CartView extends GetView<HomeController> {
  const CartView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery
        .of(context)
        .size
        .width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        title: Text(
          'Cart',
          style: GoogleFonts.roboto(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Obx(() {
              return controller.cartList.isEmpty
                  ? Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/empty.svg',
                        height: 45,
                        width: 44,
                        color: Colors.grey,
                      ),
                      Text(
                        'No Product',
                        style: GoogleFonts.roboto(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey,
                            fontStyle: FontStyle.italic),
                      )
                    ],
                  ),
                ),
              )
                  : Expanded(
                child: ListView.builder(
                    itemCount: controller.cartList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: IntrinsicHeight(
                          child: Container(
                            width: width,
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                                color: AppColors.productBg,
                                borderRadius: BorderRadius.circular(20)),
                            child: Row(
                              children: [
                                Stack(
                                  clipBehavior: Clip.none,
                                  fit: StackFit.passthrough,
                                  children: [
                                    Transform.rotate(
                                      angle: (math.pi / 180) * -15,
                                      child: Container(
                                        height: 80,
                                        width: 80,
                                        decoration: BoxDecoration(
                                            color: AppColors.itemBg,
                                            borderRadius:
                                            BorderRadius.circular(15)),
                                      ),
                                    ),
                                    Positioned.fill(
                                        child: CachedNetworkImage(
                                          imageUrl: controller.cartList[index]
                                              .image
                                              .toString(),
                                          progressIndicatorBuilder: (context,
                                              url,
                                              downloadProgress) =>
                                              CircularProgressIndicator(
                                                  value: downloadProgress
                                                      .progress),
                                          errorWidget: (context, url, error) =>
                                          const Icon(
                                            Icons.error_outline,
                                            size: 26,
                                          ),
                                          width: 120,
                                          height: 100,
                                        ))
                                  ],
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Text(
                                      controller.cartList[index].title
                                          .toString(),
                                      key: const Key('title'),
                                      style: GoogleFonts.roboto(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: Colors.black)),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text("\$ ${controller.cartList[index]
                                        .price}",
                                        style: GoogleFonts.roboto(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            color: AppColors.priceColor)),
                                    GetBuilder<HomeController>(
                                        builder: (cartController) {
                                          return Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  cartController.updateQuantity(
                                                      id: cartController
                                                          .cartList[index].id!,
                                                      tag: 2);
                                                },
                                                child: Card(
                                                  elevation: 3,
                                                  shape: const CircleBorder(),
                                                  child: Container(
                                                    padding: const EdgeInsets
                                                        .all(5),
                                                    decoration: const BoxDecoration(
                                                        color: AppColors.cartBg,
                                                        shape: BoxShape.circle),
                                                    child: const Icon(
                                                      Icons.remove,
                                                      size: 20,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets
                                                    .symmetric(
                                                    horizontal: 5.0),
                                                child: Text(
                                                    "${cartController
                                                        .cartList[index]
                                                        .quantity}",
                                                    style: GoogleFonts.roboto(
                                                        fontWeight: FontWeight
                                                            .bold,
                                                        fontSize: 16,
                                                        color: AppColors
                                                            .priceColor)),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  cartController.updateQuantity(
                                                      id: cartController
                                                          .cartList[index].id!,
                                                      tag: 1);
                                                },
                                                child: Card(
                                                  elevation: 1,
                                                  shape: const CircleBorder(),
                                                  child: Container(
                                                    padding: const EdgeInsets
                                                        .all(5),
                                                    decoration: const BoxDecoration(
                                                        color: AppColors.cartBg,
                                                        shape: BoxShape.circle),
                                                    child: const Icon(
                                                      Icons.add,
                                                      size: 20,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        })
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              );
            }),
            const Divider(color: Colors.grey, thickness: 1,),
            Obx(() {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      "Subtotal: ",
                      style: GoogleFonts.roboto(
                          fontSize: 14,
                          color: Colors.black)),
                  Text(
                      "\$${controller.subtotal.value.toStringAsFixed(2)}",
                      style: GoogleFonts.roboto(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.black))
                ],);
            }),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                    "Delivery: ",
                    style: GoogleFonts.roboto(
                        fontSize: 14,
                        color: Colors.black)),
                Text(
                    "\$10",
                    style: GoogleFonts.roboto(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.black))
              ],),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                    "Discount: ",
                    style: GoogleFonts.roboto(
                        fontSize: 14,
                        color: Colors.black)),
                Text(
                    "\$0.0",
                    style: GoogleFonts.roboto(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.grey))
              ],),
            const Divider(color: Colors.grey, thickness: 1,),
            Obx(() {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      "Total: ",
                      style: GoogleFonts.roboto(
                          fontSize: 14,
                          color: Colors.black)),
                  Text(
                      "\$${(controller.subtotal.value + 10).toStringAsFixed(2)}",
                      style: GoogleFonts.roboto(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.black))
                ],);
            }),
            const SizedBox(height: 30,),
            ElevatedButton(
                onPressed: () {
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor:  Colors.grey.shade300,
                    fixedSize: Size(width * 0.7, 50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15))),
                child:
                Text(
                    'Confirm Order',
                    style: GoogleFonts.lato(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Colors.black54)))
          ],
        ),
      ),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommarce/data/models/product_model.dart';
import 'package:ecommarce/modules/home/controller/home_controller.dart';
import 'package:ecommarce/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math' as math;

import '../../../data/resources/colors.dart';
import '../../../widgets/drawer/drawer_widget.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      drawer: AppDrawer(),
      drawerEnableOpenDragGesture: false,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        leading: Builder(builder: (context) {
          return GestureDetector(
            onTap: () {
              Scaffold.of(context).openDrawer();
            },
            child: const Icon(
              Icons.segment,
              size: 35,
            ),
          );
        }),
        title: Text(
          'New Arrival',
          style: GoogleFonts.roboto(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: SvgPicture.asset(
              'assets/filter.svg',
              height: 24,
              width: 24,
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Obx(() {
          return Column(
            children: [
              TextFormField(
                controller: controller.searchController.value,
                cursorColor: Colors.black,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
                maxLines: 1,
                onChanged: (value) {
                  controller.filter();
                },
                style: GoogleFonts.lato(color: Colors.black, fontSize: 18),
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(7.0),
                    isDense: true,
                    hintText: "Search items",
                    hintStyle:
                        GoogleFonts.lato(color: Colors.grey, fontSize: 16),
                    prefixIcon: const Icon(
                      Icons.search,
                      size: 30,
                      color: Colors.grey,
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none),
                    filled: true,
                    fillColor: AppColors.searchBg),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                  child: controller.isLoading.value
                      ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const CircularProgressIndicator(color: AppColors.priceColor),
                            const SizedBox(width: 10,),
                            Text('Loading...', style: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black, fontStyle: FontStyle.italic),)
                          ],
                        )
                      : ListView.builder(
                          itemCount: controller.filterProductList.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 20.0),
                              child: GestureDetector(
                                onTap: () {
                                  Get.toNamed(Routes.DETAILS,
                                      arguments:
                                          controller.filterProductList[index]);
                                },
                                child: Container(
                                  width: width,
                                  padding: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                      color: AppColors.productBg,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Column(
                                    children: [
                                      Stack(
                                        clipBehavior: Clip.none,
                                        fit: StackFit.passthrough,
                                        children: [
                                          Transform.rotate(
                                            angle: (math.pi / 180) * -15,
                                            child: Container(
                                              height: 130,
                                              width: 130,
                                              decoration: BoxDecoration(
                                                  color: AppColors.itemBg,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15)),
                                            ),
                                          ),
                                          Positioned.fill(
                                              child: CachedNetworkImage(
                                            imageUrl: controller
                                                .filterProductList[index].image
                                                .toString(),
                                            progressIndicatorBuilder: (context,
                                                    url, downloadProgress) =>
                                                CircularProgressIndicator(
                                                    value: downloadProgress
                                                        .progress),
                                            errorWidget:
                                                (context, url, error) =>
                                                    const Icon(
                                              Icons.error_outline,
                                              size: 26,
                                            ),
                                            width: 200,
                                            height: 150,
                                          ))
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  controller
                                                      .filterProductList[index]
                                                      .category
                                                      .toString(),
                                                  style: GoogleFonts.roboto(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 14,
                                                      color: Colors.black),
                                                ),
                                                Text(
                                                    controller
                                                        .filterProductList[
                                                            index]
                                                        .title
                                                        .toString(),
                                                    style: GoogleFonts.roboto(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16,
                                                        color: Colors.black)),
                                                Row(
                                                  children: [
                                                    RatingBar(
                                                      initialRating: controller
                                                          .filterProductList[
                                                              index]
                                                          .rating!
                                                          .rate!,
                                                      direction:
                                                          Axis.horizontal,
                                                      allowHalfRating: true,
                                                      itemSize: 15,
                                                      itemCount: 5,
                                                      ignoreGestures: true,
                                                      ratingWidget:
                                                          RatingWidget(
                                                        full: const Icon(
                                                            Icons.star),
                                                        half: const Icon(
                                                            Icons.star_half),
                                                        empty: const Icon(
                                                            Icons.star_border),
                                                      ),
                                                      onRatingUpdate:
                                                          (double value) {},
                                                    ),
                                                    Text(
                                                      " (${controller.filterProductList[index].rating!.count})",
                                                      style: GoogleFonts.roboto(
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 12,
                                                          color: Colors.black),
                                                    ),
                                                  ],
                                                ),
                                                Text(
                                                    "\$ ${controller.filterProductList[index].price}",
                                                    style: GoogleFonts.roboto(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16,
                                                        color: AppColors
                                                            .priceColor)),
                                              ],
                                            ),
                                          ),
                                          Obx(() {
                                            return Visibility(
                                              visible: !controller.cartList.any(
                                                  (element) =>
                                                      element.id ==
                                                      controller
                                                          .filterProductList[
                                                              index]
                                                          .id),
                                              child: GestureDetector(
                                                key: const Key('AddToCart'),
                                                onTap: () {
                                                  controller.addToCart(
                                                      productModel: ProductModel(
                                                          id: controller
                                                              .filterProductList[
                                                                  index]
                                                              .id,
                                                          image: controller
                                                              .filterProductList[
                                                                  index]
                                                              .image,
                                                          price: controller
                                                              .filterProductList[
                                                                  index]
                                                              .price,
                                                          title: controller
                                                              .filterProductList[
                                                                  index]
                                                              .title,
                                                          quantity: 1));
                                                },
                                                child: Container(
                                                  height: 50,
                                                  width: 50,
                                                  decoration: BoxDecoration(
                                                      color: AppColors.cartBg,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15)),
                                                  child: const Icon(Icons
                                                      .shopping_cart_outlined),
                                                ),
                                              ),
                                            );
                                          }),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }))
            ],
          );
        }),
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

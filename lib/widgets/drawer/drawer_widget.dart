import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../data/resources/colors.dart';
import '../../routes/app_pages.dart';

class AppDrawer extends StatelessWidget {
  AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final safeArea = EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top);
    return  SizedBox(
        width: MediaQuery.of(context).size.width * 0.65,
        child: Drawer(
          child: Container(
            color: Colors.white,
            child: Column(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10).add(safeArea),
                  width: double.infinity,
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              height: 80,
                              width: 80,
                              padding: const EdgeInsets.all(5.0),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: AppColors.productBg, width: 2),
                              ),
                              child:
                                 const FlutterLogo()
                            ),
                          ],
                        ),
                        const Text(
                          "Huzaifa Ahmed",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                        const Text(
                          "+8801000000000",
                          style: TextStyle(
                              fontSize: 16, color: Colors.black),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(color: Colors.grey.shade400, thickness: 1,),
                Expanded(
                  child:Column(children: [
                    GestureDetector(
                      onTap: (){
                        Get.back();
                        Get.toNamed(Routes.CART);
                      },
                      child: ListTile(
                        leading: const Icon(Icons.shopping_cart_outlined, color: Colors.black,),
                        title: Text("Cart", style: GoogleFonts.roboto(color: Colors.black, fontSize: 16),),
                      ),
                    )
                  ],),
                ),
              ],
            ),
          ),
        ),
      );
  }
}

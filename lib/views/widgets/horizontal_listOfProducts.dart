import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/lang_controller.dart';
import '../../controllers/product_controller.dart';
import '../screens/show_product/product_details.dart';
import '../screens/show_product/product_item.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
Widget buildHorizontalListOfProducts(BuildContext context ,bool fromDetails) {
  final ProductsController productController = Get.find();
  final LangController langController = Get.find();

  final screenSize = MediaQuery.of(context).size;
  return SizedBox(
    height:screenSize.height >820?langController.appLocal =="ar"? screenSize.height * 0.4-17.h:screenSize.height * 0.4-15.h:langController.appLocal =="ar"? screenSize.height * 0.4+8.h:screenSize.height * 0.4.h,
    child: FutureBuilder(
        builder: (context, data) => data.connectionState ==
                ConnectionState.waiting
            ?  SizedBox(
                width: 110.w,
                height: 110.h,
                child: FittedBox(
                  child: CircularProgressIndicator.adaptive(
                    strokeWidth: 0.9,
                  ),
                ),
              )
            : Padding(
              padding: const EdgeInsets.only(right: 0.0),
              child: CustomScrollView(
                  scrollDirection: Axis.horizontal,
                  slivers: [
                    Obx(
                      () => SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            return InkWell(
                              onTap: () {
                                productController.getOneProductDetails(
                                  productController.latestProducts[index].id!,
                                );

                                Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                        transitionDuration:
                                            const Duration(milliseconds: 500),
                                        reverseTransitionDuration:
                                            const Duration(milliseconds: 500),
                                        pageBuilder: (context, animation,
                                                secondaryAnimation) =>
                                            FadeTransition(
                                              opacity: animation,
                                              child: ProductDetails(
                                                product: productController
                                                    .latestProducts[index],
                                              ),
                                            )));
                              },
                              child: ProductItemCard(
                                product: productController.latestProducts[index],
                                fromDetails: fromDetails,
                                from: 'home_hor',
                                press: () {
                                  Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      transitionDuration:
                                          const Duration(milliseconds: 500),
                                      reverseTransitionDuration:
                                          const Duration(milliseconds: 500),
                                      pageBuilder: (context, animation,
                                              secondaryAnimation) =>
                                          FadeTransition(
                                        opacity: animation,
                                        child: ProductDetails(
                                          product: productController
                                              .recommendedProducts[index],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                          childCount: productController.latestProducts.length,
                          semanticIndexOffset: 2,
                        ),
                      ),
                    )
                  ],
                ),
            )),
  );
}

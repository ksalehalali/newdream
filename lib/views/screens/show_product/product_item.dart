import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../Assistants/globals.dart';
import '../../../controllers/lang_controller.dart';
import '../../../controllers/product_controller.dart';
import '../../../models/product_model.dart';

List likesList = [''];

bool like = false;

class ProductItemCard extends StatelessWidget {
  final ProductModel product;
  final VoidCallback press;
  final bool fromDetails;
  final String from;
  final LangController langController = Get.find();

  ProductItemCard(
      {Key? key,
      required this.product,
      required this.fromDetails,
        required this.press,
      required this.from})
      : super(key: key);

  final ProductsController productController = Get.find();

  Future<bool> onLikeButtonTapped(bool isLiked) async {
    /// send your request here
    final bool success = true;
     productController.addProductToFav(product.id!);
    /// if failed, you can do nothing
    return success ? !isLiked : isLiked;

    //return !isLiked;
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double buttonSize = 28;
    return InkWell(
      onTap: () {
        productController.getOneProductDetails(product.id!);
        press();
        // print("product id === ${product.id}");
        // productController.getOneProductDetails(product.id!);
        // print(product.providerName);
        // if (fromDetails) {
        //   Get.to(() => ProductDetails(
        //         product: product,
        //       ));
        //
        // } else {
        //   productController.getOneProductDetails(product.id!);
        //
        //   Get.to(() => ProductDetails(
        //         product: product,
        //       ));
        // }
      },
      child: Container(
        height: screenSize.height.h *0.6,
        width: screenSize.width * 0.4 + 10.w,
        decoration: BoxDecoration(
            border:
                Border.all(width: 0.3, color: myHexColor)),
        margin:  EdgeInsets.only(
          left:from == 'dep'? 2.w:6,
          right:from == 'dep'? 2.w:6,
          bottom: from == 'dep'? 3.w:1,
        ),
        padding:  EdgeInsets.only(top: 6.h, right: 6.w, left: 6.w, bottom: 0.h),
        child: Stack(
            alignment:AlignmentDirectional.topStart,
          children: <Widget>[
            InkWell(
              onTap: () {
                productController.getOneProductDetails(product.id!);

                press();
                // print(product.providerName);
                //
                // if (fromDetails) {
                //   Get.to(() => ProductDetails(
                //         product: product,
                //       ));
                // } else {
                //   Get.to(() => ProductDetails(
                //         product: product,
                //       ));
                // }
              },
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(2),
                  child: Hero(
                    tag: product.id!,
                    child: CachedNetworkImage(
                      //cacheManager: customCacheManager,
                      key: UniqueKey(),
                      imageUrl: '$baseURL/${product.imageUrl}',
                      height: screenSize.height * 0.2 + 46.h,
                      width:from =='dep' ?  screenSize.width * 0.4 +30.w:screenSize.width * 0.4.w,
                      maxHeightDiskCache: 110,
                      fit: BoxFit.fill,
                      placeholder: (context, url) =>
                           Center(child:   Shimmer.fromColors(
                            baseColor: Colors.grey[400]!,
                            highlightColor: Colors.grey[300]!,
                            child: Container(
                              height: 220.h,
                              width: screenSize.width * 0.4 + 10.w,
                              decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(2)),
                            ),
                          ),),
                      errorWidget: (context, url, error) => Container(
                        color: Colors.black,
                        child: const Icon(
                          Icons.error,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  )),
            ),
            Positioned(
                top: 8.0.h,
                left: 10.0.w,
                width: screenSize.width * .1 - 4.w,
                height: screenSize.width * .1 - 4.h,
                child: Align(
                  alignment: Alignment.center,
                  child: LikeButton(
                    size: buttonSize.sp,
                    onTap: onLikeButtonTapped,

                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    // padding: EdgeInsets.only(
                    //     left: screenSize.width * .1 - 37, top: 2),
                    circleColor: const CircleColor(
                        start: Color(0xff00ddff), end: Color(0xff0099cc)),
                    bubblesColor: const BubblesColor(
                      dotPrimaryColor: Color(0xff33b5e5),
                      dotSecondaryColor: Color(0xff0099cc),
                    ),
                    likeBuilder: (bool isLiked) {
                      return Container(
                       decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(50),
                         color: Colors.white,
                       ),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: SvgPicture.asset('assets/icons/heart.svg',
                              alignment: Alignment.center,
                              color: isLiked ? myHexColor3 : Colors.grey[600],
                              height: buttonSize,
                              width: buttonSize,
                              semanticsLabel: 'A red up arrow'),
                        ),
                      );
                    },
                    //likeCount: 665,
                    // countBuilder: (int? count, bool isLiked, String text) {
                    //   var color = isLiked ? Colors.deepPurpleAccent : Colors.grey;
                    //   Widget result;
                    //   if (count == 0) {
                    //     result = Text(
                    //       "love",
                    //       style: TextStyle(color: color),
                    //     );
                    //   } else
                    //     result = Text(
                    //       text,
                    //       style: TextStyle(color: color),
                    //     );
                    //   return result;
                    // },
                  ),
                )),
            Positioned(
              top: screenSize.height * 0.3 - 22.h,
              child: InkWell(
                onTap: () {
                  productController.getOneProductDetails(product.id!);

                  press();
                  // productController.getOneProductDetails(product.id!);
                  // print(product.providerName);
                  //
                  // if (fromDetails) {
                  //   Get.to(() => ProductDetails(
                  //         product: product,
                  //       ));
                  // } else {
                  //   Get.to(() => ProductDetails(
                  //         product: product,
                  //       ));
                  // }
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                   EdgeInsets.only(bottom: 6.0.h),
                              child: SizedBox(
                                width: screenSize.width * 0.3+32.w,
                                child: Text("${langController.appLocal=="en"? product.en_name:product.ar_name}".toUpperCase(),
                                    textDirection:langController.appLocal=="en"? TextDirection.rtl:TextDirection.ltr,
                                    textAlign: langController.appLocal=="en"?TextAlign.left:TextAlign.right,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style:  TextStyle(
                                        fontSize: 14.sp, color: Colors.grey[700])),
                              ),
                            ),

                            Padding(
                              padding:
                                   EdgeInsets.symmetric(vertical: 4.0.h),
                              child: SizedBox(
                                width: screenSize.width *.3.w,
                                child: Text(
                                  '${langController.appLocal=="en"?product.categoryNameEN:product.categoryNameAR}'.toUpperCase(),
                                  //textAlign: TextAlign.right,
                                  maxLines: 1,
                                  style: TextStyle(
                                      fontFamily: 'Montserrat-Arabic Regular',
                                      color: Colors.black.withOpacity(0.7),
                                      fontSize: 12.sp,

                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: screenSize.width * 0.3.w,
                              child: Text(
                                "${product.price! - (product.price)! * (product.offer!) / 100} QR "
                                    .toUpperCase(),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                textAlign:langController.appLocal=="en"? TextAlign.left:TextAlign.right,
                                style:  TextStyle(
                                    fontFamily: 'Montserrat-Arabic Regular',
                                    color: Colors.black,
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              width:screenSize.width<390 ? screenSize.width * 0.4 + 22.w:screenSize.width * 0.3 + 52.w,
                              child: Row(
                                children: [
                                  Text(
                                    "${product.price!.toStringAsFixed(3)} QAR"
                                        .toUpperCase(),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    textAlign: langController.appLocal=="en"?TextAlign.left:TextAlign.right,
                                    style:  TextStyle(
                                        decoration: TextDecoration.lineThrough,
                                        fontFamily: 'Montserrat-Arabic Regular',
                                        color: Colors.grey,
                                        fontSize: 12.sp),
                                  ),
                                   SizedBox(
                                    width: 5.0.w,
                                  ),
                                  Text(
                                    langController.appLocal=="en"? "Discount ${product.offer}%":"  الخصم %${product.offer} ",
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontFamily: 'Montserrat-Arabic Regular',
                                        color: myHexColor3,
                                        fontSize: 12.sp),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

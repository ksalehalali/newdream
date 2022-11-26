import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../Assistants/globals.dart';
import '../../../controllers/cart_controller.dart';
import '../../../controllers/lang_controller.dart';
import '../../../controllers/product_controller.dart';
import '../../../controllers/register_controller.dart';
import '../../../models/product_model.dart';
import '../../widgets/horizontal_listOfProducts.dart';
import '../auth/register.dart';
import '../categories/categories_screen.dart';
import '../order/Cart.dart';
import '../account/account.dart';
import '../home/home.dart';
import '../home/search_area_des.dart';
import 'package:html/parser.dart' show parse;

import 'flyingcart.dart';

class ProductDetails extends StatefulWidget {
  final ProductModel? product;

  const ProductDetails({Key? key, this.product}) : super(key: key);

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

double scaleOfCart = 1.0;
double scaleOfItem = 1.0;
int activeIndex = 0;
int duration = 800;

class _ProductDetailsState extends State<ProductDetails>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  final ProductsController productController = Get.find();
  final CartController cartController = Get.find();
  final LangController langController = Get.find();
  final RegisterController registerController = Get.find();

  int indexListImages = 0;

  final List<Color> _colorSize = [
    myHexColor3,
  ];
  final List<Color> _colorSizeBorder = [
    myHexColor3,
  ];
  Color? _color = myHexColor3;
  Color? _color2 = Colors.grey[700];

  final List<Color> _colorColor = [
    myHexColor3,
  ];
  final List<Color> _colorColorBorder = [
    myHexColor3,
  ];

  bool showOver = false;
  bool showSpec = false;

  // String _colorId = "";
  // String _sizeId = "";
  int currentSizeIndex = 0;

  Widget? flyingcart = null;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cartController.getMyCartProds(false, langController.appLocal);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  Future<bool> onLikeButtonTapped(bool isLiked) async {
    /// send your request here
    final bool success = true;
    productController.addProductToFav(widget.product!.id!);

    /// if failed, you can do nothing
    return success ? !isLiked : isLiked;

    //return !isLiked;
  }

  @override
  Widget build(BuildContext context) {
    double buttonSize = 36;
    final screenSize = MediaQuery.of(context).size;
    return Container(
      color: Colors.white,
      child: Obx(
        () => Stack(
          key: const Key('s2'),
          children: [
            productController.getDetailsDone.value == true
                ? Obx(() => Container(
                      color: myHexColor,
                      child: SafeArea(
                        top: true,
                        bottom: false,
                        child: Scaffold(
                          backgroundColor: Colors.white,
                          body: Container(
                            height: screenSize.height,
                            width: screenSize.width,
                            child: SingleChildScrollView(
                              child: Column(
                                key: const Key('l'),
                                // padding: EdgeInsets.zero,
                                // shrinkWrap: true,
                                children: [
                                  SizedBox(
                                    height: 4.0.h,
                                  ),
                                  Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Navigator.of(context).pop();

                                          print(productController
                                              .latestProducts.length);
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              right: 12.0.w, left: 10.w),
                                          child: SvgPicture.asset(
                                              langController.appLocal =='en' ?'assets/icons/left arrow.svg':'assets/icons/rghit_arrow.svg',
                                              alignment: Alignment.center,
                                              //color:,
                                              height: 22.h,
                                              width: 22.w,
                                              semanticsLabel: 'A red up arrow'),
                                        ),
                                      ),
                                      const Expanded(child: SearchAreaDesign()),
                                      InkWell(
                                        onTap: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const Cart()));
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 5.w),
                                          child: Container(
                                            height: 40.h,
                                            width: 40.w,
                                            child: Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                AnimatedScale(
                                                  scale: scaleOfCart,
                                                  duration:
                                                      duration.milliseconds,
                                                  alignment: Alignment.center,
                                                  curve: Curves.easeInOutBack,
                                                  child: SvgPicture.asset(
                                                      'assets/icons/cart-fill.svg',
                                                      alignment:
                                                          Alignment.center,
                                                      //color:,
                                                      height: 29.h,
                                                      width: 29.w,
                                                      semanticsLabel:
                                                          'A red up arrow'),
                                                ),
                                                Positioned(
                                                    right: 0.0,
                                                    top: 0.0,
                                                    child: Container(
                                                        height: 14.h,
                                                        width: 14.w,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20),
                                                            color: const Color
                                                                    .fromARGB(255, 246, 138, 24)),
                                                        child: Center(
                                                          child: Obx(
                                                            () => Text(
                                                              cartController.myPrCartProducts.length
                                                                  .toString(),
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      10.sp,
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          ),
                                                        )))
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Obx(
                                    () => Stack(
                                      key: const Key('s'),
                                      children: [
                                        productController
                                            .getDetailsDone.value == true
                                            ? Column(
                                                children: [
                                                  SizedBox(
                                                      //height: screenSize.height<720? screenSize.height * 0.3.h+46:screenSize.height * 0.2+15.h,
                                                      width: double.infinity,
                                                      child: Column(
                                                        children: [
                                                          CarouselSlider
                                                              .builder(
                                                            itemCount:
                                                                productController.imagesWidget.value[indexListImages].length,
                                                            itemBuilder: (BuildContext
                                                                        context,
                                                                    int itemIndex,
                                                                    int pageViewIndex) =>
                                                                InkWell(
                                                              onTap: () {
                                                                gallery(
                                                                    itemIndex);
                                                              },
                                                              child: Container(
                                                                width:
                                                                    screenSize.width,
                                                                child: productController
                                                                        .imagesWidget
                                                                        .value[indexListImages]
                                                                    [itemIndex],
                                                              ),
                                                            ),
                                                            options:
                                                                CarouselOptions(
                                                              viewportFraction:
                                                                  1,
                                                              height: 300,
                                                              pageSnapping:
                                                                  true,
                                                              //autoPlay: true,
                                                              enableInfiniteScroll:
                                                                  true,
                                                              enlargeCenterPage:
                                                                  true,
                                                              enlargeStrategy:
                                                                  CenterPageEnlargeStrategy
                                                                      .height,
                                                              autoPlayInterval:
                                                                  2500.milliseconds,
                                                              onPageChanged:
                                                                  (index,
                                                                      reason) {
                                                                setState(() {
                                                                  activeIndex =
                                                                      index;
                                                                });
                                                              },
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 4.0,
                                                          ),
                                                          buildIndicator(
                                                              productController
                                                                  .imagesWidget
                                                                  .value[
                                                                      indexListImages]
                                                                  .length),
                                                        ],
                                                      )),
                                                ],
                                              )
                                            : Container(),
                                        productController
                                                    .getDetailsDone.value ==
                                                true
                                            ? Positioned(
                                                top: 12.0.h,
                                                left: 12.0.w,

                                                child: Align(
                                                  alignment: Alignment.center,
                                                  child: LikeButton(
                                                    size: buttonSize + 5,
                                                    //padding: EdgeInsets.symmetric(horizontal: 22),
                                                    onTap: onLikeButtonTapped,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.center,
                                                    // padding: EdgeInsets.only(
                                                    //     left: screenSize.width * .1 - 37,
                                                    //     top: 2),
                                                    circleColor:
                                                        const CircleColor(
                                                            start:
                                                                Color(0xff00ddff),
                                                            end: Color(
                                                                0xff0099cc)),
                                                    bubblesColor:
                                                        const BubblesColor(
                                                      dotPrimaryColor:
                                                          Color(0xff33b5e5),
                                                      dotSecondaryColor:
                                                          Color(0xff0099cc),
                                                    ),
                                                    likeBuilder: (bool isLiked) {
                                                      return Container(
                                                        width: screenSize.width *
                                                            .1+5.w,
                                                        height: screenSize.width *
                                                            .1+5.h,
                                                        decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(50),
                                                          color: Colors.white,
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                               EdgeInsets
                                                                  .all(6.0.w),
                                                          child: SvgPicture.asset(
                                                              'assets/icons/heart.svg',
                                                              alignment: Alignment
                                                                  .center,
                                                              color: isLiked
                                                                  ? myHexColor3
                                                                  : Colors
                                                                      .grey[600],
                                                              height: buttonSize,
                                                              width: buttonSize,
                                                              semanticsLabel:
                                                                  'A red up arrow'),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ))
                                            : Container(),
                                        productController
                                                    .getDetailsDone.value ==
                                                true
                                            ? Positioned(
                                                top: screenSize.height * .1 - 12.h,
                                                left: 12..w,
                                                child: Container(
                                                  padding: EdgeInsets.zero,
                                                  margin: EdgeInsets.zero,
                                                  width: screenSize.width *
                                                      .1+1.w,
                                                  height: screenSize.width *
                                                      .1+1.h,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              100),
                                                      color: Colors.white
                                                          .withOpacity(1)),
                                                  child: LikeButton(
                                                    size: buttonSize - 12.sp,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    onTap: (isLiked) async {
                                                      print('share');
                                                      return isLiked;
                                                    },
                                                    circleColor:
                                                        const CircleColor(
                                                            start: Colors.grey,
                                                            end: Colors.grey),
                                                    bubblesColor:
                                                        const BubblesColor(
                                                      dotPrimaryColor:
                                                          Color(0xff33b5e5),
                                                      dotSecondaryColor:
                                                          Color(0xff0099cc),
                                                    ),
                                                    likeBuilder:
                                                        (bool isLiked) {
                                                      return SvgPicture.asset(
                                                          'assets/icons/share3.svg',
                                                          alignment:
                                                              Alignment.center,
                                                          color: isLiked
                                                              ? myHexColor3
                                                              : Colors
                                                                  .grey[600],
                                                          height: buttonSize,
                                                          width: buttonSize,
                                                          semanticsLabel:
                                                              'A red up arrow');
                                                    },
                                                  ),
                                                ),
                                              )
                                            : Container()
                                      ],
                                    ),
                                  ),

                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 12.0.w),
                                    child: Obx(
                                      () => Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 10.0.h,
                                          ),
                                          Text(
                                            '${productController.productDetails.providerName}',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16.sp,
                                                color: myHexColor1),
                                          ),
                                          SizedBox(
                                            height:
                                                screenSize.height * 0.1 - 70.h,
                                          ),
                                          Text(
                                            langController.appLocal=='en' ?productController
                                                .productDetails.en_name!
                                                .toUpperCase():productController
                                                .productDetails.ar_name!
                                                .toUpperCase(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 15.sp,
                                                color: Colors.black),
                                          ),
                                          SizedBox(
                                            height:
                                                screenSize.height * 0.1 - 72.h,
                                          ),
                                          Text(
                                            '${productController.productDetails.price! - productController.offerFromPrice.value} QAR',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 15.sp,
                                                color: Colors.black),
                                          ),
                                          SizedBox(
                                            height:
                                                screenSize.height * 0.1 - 60.h,
                                          ),
                                          Text(
                                            'Size_txt'.tr,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 14.sp,
                                                color: Colors.black),
                                          ),
                                          SizedBox(
                                            height: 2.h,
                                          ),
                                          _buildSizesOptions(screenSize),
                                          SizedBox(
                                            height: 22.0.h,
                                          ),
                                          Text(
                                            'Color_txt'.tr,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 14.sp,
                                                color: Colors.black),
                                          ),
                                          SizedBox(
                                            height: 2.h,
                                          ),
                                          _buildColorsOptions(screenSize),
                                          SizedBox(
                                            height: 22.0.h,
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                                border: Border.all(
                                                  width: 1,
                                                  color: Colors.grey[500]!,
                                                )),
                                            width: screenSize.width,
                                            height:
                                                screenSize.height * 0.1 - 30.h,
                                            child: Row(
                                              children: [
                                                SizedBox(
                                                  width: 10.0.w,
                                                ),
                                                SvgPicture.asset(
                                                    'assets/icons/shipping.svg',
                                                    color: Colors.grey[600],
                                                    height: 18.0.h,
                                                    width: 18.0.w,
                                                    semanticsLabel:
                                                        'A red up arrow'),
                                                const SizedBox(
                                                  width: 10.0,
                                                ),
                                                 Text('Delivery time :_txt'.tr),
                                                const Spacer(),
                                                 Text(' Jan 28 - Jan 30_txt'.tr),
                                                SizedBox(
                                                  width:
                                                      screenSize.width * 0.1 -
                                                          12.w,
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 14.0.h),
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 0, vertical: 0),
                                      decoration: BoxDecoration(
                                          color: Colors.grey[300],
                                          borderRadius:
                                              BorderRadius.circular(3)),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 12.h),
                                        child: Container(
                                          color: Colors.white,
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 18.0.h,
                                                    horizontal: 12.w),
                                                child: Row(
                                                  children: [
                                                    SvgPicture.asset(
                                                        'assets/images/svg/9593997931634472866.svg',
                                                        // color: Colors.black,
                                                        height: 21.00.h,
                                                        width: 21.0.w,
                                                        semanticsLabel:
                                                            'A red up arrow'),
                                                    const SizedBox(
                                                      width: 5.0,
                                                    ),
                                                    Text(
                                                      'Merchant_txt'.tr,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 15.sp),
                                                    ),
                                                    SizedBox(
                                                      width: 8.0.w,
                                                    ),
                                                    Text(
                                                      'QR Market',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 16.sp,
                                                          color: myHexColor3),
                                                    ),
                                                    const Spacer(),
                                                    const Icon(Icons
                                                        .keyboard_arrow_right)
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            _color = myHexColor3;
                                            _color2 = Colors.grey[700];
                                            showOver = true;
                                            showSpec = false;
                                          });
                                        },
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            AnimatedContainer(
                                                duration: 11.seconds,
                                                curve: Curves.easeIn,
                                                child: Text('Overview_txt'.tr,
                                                    style: TextStyle(
                                                        color: _color,
                                                        fontWeight:
                                                            FontWeight.w500))),
                                            SizedBox(
                                              height: 10.0.h,
                                            ),
                                            AnimatedContainer(
                                              curve: Curves.easeInOut,
                                              width:screenSize.width<390 ? screenSize.width / 2.w -34:screenSize.width / 2.w,
                                              height: 2.5.h,
                                              color: _color,
                                              duration: 900.milliseconds,
                                            )
                                          ],
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            _color2 = myHexColor3;
                                            _color = Colors.grey[700];
                                            showOver = false;
                                            showSpec = true;
                                          });
                                        },
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            AnimatedContainer(
                                                curve: Curves.easeIn,
                                                duration: 14.seconds,
                                                child: Text(
                                                  'Specifications_txt'.tr,
                                                  style: TextStyle(
                                                      color: _color2,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )),
                                            SizedBox(
                                              height: 10.0.h,
                                            ),
                                            AnimatedContainer(
                                              curve: Curves.easeInOut,
                                              width: screenSize.width / 2.w,
                                              height: 2.5.h,
                                              color: _color2,
                                              duration: 900.milliseconds,
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  showSpec
                                      ? Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 14.0.h,
                                                  horizontal: 12.w),
                                              child: Text(
                                                'Specifications_txt'.tr,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 12.sp,
                                                    fontWeight:
                                                        FontWeight.w800),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 12.0.h,
                                                  horizontal: 12.w),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                      width: screenSize.width *
                                                              0.9 +
                                                          10.w,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          ..._buildSpicalProperties(screenSize)
                                                        ],
                                                      )),
                                                  const Spacer()
                                                ],
                                              ),
                                            ),
                                            Container(
                                              color:
                                                  myHexColor3.withOpacity(0.4),
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 12.0.h,
                                                    horizontal: 12.w),
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                        child: Text(
                                                          'Color name',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .grey[900],
                                                              fontSize: 11.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                        width:
                                                            screenSize.width *
                                                                    .5 -
                                                                30.w),
                                                    Text(
                                                      productController
                                                              .productDetails
                                                              .colorsData![
                                                          0]['color'],
                                                      maxLines: 3,
                                                      style: TextStyle(
                                                          color: Colors
                                                              .grey[800],
                                                          fontSize: 11.sp,
                                                          fontWeight:
                                                              FontWeight
                                                                  .w500),
                                                    ),
                                                    const Spacer()
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 12.0.h,
                                                  horizontal: 12.w),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                      width: screenSize.width *
                                                              .5 -
                                                          30.w,
                                                      child: Text(
                                                        'Department_txt'.tr,
                                                        style: TextStyle(
                                                            color: Colors
                                                                .grey[900],
                                                            fontSize: 11.sp,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      )),
                                                  Text(
                                                    productController
                                                        .productDetails
                                                        .categoryNameEN!,
                                                    maxLines: 3,
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.grey[800],
                                                      fontSize: 11.sp,
                                                    ),
                                                  ),
                                                  const Spacer()
                                                ],
                                              ),
                                            ),
                                            Container(
                                              color:
                                                  myHexColor3.withOpacity(0.4),
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 12.0.h,
                                                    horizontal: 12.w),
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                        width:
                                                            screenSize.width *
                                                                    .5 -
                                                                30.w,
                                                        child: Text(
                                                          'Offer_txt'.tr,
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .grey[900],
                                                              fontSize: 11.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        )),
                                                    Text(
                                                      '${productController.productDetails.offer.toString()} %',
                                                      maxLines: 3,
                                                      style: TextStyle(
                                                          color:
                                                              Colors.grey[800],
                                                          fontSize: 11.sp,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    const Spacer()
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 12.0.h,
                                                  horizontal: 12.w),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                      width: screenSize.width *
                                                              .5 -
                                                          30.w,
                                                      child: Text(
                                                        'Material_txt'.tr,
                                                        style: TextStyle(
                                                            color: Colors
                                                                .grey[900],
                                                            fontSize: 11.sp,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      )),
                                                  Text(
                                                    'any',
                                                    maxLines: 3,
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.grey[800],
                                                      fontSize: 11.sp,
                                                    ),
                                                  ),
                                                  const Spacer()
                                                ],
                                              ),
                                            ),
                                            Container(
                                              color:
                                                  myHexColor3.withOpacity(0.4),
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 12.0.h,
                                                    horizontal: 12.w),
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                        width:
                                                            screenSize.width *
                                                                    .5 -
                                                                30.w,
                                                        child: Text(
                                                          'Material Composition_txt'.tr,
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .grey[900],
                                                              fontSize: 11.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        )),
                                                    Text(
                                                      '100% any',
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 3,
                                                      style: TextStyle(
                                                          color:
                                                              Colors.grey[800],
                                                          fontSize: 11.sp,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    const Spacer()
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 12.0.h,
                                                  horizontal: 12.w),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                      width: screenSize.width *
                                                              .5 -
                                                          30.w,
                                                      child: Text(
                                                        'Model Number_txt'.tr,
                                                        style: TextStyle(
                                                            color: Colors
                                                                .grey[900],
                                                            fontSize: 11.sp,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      )),
                                                  Text(
                                                    productController
                                                        .productDetails
                                                        .modelName!,
                                                    maxLines: 3,
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.grey[800],
                                                      fontSize: 11.sp,
                                                    ),
                                                  ),
                                                  const Spacer()
                                                ],
                                              ),
                                            ),
                                            Container(
                                              color:
                                                  myHexColor3.withOpacity(0.4),
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 12.0.h,
                                                    horizontal: 12.w),
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    SizedBox(
                                                        width:
                                                            screenSize.width *
                                                                    .5 -
                                                                30.w,
                                                        child: Text(
                                                          'Merchant_txt'.tr,
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .grey[900],
                                                              fontSize: 11.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        )),
                                                    Text(
                                                      productController
                                                          .productDetails
                                                          .providerName!,
                                                      maxLines: 3,
                                                      style: TextStyle(
                                                          color:
                                                              Colors.grey[800],
                                                          fontSize: 11.sp,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    const Spacer()
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      : Align(
                                          alignment: Alignment.centerLeft,
                                          child: Container(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      right: 12.0.w,
                                                      left: 12.0.w,
                                                      top: 22.0.h,
                                                      bottom: 4.h),
                                                  child: Text(
                                                    'Highlights_txt'.tr,
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 12.sp,
                                                        fontWeight:
                                                            FontWeight.w800),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 1.0.h,
                                                      horizontal: 12.w),
                                                  child: productController
                                                              .productDetails
                                                              .desc_EN !=
                                                          null
                                                      ? Html(
                                                          data: productController
                                                              .productDetails
                                                              .desc_EN,
                                                        )
                                                      : Container(),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      right: 12.0.w,
                                                      left: 12.0.w,
                                                      top: 5.0.h,
                                                      bottom: 10.h),
                                                  child: Text(
                                                    'Specifications_txt'.tr,
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 12.sp,
                                                        fontWeight:
                                                        FontWeight.w800),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 1.0.h ,
                                                      horizontal: 12.w),
                                                  child: productController
                                                      .productDetails
                                                      .desc_EN !=
                                                      null
                                                      ? Html(
                                                    data: productController
                                                        .productDetails
                                                        .desc_EN,
                                                  )
                                                      : Container(),
                                                ),
                                                SizedBox(
                                                  height: 20.h,
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                  SizedBox(
                                    height: 40.h,
                                  ),
                                  Align(
                                    alignment:langController.appLocal =='en' ?Alignment.centerLeft:Alignment.centerRight,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          right: 12.0.w,
                                          left: 12.0.w,
                                          top: 22.0.h,
                                          bottom: 10.h),
                                      child: Text(
                                        langController.appLocal == 'en' ? 'More from ${productController.product.value.brand}':' المزيد من ${productController.product.value.brand} ',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w800),
                                      ),
                                    ),
                                  ),
                                  buildHorizontalListOfProducts(context,true),
                                  SizedBox(
                                    height: 60.h,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          bottomSheet:
                              productController.getDetailsDone.value == true
                                  ? buildAddCartPrice(screenSize,
                                      productController.productDetails.price!,
                                      productController.productDetails.offer,
                                      indexListImages)
                                  : Container(),
                        ),
                      ),
                    ))
                : _buildShimmerLoadingData(screenSize),
            Container(
              margin: EdgeInsets.only(top: screenSize.height * 0.1 - 54.h),
              width: MediaQuery.of(context).size.width.w,
              height: MediaQuery.of(context).size.height - 50.h,
              child: flyingcart == null ? Container() : flyingcart,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildShimmerLoadingData(screenSize) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: screenSize.height * 0.1 / 7.h,
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 24.0.h, horizontal: 12.w),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[400]!,
            highlightColor: Colors.grey[300]!,
            child: Container(
              height: screenSize.height * 0.4 - 10.h,
              width: screenSize.width,
              decoration: BoxDecoration(
                  color: Colors.grey, borderRadius: BorderRadius.circular(12)),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 5.0.h, horizontal: 12.w),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[400]!,
            highlightColor: Colors.grey[300]!,
            child: Container(
              height: screenSize.height * 0.1 - 60.h,
              width: screenSize.width * 0.4.w,
              decoration: BoxDecoration(
                  color: Colors.grey, borderRadius: BorderRadius.circular(6)),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 22.0.h, right: 12.w, left: 12.w),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[400]!,
            highlightColor: Colors.grey[300]!,
            child: Container(
              height: screenSize.height * 0.1 - 62.h,
              width: screenSize.width,
              decoration: BoxDecoration(
                  color: Colors.grey, borderRadius: BorderRadius.circular(4)),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 12.0.h, horizontal: 12.w),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[400]!,
            highlightColor: Colors.grey[300]!,
            child: Container(
              height: screenSize.height * 0.1 - 62.h,
              width: screenSize.width,
              decoration: BoxDecoration(
                  color: Colors.grey, borderRadius: BorderRadius.circular(4)),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 12),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[400]!,
            highlightColor: Colors.grey[300]!,
            child: Container(
              height: screenSize.height * 0.1 - 62.h,
              width: screenSize.width,
              decoration: BoxDecoration(
                  color: Colors.grey, borderRadius: BorderRadius.circular(4)),
            ),
          ),
        ),
        SizedBox(
          height: 60.h,
        ),
        Row(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 0.0.h, horizontal: 12.w),
              child: Shimmer.fromColors(
                baseColor: Colors.grey[400]!,
                highlightColor: Colors.grey[300]!,
                child: Container(
                  height: screenSize.height * 0.1 - 30.h,
                  width: screenSize.width * 0.2.w,
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(2)),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 0.0.h, horizontal: 12.w),
              child: Shimmer.fromColors(
                baseColor: Colors.grey[400]!,
                highlightColor: Colors.grey[300]!,
                child: Container(
                  height: screenSize.height * 0.1 - 30.h,
                  width: screenSize.width * 0.2.w,
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(2)),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 12.w),
              child: Shimmer.fromColors(
                baseColor: Colors.grey[400]!,
                highlightColor: Colors.grey[300]!,
                child: Container(
                  height: screenSize.height * 0.1 - 30.h,
                  width: screenSize.width * 0.2.w,
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(2)),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 60,
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 12.w),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[200]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              height: screenSize.height * 0.1 - 70.h,
              width: screenSize.width,
              decoration: BoxDecoration(
                  color: Colors.grey, borderRadius: BorderRadius.circular(2)),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.w),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[200]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              height: screenSize.height * 0.1 - 70.h,
              width: screenSize.width,
              decoration: BoxDecoration(
                  color: Colors.red[50],
                  borderRadius: BorderRadius.circular(2)),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSizesOptions(size) {
    return SizedBox(
      width: size.width,
      height: 36.h,
      child: CustomScrollView(
        scrollDirection: Axis.horizontal,
        slivers: [
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                _colorSize.add(Colors.grey[800]!);
                _colorSizeBorder.add(Colors.grey[400]!);

                // productController.currentSizeIdSelected.value =
                // productController.sizes[0]['sizeID'];
                // _sizeId = productController.sizes[index]['sizeID'];
                return InkWell(
                  onTap: () {
                    currentSizeIndex = index;
                    productController.currentSizeSelected.value =
                        productController.sizes[index]['size'];
                    productController.currentSizeIdSelected.value =
                        productController.sizes[index]['sizeID'];
                    //_sizeId = productController.sizes[index]['sizeID'];

                    print(
                        "size is = ${productController.sizes[index]['sizeID']}");
                    setState(() {
                      for (var i = 0; i < _colorSize.length; i++) {
                        if (i == index) {
                          _colorSize[i] = myHexColor3;
                          _colorSizeBorder[i] = myHexColor3;
                        } else {
                          _colorSize[i] = Colors.grey[800]!;
                          _colorSizeBorder[i] = Colors.grey[400]!;
                        }
                      }
                    });
                  },
                  child: Padding(
                    padding: EdgeInsets.only(right: 8.0.w),
                    child: Container(
                      height: 24.h,
                      width: 78.w,
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 1.2, color: _colorSizeBorder[index])),
                      child: Center(
                        child: Text(
                          productController.sizes[index]['size'],
                          style: TextStyle(
                              color: _colorSize[index],
                              fontWeight: FontWeight.bold,
                              decoration:
                                  productController.qytsWithSizes[index].qyt ==
                                              0 &&
                                          productController
                                                  .currentSizeIdSelected
                                                  .value ==
                                              productController
                                                  .qytsWithSizes[index].sizeID
                                      ? TextDecoration.lineThrough
                                      : TextDecoration.none,
                              fontSize: 13.sp),
                        ),
                      ),
                    ),
                  ),
                );
              },
              childCount: productController.sizes.length,
              semanticIndexOffset: 0,
            ),
          )
        ],
      ),
    );
  }

//build colors options
  Widget _buildColorsOptions(size) {
    return SizedBox(
      width: size.width,
      height: 36.h,
      child: CustomScrollView(
        scrollDirection: Axis.horizontal,
        slivers: [
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                // print('color id for $index is:: ${productController.imagesData[index].colorId}');
                // print('qyt :: ${productController.sizes[index]['color'][index]['qyt']}');
                _colorColor.add(Colors.grey[800]!);
                _colorColorBorder.add(Colors.grey[400]!);

                return InkWell(
                  onTap: () {
                    print('current index is :::: $index');
                    print('color id ${productController.imagesData[index].colorId}');
                    print('color name ${productController.imagesData[index].color}');

                    //print('all data :: ${productController.colorsData[index]['property']}');
                    productController.currentColorSelected.value =
                        productController.imagesData[index].color;
                    productController.currentColorIdSelected.value =
                        productController.imagesData[index].colorId;

                    indexListImages = index;
                    setState(() {
                      for (var i = 0; i < _colorColor.length; i++) {
                        if (i == index) {
                          _colorColor[i] = myHexColor3;
                          _colorColorBorder[i] = myHexColor3;
                        } else {
                          _colorColor[i] = Colors.grey[800]!;
                          _colorColorBorder[i] = Colors.grey[400]!;
                        }
                      }
                    });
                  },
                  child: Padding(
                    padding: EdgeInsets.only(right: 8.0.w),
                    child: Container(
                      height: 24.h,
                      width: 78.w,
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 1.2, color: _colorColorBorder[index])),
                      child: Center(
                        child: Text(
                          productController.productDetails.colorsData![index]['color'],
                          style: TextStyle(
                              color: _colorColor[index],
                              fontWeight: FontWeight.bold,
                              decoration:
                                  productController.sizes[currentSizeIndex]
                                              ['color'][index]['qyt'] ==0
                                      ? TextDecoration.lineThrough
                                      : TextDecoration.none,
                              fontSize: 13),
                        ),
                      ),
                    ),
                  ),
                );
              },
              childCount:
                  productController.sizes[currentSizeIndex]['color'].length,

            ),
          )
        ],
      ),
    );
  }

  List _buildSpicalProperties(screenSize) {
    var sList = [];
    for (int i = 0; productController.productDetails.special!.length > i; i++) {
      sList.add(
        Padding(
          padding: EdgeInsets.symmetric(vertical: 6.0.h),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: screenSize.width * .5 - 30.w,
                    child: Text(
                      '${productController.productDetails.special![i]['prorerty']}',
                      textDirection: TextDirection.ltr,
                      style: TextStyle(
                          fontSize: 13.sp,
                          color: Colors.grey[800],
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    width: screenSize.width * .6 - 46.w,
                    child: Text(
                      '${productController.productDetails.special![i]['value']}',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(
                          fontSize: 13.sp,
                          color: Colors.grey[800],
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Spacer(),
                ],
              ),
              Divider(
                thickness: .5,
                height: 10.0.h,
              ),
            ],
          ),
        ),
      );
    }

    return sList;
  }

  Widget buildAddCartPrice(screenSize,double price, int? offer, int indexImage) {
    return Card(
      margin: EdgeInsets.zero,
      child: Row(
        children: [
          Expanded(
            child: InkWell(
                onTap: () async{
                  bool available = false;
                  if(registerController.isLoggedIn.value ==false){
                    showDialogBoxNotLoggedIn();
                    return;
                  }
                  for (int i = 0; i < productController.colorsSizesItems.length; i++) {
                    if (productController.currentColorIdSelected.value ==
                            productController.colorsSizesItems[i]['colorID'] &&
                        productController.currentSizeIdSelected.value ==
                            productController.colorsSizesItems[i]['sizeID'] &&
                        productController.colorsSizesItems[i]['qyt'] > 0) {
                      print('true ...=============..');
                      available = true;
                      print('${productController.colorsSizesItems[i]['qyt']}');
                    } else {}

                    print(
                        'id ==color== ${productController.colorsSizesItems[i]['colorID']}');
                    // print('id ==l== $_colorId');
                    print(
                        'id ==== ${productController.colorsSizesItems[i]['color']}');

                    print(
                        'id ==size== ${productController.colorsSizesItems[i]['sizeID']}');
                    //print('id ==l== $_sizeId');
                    print(
                        'size ==== ${productController.colorsSizesItems[i]['size']}');
                    print(
                        'qyt ==== ${productController.colorsSizesItems[i]['qyt']}');

                    print('.\n\n');
                  }

                  if (available) {
                    //when this button is pressed, a flying cart display
                    setState(() {
                      duration = 800;
                      scaleOfCart = 1.5;
                      scaleOfItem = 1.2;
                      flyingcart =  FlyingCart(indexListImages:  indexListImages);

                      //wait 2 second
                    });

                    Future.delayed(const Duration(milliseconds: 800), () {
                      setState(() {
                        scaleOfItem = 0;
                        duration = 500;
                        scaleOfCart = 1.0;
                      });
                    });

                    Future.delayed(const Duration(seconds: 1), () {
                      setState(() {
                        flyingcart = null;
                        //hide flycart and add number
                      });
                    });

                    var addToCart =await cartController.addToCart(
                            productController.productData['id'],
                            productController.currentColorIdSelected,
                            productController.currentSizeIdSelected,
                            langController.appLocal);
                    if(addToCart == true){
                      showGeneralDialog(
                          context: context,
                          barrierDismissible: true,
                          transitionDuration: 500.milliseconds,
                          barrierLabel:
                          MaterialLocalizations.of(context).dialogLabel,
                          barrierColor: Colors.black.withOpacity(0.5),
                          pageBuilder: (context, _, __) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: screenSize.width,
                                  color: Colors.white,
                                  child: Card(
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: screenSize.height *0.1 -20,
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              left: 10.w, right: 10.w),
                                          child: Row(
                                            children: [
                                              SvgPicture.asset(
                                                'assets/icons/done.svg',
                                                width:screenSize.width *0.1 -30,
                                                height: screenSize.height *0.1 -30,
                                                color: myHexColor,
                                              ),
                                              SizedBox(width: 4.w,),
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceBetween,
                                                crossAxisAlignment:
                                                CrossAxisAlignment
                                                    .center,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .center,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                        EdgeInsets.only(
                                                            left:
                                                            4.0.w),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                          children: [
                                                            SizedBox(
                                                              width: screenSize
                                                                  .width *
                                                                  0.4.w,
                                                              child: Text(
                                                                langController.appLocal=='en' ?productController
                                                                    .productDetails.en_name!
                                                                    .toUpperCase():productController
                                                                    .productDetails.ar_name!
                                                                    .toUpperCase(),
                                                                maxLines: 1,
                                                                overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                                style: TextStyle(
                                                                    fontSize: 14
                                                                        .sp,
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                    color: Colors
                                                                        .black87),
                                                              ),
                                                            ),
                                                            Text(
                                                              'Added to cart _txt'.tr,
                                                              style: TextStyle(
                                                                  fontSize:
                                                                  14.sp,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                                  color: Colors
                                                                      .black87),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                        EdgeInsets.only(
                                                            left: screenSize.width *0.1 -30.w),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                          children: [
                                                            Text(
                                                              'Cart Total_txt'.tr,
                                                              style: TextStyle(
                                                                  fontSize:
                                                                  14.sp,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                                  color: Colors
                                                                      .black87),
                                                            ),
                                                            Obx(
                                                                  () => Text(
                                                                cartController
                                                                    .fullPrice
                                                                    .value
                                                                    .toStringAsFixed(
                                                                    2),
                                                                style: TextStyle(
                                                                    fontSize: 14
                                                                        .sp,
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                    color: Colors
                                                                        .black87),
                                                              ),
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
                                        SizedBox(
                                          height: 12.h,
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            ElevatedButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              style:
                                              ElevatedButton.styleFrom(maximumSize: Size(220, 220), minimumSize: Size(180, 34),
                                                  primary: Colors.green[800],
                                                  onPrimary: Colors.green[900],
                                                  alignment: Alignment.center),
                                              child: Text(
                                                'CONTINUE SHOPPING_txt'.tr,
                                                maxLines: 1,
                                                style: const TextStyle(
                                                    fontWeight:
                                                    FontWeight.w700,
                                                    color: Colors.white),
                                              ),
                                            ),
                                            ElevatedButton(
                                              onPressed: () {
                                                Navigator.of(context)
                                                    .pushReplacement(
                                                    MaterialPageRoute(
                                                        builder:
                                                            (context) =>
                                                        const Cart()));
                                              },
                                              style:
                                              ElevatedButton.styleFrom(
                                                  maximumSize:
                                                  Size(200, 220),
                                                  minimumSize:
                                                  Size(180, 34),
                                                  primary: myHexColor,
                                                  onPrimary:
                                                  Colors.white,
                                                  alignment:
                                                  Alignment.center),
                                              child:  Text(
                                                'CHECKOUT_txt'.tr,
                                                style: TextStyle(
                                                    fontWeight:
                                                    FontWeight.w700,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            );
                          },
                          transitionBuilder: (context, animation,
                              secondaryAnimation, child) {
                            return SlideTransition(
                              position: CurvedAnimation(
                                parent: animation,
                                curve: Curves.easeInOutCubic,
                              ).drive(
                                Tween<Offset>(
                                    begin: const Offset(0, -1.0),
                                    end: Offset.zero),
                              ),
                              child: child,
                            );
                          });
                    }else{
                      Get.snackbar(
                          'UnAvailable_txt'.tr, 'this color or size is not available_txt'.tr,
                          snackPosition: SnackPosition.TOP,
                          snackStyle: SnackStyle.FLOATING,
                          titleText: Text(
                            'UnAvailable_txt'.tr,
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),messageText:Text(
                        'this color or size is not available_txt'.tr,
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w500,color: Colors.black54),
                      ) );
                    }

                  }else{
                    Get.snackbar(
                        'UnAvailable_txt'.tr, 'this color or size is not available_txt'.tr,
                        snackPosition: SnackPosition.TOP,
                        snackStyle: SnackStyle.FLOATING,
                        titleText: Text(
                          'UnAvailable_txt'.tr,
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),messageText:Text(
                      'this color or size is not available_txt'.tr,
                      style: TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w500,color: Colors.black54),
                    ) );
                  }


                },
                child: Container(
                  height: 54.h,
                  color: myHexColor1,
                  child:  Center(
                    child: Text(
                      'Add to cart _txt'.tr,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                )),
          ),
          Container(
            height: 44.h,
            width: 130.w,
            color: Colors.white,
            child: Center(
              child: Text(
                '${price - price * offer! / 100}',
                style: const TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      ),
    );
  }

  showDialogBoxNotLoggedIn() => showCupertinoDialog<String>(
    context: context,
    builder: (BuildContext context) => CupertinoAlertDialog(
      title: const Text('Your are\'nt logged in'),
      content: const Text('Please please login to fill cart'),
      actions: <Widget>[
        TextButton(
          onPressed: () async {
            Navigator.pop(context, 'Cancel');
            Get.offAll(()=> Register());
          },
          child: const Text('Login'),
        ),
        TextButton(
          onPressed: () async {
            Navigator.pop(context, 'Cancel');
          },
          child: const Text('Cancel'),
        ),
      ],
    ),
  );

  void gallery(int i) => Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => GalleryWidget(
          index: i,
          urlImages:
              productController.imagesData[indexListImages].imagesUrls)));

  buildIndicator(int count) => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: count,
        effect:
            WormEffect(dotHeight: 10, dotWidth: 10, activeDotColor: myHexColor),
      );
}

class GalleryWidget extends StatefulWidget {
  final PageController pageController;
  final List<String> urlImages;
  final int index;

  GalleryWidget({Key? key, required this.urlImages, this.index = 0})
      : pageController = PageController(initialPage: index);

  @override
  State<GalleryWidget> createState() => _GalleryWidgetState();
}

class _GalleryWidgetState extends State<GalleryWidget> {
  late int index = widget.index;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    widget.pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            foregroundColor: Colors.black.withOpacity(1.0),
            backgroundColor: Colors.transparent,
            elevation: 0.0,
          ),
          body: Container(
            color: Colors.white,
            child: Stack(
              alignment: Alignment.bottomLeft,
              children: [
                PhotoViewGallery.builder(
                  backgroundDecoration: BoxDecoration(color: Colors.white),
                  pageController: widget.pageController,
                  itemCount: widget.urlImages.length,
                  builder: (context, index) {
                    final urlImage = widget.urlImages[index];
                    return PhotoViewGalleryPageOptions(
                      imageProvider: NetworkImage(
                        "$baseURL/$urlImage",
                      ),
                      minScale: PhotoViewComputedScale.contained,
                      maxScale: PhotoViewComputedScale.contained * 4,
                    );
                  },
                  onPageChanged: (index) => setState(() => this.index = index),
                ),
                Container(
                  padding: EdgeInsets.only(
                      top: 33.h, bottom: 20.h, right: 20.w, left: 20.w),
                  child: Text(
                    'image ${index + 1}/${widget.urlImages.length}',
                    style: TextStyle(fontSize: 22.sp, color: myHexColor),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}


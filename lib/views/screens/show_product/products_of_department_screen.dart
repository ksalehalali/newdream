import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:newdream/views/screens/show_product/product_details.dart';
import '../../../Assistants/globals.dart';
import '../../../controllers/catgories_controller.dart';
import '../../../controllers/lang_controller.dart';
import '../../../controllers/product_controller.dart';
import '../home/search_area_des.dart';
import 'product_item.dart';

class ProductsOfDepartmentScreen extends StatefulWidget {
  final String depId;
  final bool haveChildren;

  const ProductsOfDepartmentScreen(
      {Key? key, required this.depId, required this.haveChildren})
      : super(key: key);

  @override
  State<ProductsOfDepartmentScreen> createState() =>
      _ProductsOfDepartmentScreenState();
}

class _ProductsOfDepartmentScreenState extends State<ProductsOfDepartmentScreen>
    with SingleTickerProviderStateMixin {
  bool showOneList = false;
  final CategoriesController categoriesController = Get.find();
  final ProductsController productController = Get.find();

  List colors = [];
  Color color = Colors.grey;
  List<double> opacityColor = [];

  //
  List colors2 = [];
  Color color2 = Colors.grey;
  List<double> opacityColor2 = [];
  bool hasChildren2 = false;
  late final AnimationController _controller;
  bool show = false;
  final LangController langController = Get.find();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
getData();
  }

  getData()async{
    if (widget.haveChildren == true) {

      await categoriesController.getListCategoryByCategory(widget.depId);
      productController.getProductsByCat(categoriesController.departments[0]['id'],langController.appLocal);
    } else {
      productController.getProductsByCat(widget.depId,langController.appLocal);
    }
  }
  var childAspectRatio = 0.5;
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Container(
      color: myHexColor5,
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(1.0),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: [
                        InkWell(
                          onTap: () {
                            Get.back();
                            productController.catProducts.value = [];
                            categoriesController.departments.value = [];
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 14.0, right: 12, left: 12, bottom: 12),
                            child: SvgPicture.asset(
                                langController.appLocal == 'en'? 'assets/icons/left arrow.svg':'assets/icons/rghit_arrow.svg',
                                color: Colors.grey[800],
                                height: 24.00,
                                width: 24.0,
                                semanticsLabel: 'A red up arrow'),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              if (showOneList) {
                                showOneList = false;
                              } else {
                                showOneList = true;
                              }
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 14.0, right: 12, left: 12, bottom: 12),
                            child: showOneList
                                ? SvgPicture.asset('assets/icons/menu.svg',
                                color: Colors.grey[800],
                                height: 22.00,
                                width: 22.0,
                                semanticsLabel: 'A red up arrow')
                                : SvgPicture.asset(
                                'assets/icons/menu_category.svg',
                                color: Colors.grey[800],
                                height: 24.00,
                                width: 24.0,
                                semanticsLabel: 'A red up arrow'),
                          ),
                        ),
                      ],
                    ),
                    const SearchAreaDesign(),
                    const SizedBox(
                      height: 3.0,
                    ),
                    Container(
                      width: screenSize.width,
                      height: 2,
                      color: Colors.grey[400],
                    ),
                  ],
                ),
              ),
               SizedBox(
                height: 4.0.h,
              ),
              widget.haveChildren == true
                  ? SizedBox(
                  width: screenSize.width.w,
                  height: screenSize.height * 0.1+12.h,
                  child: _buildDepartmentsOptions(screenSize))
                  : Container(),
              hasChildren2 ==true?Divider():Container(),
              hasChildren2 == true
                  ? SizedBox(
                  width: screenSize.width.w,
                  height: screenSize.height * 0.1 - 44.h,
                  child: _buildDepartmentsOptionsOfDeps())
                  : Container(),
              // productController.gotProductsByCat.value == false
              //     ?Padding(
              //   padding: const EdgeInsets.only(top: 8.0),
              //   child: Center(
              //     child: Obx(
              //           () => productController.gotProductsByCat.value == false
              //           ? Lottie.asset(
              //         'assets/animations/30826-online-shopping.json',
              //         height: 42.h,
              //         width: 222.w,
              //         fit: BoxFit.cover,
              //         controller: _controller,
              //         onLoaded: (composition) {
              //           // Configure the AnimationController with the duration of the
              //           // Lottie file and start the animation.
              //           _controller
              //             ..duration = composition.duration
              //             ..forward();
              //         },
              //       )
              //           : Container(),
              //     ),
              //   ),
              // ):Container(),
              const SizedBox(
                height: 12.0,
              ),
              SizedBox(
                  height: widget.haveChildren ==true ?screenSize.height * 0.6-15:screenSize.height * 0.8-30,
                  child: _buildDepartmentProductsList()),

            ],
          ),
        ),
      ),
    );


  }

  Widget _buildDepartmentsOptions(screenSize) {
    return CustomScrollView(
      scrollDirection: Axis.horizontal,
      slivers: [
        Obx(
              () => SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) {
                for (int i = 0;
                i < categoriesController.departments.length;
                i++) {
                  if (i == 0) {
                    colors.add(myHexColor);
                    opacityColor.add(1.0);
                  } else {
                    opacityColor.add(0.7);
                    colors.add(Colors.black87);
                  }
                }
                return InkWell(
                  onTap: () {
                    setState(() {
                      for (int i = 0; i < colors.length; i++) {
                        if (index == i) {
                          colors[index] = myHexColor;
                          opacityColor[index] = 1.0;
                        } else {
                          opacityColor[i] = 0.7;
                          colors[i] = Colors.black87;
                        }
                        opacityColor2.clear();
                        colors2.clear();
                      }
                    });
                    productController.getProductsByCat(categoriesController.departments[index]['id'],langController.appLocal);
                    print('has children ::: ${ categoriesController.departments[index]['children']}');
                    if(categoriesController.departments[index]['children']==true){
                      categoriesController.getListDepartmentsByDepartmentId(categoriesController.departments[index]['id']).then((value) {
                        setState(() {
                          hasChildren2 =true;
                        });
                        productController.getProductsByCat(categoriesController.departments2[0]['id'],langController.appLocal);

                      });

                    }else{
                      setState(() {
                        hasChildren2 =false;
                      });
                    }
                  },
                  child:

                  Column(
                    children: <Widget>[
                      Container(
                        height: screenSize.height *0.1 -17,
                        width:  screenSize.height *0.1 -16,
                        padding:  EdgeInsets.all(0.1),
                        decoration:  BoxDecoration(
                          color: myHexColor,
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                          child: Image.network(
                            "$baseURL/${categoriesController.departments[index]['image']}",
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      SizedBox(height: 4),
                      SizedBox(
                          width: screenSize.width *0.2+32.w,
                          child: Text(langController.appLocal=="ar"?categoriesController.departments[index]['name_AR'] :categoriesController.departments[index]['name_EN'],overflow: TextOverflow.fade,maxLines:1,style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold,color:  colors[index],),textAlign: TextAlign.center,))
                    ],
                  ),
                );
              },
              childCount: categoriesController.departments.length,
              semanticIndexOffset: 1,
            ),
          ),
        )
      ],
    );
  }

  //build departments2
  Widget _buildDepartmentsOptionsOfDeps() {
    return CustomScrollView(
      scrollDirection: Axis.horizontal,
      slivers: [
        Obx(
              () => SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) {
                for (int i = 0;
                i < categoriesController.departments2.length;
                i++) {
                  if (i == 0) {
                    colors2.add(myHexColor);
                    opacityColor2.add(1.0);
                  } else {
                    opacityColor2.add(0.7);
                    colors2.add(Colors.black);
                  }
                }
                return InkWell(
                  onTap: () {
                    setState(() {
                      for (int i = 0; i < colors2.length; i++) {
                        if (index == i) {
                          colors2[index] = myHexColor;
                          opacityColor2[index] = 1.0;
                        } else {
                          opacityColor2[i] = 0.7;
                          colors2[i] = Colors.black;
                        }
                      }
                    });
                    productController.getProductsByCat(categoriesController.departments2[index]['id'],langController.appLocal);
                    print('has children ::: ${ categoriesController.departments2[index]['children']}');

                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    padding: EdgeInsets.zero,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 0.4,
                        color: colors[index].withOpacity(opacityColor[index]),

                      ),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Center(
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 13.0,),
                          child: Text(
                            langController.appLocal=="ar"?categoriesController.departments2[index]['name_AR'] :categoriesController.departments2[index]['name_EN'],
                            style: TextStyle(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w400,
                              color: colors2[index],
                            ),
                          ),
                        ),
                      ),

                    ),
                  ),
                );
              },
              childCount: categoriesController.departments2.length,
              semanticIndexOffset: 1,
            ),
          ),
        )
      ],
    );
  }


  Widget _buildDepartmentProductsList() {

    return Padding(
      padding:  EdgeInsets.only(top: 2.0.h, bottom: 0.0.h),
      child: Container(
        color: Colors.grey[50],
        child: Obx(
              () => GridView.builder(
            itemCount: productController.catProducts.length,
            physics:ScrollPhysics() ,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            semanticChildCount: 0,
            gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 1,
                crossAxisSpacing: 1,
                childAspectRatio: 0.6 ,),
            itemBuilder: (context, index) {
              return Padding(
                  padding: EdgeInsets.zero,
                  child: ProductItemCard(
                    product: productController.catProducts[index],
                    fromDetails: false,
                    from: 'dep',
                    press: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          transitionDuration: const Duration(milliseconds: 500),
                          reverseTransitionDuration:
                          const Duration(milliseconds: 500),
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                              FadeTransition(
                                opacity: animation,
                                child: ProductDetails(
                                  product: productController.recommendedProducts[index],
                                ),
                              ),
                        ),
                      );
                    },
                  ));
            },
          ),
        ),
      ),
    );
  }


}
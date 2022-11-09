import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import '../Assistants/globals.dart';
import '../controllers/product_controller.dart';
import 'widgets/list_one_item_v.dart';

class FavoriteScreen extends StatefulWidget {
  FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  final ProductsController productController = Get.find();

  clearCache() {
    DefaultCacheManager().emptyCache();
    imageCache.clear();
    imageCache.clearLiveImages();
  }
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    productController.getMyFav();
  }
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Container(
      color: myHexColor,
      child: SafeArea(
        child: Scaffold(
          body: Container(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          clearCache();
                          Get.back();
                          productController.catProducts.value = [];
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 16.0, right: 12, left: 12, bottom: 12),
                          child: SvgPicture.asset('assets/icons/left arrow.svg',
                              color: Colors.grey[800],
                              height: 18.00,
                              width: 18.0,
                              semanticsLabel: 'A red up arrow'),
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Padding(
                            padding: const EdgeInsets.only(
                                top: 16.0, right: 12, left: 12, bottom: 12),
                            child: SvgPicture.asset('assets/icons/menu.svg',
                                color: Colors.grey[800],
                                height: 18.00,
                                width: 18.0,
                                semanticsLabel: 'A red up arrow')),
                      ),
                    ],
                  ),
                  SizedBox(height: 12,),
                  SizedBox(
                      height: screenSize.height - 120,
                      width: screenSize.width,
                      child: ListOneItem(context,productController.favProducts)),
                  SizedBox(
                    height: screenSize.height * 0.1,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

import '../../Assistants/globals.dart';
import '../../controllers/product_controller.dart';

Widget ListOneItem(BuildContext context,list) {
  final ProductsController productController = Get.find();
  final screenSize = MediaQuery.of(context).size;

  final customCacheManager = CacheManager(
      Config('customCacheKey', stalePeriod: 15.days, maxNrOfCacheObjects: 100));
  return CustomScrollView(
    scrollDirection: Axis.vertical,
    slivers: [
      Obx(
        () => SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return Padding(
                  padding: EdgeInsets.all(3),
                  child: Container(
                    height: 170,
                    width: screenSize.width - 20,
                    decoration: BoxDecoration(
                        border: Border.all(width: 0.5, color: myHexColor)),
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: CachedNetworkImage(
                                //cacheManager: customCacheManager,
                                key: UniqueKey(),
                                imageUrl: '$baseURL/${list[index]['image']}',
                                height: 160,
                                width: 120,
                                maxHeightDiskCache: 75,
                                fit: BoxFit.fill,
                                placeholder: (context, url) => const Center(
                                    child: CircularProgressIndicator()),
                                errorWidget: (context, url, error) => Container(
                                  color: Colors.black,
                                  child: const Icon(
                                    Icons.error,
                                    color: Colors.red,
                                  ),
                                ),
                              )),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: SizedBox(
                                    width: screenSize.width * 0.5 - 12,
                                    child: Text(
                                      '${list[index]['product']}'.toUpperCase(),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                          color: Color.fromARGB(255, 22, 21, 21)),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: screenSize.height * 0.1 - 70,
                                ),
                                Text(
                                  '${list[index]['userName']}',
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: const Color.fromARGB(
                                          255, 22, 21, 21)),
                                ),
                                SizedBox(
                                  height: screenSize.height * 0.1 - 70,
                                ),
                                Text(
                                  '${num.parse(list[index]['price']) - num.parse(list[index]['price']) * num.parse(list[index]['offer']) / 100}',
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: const Color.fromARGB(
                                          255, 22, 21, 21)),
                                ),
                                SizedBox(
                                  height: screenSize.height * 0.1 - 70,
                                ),
                                SizedBox(
                                  width: screenSize.width * 0.5 - 12,
                                  child: Row(
                                    children: [
                                      Text(
                                        "${num.parse(list[index]['price']).toStringAsFixed(3)} QR"
                                            .toUpperCase(),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        textAlign: TextAlign.left,
                                        style: const TextStyle(
                                            decoration:
                                                TextDecoration.lineThrough,
                                            fontFamily:
                                                'Montserrat-Arabic Regular',
                                            color: Colors.grey,
                                            fontSize: 13),
                                      ),
                                      const SizedBox(
                                        width: 7.0,
                                      ),
                                      Text(
                                        "Discount ${list[index]['offer']}%",
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontFamily:
                                                'Montserrat-Arabic Regular',
                                            color: myHexColor3,
                                            fontSize: 13),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: screenSize.height * 0.1 - 70,
                                ),
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: (() => productController
                                .deleteProdFromFav(list[index]['id'])),
                            child: Padding(
                              padding: EdgeInsets.only(top: 0),
                              child: Icon(
                                Icons.delete_forever,
                                size: 26,
                                color: Colors.red,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ));
            },
            childCount: list.length,
            semanticIndexOffset: 2,
          ),
        ),
      )
    ],
  );
}

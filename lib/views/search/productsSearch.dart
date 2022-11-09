import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../Assistants/globals.dart';
import '../../Assistants/request-assistant.dart';
import '../../controllers/address_location_controller.dart';
import '../../controllers/product_controller.dart';
import '../../models/address.dart';
import '../../models/product_model.dart';
import '../address/address_on_map.dart';
import '../address/config-maps.dart';
import '../screens/show_product/product_details.dart';
import '../widgets/divider.dart';
import '../widgets/progressDialog.dart';



class SearchProductScreen extends StatefulWidget {
  const SearchProductScreen({Key? key}) : super(key: key);

  @override
  _SearchProductScreenState createState() => _SearchProductScreenState();
}

class _SearchProductScreenState extends State<SearchProductScreen> {
  TextEditingController dropAddressController = TextEditingController();
  final AddressController addressController = Get.find();
  final ProductsController productController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black87,
      ) ,

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Padding(
            padding: const EdgeInsets.all(12.0),
            child: SizedBox(
              height: 48,
              child: TextFormField(
                controller: dropAddressController,

                onTap: () {

                },
                onChanged: (val) {
                  productController.findProduct(val);

                },
                onFieldSubmitted: (val) {

                },
                decoration: InputDecoration(
                  alignLabelWithHint: true,
                  hintText: 'What are you looking for?',
                  hintStyle: TextStyle(
                    height: 1,
                      fontWeight: FontWeight.bold
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(5.5),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                  prefixIcon: Icon(
                    Icons.search_rounded,
                    color: Colors.grey[400],
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  labelText: "Enter Product Name",

                  labelStyle: TextStyle(color: Colors.grey[600]),
                ),
              ),
            ),
          ),

          //
          Obx(() {
            return Expanded(
              child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 16.0,
                  ),
                  child: ListView.separated(
                    padding: EdgeInsets.all(0.0),
                    itemBuilder: (context, index) => PredictionTile(
                      productPredictions:
                      productController.productPredictionList[index],
                    ),
                    itemCount: productController.productPredictionList.length,
                    separatorBuilder: (BuildContext context, index) =>
                       Divider(thickness: 0.4,),
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                  )),
            );
          })
        ],
      ),
    );
  }
}

class PredictionTile extends StatefulWidget {
  final ProductModel? productPredictions;

  PredictionTile({Key? key, this.productPredictions}) : super(key: key);

  @override
  State<PredictionTile> createState() => _PredictionTileState();
}

class _PredictionTileState extends State<PredictionTile> {
  final AddressController addressController = Get.find();

  final ProductsController productController = Get.find();


  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return InkWell(
      onTap: () {
        productController.getOneProductDetails(widget.productPredictions!.id!);

        Get.to(() => ProductDetails(
          product: widget.productPredictions,
        ));
        // Navigator.pushAndRemoveUntil(
        //     context,
        //     MaterialPageRoute(builder: (context) => const AddressOnMap()),
        //         (route) => false);
      },
      child: Container(
        child: Column(
          children: [
            SizedBox(
              width: 10.0,
            ),
            Row(
              children: [

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: CachedNetworkImage(
                            //cacheManager: customCacheManager,
                            key: UniqueKey(),
                            imageUrl: '$baseURL/${widget.productPredictions!.imageUrl}',
                            height: screenSize.height * 0.3,
                            width: screenSize.width * 0.5,
                            maxHeightDiskCache: 110,
                            fit: BoxFit.fill,
                            placeholder: (context, url) =>
                            const Center(child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) => Container(
                              color: Colors.black,
                              child: const Icon(
                                Icons.error,
                                color: Colors.red,
                                size: 38,
                              ),
                            ),
                          )),
                      SizedBox(height: 6,),
                      Text(
                        widget.productPredictions!.en_name!,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 16.0,fontWeight: FontWeight.w600,letterSpacing: 1),
                      ),
                      SizedBox(height: 6,),
                      Text(
                        widget.productPredictions!.brand!,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 16.0,fontWeight: FontWeight.w600,letterSpacing: 1),
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        "${widget.productPredictions!.price.toString()} QAR",
                        overflow: TextOverflow.ellipsis,
                        style:
                        TextStyle(fontSize: 14.0, color: Colors.grey[800],letterSpacing: 0.5),
                      ),
                      SizedBox(
                        height: 8,
                      )
                    ],
                  ),
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}
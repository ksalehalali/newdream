import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../Assistants/request-assistant.dart';
import '../../controllers/address_location_controller.dart';
import '../../models/address.dart';
import '../widgets/divider.dart';
import '../widgets/progressDialog.dart';
import 'address_on_map.dart';
import 'config-maps.dart';

class SearchAddressScreen extends StatefulWidget {
  const SearchAddressScreen({Key? key}) : super(key: key);

  @override
  _SearchAddressScreenState createState() => _SearchAddressScreenState();
}

class _SearchAddressScreenState extends State<SearchAddressScreen> {
  TextEditingController dropAddressController = TextEditingController();
  final AddressController addressController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 70,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: dropAddressController,

              onTap: () {

              },
              onChanged: (val) {
                addressController.findPlace(val);

              },
              onFieldSubmitted: (val) {

              },
              decoration: InputDecoration(
                alignLabelWithHint: true,
               hintText: 'Where shall we drop your order?',
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
                labelText: "Enter Your Address",
                labelStyle: TextStyle(color: Colors.grey[400]),
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
                      placePredictions:
                      addressController.placePredictionList[index],
                    ),
                    itemCount: addressController.placePredictionList.length,
                    separatorBuilder: (BuildContext context, index) =>
                        DividerWidget(),
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

class PredictionTile extends StatelessWidget {
  final PlaceShort? placePredictions;
  final AddressController addressController = Get.find();

  PredictionTile({Key? key, this.placePredictions}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: () {
        Address address = Address(
          placeName: placePredictions!.mainText,
        );

          getPlaceAddressDetails(placePredictions!.placeId!, context);
        addressController.areaLoc.value = LatLng(placePredictions!.lat!, placePredictions!.lng!);
        print("on tap :::===== ${placePredictions!.lng}");


            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) =>  const AddressOnMap(fromCart:false ,)),
                    (route) => false);
      },
      child: Container(
        child: Column(
          children: [
            SizedBox(
              width: 10.0,
            ),
            Row(
              children: [
                Icon(Icons.add_location),
                SizedBox(
                  width: 14.0,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        placePredictions!.mainText!,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 16.0),
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        placePredictions!.secondText!,
                        overflow: TextOverflow.ellipsis,
                        style:
                        TextStyle(fontSize: 12.0, color: Colors.grey[600]),
                      ),
                      SizedBox(
                        height: 8,
                      )
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 14.0,
            ),
          ],
        ),
      ),
    );
  }

  void getPlaceAddressDetails(String placeId, context) async {
    showDialog(
        context: context,
        builder: (BuildContext context) => ProgressDialog(
          message: "Setting DropOff , Please wait ...",
        ));

    String placeDetailsURL =
        "https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$mapKey";

    var res = await RequestAssistant.getRequest(placeDetailsURL);

    if (res == "failed") {
      return;
    }

    if (res["status"] == "OK") {
      Address address = Address();

      address.placeName = res["result"]["name"];
      address.placeId = placeId;
      address.latitude = res["result"]["geometry"]["location"]["lat"];
      address.longitude = res["result"]["geometry"]["location"]["lng"];
      //
      // initialPoint.latitude = address.latitude!;
      // initialPoint.longitude = address.longitude!;


      print("this drop off location :: ${address.placeName}");
      print(
          "this drop off location :: lat ${address.latitude} ,long ${address.longitude}");
      // Navigator.pushAndRemoveUntil(context,
      //     MaterialPageRoute(builder: (context) => Map()), (route) => false);
    }
  }
}
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:newdream/views/address/search_address_screen.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../Assistants/assistantMethods.dart';
import '../../Assistants/globals.dart';
import '../../controllers/address_location_controller.dart';
import '../screens/home/home.dart';
import '../screens/main_screen.dart';
import '../widgets/search_area_des.dart';
import 'add_address_screen.dart';

class AddressOnMap extends StatefulWidget {
  final bool fromCart;
  const AddressOnMap({Key? key,required this.fromCart}) : super(key: key);

  @override
  State<AddressOnMap> createState() => AddressOnMapState();
}

class AddressOnMapState extends State<AddressOnMap> {
  Completer<GoogleMapController> _controller = Completer();
  PanelController panelController = PanelController();
  GoogleMapController? newGoogleMapController;
  double bottomPaddingOfMap = 0;
  Color myHexColor = Color(0xff01a9a9);
  var assistantMethods = AssistantMethods();

  LatLng myCurrentLoc = LatLng(0.0, 0.0);
  static CameraPosition _inialPointCamera = CameraPosition(
    target: LatLng(29.2556835, 47.9234983),
    zoom: 14.4746,
  );
  CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(29.2556835, 47.9234983),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  LatLng locFromCam = LatLng(0.0, 0.0);
  final AddressController addressController = Get.find();

  updateCurrentLocMarker(LatLng latLng) {
    assistantMethods.searchCoordinateAddress(latLng, context, false);
    addressController.updateCurrentLoc(latLng);
  }

  //
  //
  var location = Location();

  void locatePosition() async {
    LatLng latLngPosition = LatLng(addressController.areaLoc.value.latitude,
        addressController.areaLoc.value.longitude);
    CameraPosition cameraPosition =
        CameraPosition(target: latLngPosition, zoom: 15);
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SlidingUpPanel(
        controller: panelController,
        maxHeight: screenSize.height * 0.2 - 10,
        minHeight: screenSize.height * 0.2 - 40,
        panelBuilder: (scrollContainer) => AnimatedSize(
          duration: 200.milliseconds,
          curve: Curves.bounceIn,
          child: Column(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Obx(
                    () => SizedBox(
                      width: screenSize.width  ,
                      child: Text(
                        addressController.pinAddress.value,
                        maxLines: 2,

                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.black, fontSize: 15),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height:12.h),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AddAddressScreen(fromCart: false,)));
                },
                child: Text(
                  'CONFIRM LOCATION_txt'.tr,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                style: ElevatedButton.styleFrom(
                    maximumSize: Size(210, 300),
                    minimumSize: Size(210, 40),
                    primary: myHexColor1,
                    onPrimary: Colors.white,
                    alignment: Alignment.center),
              )
            ],
          ),
        ),
        body: Stack(
          fit: StackFit.expand,
          children: [
            Obx(
              () => GoogleMap(
                markers: {
                  Marker(
                      markerId: MarkerId('a'),
                      position: addressController.myCurrentLoc.value,
                      onTap: () {
                        print('object');
                      })
                },
                padding: EdgeInsets.only(bottom: 110, top: 25),
                mapType: MapType.satellite,
                mapToolbarEnabled: true,
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
                initialCameraPosition: _inialPointCamera,
                onCameraIdle: () {
                  updateCurrentLocMarker(locFromCam);

                  print('onCameraIdle');
                },
                onCameraMove: (camera) {
                  locFromCam = camera.target;

                  print(camera.target.latitude);
                },
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                  newGoogleMapController = controller;
                  setState(() {
                    bottomPaddingOfMap = 320.0;
                  });
                  locatePosition();
                },
              ),
            ),
            Positioned(
              top: 35.0,
              left: 22.0,
              child: InkWell(
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MainScreen(index: 0)));
                },
                child: Container(
                  //height: 300.0,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(22.0),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black,
                          blurRadius: 6.0,
                          spreadRadius: 0.5,
                          offset: Offset(0.7, 0.7),
                        ),
                      ]),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.close,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
                top: 90,
                width: screenSize.width,
                child: InkWell(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const SearchAddressScreen()));
                    },
                    child: searchAreaDes()))
          ],
        ),
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}

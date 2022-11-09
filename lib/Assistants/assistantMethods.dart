import 'dart:math';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../Assistants/request-assistant.dart';

import '../controllers/address_location_controller.dart';
import '../views/address/config-maps.dart';

class AssistantMethods {
  final box = GetStorage();
  final AddressController addressController = Get.find();
  Future<String> searchCoordinateAddress(
      LatLng latLng, context, bool homeCall) async {
    String placeAddress = "";

    var res = await RequestAssistant.getRequest(
        'https://api.mapbox.com/geocoding/v5/mapbox.places/${latLng.longitude},${latLng.latitude}.json?language=en&access_token=$mapbox_token');
    if (res != "failed") {
      // print("res === $res");
      // print('address :: ${res['features'][0]['place_name']}');
      // print('address :: ${res['features'][1]['id']}');
      // print('address :: ${res['features'][2]['place_name']}');
      // print('address :: ${res['features'][3]['place_name']}');

      print('0 :::::: ${res['features'][0]}');
      addressController.updatePinAddress('${res['features'][0]['place_name_en']}',res['features'][0]['text_en'],res['features'][0]['context'][0]['text_en']);

      if(res['features'][0]['context'].length >1){
        //print('0 context :: ${res['features'][0]['context'][2]['text_en']}'); //المحافضة
        addressController.updatePinAddress('${res['features'][0]['place_name_en']}',res['features'][0]['text_en'],res['features'][0]['context'][0]['text_en']);

      }else if(res['features'][0]['context'].length >=1){
        //print('0 context :: ${res['features'][0]['context'][1]['text_en']}'); //المنطقة

        print('0 :: ${res['features'][0]['text_en']}'); //العنوان
        placeAddress = res['features'][0]['place_name'];
        box.write('address', res['features'][0]['place_name']);

      }


      //print('0 :: ${res['features'][0]['place_name_en']}');

      // print('1 :: ${res['features'][1]}');
      // print('1 :: ${res['features'][1]['text']}');
      // print('1 :: ${res['features'][1]['place_name']}');
      //
      // print('2 :: ${res['features'][2]}');
      // print('2 :: ${res['features'][2]['text']}');
      // print('2 :: ${res['features'][2]['place_name']}');
      //
      // print('3 :: ${res['features'][3]}');
      // print('3 :: ${res['features'][3]['text']}');
      // print('3 :: ${res['features'][3]['place_name']}');

    } else {
      print(res);
      print("get address failed");
    }

    return placeAddress;
  }

  //
  Future obtainDirectionDetails() async {
    String directionURL =
        "https://maps.googleapis.com/maps/api/directions/json?destination=29.37477,47.994738;&origin=29.37477,47.994738;29.374678,47.99484;29.374527,47.995005&key=AIzaSyBSn3hFO_1ndRGrxuCZcnQ-LzhWet2Nq-s";

    var res = await RequestAssistant.getRequest(directionURL);

    if (res == "failed") {
      return null;
    }
    print("res :: $res");
  }

  static void getCurrentOnLineUserInfo() async {}

  static double createRandomNumber(int num) {
    var random = Random();
    int redNumber = random.nextInt(num);

    return redNumber.toDouble();
  }
}

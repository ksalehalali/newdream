import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import '../Assistants/globals.dart';
import '../Assistants/request-assistant.dart';
import '../Data/current_data.dart';
import '../models/placePredictions.dart';
import '../views/address/config-maps.dart';

class AddressController extends GetxController {
  var myCurrentLoc = LatLng(0.0, 0.0).obs;
  var myFullCurrentAddress = ''.obs;
  var aAddress = ''.obs;
  var bAddress = ''.obs;
  var addressSelected = ''.obs;
  var myAddressData = [].obs;
  var addressLength=0.obs;
  var areaLoc = LatLng(0.0, 0.0).obs;
  var addressWidgetSize = 20.0.obs;
  var addressWidgetIconSize = 17.0.obs;
  var s = 50.obs;
  var gotMyAddress = false.obs;
  var addresses = [].obs;
  var addingAddressForOrder = false.obs;
  var pinAddress = ''.obs;
  List placePredictionList = [].obs;

  updatePinAddress(String address, a, b) {
    pinAddress.value = address;
    myFullCurrentAddress.value = address;
    aAddress.value = a;
    bAddress.value = b;
    update();
  }

  updateCurrentLoc(LatLng latLng) {
    myCurrentLoc.value = latLng;
    print(myCurrentLoc.value.latitude);
    update();
  }

  showHideAddress(bool show) {
    if (show) {
      s.value = 50;
      addressWidgetSize.value = 20;
      addressWidgetIconSize.value = 17.0;
    } else {
      Timer(700.milliseconds, () {
        s.value = 30;
      });
      addressWidgetIconSize.value = 0.0;
      addressWidgetSize.value = 0.0;
    }
    update();
  }

  Future addNewAddress(
      {required String addressName,
      required String phone,
      required String area,
      required String street,
      required String house}) async {
    print('address === ${pinAddress.value}');
    print(' name $addressName ... phone :: ${phone}');
    var headers = {
      'Authorization': 'Bearer ${user.accessToken}',
      'Content-Type': 'application/json'
    };
    var request = http.Request(
        'POST', Uri.parse('https://dashcommerce.click68.com/api/AddAddress'));
    request.body = json.encode({
      "Longitude": myCurrentLoc.value.longitude,
      "Latitude": myCurrentLoc.value.latitude,
      "Address": pinAddress.value.toString(),
      "NameAddress": addressName,
      "phone": phone,
      "Area":area,
      "Strret":street,
      "House":house
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      getMyAddresses((addressLength.value/10).ceil());
    } else {
      print(response.reasonPhrase);
    }
  }

  Future getMyAddresses(int currentPage) async {
    gotMyAddress.value = false;
    var headers = {
      'Authorization': 'Bearer ${user.accessToken}',
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST',
        Uri.parse('https://dashcommerce.click68.com/api/ListAddressByUserID'));
    request.body = json
        .encode({"PageNumber": currentPage, "SizeNumber": 111, "UserID": user.id});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var json = jsonDecode(await response.stream.bytesToString());
      var data = json['description'];
      addressLength.value = json['total'];
      gotMyAddress.value = true;
      print(data);
      myAddressData.value = data;
    } else {
      print(response.reasonPhrase);
    }
  }

  Future deleteAddress(String id,) async {
    var headers = {
      'Authorization': 'Bearer ${user.accessToken}',
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST',
        Uri.parse('https://dashcommerce.click68.com/api/DeleteAddress'));
    request.body = json.encode({"id": id});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    var jsonRes = jsonDecode(await response.stream.bytesToString());
    var data = jsonRes['description'];
    print(jsonRes);
    if (jsonRes['status'] == true) {
      print(data);
      getMyAddresses((addressLength.value/10).ceil());
    } else {
      Get.snackbar('Wrong','Delete not done');
      print(response.reasonPhrase);
    }
  }

//
  void findPlace(String placeName) async {
    if (placeName.length > 1) {
      placePredictionList.clear();
      String autoCompleteUrl =
          "https://api.mapbox.com/geocoding/v5/mapbox.places/$placeName.json?worldview=us&access_token=$mapbox_token";

      var res = await RequestAssistant.getRequest(autoCompleteUrl);

      if (res == "failed") {
        print('failed');
        return;
      }
      if (res["features"] != null) {
        print(res['status']);
        var predictions = res["features"];

        var placesList = (predictions as List)
            .map((e) => PlacePredictions.fromJson(e))
            .toList();

        //placePredictionList = placesList;
        placesList.forEach((element) {
          placePredictionList.add(PlaceShort(
              placeId: element.id,
              mainText: element.text,
              secondText: element.place_name,
              lat: element.lat,
              lng: element.lng));
        });
        print(placePredictionList.first.mainText);
        update();
      }
    }
  }


  Color? _color = myHexColor3;
  Color? _color2 = Colors.grey[700];

  final List<Color> _colorColor = [
    myHexColor3,
  ];
  final List<Color> _colorColorBorder = [
    myHexColor3,
  ];
}

class PlaceShort {
  String? placeId;
  String? mainText;
  String? secondText;
  double? lat;
  double? lng;

  PlaceShort(
      {this.mainText, this.placeId, this.secondText, this.lat, this.lng});
}

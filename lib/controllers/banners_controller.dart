import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';

import '../Assistants/globals.dart';
class BannerController extends GetxController{
  var banner1 =[].obs;
  var banner2 =[].obs;
  var banner3 =[].obs;
  var gotBanner1 =false.obs;
  var gotBanner2 =false.obs;
  var gotBanner3= false.obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getBanner1();
    getBanner2();
    getBanner3();
  }

  Future getBanner1()async{
    var request = http.Request('GET', Uri.parse('$baseURL/api/ListBanner2'));


    http.StreamedResponse response = await request.send();
    var json = jsonDecode(await response.stream.bytesToString());
    var data = json['description'];

    if (response.statusCode == 200 && json['status']) {
      print('banner1 data = $json');

      for(int i = 0; i < data.length; i++){
        banner1.add(
          CachedNetworkImage(
            key: UniqueKey(),
            imageUrl:"$baseURL/${data[i]['banner']}",
            fit: BoxFit.fill,
            maxHeightDiskCache: 110,
            placeholder: (context, url) =>
                Center(child:   Shimmer.fromColors(
                  baseColor: Colors.grey[400]!,
                  highlightColor: Colors.grey[300]!,
                  child: Container(
                    height: 220.h,
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
        );
      }
      gotBanner1.value = true;
      update();
      print('banner1 got it.....');
    }
    else {
      print('Error banner1 data = $json');
      print(response.reasonPhrase);
    }
  }

  Future getBanner2()async{
    var request = http.Request('GET', Uri.parse('$baseURL/api/ListBanner2'));


    http.StreamedResponse response = await request.send();
    var json = jsonDecode(await response.stream.bytesToString());
    var data = json['description'];

    if (response.statusCode == 200 && json['status']) {
      print('banner2 data = $json');

      for(int i = 0; i < data.length; i++){
        banner2.add(
          CachedNetworkImage(
            key: UniqueKey(),
            imageUrl:"$baseURL/${data[i]['banner']}",
            fit: BoxFit.fill,
            maxHeightDiskCache: 110,
            placeholder: (context, url) =>
                Center(child:   Shimmer.fromColors(
                  baseColor: Colors.grey[400]!,
                  highlightColor: Colors.grey[300]!,
                  child: Container(
                    height: 220.h,
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
        );
      }

      gotBanner2.value = true;
      update();
      print('banner1 got it.....');
    }
    else {
      print('Error banner2 data = $json');
      print(response.reasonPhrase);
    }
  }

  Future getBanner3()async{
    var request = http.Request('GET', Uri.parse('$baseURL/api/ListBanner3'));


    http.StreamedResponse response = await request.send();
    var json = jsonDecode(await response.stream.bytesToString());
    var data = json['description'];

    if (response.statusCode == 200 && json['status']) {
      print('banner3 data = $json');

      for(int i = 0; i < data.length; i++){
        banner3.add(
          CachedNetworkImage(
            key: UniqueKey(),
            imageUrl:"$baseURL/${data[i]['banner']}",
            fit: BoxFit.fill,
            maxHeightDiskCache: 110,
            placeholder: (context, url) =>
                Center(child:   Shimmer.fromColors(
                  baseColor: Colors.grey[400]!,
                  highlightColor: Colors.grey[300]!,
                  child: Container(
                    height: 220.h,
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
        );
      }

      gotBanner3.value = true;
      update();
      print('banner1 got it.....');
    }
    else {
      print('Error banner3 data = $json');
      print(response.reasonPhrase);
    }
  }
}
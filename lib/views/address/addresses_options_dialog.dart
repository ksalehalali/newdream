import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../Assistants/globals.dart';
import '../../controllers/address_location_controller.dart';

Widget buildAddressesOptions() {
  final AddressController addressController = Get.find();

  List colors = [];

  Color color = Colors.grey;
  final storage = GetStorage();
  final screenSize = Get.size;

  List<double> opacityColor = [];
  return CustomScrollView(
    scrollDirection: Axis.vertical,
    slivers: [
      Obx(
        () => SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              for (int i = 0; i < addressController.myAddressData.length; i++) {
                if (i == 0) {
                  colors.add(myHexColor);
                  opacityColor.add(1.0);
                } else {
                  opacityColor.add(0.7);
                  colors.add(Colors.black);
                }
              }
              return InkWell(
                onTap: () {
                  storage.write('idAddressSelected',
                      addressController.myAddressData[index]['id']);
                  storage.write('address',
                      addressController.myAddressData[index]['address']);
                  storage.write('indexAddressSelected', index);
                  addressController.addressSelected.value =
                      addressController.myAddressData[index]['address'];
                  //  setState(() {
                  for (int i = 0; i < colors.length; i++) {
                    if (index == i) {
                      colors[index] = myHexColor;
                      opacityColor[index] = 1.0;
                    } else {
                      opacityColor[i] = 0.7;
                      colors[i] = Colors.black;
                    }
                  }
                  //});
                },
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        width: 0.7,
                        color: colors[index].withOpacity(opacityColor[index]),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(7.0),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.location_on),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 6.0, vertical: 2),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.edit,
                                      size: 22,
                                      color: Colors.grey[700],
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Text(
                                      'Edit',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey[700]),
                                    ),
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  addressController.deleteAddress(
                                      addressController.myAddressData[index]
                                          ['id']);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 2, right: 2.0),
                                  child: Icon(
                                    Icons.delete_forever,
                                    color: Colors.red,
                                  ),
                                ),
                              )
                            ],
                          ),
                          Divider(
                            thickness: 2,
                            height: 10,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: screenSize.width * 0.3,
                                child: Text('Name',
                                    style: TextStyle(
                                        fontSize: 13, color: Colors.grey[700])),
                              ),
                              SizedBox(
                                width: screenSize.width * 0.5,
                                child: Text(
                                    addressController.myAddressData[index]
                                        ['nameAddress'],
                                    style: TextStyle(
                                        fontSize: 13, color: Colors.grey[700])),
                              ),
                            ],
                          ),
                          Divider(
                            thickness: 2,
                            height: 10,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: screenSize.width * 0.3,
                                child: Text('Phone',
                                    style: TextStyle(
                                        fontSize: 13, color: Colors.grey[700])),
                              ),
                              SizedBox(
                                width: screenSize.width * 0.5,
                                child: Text(
                                    addressController.myAddressData[index]
                                        ['phone'],
                                    style: TextStyle(
                                        fontSize: 13, color: Colors.grey[700])),
                              ),
                            ],
                          ),
                          Divider(
                            thickness: 2,
                            height: 10,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: screenSize.width * 0.3,
                                child: Text('Address',
                                    style: TextStyle(
                                        fontSize: 13, color: Colors.grey[700])),
                              ),
                              SizedBox(
                                width: screenSize.width * 0.5,
                                child: Text(
                                    addressController.myAddressData[index]
                                        ['address'],
                                    style: TextStyle(
                                        fontSize: 13, color: Colors.grey[700])),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
            childCount: addressController.myAddressData.length,
            semanticIndexOffset: 2,
          ),
        ),
      )
    ],
  );
}

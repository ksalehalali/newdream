import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../../Assistants/globals.dart';
import '../../controllers/address_location_controller.dart';
import '../../controllers/lang_controller.dart';
import '../screens/main_screen.dart';
import 'address_on_map.dart';
import 'list_addresses.dart';

class AddAddressScreen extends StatefulWidget {
  final bool fromCart;
  const AddAddressScreen({Key? key,required this.fromCart}) : super(key: key);

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {

  final AddressController addressController = Get.find();
  TextEditingController _addresNameController = TextEditingController();
  TextEditingController _areaController = TextEditingController();
  TextEditingController _streetNameController = TextEditingController();
  TextEditingController _houseNameController = TextEditingController();

  final LangController langController = Get.find();
String? phoneNumber;
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Container(
      child: Scaffold(
        body: SingleChildScrollView(
            child: Column(
          children: [
            SizedBox(
              height: screenSize.height * 0.1 - 60,
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.location_history,
                    size: 32,
                    color: Colors.green[800],
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const MainScreen(index: 0)));
                    },
                    child: Text(
                      "CANCEL_txt".tr,
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[800],
                          fontWeight: FontWeight.w500),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: screenSize.height * 0.1 - 60.h,
            ),
            Padding(
              padding: const EdgeInsets.all(0.0),
              child: Text(
                'Location Information_txt'.tr,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: myHexColor),
              ),
            ),
            SizedBox(
              height: screenSize.height * 0.1 - 44,
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 160.w,
                        child: Text(
                          addressController.aAddress.value,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      SizedBox(
                        width: screenSize.width * 0.6.w,
                        child: Text(
                          addressController.bAddress.value,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  // Align(
                  //   alignment: Alignment.centerRight,
                  //   child: InkWell(
                  //     onTap: () {
                  //       Navigator.of(context).push(MaterialPageRoute(
                  //           builder: (context) =>  AddressOnMap(fromCart: widget.fromCart,)));
                  //     },
                  //     child: Container(
                  //         height: 72.h,
                  //         width: 72.w,
                  //         decoration: BoxDecoration(
                  //             image: const DecorationImage(
                  //               fit: BoxFit.fill,
                  //               opacity: 0.7,
                  //               image: AssetImage(
                  //                 'assets/images/isolate-golden-location-pin.jpg',
                  //               ),
                  //             ),
                  //             borderRadius: BorderRadius.circular(12)),
                  //         child: Stack(
                  //           alignment: Alignment.bottomCenter,
                  //           children: [
                  //             Container(
                  //               height: 17.h,
                  //               color: Colors.white.withOpacity(0.3),
                  //             ),
                  //             Text(
                  //               'Edit_txt'.tr,
                  //               style: TextStyle(
                  //                   fontSize: 14,
                  //                   color: Colors.blue[700],
                  //                   fontWeight: FontWeight.bold),
                  //             )
                  //           ],
                  //         )),
                  //   ),
                  // )
                ],
              ),
            ),

            //
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Theme(
                data: ThemeData.from(
                  colorScheme: ColorScheme.fromSwatch(
                      primarySwatch: primaryColorSwatch),
                ),
                child: SizedBox(
                  width: screenSize.width * 0.7.w,
                  height: 50,
                  child: TextFormField(
                    controller: _areaController,
                    decoration: InputDecoration(
                        focusColor: Colors.blue[700],
                        labelStyle: TextStyle(fontSize: 14),
                        hoverColor: Colors.blue[700],
                        border: OutlineInputBorder(),
                        label: Text('Area_txt'.tr)),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: screenSize.height * 0.1-60.h,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Theme(
                data: ThemeData.from(
                  colorScheme: ColorScheme.fromSwatch(
                      primarySwatch: primaryColorSwatch),
                ),
                child: SizedBox(
                  width: screenSize.width * 0.7.w,
                  height: 50,
                  child: TextFormField(
                    controller: _streetNameController,
                    decoration: InputDecoration(
                        focusColor: Colors.blue[700],
                        labelStyle: TextStyle(fontSize: 14),
                        hoverColor: Colors.blue[700],
                        border: OutlineInputBorder(),
                        label: Text('Street_txt'.tr)),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: screenSize.height * 0.1-60.h,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Theme(
                data: ThemeData.from(
                  colorScheme: ColorScheme.fromSwatch(
                      primarySwatch: primaryColorSwatch),
                ),
                child: SizedBox(
                  width: screenSize.width * 0.7.w,
                  height: 50,
                  child: TextFormField(
                    controller: _houseNameController,
                    decoration: InputDecoration(
                        focusColor: Colors.blue[700],
                        labelStyle: TextStyle(fontSize: 14),
                        hoverColor: Colors.blue[700],
                        border: OutlineInputBorder(),
                        label: Text('HouseOrBuilding_txt'.tr)),
                  ),
                ),
              ),
            ),
            Divider(
              thickness: 1,
              height: 20.h,
            ),
            SizedBox(
              height: screenSize.height * 0.1-50.h,
            ),
            Text(
              'Personal Information_txt'.tr,
              style: TextStyle(
                  fontSize: 16, color: myHexColor, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: screenSize.height * 0.1 - 70,
            ),
            Container(
              width: screenSize.width,
              color: Colors.grey[100],
              //margin: EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 14),
                    child: SizedBox(
                      width: screenSize.width * 0.7,
                      child: IntlPhoneField(
                        decoration: InputDecoration(
                          labelText: 'Phone_txt'.tr,
                          focusColor: myHexColor,
                          labelStyle: TextStyle(fontSize: 14),
                          hoverColor: myHexColor,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: myHexColor),
                          ),
                        ),
                        initialCountryCode: 'QA',
                        onChanged: (phone) {
                          print(phone.completeNumber);
                          phoneNumber = phone.completeNumber;
                          print(phoneNumber);
                        },
                      )
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Theme(
                      data: ThemeData.from(
                        colorScheme: ColorScheme.fromSwatch(
                            primarySwatch: primaryColorSwatch),
                      ),
                      child: SizedBox(
                        width: screenSize.width * 0.7,
                        child: TextFormField(
                          controller: _addresNameController,
                          decoration: InputDecoration(
                              focusColor: Colors.blue[700],
                              labelStyle: TextStyle(fontSize: 14),
                              hoverColor: Colors.blue[700],
                              border: OutlineInputBorder(),
                              label: Text('Name_txt'.tr)),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: screenSize.height * 0.1 - 40,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      print('area ${_areaController.text}');
                      print('street ${_streetNameController.text}');

                      print('house ${_houseNameController.text}');
                      print('phone ${phoneNumber}');
                      print('name ${_addresNameController.text}');


                      if(_areaController.text.length > 3 && _streetNameController.text.length >1) {
                        addressController.addNewAddress(
                            addressName:_addresNameController.text,phone: phoneNumber!,area:_areaController.text,street:_streetNameController.text,house:_houseNameController.text).then((value) =>
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>  ListAddresses(fromCart: false,fromAccount: false,)))
                        );
                      }

                    },
                    child:  Text(
                      'SAVE ADDRESS_txt'.tr,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    style: ElevatedButton.styleFrom(
                        maximumSize: Size(200, 300),
                        minimumSize: Size(200, 40),
                        primary: myHexColor1,
                        onPrimary: Colors.white,
                        alignment: Alignment.center),
                  ),
                  SizedBox(
                    height: screenSize.height * 0.1 - 60,
                  ),
                ],
              ),
            ),
          ],
        )),
      ),
    );
  }
}

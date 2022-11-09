import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../Assistants/globals.dart';
import '../../controllers/address_location_controller.dart';
import '../screens/order/bay_options.dart';
import '../screens/order/Cart.dart';
import '../screens/main_screen.dart';
import 'add_address_screen.dart';
import 'address_on_map.dart';

class ListAddresses extends StatefulWidget {
  bool fromCart ;
  bool fromAccount;
   ListAddresses({Key? key,required this.fromCart,required this.fromAccount}) : super(key: key);

  @override
  State<ListAddresses> createState() => _ListAddressesState();
}

class _ListAddressesState extends State<ListAddresses> {
  final AddressController addressController = Get.find();

  List colors = [];

  Color color = Colors.grey;

  List<double> opacityColor = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    addressController.getMyAddresses(currentPage);
  }

  final storage = GetStorage();
  int currentPage = 0;
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Container(
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.location_history,
                        size: 32,
                        color: myHexColor,
                      ),
                       Row(
                         children: [
                           InkWell(
                             onTap: () {
                               currentPage--;
                               addressController.getMyAddresses(currentPage);
                               setState(() {
                               });
                             },
                             child: Icon(Icons.arrow_back_ios_new,size: 28,),),
                           SizedBox(width: 8,),
                           Obx(()=> Text("${currentPage.toString()} / ${(addressController.addressLength.value/10).ceil()}",style: TextStyle(fontSize: 16,color: myHexColor),)),
                           SizedBox(width: 8,),
                           InkWell(
                             onTap: () {
                               currentPage++;
                               addressController.getMyAddresses(currentPage);
                               setState(() {

                               });
                             },
                             child: Icon(Icons.arrow_forward_ios_outlined,size: 28,),),
                         ],
                       ),
                      InkWell(
                          onTap: () {
                            if(widget.fromCart ==true){
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => const Cart()));
                            }else if(widget.fromAccount ==true){
                              Navigator.of(context).pop();
                            }else if(widget.fromAccount ==false && widget.fromCart ==false){
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => const MainScreen(index: 0)));
                            }
                          },
                          child: const Icon(
                            Icons.cancel_outlined,
                            size: 28,
                            color: Colors.grey,
                          ))
                    ],
                  ),
                ),
                Obx(()=>SizedBox(
                      height: screenSize.height - 180,
                      width: screenSize.width,
                      child:addressController.myAddressData.value.length>0? buildAddressesOptions(screenSize):Padding(
                        padding: const EdgeInsets.symmetric(vertical: 18.0),
                        child: Container(
                          child:  Center(child: Text('No Addresses_txt'.tr),),
                        ),
                      )),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>  AddressOnMap(fromCart: widget.fromCart,)));
                  },
                  label:  Text(
                    'Add a new address_txt'.tr,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  icon: Icon(Icons.add),
                  style: ElevatedButton.styleFrom(
                      maximumSize: Size(220, 300),
                      minimumSize: Size(220, 40),
                      primary: myHexColor1,
                      onPrimary: Colors.white,
                      alignment: Alignment.center),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildAddressesOptions(screenSize) {
    return CustomScrollView(
      scrollDirection: Axis.vertical,
      slivers: [
        Obx(
          () => SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                for (int i = 0;
                    i < addressController.myAddressData.length;
                    i++) {
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
                    setState(() {
                      for (int i = 0; i < colors.length; i++) {
                        if (index == i) {
                          colors[index] = myHexColor;
                          opacityColor[index] = 1.0;
                        } else {
                          opacityColor[i] = 0.7;
                          colors[i] = Colors.black;
                        }
                      }
                    });
                    if(widget.fromAccount ==true)return;
                    if(addressController.addingAddressForOrder.value =true) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => const BayOptions()));
                    }

                    if(widget.fromCart ==false){
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                              builder: (context) => const MainScreen(index: 0)));
                    }else{
                      Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => const BayOptions()));
                    }
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
                                // Padding(
                                //   padding: const EdgeInsets.symmetric(
                                //       horizontal: 6.0, vertical: 2),
                                //   child: Row(
                                //     children: [
                                //       Icon(
                                //         Icons.edit,
                                //         size: 22,
                                //         color: Colors.grey[700],
                                //       ),
                                //       SizedBox(
                                //         width: 4,
                                //       ),
                                //       Text(
                                //         'Edit',
                                //         style: TextStyle(
                                //             fontSize: 14,
                                //             color: Colors.grey[700]),
                                //       ),
                                //     ],
                                //   ),
                                // ),
                                InkWell(
                                  onTap: () {
                                    addressController.deleteAddress(
                                        addressController.myAddressData[index]
                                            ['id']);
                                  },
                                  child: const Padding(
                                    padding: EdgeInsets.only(
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
                                  child: Text('Name_txt'.tr,
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.grey[700])),
                                ),
                                SizedBox(
                                  width: screenSize.width * 0.5,
                                  child: Text(
                                      addressController.myAddressData[index]
                                          ['nameAddress'],
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.grey[700])),
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
                                  child: Text('Phone_txt'.tr,
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.grey[700])),
                                ),
                                SizedBox(
                                  width: screenSize.width * 0.5,
                                  child: Text(
                                      addressController.myAddressData[index]
                                          ['phone'],
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.grey[700])),
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
                                  child: Text('Full auto address'.tr,
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.grey[700])),
                                ),
                                SizedBox(
                                  width: screenSize.width * 0.5,
                                  child: Text(
                                      addressController.myAddressData[index]
                                          ['address'],
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.grey[700])),
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
                                  child: Text('area'.tr,
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.grey[700])),
                                ),
                                SizedBox(
                                  width: screenSize.width * 0.5,
                                  child: Text(
                                      addressController.myAddressData[index]
                                      ['area']??'',
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.grey[700])),
                                ),
                              ],
                            ), Divider(
                              thickness: 2,
                              height: 10,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: screenSize.width * 0.3,
                                  child: Text('Street'.tr,
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.grey[700])),
                                ),
                                SizedBox(
                                  width: screenSize.width * 0.5,
                                  child: Text(
                                      addressController.myAddressData[index]
                                      ['strret']??'',
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.grey[700])),
                                ),
                              ],
                            ), Divider(
                              thickness: 2,
                              height: 10,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: screenSize.width * 0.3,
                                  child: Text('House'.tr,
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.grey[700])),
                                ),
                                SizedBox(
                                  width: screenSize.width * 0.5,
                                  child: Text(
                                      addressController.myAddressData[index]
                                      ['house']??'',
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.grey[700])),
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
}

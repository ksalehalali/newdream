import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Assistants/globals.dart';
import '../../../controllers/account_controller.dart';

Widget headHomeScreen(MediaQueryData screenSize) {
  final AccountController accountController = Get.find();

  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12.0),
    child: Container(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // const Icon(Icons.shopping_cart),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'welcome_txt'.tr,
              style: TextStyle(
                fontSize: 13,
                color: myHexColor3,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: 4,
            ),
            Obx(()=>Text("${accountController.firstName.value}",
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey[900],
                      fontWeight: FontWeight.bold)),
            )
          ],
        ),
        // Image.asset(
        //   'assets/images/logo.png',
        //   height: screenSize.size.height *0.1-25,
        //   width: screenSize.size.width *0.2+5,
        //   fit: BoxFit.fill,
        // )
      ],
    )),
  );
}

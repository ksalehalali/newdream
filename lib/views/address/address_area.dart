import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../controllers/address_location_controller.dart';
import '../../controllers/lang_controller.dart';

Widget addressHomeScreen(BuildContext context, MediaQueryData screenSize) {
  final box = GetStorage();
  final LangController langController = Get.find();

  final AddressController addressController = Get.find();
  final angle = langController.appLocal == 'ar'?-180 / 180 * pi:30 / 180 * pi;
  final transform = Matrix4.identity()..setEntry(3, 2,0.001 )..rotateY(angle);
  return Row(
    // mainAxisAlignment: MainAxisAlignment.center,
    // crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      Transform(
        alignment:langController.appLocal == 'ar'? Alignment.center:Alignment.center,
        transform: transform,
        child: SvgPicture.asset('assets/icons/shipping.svg',
            color: Colors.grey[600],
            height: 28.0.h,
            width: 28.0.w,
            semanticsLabel: 'A red up arrow'),
      ),
      SizedBox(
        width: screenSize.size.width * 0.1 - 37,
      ),
      Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width - 72.w,
           // height: Get.size.height *0.1-10.h,
            child: RichText(
                text: TextSpan(children: [
               TextSpan(
                  text: 'Delivery Address _txt'.tr,
                  style: TextStyle(fontSize: 13, color: Colors.black)),
              TextSpan(
                  text: box.read('address') ?? 'Add New Address_txt'.tr,
                  style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      overflow: TextOverflow.ellipsis)),
            ])),
          ),

          Obx(
            () => AnimatedSize(
              duration: 300.milliseconds,
              child: Padding(
                padding: EdgeInsets.zero,
                child: Icon(
                  langController.appLocal == 'ar'?FontAwesomeIcons.angleLeft:FontAwesomeIcons.angleRight,
                  color: Colors.blue[900],
                  size: addressController.addressWidgetIconSize.value,
                ),
              ),
            ),
          ),
        ],
      ),
    ],
  );
}

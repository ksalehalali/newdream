import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../Assistants/globals.dart';
import '../../../controllers/account_controller.dart';
import 'change_password_screen.dart';
import 'edit_personal_info_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final AccountController accountController = Get.find();

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Container(
      color: myHexColor5.withOpacity(0.9),
      child: SafeArea(
        child: Scaffold(
          body: Container(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: Colors.white,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 0.0, vertical: 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 14.h,
                          ),
                          Row(
                            children: [
                              InkWell(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Icon(
                                    Icons.arrow_back,
                                    size: 28,
                                    color: Colors.black54,
                                  ),
                                ),
                              ),
                              Text('Q Market'),
                            ],
                          ),
                          SizedBox(
                            height: screenSize.height * 0.1 - 40.h,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${accountController.username.value}',
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                  ),
                                ),
                                Text(
                                  '${accountController.userEmail.value}',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 14.h,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 14.h,
                  ),
                  Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text('Personal Information_txt'.tr,
                                  style: TextStyle(
                                      fontSize: 16.sp,
                                      color: Colors.grey[700],
                                      fontWeight: FontWeight.bold)),
                              Spacer(),
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          EditPersonalInfoScreen()));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Text('Edit_txt'.tr,
                                      style: TextStyle(
                                          fontSize: 16.sp,
                                          color: Colors.blue[700])),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 28.0.h,
                          ),
                          Text(
                            'First Name_txt'.tr,
                            style: TextStyle(
                              fontSize: 14.sp,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            '${accountController.firstName.value}',
                            style: TextStyle(
                                fontSize: 16.sp, fontWeight: FontWeight.bold),
                          ),
                          Divider(),

                          SizedBox(
                            height: 28.0.h,
                          ),
                          Text(
                            'Last Name_txt'.tr,
                            style: TextStyle(
                              fontSize: 14.sp,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            '${accountController.lastName.value}',
                            style: TextStyle(
                                fontSize: 16.sp, fontWeight: FontWeight.bold),
                          ),
                          Divider(),
                          SizedBox(
                            height: 28.0.h,
                          ),
                          Text(
                            'Receive Communications In_txt'.tr,
                            style: TextStyle(
                              fontSize: 14.sp,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            '${Get.locale}',
                            style: TextStyle(
                                fontSize: 16.sp, fontWeight: FontWeight.bold),
                          ),
                          Divider(),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 28.0.h,
                  ),
                  Container(
                    color: Colors.white,
                    width: screenSize.width,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          SizedBox(height: 5),
                          Text(
                            'SECURITY INFORMATION_txt'.tr,
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[700],
                            ),
                          ),
                          OutlinedButton(
                              style: ElevatedButton.styleFrom(
                                elevation: 0.0,
                                maximumSize: Size(
                                    Get.size.width - 220, Get.size.width - 90),
                                minimumSize: Size(Get.size.width - 220, 32),
                                primary: Colors.transparent,
                                onPrimary: myHexColor,
                                alignment: Alignment.center,
                              ),
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        ChangePasswordScreen()));
                              },
                              child: Text(
                                'CHANGE PASSWORD',
                              )),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

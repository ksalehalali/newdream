// ignore_for_file: sized_box_for_whitespace, prefer_final_fields, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Assistants/globals.dart';
import '../../../controllers/lang_controller.dart';
import '../../../controllers/register_controller.dart';
import '../account/account.dart';
import '../main_screen.dart';
import 'confirm_number.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final registerController = Get.put(RegisterController());

  final signUpUsernameController = TextEditingController();
  final signUpEmailController = TextEditingController();
  final signUpPasswordController = TextEditingController();
  final signUpConfirmPasswordController = TextEditingController();

  RxBool showSignUp = false.obs;
  bool moveWidgets = false;
  RxBool instantlyTransitionedWidgets = false.obs;
  bool disabilitySwitch =
      false; // When false, login text fields are not disabled, sign up text fields are.
  double stackHeight =
      Get.height > 700 ? Get.size.height * 0.8 : Get.size.height * 0.9;

  double opacity = 1.0;

  List<Widget> stackItems = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    stackItems = [
//       TOGGLE SIGN UP
      Obx(
        () => AnimatedOpacity(
          opacity: showSignUp.value ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 0),
          child: Column(
            children: [
              SizedBox(
                height: 32.h,
              ),
              // WELCOME
              Container(
                alignment: Alignment.center,
                child: Text(
                  "Create A New Account_txt".tr,
                  style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                      fontSize: 30.sp),
                ),
              ),
              SizedBox(
                height: 32.h,
              ),
              // USERNAME TEXT FIELD
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Phone number_txt".tr,
                    style: TextStyle(
                      color: myHexColor2,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Theme(
                    data: ThemeData.from(
                      colorScheme: ColorScheme.fromSwatch(
                          primarySwatch: primaryColorSwatch),
                    ),
                    child: TextField(
                      controller: registerController.signUpUsernameController,
                      enabled: showSignUp.value,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 16.h,
              ),
              // EMAIL TEXT FIELD
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Email_txt".tr,
                    style: TextStyle(
                      color: myHexColor2,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Theme(
                    data: ThemeData.from(
                      colorScheme: ColorScheme.fromSwatch(
                          primarySwatch: primaryColorSwatch),
                    ),
                    child: TextField(
                      controller: registerController.signUpEmailController,
                      enabled: showSignUp.value,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              // PASSWORD TEXT FIELD
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Password_txt".tr,
                    style: TextStyle(
                      color: myHexColor2,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Theme(
                    data: ThemeData.from(
                      colorScheme: ColorScheme.fromSwatch(
                          primarySwatch: primaryColorSwatch),
                    ),
                    child: TextField(
                      controller: registerController.signUpPasswordController,
                      enabled: showSignUp.value,
                      obscureText: true,
                      decoration: InputDecoration(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              // PASSWORD CONFIRM TEXT FIELD
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Confirm Password_txt".tr,
                    style: TextStyle(
                      color: myHexColor2,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Theme(
                    data: ThemeData.from(
                      colorScheme: ColorScheme.fromSwatch(
                          primarySwatch: primaryColorSwatch),
                    ),
                    child: TextField(
                      controller:
                          registerController.signUpConfirmPasswordController,
                      enabled: showSignUp.value,
                      obscureText: true,
                      decoration: InputDecoration(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 32.h,
              ),
            ],
          ),
        ),
      ),

//       TOGGLE LOGIN
      Obx(
        () => AnimatedOpacity(
          opacity: !showSignUp.value ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 500),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 12.h,
              ),
              Container(
                alignment: Alignment.center,
                child: Text(
                  "Welcome again !_txt".tr,
                  style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                      fontSize: 30.sp),
                ),
              ),
              SizedBox(
                height: 32.h,
              ),
              // EMAIL TEXT FIELD
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Phone number_txt".tr,
                    style: TextStyle(
                      color: myHexColor2,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Theme(
                    data: ThemeData.from(
                      colorScheme: ColorScheme.fromSwatch(
                          primarySwatch: primaryColorSwatch),
                    ),
                    child: TextField(
                      controller: registerController.loginEmailController,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 16.h,
              ),
              // PASSWORD TEXT FIELD
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Password_txt".tr,
                    style: TextStyle(
                      color: myHexColor2,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Theme(
                    data: ThemeData.from(
                      colorScheme: ColorScheme.fromSwatch(
                          primarySwatch: primaryColorSwatch),
                    ),
                    child: TextField(
                      controller: registerController.loginPasswordController,
                      obscureText: true,
                      decoration: InputDecoration(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              // FORGOT PASSWORD?
              Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    alignment: Alignment.topRight,
                    child: Text(
                      "Forgot Password ?_txt".tr,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 32.h,
              ),
            ],
          ),
        ),
      ),
    ];
    autoLang();
  }

  //lng
  final LangController langController = Get.find();

  void autoLang() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var lang = await prefs.getString('lang');
    print("lang ====== lang === $lang");
    if (lang != null) {
      langController.changeLang(lang);
      Get.updateLocale(Locale(lang));
      langController.changeDIR(lang);
      print(Get.deviceLocale);
      print(Get.locale);
    }
  }

  String? phoneNumber;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          width: Get.size.width,
          height: Get.size.height.h,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 3,
                ),
                // CLOSE
                Container(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    icon:  Icon(Icons.close,size: 38.sp,),
                    onPressed: () {
                      registerController.accountController.signOut();
                      Get.off(MainScreen(index: 0,));
                    },
                  ),
                ),

                 //     TOGGLE LOGIN
                Obx(
                      () =>!showSignUp.value ? AnimatedOpacity(
                    opacity: !showSignUp.value ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 300),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 12.h,
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: Text(
                            "Welcome again !_txt".tr,
                            style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.bold,
                                fontSize: 30.sp),
                          ),
                        ),
                        SizedBox(
                          height: 32.h,
                        ),
                        // EMAIL TEXT FIELD
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Phone number_txt".tr,
                              style: TextStyle(
                                color: myHexColor2,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Theme(
                              data: ThemeData.from(
                                colorScheme: ColorScheme.fromSwatch(
                                    primarySwatch: primaryColorSwatch),
                              ),
                              child: TextField(
                                controller: registerController.loginEmailController,
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        // PASSWORD TEXT FIELD
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Password_txt".tr,
                              style: TextStyle(
                                color: myHexColor2,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Theme(
                              data: ThemeData.from(
                                colorScheme: ColorScheme.fromSwatch(
                                    primarySwatch: primaryColorSwatch),
                              ),
                              child: TextField(
                                controller: registerController.loginPasswordController,
                                obscureText: true,
                                decoration: InputDecoration(),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        // FORGOT PASSWORD?
                        Align(
                          alignment: Alignment.centerLeft,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ConfirmNumber()));
                            },
                            child: Container(
                              alignment: Alignment.topRight,
                              child: Text(
                                "Forgot Password ?_txt".tr,
                                style: TextStyle(
                                  decoration: TextDecoration.underline
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 4.h,
                        ),
                      ],
                    ),
                  ):Container(),
                ),

                //       TOGGLE SIGN UP
                Obx(
                      () =>
                      showSignUp.value ?AnimatedContainer(
                        height: !showSignUp.value ?0.0  : screenSize.height*0.6-20,
                        width: !showSignUp.value ? 0.0 : screenSize.width,
                            duration: const Duration(milliseconds: 200),
                      child:
                      AnimatedOpacity(
                        opacity: !showSignUp.value ?0.0  : 1.0,
                        duration: const Duration(milliseconds: 300),
                    child:showSignUp.value ? Column(
                      children: [
                        SizedBox(
                          height: 28.h,
                        ),
                        // WELCOME
                        Container(
                          alignment: Alignment.center,
                          child: Text(
                            "Create A New Account_txt".tr,
                            style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.bold,
                                fontSize: 30.sp),
                          ),
                        ),
                        SizedBox(
                          height: 28.h,
                        ),
                        // USERNAME TEXT FIELD
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Theme(
                              data: ThemeData.from(
                                colorScheme: ColorScheme.fromSwatch(
                                    primarySwatch: primaryColorSwatch),
                              ),
                              child:   SizedBox(
                                  width: screenSize.width * 0.9,
                                  child: IntlPhoneField(
                                    decoration: InputDecoration(
                                      labelText: 'Phone_txt'.tr,

                                      focusColor: myHexColor,
                                      labelStyle: TextStyle(fontSize: 15),
                                      hoverColor: Colors.grey,
                                      enabled: showSignUp.value,
                                      // border: OutlineInputBorder(
                                      //   borderSide: BorderSide(color: myHexColor),
                                      // ),
                                    ),
                                    initialCountryCode: 'QA',
                                    onChanged: (phone) {
                                      print(phone.completeNumber);
                                      phoneNumber = phone.completeNumber;
                                      registerController.phoneNumber = phoneNumber!;
                                      print(phoneNumber);
                                    },
                                  )
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        // EMAIL TEXT FIELD
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Theme(
                              data: ThemeData.from(
                                colorScheme: ColorScheme.fromSwatch(
                                    primarySwatch: primaryColorSwatch),
                              ),
                              child: TextField(
                                controller: registerController.signUpUsernameController,
                                enabled: showSignUp.value,
                                decoration: InputDecoration(
                                  hintText: "Name_txt".tr,
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),

                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        // PASSWORD TEXT FIELD
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Theme(
                              data: ThemeData.from(
                                colorScheme: ColorScheme.fromSwatch(
                                    primarySwatch: primaryColorSwatch),
                              ),
                              child: TextField(
                                controller: registerController.signUpPasswordController,
                                enabled: showSignUp.value,
                                obscureText: true,
                                decoration: InputDecoration(hintText: "Password_txt".tr,hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                ),),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        // PASSWORD CONFIRM TEXT FIELD
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Theme(
                              data: ThemeData.from(
                                colorScheme: ColorScheme.fromSwatch(
                                    primarySwatch: primaryColorSwatch),
                              ),
                              child: TextField(
                                controller:
                                registerController.signUpConfirmPasswordController,
                                enabled: showSignUp.value,
                                obscureText: true,
                                decoration: InputDecoration(hintText: "Confirm Password_txt".tr,hintStyle:TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                ), ),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 32.h,
                        ),
                      ],
                    ):Container(),
                  ),
                ):Container()),
                //  LOGIN / SIGN UP SWITCH
                Container(
                  width: Get.size.width,
                  height: stackHeight.h,
                  child: Column(
                    children: [


                      // LOGIN / SIGN UP BUTTON
                      Container(
                        height: 60.h,
                        width: Get.size.width,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                            MaterialStateProperty.all(myHexColor2),
                          ),

                          onPressed: () async {
                            print('object');
                            if (!instantlyTransitionedWidgets.value) {
                              registerController.isRegisterLoading.value =
                              true;
                              await registerController.makeLoginRequest();
                              registerController.isRegisterLoading.value =
                              false;
                            } else {
                              registerController.isRegisterLoading.value =
                              true;

                              await registerController
                                  .makeRegisterRequest(context);
                              registerController.isRegisterLoading.value =
                              false;
                            }
                          },
                          child: Obx(
                                () => !registerController
                                .isRegisterLoading.value
                                ? Text(
                              !instantlyTransitionedWidgets.value
                                  ? "Login_txt".tr
                                  : "Create A New Account",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 18.sp,
                              ),
                            )
                                : Container(
                                width: 36.w,
                                height: 36.h,
                                child: Container()),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 32.h,
                      ),
                      // LOGIN OPTION TEXT
                      Text(
                        "Or login via social media account_txt".tr,
                        style: TextStyle(
                            fontSize: 15.sp, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 32.h,
                      ),
                      // SOCIAL MEDIA OPTIONS
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // FACEBOOK
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black12,
                              ),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(30),
                              ),
                            ),
                            child: SvgPicture.asset(
                              "assets/images/svg/facebook2.svg",
                              width: 25,
                              height: 25,
                            ),
                          ),
                          SizedBox(
                            width: 32.w,
                          ),
                          // GOOGLE
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black12,
                              ),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(30),
                              ),
                            ),
                            child: SvgPicture.asset(
                              "assets/images/svg/google.svg",
                              width: 25,
                              height: 25,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      // NEW USER / ALREADY HAVE AN ACCOUNT
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            !instantlyTransitionedWidgets.value
                                ? "New User ?  _txt".tr
                                : "Already have an account ? _txt".tr,
                            style: TextStyle(),
                          ),
                          GestureDetector(
                            onTap: () {
                              print('reg........');
                              setState(() {
                                registerController
                                    .loginEmailController.text = "";
                                registerController
                                    .loginPasswordController.text = "";
                                registerController
                                    .signUpUsernameController.text = "";
                                registerController
                                    .signUpEmailController.text = "";
                                registerController
                                    .signUpPasswordController.text = "";
                                registerController
                                    .signUpConfirmPasswordController
                                    .text = "";

                                Widget temp = stackItems[0];
                                stackItems[0] = stackItems[1];
                                stackItems[1] = temp;

                                instantlyTransitionedWidgets.value =
                                !instantlyTransitionedWidgets.value;
                                if (!moveWidgets) {
                                  opacity = 1.0;
                                  stackHeight = Get.size.height * 1.0;
                                  moveWidgets = !moveWidgets;
                                  Future.delayed(
                                      const Duration(milliseconds: 500),
                                          () {
                                        setState(() {
                                          showSignUp.value =
                                          !showSignUp.value;
                                          print(
                                              "moveWidgets: ${moveWidgets} showSignUp: ${showSignUp.value}");
                                        });
                                      });
                                } else {
                                  opacity = 1.0;
                                  showSignUp.value = !showSignUp.value;
                                  print(
                                      "moveWidgets: ${moveWidgets} showSignUp: ${showSignUp.value}");
                                  Future.delayed(
                                      const Duration(milliseconds: 500),
                                          () {
                                        setState(() {
                                          moveWidgets = !moveWidgets;
                                          Future.delayed(
                                              const Duration(
                                                  milliseconds: 500), () {
                                            setState(() {
                                              stackHeight =
                                                  Get.size.height * 0.80;
                                            });
                                          });
                                        });
                                      });
                                }
                              });
                            },
                            child: Text(
                              !instantlyTransitionedWidgets.value
                                  ? "Create A New Account_txt".tr
                                  : "Login_txt".tr,
                              style: TextStyle(
                                color: myHexColor2,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 11.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

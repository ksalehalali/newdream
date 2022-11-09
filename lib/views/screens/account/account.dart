
// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Assistants/globals.dart';
import '../../../controllers/account_controller.dart';
import '../../../controllers/cart_controller.dart';
import '../../../controllers/lang_controller.dart';
import '../../../controllers/payment_controller.dart';
import '../../../controllers/register_controller.dart';
import '../../address/list_addresses.dart';
import '../../favorite_screen.dart';
import '../../widgets/new_button.dart';
import '../auth/register.dart';
import '../order/my_orders.dart';
import '../wallet/wallet_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'profile_screen.dart';


class Account extends StatefulWidget {
  Account({Key? key}) : super(key: key);

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  final accountController = Get.put(AccountController());
  final CartController cartController = Get.find();
  final PaymentController paymentController = Get.find();
  final LangController langController = Get.find();
  final RegisterController registerController = Get.find();

  bool btnPressed =false;
  bool btnPressed2 =false;
  bool btnPressed3 =false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    paymentController.getMyWallet();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: myHexColor5,

      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.grey[200],
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // WELCOME
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                  child: accountController.isLoggedIn.value == false ?
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 8.0.h,),
                      // WELCOME
                      Text(
                        "welcome_txt".tr,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(56, 216, 218, 1.0),
                        ),
                      ),
                      SizedBox(height: 8.0.h,),
                      // JOIN US
                      Text(
                        "join us,login".tr,
                        style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54
                        ),
                      ),
                      SizedBox(height: 16.0.h,),
                      Center(
                        child: InkWell(
                          onTap: () {
                            // nav to login
                            Get.to(() => Register());
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(17.5),
                                  decoration: BoxDecoration(
                                      color: myHexColor2,
                                      shape: BoxShape.circle
                                  ),
                                  child: SvgPicture.asset(
                                    "${assetsIconDir}user.svg",
                                    width: 30.w,
                                  ),
                                ),
                                SizedBox(height: 8.0.h,),
                                Text(
                                  "login_txt".tr,
                                  style: TextStyle(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 16.0.h,),

                    ],
                  ) :
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 8.0.h,),
                      Text(
                        "welcome_txt".tr,
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(56, 216, 218, 1.0),
                        ),
                      ),
                      SizedBox(height: 8.0.h),
                      Text(
                        accountController.firstName.value,
                        style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54
                        ),
                      ),
                      SizedBox(height: 16.0.h,),
                    ],
                  ),
                ),
                SizedBox(height: 8.h,),

                accountController.isLoggedIn.value != false ? Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 38.0.w),
                  child: NeuButton(onTap: (){
                    setState(() {
                      if(btnPressed == true){
                        btnPressed = false;
                      }else if(btnPressed == false){
                        btnPressed =true;
                        btnPressed2 =false;
                        btnPressed3 =false;

                      }
                    });
                    Future.delayed(200.milliseconds,(){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MyOrders()));
                      setState(() {
                        if(btnPressed == true){
                          btnPressed = false;
                        }else if(btnPressed == false){
                          btnPressed =true;
                          btnPressed2 =false;
                          btnPressed3 =false;

                        }
                      });
                    });


                  },onTap2: (){
                    setState(() {
                      if(btnPressed2 == true){
                        btnPressed2 = false;
                      }else if(btnPressed2 == false){
                        btnPressed2 =true;
                        btnPressed =false;
                        btnPressed3 =false;

                      }
                    });
                    Future.delayed(200.milliseconds,(){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>WalletScreen()));
                      setState(() {
                        if(btnPressed2 == true){
                          btnPressed2 = false;
                        }else if(btnPressed2 == false){
                          btnPressed2 =true;
                          btnPressed =false;
                          btnPressed3 =false;

                        }
                      });
                    });


                  }
                  ,onTap3: (){
                      setState(() {
                        if(btnPressed3 == true){
                          btnPressed3 = false;
                        }else if(btnPressed3 == false){
                          btnPressed3 =true;
                          btnPressed2 =false;
                          btnPressed =false;

                        }
                      });
                      Future.delayed(200.milliseconds,(){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>FavoriteScreen()));
                        setState(() {
                          if(btnPressed3 == true){
                            btnPressed3 = false;
                          }else if(btnPressed3 == false){
                            btnPressed3 =true;
                            btnPressed2 =false;
                            btnPressed =false;

                          }
                        });
                      });


                    },btnPressed: btnPressed,btnPressed2: btnPressed2,btnPressed3: btnPressed3,),
                ):Container(),
                SizedBox(height: 14.h,),
                accountController.isLoggedIn.value != false ?
                Column(
                  children: [
                    // MY ACCOUNT
                    InkWell(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>WalletScreen()));

                      },
                      child: Container(
                        height: 60.h,
                        color: Color.fromRGBO(245, 246, 248, 1.0),
                        padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                        child: Align(
                          alignment: Get.locale == "en"?Alignment.centerRight : Alignment.centerLeft, // Align however you like (i.e .centerRight, centerLeft)
                          child: Text(
                            "my_account".tr,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: 16.sp,
                                color: Colors.black54,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ),
                    ),

                    InkWell(
                        onTap: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ProfileScreen()));
                        },
                        child: buildOptionRow("personal_info".tr, Icons.account_circle_outlined,false)),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 64.0.w),
                      child: Divider(
                        thickness: 1,
                      ),
                    ),

                    InkWell(
                        onTap: (){

                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ListAddresses(fromAccount: true,fromCart: false,)));
                        },
                        child: buildOptionRow("My_Address_txt".tr, Icons.location_history,false)),
                  ],
                ) :
                Container(),
                // APP SETTINGS
                Container(
                  height: 60.h,
                  color: Color.fromRGBO(245, 246, 248, 1.0),
                  padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                  child: Align(
                    alignment: Get.locale == "en"?Alignment.centerRight : Alignment.centerLeft, // Align however you like (i.e .centerRight, centerLeft)
                    child: Text(
                      "App_Settings_txt".tr,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.black54,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding:  EdgeInsets.only(right: langController.appLocal=="ar"?   14.0.w:0.0,left: langController.appLocal=="en"?   14.0.w:0.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.language,
                        size: 26.sp,
                        color: Colors.grey[600],
                      ),
                      SizedBox(
                        width: 20.0.w,
                      ),
                      Text(
                        'Language_txt'.tr,
                        style:TextStyle(fontWeight: FontWeight.w700,fontSize: 15.sp,color: Colors.grey[600]),

                      ),
                      Spacer(),
                      SizedBox(
                        width: 100.w,
                        child: ListTile(

                          leading: GetBuilder<LangController>(
                            init: LangController(),
                            builder: (controller)=> DropdownButton(
                              iconSize: 38.sp,
                              style: TextStyle(fontSize: 16.sp,color: Colors.blue[900],),
                              items: const [
                                DropdownMenuItem(child: Text('EN'),value: 'en',),
                                DropdownMenuItem(child: Text('AR'),value: 'ar',),
                                // DropdownMenuItem(child: Text('HI'),value: 'hi',)

                              ],
                              value:controller.appLocal ,
                              onChanged: (val)async{
                                print(val.toString());
                                controller.changeLang(val.toString());
                                Get.updateLocale(Locale(val.toString()));
                                controller.changeDIR(val.toString());
                                print(Get.deviceLocale);
                                print(Get.locale);
                                SharedPreferences prefs = await SharedPreferences.getInstance();

                                await prefs.setString('lang', val.toString());
                              },
                            ),
                          ),
                          onTap: () {
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  margin: EdgeInsets.symmetric(horizontal: 64.0.w),
                  child: Divider(
                    thickness: 1,
                  ),
                ),

                buildOptionRow("Notifications_txt".tr, Icons.notification_important_outlined,false),
                // CONTACT US
                Container(
                  height: 60.h,
                  color: Color.fromRGBO(245, 246, 248, 1.0),
                  padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                  child: Align(
                    alignment: Get.locale == "en"?Alignment.centerRight : Alignment.centerLeft, // Align however you like (i.e .centerRight, centerLeft)
                    child: Text(
                      "Contact_Us_txt".tr,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.black54,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
                buildOptionRow("Help_And_Technical_Support_txt".tr, Icons.contact_support_outlined,false),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 64.0.w),
                  child: Divider(
                    thickness: 1,
                  ),
                ),
                buildOptionRow("Terms_Of_Usage_txt".tr, Icons.event_note_outlined,false),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 64.0.w),
                  child: Divider(
                    thickness: 1,
                  ),
                ),
                buildOptionRow("Contact_Us_txt".tr, Icons.call,false),
                accountController.isLoggedIn.value != false ?
                // LOGOUT
                Container(
                  height: 70.h,
                  color: Color.fromRGBO(245, 246, 248, 1.0),
                  padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                  child: GestureDetector(
                    onTap: () {
                      // TODO: logout
                      accountController.signOut();
                      registerController.isLoggedIn.value = false;

                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.close, color: Colors.red, size: 30.sp,),
                        SizedBox(width: 16.0.w,),
                        Align(
                          alignment: Alignment.centerLeft, // Align however you like (i.e .centerRight, centerLeft)
                          child: Text(
                            "Sign_Out_txt".tr,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: 16.sp,
                                color: Colors.red,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ):
                Container(),
              ],
            ),
          ),
        ),
      ),
    );

  }

  Container buildOptionRow(String optionText, IconData optionIcon,bool lang) {
    return Container(
      height: 50.h,
      padding: EdgeInsets.symmetric(horizontal: 16.0.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            optionIcon,
            size: 26.sp,
            color: Colors.black54,
          ),
          SizedBox(width: 16.w,),
          Text(
            optionText,
            style: TextStyle(
                fontSize: 15.sp,
                color: Colors.black54,
                fontWeight: FontWeight.bold
            ),
          ),
          Spacer(),
         lang == false? Icon(Icons.arrow_forward_ios_rounded, size: 14.sp, color: Colors.black54,): SizedBox(
           width: 100,
           child: ListTile(

             leading: GetBuilder<LangController>(
               init: LangController(),
               builder: (controller)=> DropdownButton(
                 iconSize: 38,
                 style: TextStyle(fontSize: 18,color: Colors.blue[900],),
                 items: [
                   DropdownMenuItem(child: Text('EN'),value: 'en',),
                   DropdownMenuItem(child: Text('AR'),value: 'ar',),
                    DropdownMenuItem(child: Text('HI'),value: 'hi',)

                 ],
                 value:controller.appLocal ,
                 onChanged: (val)async{
                   print(val.toString());
                   controller.changeLang(val.toString());
                   Get.updateLocale(Locale(val.toString()));
                   controller.changeDIR(val.toString());
                   print(Get.deviceLocale);
                   print(Get.locale);
                   SharedPreferences prefs = await SharedPreferences.getInstance();

                   await prefs.setString('lang', val.toString());
                 },
               ),
             ),
             onTap: () {
             },
           ),
         ),

        ],
      ),
    );
  }
}
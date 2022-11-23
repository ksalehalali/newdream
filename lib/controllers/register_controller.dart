
// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import '../Data/current_data.dart';
import '../views/screens/auth/register.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Assistants/globals.dart';
import '../views/screens/main_screen.dart';
import 'account_controller.dart';
import 'base_controller.dart';

class RegisterController extends GetxController with BaseController {
  final accountController = Get.put(AccountController());

  final loginEmailController = TextEditingController();
  final loginPasswordController = TextEditingController();
  final signUpFirstNameController = TextEditingController();
  final signUpLastNameController = TextEditingController();

  final signUpEmailController = TextEditingController();
  final signUpPasswordController = TextEditingController();
  final signUpConfirmPasswordController = TextEditingController();
  final codeController = new TextEditingController();

  var phoneNumber='';
  final storage = GetStorage();
  var isRegisterLoading = false.obs;
  var isLoggedIn = false.obs;
  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 120;
  late CountdownTimerController controller;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    controller = CountdownTimerController(endTime: endTime, onEnd: onEnd);
  }

  void onEnd() {
    print('onEnd');
  }
  @override
  void onClose() {
    super.onClose();
    loginEmailController.dispose();
    loginPasswordController.dispose();
    signUpFirstNameController.dispose();
    signUpEmailController.dispose();
    signUpPasswordController.dispose();
    signUpConfirmPasswordController.dispose();
  }

  Future<void> makeLoginRequest () async{
    if(loginEmailController.text != "" || loginPasswordController.text != ""){
      Future.delayed(5.milliseconds, () {
        showLoading('loading');
      });
    }

    if(loginEmailController.text == "" || loginPasswordController.text == "") {
      // Fill the required information
      Fluttertoast.showToast(
          msg: "Please fill the required information",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.white70,
          textColor: Colors.black,
          fontSize: 16.0
      );
      hideLoading();
    } else {

      var head = {
        "Accept": "application/json",
        "content-type":"application/json"
      };

      var response = await http.post(Uri.parse(baseURL + "/api/Login"), body: jsonEncode(
        {
          "UserName": "974${loginEmailController.text}",
          "Password": loginPasswordController.text
        },
      ), headers: head
      ).timeout(const Duration(seconds: 20), onTimeout:(){
        Fluttertoast.showToast(
            msg: "The connection has timed out, Please try again!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.white70,
            textColor: Colors.black,
            fontSize: 16.0
        );
        hideLoading();
        throw TimeoutException('The connection has timed out, Please try again!');
      });
print('login...');
      if(response.statusCode == 500) {
        Fluttertoast.showToast(
            msg: "Error 500",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.white70,
            textColor: Colors.black,
            fontSize: 16.0);
        hideLoading();
      }
      else if (response.statusCode == 200){
        isLoggedIn.value = true;
        accountController.isLoggedIn.value =true;
        var jsonResponse = json.decode(response.body);
        if(jsonResponse["status"]){
          print('user data ::: ${jsonResponse["description"]}');
          storeUserLoginPreference(jsonResponse["description"]["token"], jsonResponse["description"]["FirstName"], loginPasswordController.text, jsonResponse["description"]["id"],jsonResponse["description"]["email"]);
          accountController.fetchUserLoginPreference();
          user.accessToken = jsonResponse["description"]["token"];
          accountController.getMyProfile();
          hideLoading();
          Get.to(MainScreen(index: 0));
          isRegisterLoading.value =true;
        } else {
          Fluttertoast.showToast(
              msg: "Username and password do not match!",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.white70,
              textColor: Colors.black,
              fontSize: 16.0);
          hideLoading();
          Get.to(Register());
          return;
        }
      }

    }

  }

  Future<void> makeAutoLoginRequest (username, password) async{
    // Future.delayed(5.milliseconds, () {
    //   showLoading('loading');
    // });
    print("CALLING makeAutoLoginRequest");
    var head = {
      "Accept": "application/json",
      "content-type":"application/json"
    };

    var response = await http.post(Uri.parse(baseURL + "/api/Login"), body: jsonEncode(
      {
        "UserName": username,
        "Password": password
      },
    ), headers: head
    ).timeout(const Duration(seconds: 20), onTimeout:(){
      Fluttertoast.showToast(
          msg: "The connection has timed out, Please try again!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.white70,
          textColor: Colors.black,
          fontSize: 16.0
      );
     // hideLoading();
      throw TimeoutException('The connection has timed out, Please try again!');
    });

    if(response.statusCode == 500) {
      Fluttertoast.showToast(
          msg: "Error 500",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.white70,
          textColor: Colors.black,
          fontSize: 16.0);
     // hideLoading();
      Get.to(()=>Register());

    }
    else if (response.statusCode == 200){
      var jsonResponse = json.decode(response.body);
      if(jsonResponse["status"]){
        print("auttto login ${jsonResponse["description"]}");
        print('user data ::: ${jsonResponse["description"]}');
        accountController.isLoggedIn.value =true;

        token = jsonResponse["description"]["token"];
        storeUserLoginPreference(jsonResponse["description"]["token"], jsonResponse["description"]["userName"], password, jsonResponse["description"]["id"],jsonResponse["description"]["email"]);
        print(jsonResponse["description"]["token"]);
        accountController.fetchUserLoginPreference();
        user.accessToken = jsonResponse["description"]["token"];
        accountController.getMyProfile();

        isLoggedIn.value = true;
        Get.offAll(const MainScreen(index: 0,));

      } else {
        Fluttertoast.showToast(
            msg: "Username and password do not match!",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.white70,
            textColor: Colors.red,
            fontSize: 16.0);
        Get.offAll(()=>Register());
       // hideLoading();
        return;

      }
    }


  }

  Future<void> storeUserLoginPreference(token, username, password, id,userEmail) async {
    storage.write('token', token);
    storage.write('username', username);
    storage.write('userEmail', userEmail);
    storage.write('password', password);
    storage.write('id', id);

       SharedPreferences prefs = await SharedPreferences.getInstance();
   await prefs.setString('token', token);
   await prefs.setString('username', username);
   await prefs.setString('password', password);
   await prefs.setString('id', id);
  }

  Future getMyProfile()async{
    var headers = {
      'Authorization': 'Bearer ${user.accessToken}'
    };
    var request = http.Request('GET', Uri.parse('$baseURL/api/MyProfile'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var json = jsonDecode(await response.stream.bytesToString());
      var data = json['description'];

    }
    else {
      print(response.reasonPhrase);
    }

  }

  Future<void> clearUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    storage.erase();

  }


  Future<void> makeCodeConfirmationRequest(context) async{

    List<String> codeCredentials = [
      phoneNumber.replaceAll("+", ""),
      codeController.text
    ];

    var head = {
      "Accept": "application/json",
      "content-type":"application/json"
    };

    print("sssss");
    print("${codeCredentials[0]}");
    print("${codeCredentials[1]}");

    if (codeCredentials[1].isEmpty) {
      Fluttertoast.showToast(
          msg: "Please Enter the code",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.white70,
          textColor: Colors.black,
          fontSize: 16.0);
    } else {
      var response = await http.post(Uri.parse(baseURL + "/api/ConfirmPhoneNumber"), body: jsonEncode(
        {
          "UserName": "${codeCredentials[0]}",
          "Code": codeCredentials[1]
        },
      ), headers: head
      ).timeout(const Duration(seconds: 20), onTimeout:() {
        Fluttertoast.showToast(
            msg: "The connection has timed out, Please try again!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.white70,
            textColor: Colors.black,
            fontSize: 16.0
        );
        throw TimeoutException('The connection has timed out, Please try again!');
      });

      if(response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        if(jsonResponse["status"]==true){
          Navigator.pop(context, 'OK');
          //add the installation to promoter

          Get.offAll(()=>Register());
        } else{
          Fluttertoast.showToast(
              msg: "${jsonResponse["description"]}",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.white70,
              textColor: Colors.black,
              fontSize: 16.0);
        }
      } else{
        Fluttertoast.showToast(
            msg: "Error ${response.statusCode}",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.white70,
            textColor: Colors.black,
            fontSize: 16.0);
      }
    }

  }

  Future <void> makeRegisterRequest (BuildContext context) async {
    print("CALLING makeRegisterRequest");
    clearUserData();
    if (signUpFirstNameController.text == "" ||
        signUpPasswordController.text == "" ||
        signUpConfirmPasswordController.text == "") {
      // Fill the required information
      Fluttertoast.showToast(
          msg: "Please fill the required information",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.white70,
          textColor: Colors.black,
          fontSize: 16.0
      );
    } else
    if (signUpPasswordController.text != signUpConfirmPasswordController.text) {
      // passwords do not match
      Fluttertoast.showToast(
          msg: "Passwords do not match",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.white70,
          textColor: Colors.black,
          fontSize: 16.0
      );
    } else {
      print("Conditions met, sending request");

      var head = {
        "Accept": "application/json",
        "content-type": "application/json"
      };
      print("username: ${phoneNumber.replaceAll("+", "")}");
      print("password: ${signUpPasswordController.text}");
      var response = await http.post(
          Uri.parse(baseURL + "/api/Register"), body: jsonEncode(
        {
          "UserName": phoneNumber.replaceAll("+", ""),
          "Password": signUpPasswordController.text,
          "FirstName": signUpFirstNameController.text,
          "LastName": signUpLastNameController.text
        },
      ), headers: head
      ).timeout(const Duration(seconds: 20), onTimeout: () {
        Fluttertoast.showToast(
            msg: "The connection has timed out, Please try again!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.white70,
            textColor: Colors.black,
            fontSize: 16.0
        );
        throw TimeoutException(
            'The connection has timed out, Please try again!');
      });

      print("reqqq: ${response.body}");

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        print('register data  = $jsonResponse');

          // Sign up successful
          if (jsonResponse["status"]) {
            print(jsonResponse["description"]);
            endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 120;
            showDialog<String>(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  print("Ssssssssssssssssss");
                  return AlertDialog(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Enter the SMS code",
                          style: TextStyle(
                              color: Color.fromRGBO(46, 96, 113, 1),
                              fontSize: 16
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 0, right: 0),
                          alignment: Alignment.topRight,
                          child: GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Icon(Icons.cancel, color: Color.fromRGBO(
                                  46, 96, 113, 1), size: 25,)
                          ),
                        ),
                      ],
                    ),
                    // CODE TEXT FIELD
                    content: Container(
                        width: 300,
                        height: 100,
                        child: Column(
                          children: [
                            CountdownTimer(
                              endTime: endTime,
                              onEnd: onEnd,
                            ),
                            SizedBox(height: 16,),
                            TextField(
                              controller: codeController,
                              keyboardType: TextInputType.number,
                            ),
                          ],
                        )
                    ),
                    actions: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'Cancel'),
                            child: Text("Cancel"),
                          ),
                          TextButton(
                            onPressed: () async {
                              await makeCodeConfirmationRequest(context);
                            },
                            child: Text("Ok"),
                          ),
                        ],
                      ),
                    ],
                  );
                }
            );
          } else {
            Fluttertoast.showToast(
                msg: "This Username is already used",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.white70,
                textColor: Colors.black,
                fontSize: 16.0);
          }

      }
    }
  }}

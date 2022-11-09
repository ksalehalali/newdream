import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_storage/get_storage.dart';
import '../controllers/register_controller.dart';
import '../views/screens/account/account.dart';
import '../views/screens/main_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Assistants/globals.dart';
import '../views/screens/auth/register.dart';

class StartUpController extends GetxController {
  final RegisterController registerController = Get.find();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    //fetchUserLoginPreference();
  }

  Future<void> fetchUserLoginPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? prefToken = prefs.getString('token');
    String? prefUsername = prefs.getString('username');
    String? prefPassword = prefs.getString('password');

    final storage = GetStorage();

    String? storageToken = storage.read('token');
    String? storageUsername = storage.read('username');
    String? storagePassword = storage.read('password');

    print("ssssss ${storageToken}");
    if (storageToken == null) {
      print('null');
      SchedulerBinding.instance.addPostFrameCallback((_) {
        Get.to(() => Register());
        //yourcode
      });
    } else {
      token = storageToken;
      await registerController.makeAutoLoginRequest(
          storageUsername, storagePassword);
    }
  }
}

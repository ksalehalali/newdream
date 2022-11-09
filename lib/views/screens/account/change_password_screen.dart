import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../Assistants/globals.dart';
import '../../../controllers/account_controller.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController passwordTextEditingController = TextEditingController();
  TextEditingController newPasswordTextEditingController = TextEditingController();

  TextEditingController confirmTextEditingController = TextEditingController();
  final AccountController accountController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        color: myHexColor,
        child: SafeArea(
          child: Scaffold(
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 14.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      children: [
                        Text('Q Market',style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.grey[800]),),
                        Spacer(),
                        InkWell(
                          onTap: (){
                            Navigator.of(context).pop();
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text('CANCEL',style: TextStyle(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w700,
                                color: Colors.grey[800]),)
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 44.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Current Password',
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w300,
                              color: Colors.grey[500]),
                        ),

                        TextFormField(
                          controller: passwordTextEditingController,
                          decoration: InputDecoration(
                              hintText: 'Please enter your current password',
                              suffixIcon: InkWell(
                                child: Icon(Icons.remove_red_eye_outlined),
                              )),
                          validator: (value) {
                            if (value!.isEmpty || value.length < 4) {
                              return 'Please enter correct password';
                            }
                            return null;
                          },
                        )
                      ],
                    ),
                  ),

                  SizedBox(
                    height: 64.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'New Password',
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w300,
                              color: Colors.grey[500]),
                        ),

                        TextFormField(
                          controller: newPasswordTextEditingController,
                          decoration: InputDecoration(
                              hintText: 'Please enter your new password',
                              suffixIcon: InkWell(
                                child: Icon(Icons.remove_red_eye_outlined),
                              )),
                          validator: (value) {
                            if (value!.isEmpty || value.length < 4) {
                              return 'Please enter correct password';
                            }
                            return null;
                          },
                        )
                      ],
                    ),
                  ),

                  SizedBox(
                    height: 24.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Confirm Password',
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w300,
                              color: Colors.grey[500]),
                        ),

                        TextFormField(
                          controller: confirmTextEditingController,
                          decoration: InputDecoration(
                              hintText: 'Please enter your new password again',
                              suffixIcon: InkWell(
                                child: Icon(Icons.remove_red_eye_outlined),
                              )),
                          validator: (value) {
                            if (value!.isEmpty || value.length < 4) {
                              return 'Please enter correct password';
                            }else if (value != newPasswordTextEditingController.text){
                              return 'password not match';
                            }
                            return null;
                          },
                        )
                      ],
                    ),
                  ),

                ],
              ),
            ),
            bottomSheet:InkWell(
              onTap: (){
                _formKey.currentState!.validate();

                if (_formKey.currentState!.validate()){
                  print('validate');
                   // Get.bottomSheet(Container(
                   //   color: Colors.white,
                   //   height: 200,
                   //   child: Text('Password'),));

                  accountController.changePassword(passwordTextEditingController.text, newPasswordTextEditingController.text, confirmTextEditingController.text);
                }
              },
              child: Container(
                height: 40,
                color: myHexColor,
                child: Center(child: Text(
                  'CHANGE PASSWORD',style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),
                ),),
              ),
            ) ,
          ),
        ),
      ),
    );
  }
}

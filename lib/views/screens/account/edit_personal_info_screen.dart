import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../Assistants/globals.dart';
import '../../../controllers/account_controller.dart';

class EditPersonalInfoScreen extends StatefulWidget {
  const EditPersonalInfoScreen({Key? key}) : super(key: key);

  @override
  State<EditPersonalInfoScreen> createState() => _EditPersonalInfoScreenState();
}

class _EditPersonalInfoScreenState extends State<EditPersonalInfoScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController lastNameTextEditingController = TextEditingController();

  TextEditingController emailTextEditingController = TextEditingController();

  TextEditingController confirmTextEditingController = TextEditingController();
  final AccountController accountController = Get.find();
  String? firstName , lastName , email ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    firstName = accountController.username.value;
    lastName = accountController.lastName.value;
    email = accountController.userEmail.value;
  }

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
                              child: Text('CANCEL_txt'.tr,style: TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.grey[800]),)
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 54.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'First Name_txt',
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w300,
                              color: Colors.grey[500]),
                        ),

                        TextFormField(
                         // controller: nameTextEditingController,
                          initialValue: accountController.firstName.value,
                          decoration: InputDecoration(
                              hintText: 'Please enter your first name_txt'.tr,
                             ),
                          validator: (value) {
                            if (value!.isEmpty || value.length < 4) {
                              return 'Please enter correct name_txt'.tr;
                            }
                            return null;
                          },
                          onChanged: (val){
                            firstName = val;
                          },
                        )
                      ],
                    ),
                  ),

                  SizedBox(
                    height: 34.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Last Name_txt'.tr,
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w300,
                              color: Colors.grey[500]),
                        ),

                        TextFormField(
                          // controller: nameTextEditingController,
                          initialValue: accountController.lastName.value,
                          decoration: InputDecoration(
                            hintText: 'Please enter your last name_txt'.tr,
                          ),
                          validator: (value) {
                            if (value!.isEmpty || value.length < 4) {
                              return 'Please enter correct name_txt'.tr;
                            }
                            return null;
                          },
                          onChanged: (val){
                            lastName = val;
                          },
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 34.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Email_txt'.tr,
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w300,
                              color: Colors.grey[500]),
                        ),

                        TextFormField(
                          initialValue: accountController.userEmail.value,
                          decoration: InputDecoration(
                              hintText: 'Please enter your email_txt'.tr,
                             ),
                          validator: (value) {
                            if (value!.isEmpty || value.length < 4) {
                              return 'Please enter correct email_txt'.tr;
                            }
                            return null;
                          },
                          onChanged: (val){
                            email = val;
                          },
                        )
                      ],
                    ),
                  ),

                  SizedBox(
                    height: 24.h,
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

                  accountController.editPersonalInformation( firstName:  firstName!,lastName:  lastName!,email: email!,);
                }
              },
              child: Container(
                height: 40,
                color: myHexColor,
                child: Center(child: Text(
                  'SAVE_txt'.tr,style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),
                ),),
              ),
            ) ,
          ),
        ),
      ),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Assistants/globals.dart';
import '../controllers/base_controller.dart';
import '../controllers/cart_controller.dart';
import '../controllers/lang_controller.dart';
import '../services/app_exceptions.dart';
import '../views/screens/home/home.dart';
import '../views/screens/main_screen.dart';
import '../views/widgets/progressDialog.dart';
import 'package:myfatoorah_pay/myfatoorah_pay.dart';
import 'dart:developer';


class MyFatoorahCheckOut with BaseController {
  final CartController cartController = Get.find();
  final LangController langController = Get.find();

  static const String myFatoorahApi = 'rLtt6JWvbUHDDhsZnfpAhpYk4dxYDQkbcPTyGaKp2TYqQgG7FGZ5Th_WD53Oq8Ebz6A53njUoo1w3pjU1D4vs_ZMqFiz_j0urb_BH9Oq9VZoKFoJEDAbRZepGcQanImyYrry7Kt6MnMdgfG5jn4HngWoRdKduNNyP4kzcp3mRv7x00ahkm9LAK7ZRieg7k1PDAnBIOG3EyVSJ5kK4WLMvYr7sCwHbHcu4A5WwelxYK0GMJy37bNAarSJDFQsJ2ZvJjvMDmfWwDVFEVe_5tOomfVNt6bOg9mexbGjMrnHBnKnZR1vQbBtQieDlQepzTZMuQrSuKn-t5XZM7V6fCW7oP-uXGX-sMOajeX65JOf6XVpk29DP6ro8WTAflCDANC193yof8-f5_EYY-3hXhJj7RBXmizDpneEQDSaSz5sFk0sV5qPcARJ9zGG73vuGFyenjPPmtDtXtpx35A-BVcOSBYVIWe9kndG3nclfefjKEuZ3m4jL9Gg1h2JBvmXSMYiZtp9MR5I6pvbvylU_PP5xJFSjVTIz7IQSjcVGO41npnwIxRXNRxFOdIUHn0tjQ-7LwvEcTXyPsHXcMD8WtgBh-wxR8aKX7WPSsT1O8d8reb2aR7K3rkV3K82K_0OgawImEpwSvp9MNKynEAJQS6ZHe_J_l77652xwPNxMRTMASk1ZsJL';

  startPayment(BuildContext context)async{
  var response = await MyFatoorahPay.startPayment(

    context: context,
    errorChild: HomeScreen(),
    successChild: HomeScreen(),
    showServiceCharge: true,
    afterPaymentBehaviour: AfterPaymentBehaviour.BeforeCallbackExecution,
    request: MyfatoorahRequest.test(

      currencyIso: Country.Qatar,
      invoiceAmount: cartController.fullPrice.value.toDouble(),
      language:langController.appLocal =="ar"? ApiLanguage.Arabic :ApiLanguage.English,
      token: myFatoorahApi,


    ),
  );
  print(response.status);
  print(response.isSuccess);
  print(response.paymentId);
  print(response.url);
  if(!response.isSuccess){
    print(response.paymentId);
    var addOrder = cartController.addNewOrder(response.paymentId!, 'Card', cartController.fullPrice.value.toDouble(), 1,langController.langCode);
    if(addOrder ==true){
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>MainScreen(index: 0)), (route) => false);
    }else{

    }
  }else{

  }
  }
}

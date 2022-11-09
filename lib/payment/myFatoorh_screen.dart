import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:my_fatoorah/my_fatoorah.dart';

import '../Assistants/globals.dart';
import '../controllers/cart_controller.dart';
import '../controllers/lang_controller.dart';
import '../views/widgets/cupertino-dialog-message.dart';

class MyFatoorhScreen extends StatefulWidget {
  const MyFatoorhScreen({Key? key}) : super(key: key);

  @override
  State<MyFatoorhScreen> createState() => _MyFatoorhScreenState();
}

class _MyFatoorhScreenState extends State<MyFatoorhScreen> {
  final CartController cartController = Get.find();
  final LangController langController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: MyFatoorah(
          onResult: (response) {
            print('-------------------------------...');
            print(response);
            print(response.status);
            var addOrder = cartController.addNewOrder(response.paymentId!, 'Card', cartController.fullPrice.value.toDouble(), 1,langController.langCode);
          if(addOrder == true) {

          }else{
            showCupertinoDialogBox(context,'Something wont wrong','Please check and try again.');
            return;
          }
            },
          successChild: Column(
            children: [
              Icon(
                Icons.done,
                size: 110,
                color: myHexColor5,
              ),
              
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: const Text('Payment completed successfully',style: TextStyle(fontSize: 20,color: Colors.black87),),
              ),

              Padding(
                padding: const EdgeInsets.all(14.0),
                child: const Text('please click on the back arrow above (<--) to go to order summary.',style: TextStyle(fontSize: 16,color: Colors.black87),),
              )
            ],
          ),
          buildAppBar: (context) {
            return AppBar(
              title: const Text('Payment'),
              backgroundColor: myHexColor,
              // leading: InkWell(
              //   onTap: ()async {
              //     print('aaa');
              //     if (WebViewPageState().response.status == PaymentStatus.None && await WebViewPageState().controller.canGoBack()) {
              //       WebViewPageState().controller.goBack();
              //     } else {
              //     Navigator.of(context).pop(WebViewPageState().response);
              //     }
              //   },
              //   child: Icon(Icons.cancel_outlined),
              // ),
            );
          },
          request: MyfatoorahRequest.test(
            currencyIso: Country.Qatar,
            successUrl:
                'https://dashcommerce.click68.com/Files/Product/Color/Image1/8215b4b4-1f6e-440b-804e-b17bfc0525cc/7f353255-afb7-44a7-0cfc-08da0fd3fd80/ECommerce637876256662210008.webp',
            errorUrl: 'https://www.google.com',
            invoiceAmount: cartController.fullPrice.value,
            language: ApiLanguage.English,
            token:
                "rLtt6JWvbUHDDhsZnfpAhpYk4dxYDQkbcPTyGaKp2TYqQgG7FGZ5Th_WD53Oq8Ebz6A53njUoo1w3pjU1D4vs_ZMqFiz_j0urb_BH9Oq9VZoKFoJEDAbRZepGcQanImyYrry7Kt6MnMdgfG5jn4HngWoRdKduNNyP4kzcp3mRv7x00ahkm9LAK7ZRieg7k1PDAnBIOG3EyVSJ5kK4WLMvYr7sCwHbHcu4A5WwelxYK0GMJy37bNAarSJDFQsJ2ZvJjvMDmfWwDVFEVe_5tOomfVNt6bOg9mexbGjMrnHBnKnZR1vQbBtQieDlQepzTZMuQrSuKn-t5XZM7V6fCW7oP-uXGX-sMOajeX65JOf6XVpk29DP6ro8WTAflCDANC193yof8-f5_EYY-3hXhJj7RBXmizDpneEQDSaSz5sFk0sV5qPcARJ9zGG73vuGFyenjPPmtDtXtpx35A-BVcOSBYVIWe9kndG3nclfefjKEuZ3m4jL9Gg1h2JBvmXSMYiZtp9MR5I6pvbvylU_PP5xJFSjVTIz7IQSjcVGO41npnwIxRXNRxFOdIUHn0tjQ-7LwvEcTXyPsHXcMD8WtgBh-wxR8aKX7WPSsT1O8d8reb2aR7K3rkV3K82K_0OgawImEpwSvp9MNKynEAJQS6ZHe_J_l77652xwPNxMRTMASk1ZsJL",
          ),
        ),
      ),
    );
  }
}

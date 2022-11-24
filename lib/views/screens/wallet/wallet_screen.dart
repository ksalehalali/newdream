import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import '../../../Assistants/globals.dart';
import '../../../controllers/payment_controller.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  final PaymentController paymentController = Get.find();
  var wallet;
  Color? _color = myHexColor5;
  Color? _color2 = Colors.grey[700];
  bool showCredits =true;
  bool showTransfers = false;
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    paymentController.getListChargeMyWallet();
  }
  @override
  Widget build(BuildContext context) {
  final screenSize = MediaQuery.of(context).size;

    return Container(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          foregroundColor: Colors.grey[800],
        ),
        body: SingleChildScrollView(
          child: Obx(()=>Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    'Wallet balance_txt'.tr,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[700]),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Center(
                    child: Text(
                      'QAR  ${paymentController.myBalance.value.toStringAsFixed(3)}',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.grey[900]),
                    ),
                  ),
                ),

                Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10.0,),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: (){
                                setState(() {
                                  _color = myHexColor5;
                                  _color2 = Colors.grey[700];
                                  showCredits =true;
                                  showTransfers =false;

                                });
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  AnimatedContainer(duration: 11.seconds,
                                      curve: Curves.easeIn,
                                      child: Text('Credits_txt'.tr,style: TextStyle(color: _color,fontWeight: FontWeight.w600))),
                                  SizedBox(height: 10.0,),
                                  AnimatedContainer(
                                    curve: Curves.easeInOut,
                                    width:screenSize.width/2-13,
                                    height: 2.5,
                                    color: _color,
                                    duration: 900.milliseconds ,

                                  )
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: (){
                                setState(() {
                                  _color2 = myHexColor5;
                                  _color = Colors.grey[700];
                                  showCredits =false;
                                  showTransfers =true;
                                });
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  AnimatedContainer(
                                      curve: Curves.easeIn,
                                      duration: 14.seconds,

                                      child: Text('Transfers_txt'.tr,style: TextStyle(color: _color2,fontWeight: FontWeight.w600),)),
                                  SizedBox(height: 10.0,),
                                  AnimatedContainer(
                                    curve: Curves.easeInOut,
                                    width: screenSize.width/2-13,
                                    height: 2.5,
                                    color: _color2,
                                    duration: 900.milliseconds ,

                                  )
                                ],
                              ),
                            )
                          ],
                        ),

                        SizedBox(
                          height: screenSize.height * 0.1 - 62,
                        ),
                       Center(child:   SizedBox(
                          width: 80,
                          height: 80,

                          child:Obx(()=> paymentController.gotMyCredits.value ==false ? Lottie.asset(
                            'assets/animations/loading_black_background_editor.json',
                            width: 80,
                            height: 80,

                          ):Container(),
                        ))),
                        showCredits?SizedBox(
                            height: screenSize.height-200,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 122.0),
                              child: CustomScrollView(
                                slivers: [
                                  Obx(()=> SliverList(delegate: SliverChildBuilderDelegate((context,index){
                                    return Column(
                                      children: [
                                        ListTile(
                                          title: Text('${paymentController.credits.value[index]['paymentGateway']} ',style: TextStyle(color: Colors.black),),
                                          subtitle:  Text(DateFormat('yyyy-MM-dd  HH:mm :ss').format(DateTime.parse(paymentController.credits[index]['charging_Date'])),style: TextStyle(height: 2),),
                                          trailing:  Text(paymentController.credits.value[index]['value'].toStringAsFixed(3),style: TextStyle(color:Colors.green[800],fontWeight: FontWeight.w600),),
                                          onTap: (){
                                            //showDialog(context: context, builder: (context)=>CustomDialog(payment:  walletController.payments[index],fromPaymentLists: false,failedPay: false,));
                                          },
                                        ),
                                        Divider(thickness: 1,height: 10,),
                                      ],
                                    );
                                  },childCount:paymentController.credits.length ),),
                                  )
                                ],
                              ),
                            )

                        ):Container(),

                        showTransfers?SizedBox(
                            height: screenSize.height-200,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 122.0),
                              child: CustomScrollView(
                                slivers: [
                                  Obx(()=> SliverList(delegate: SliverChildBuilderDelegate((context,index){
                                    // print( DateFormat('yyyy-MM-dd-HH:mm').format(walletController.allTrans[0].time as DateTime));
                                    //final sortedCars = walletController.allTrans..sort((a, b) => a.time!.compareTo(b.time!));
                                    //print(sortedCars);
                                    return Column(
                                      children: [
                                        ListTile(
                                          //leading: Icon(Icons.payments_outlined),
                                          title: Text(paymentController.transfers[index]['paymentGateway'].toString(),style: TextStyle(color: Colors.black),),
                                          subtitle:  Text(DateFormat('yyyy-MM-dd  HH:mm :ss').format(DateTime.parse(paymentController.transfers[index]['charging_Date'])),style: TextStyle(height: 2),),
                                          trailing:  Text(paymentController.transfers[index]['value'].toStringAsFixed(3),style: TextStyle(color:myHexColor5,fontWeight: FontWeight.w600),),
                                        ),
                                        Divider(thickness: 1,height: 10,)
                                      ],
                                    );
                                  },childCount:paymentController.transfers.length ),),
                                  )
                                ],
                              ),
                            )

                        ):Container(),
                        SizedBox(
                          height: 10.0,
                        ),
                        Container(
                          width: screenSize.width - 20,
                          height: 2,
                          color: Colors.grey[300],
                        ),

                      ],
                    ),
                  ),
                ),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

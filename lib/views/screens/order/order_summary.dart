import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../Assistants/globals.dart';
import '../../../Data/current_data.dart';
import '../../../controllers/address_location_controller.dart';
import '../../../controllers/cart_controller.dart';
import '../../../controllers/lang_controller.dart';
import '../main_screen.dart';
import 'order_timeline.dart';

class OrderSummary extends StatefulWidget {
  final bool fromOrdersList;
  final Map Order;
   OrderSummary({Key? key,required this.fromOrdersList, required this.Order }) : super(key: key);

  @override
  State<OrderSummary> createState() => _OrderSummaryState();
}

class _OrderSummaryState extends State<OrderSummary> {
  final AddressController addressController = Get.find();
  final LangController langController = Get.find();

   final storage = GetStorage();

   final CartController cartController = Get.find();

  int _value =1;

  @override
  Widget build(BuildContext context) {
    int indexAddress = storage.read("indexAddressSelected");
    final screenSize = MediaQuery.of(context).size;

    return Container(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0
          ,
          leading: InkWell(
              onTap: (){
               if(widget.fromOrdersList ==true) {
                 Navigator.of(context).pop();

               }else{
                 Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>const MainScreen(index: 0)));
               }
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 12.0,left: 8,bottom: 12,top: 1),
                child: Icon(Icons.cancel_outlined,color: Colors.grey[500],size: 28,),
              )),
          actions:  [
           widget.fromOrdersList ==true? Align(
              alignment: Alignment.center,
              child: InkWell(
                onTap: (){
                  showGeneralDialog(
                      context: context,
                      barrierDismissible: true,
                      transitionDuration: 500.milliseconds,
                      barrierLabel: MaterialLocalizations.of(context).dialogLabel,
                      barrierColor: Colors.black.withOpacity(0.5),
                      pageBuilder: (context,_,__){
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: screenSize.width,
                              color: Colors.white,
                              child: Card(
                                child:Obx(()=>Column(
                                    children: [
                                      const SizedBox(height: 55,),
                                      Padding(
                                        padding: const EdgeInsets.only(right: 18.0,left: 12,bottom: 28),
                                        child: Container(
                                          color: Colors.white,
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [

                                              Radio(value: 1, groupValue: cartController.optionReasonSelected.value, onChanged: (int? val){
                                                setState(() {
                                                  cartController.optionReasonSelected.value =val!;
                                                  print(val);

                                                });
                                              }),
                                              Text('I changed my mind'),
                                              Spacer(),
                                              // Padding(
                                              //   padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                              //   child: SvgPicture.asset('assets/icons/cash2.svg',
                                              //       //color: Colors.grey[600],
                                              //       height: 22.00,
                                              //       width: 22.0,
                                              //       semanticsLabel: 'A red up arrow'),
                                              // ),
                                            ],
                                          ),
                                        ),
                                      ),

                                      Padding(
                                        padding: const EdgeInsets.only(right: 18.0,left: 12,bottom: 28),
                                        child: Container(
                                          color: Colors.white,
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [

                                              Radio(value: 2, groupValue: cartController.optionReasonSelected.value, onChanged: (int? val){
                                                setState(() {
                                                  cartController.optionReasonSelected.value =val!;
                                                  print(val);

                                                });
                                              }),
                                              Text('I forgot to use my coupon '),
                                              Spacer(),
                                              // Padding(
                                              //   padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                              //   child: SvgPicture.asset('assets/icons/cash2.svg',
                                              //       //color: Colors.grey[600],
                                              //       height: 22.00,
                                              //       width: 22.0,
                                              //       semanticsLabel: 'A red up arrow'),
                                              // ),
                                            ],
                                          ),
                                        ),
                                      ),

                                      Padding(
                                        padding: const EdgeInsets.only(right: 18.0,left: 12,bottom: 28),
                                        child: Container(
                                          color: Colors.white,
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [

                                              Radio(value: 3, groupValue: cartController.optionReasonSelected.value, onChanged: (int? val){
                                                setState(() {
                                                  cartController.optionReasonSelected.value =val!;
                                                  print(val);

                                                });
                                              }),
                                              Text('No reason'),
                                              Spacer(),
                                              // Padding(
                                              //   padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                              //   child: SvgPicture.asset('assets/icons/cash2.svg',
                                              //       //color: Colors.grey[600],
                                              //       height: 22.00,
                                              //       width: 22.0,
                                              //       semanticsLabel: 'A red up arrow'),
                                              // ),
                                            ],
                                          ),
                                        ),
                                      ),

                                      const SizedBox(height: 12,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [

                                          ElevatedButton(
                                            onPressed: ()async {
                                              if(cartController.optionReasonSelected.value >0){
                                                await cartController.deleteOrder(cartController.oneOrderDetails['id'],context,langController.appLocal).then((value) => Navigator.pop(context) );
                                                Navigator.pop(context);

                                              }
                                            },
                                            style: ElevatedButton.styleFrom(
                                                maximumSize: Size(200,220),
                                                minimumSize: Size(180, 34),
                                                primary:cartController.optionReasonSelected.value >0? Colors.redAccent:Colors.grey,
                                                onPrimary: Colors.white,
                                                alignment: Alignment.center),
                                            child: const Text('Confirm',style: TextStyle(fontWeight: FontWeight.w700,color: Colors.white),),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ) ,
                              ),
                            )
                          ],
                        );
                      },
                      transitionBuilder: (context,animation,secondaryAnimation,child){
                        return SlideTransition(position: CurvedAnimation(
                          parent: animation,
                          curve: Curves.easeInOutCubic,
                        ).drive(Tween<Offset>(
                            begin: const Offset(0,-1.0),
                            end:Offset.zero
                        ),),
                          child: child,);
                      }


                  );
                },
                child: const Padding(
                  padding: EdgeInsets.only(right: 8.0,left: 8,bottom: 1,top: 1),
                  child: Text('CANCEL',textAlign: TextAlign.end,style: TextStyle(fontWeight: FontWeight.w700,fontSize: 15,color: Colors.red),),
                ),
              ),
            ):Container()
          ],

        ),
        body: SingleChildScrollView(
          child: cartController.gotOrderDetails.value == true ?
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 1,
              ),
              SizedBox(
                  width: double.infinity, height: 120, child: OrderTimeLine(status:cartController.oneOrderDetails['status'] ,)),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Row(
                  children:  [
                    Text('Order : ',style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[800]
                    ),),
                     SizedBox(
                       width: screenSize.width -110,
                       child: SelectableText(
                         widget.Order['orderNumber'],
                         maxLines: 1,
                         scrollPhysics: ScrollPhysics(),
                         style: TextStyle(
                          fontSize: 15,
                          overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.w700,
                          color: Colors.grey[900]

                    ),
                    ),
                     ),
                  ],
                ),
              ),

              const SizedBox(
                height: 32,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:   [
                    Text('SHIPPING ADDRESS ',style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w800
                    ),),
                    SizedBox(
                      height: 8.0,
                    ),
                    Text('Address : \n${widget.Order['address']}',textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey[900],
                          fontWeight: FontWeight.w700
                      ),),
                    SizedBox(height: 8,),

                  ],
                ),
              ),
              Divider(height: 42,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:  [
                    const Text('PAYMENT METHOD ',style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w800
                    ),),
                    const SizedBox(
                      height: 12.0,
                    ),
                    widget.Order['paymentMethod'] == 0 ?Row(
                      children: [
                        SvgPicture.asset('assets/icons/cash2.svg',
                            //color: Colors.grey[600],
                            height: 22.00,
                            width: 22.0,
                            semanticsLabel: 'A red up arrow'),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Text('Cash on Delivery',textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey[900],
                                fontWeight: FontWeight.w700
                            ),),
                        ),
                      ],
                    ):Row(
                      children: [
                        SvgPicture.asset('assets/icons/creditCard.svg',
                            //color: Colors.grey[600],
                            height: 22.00,
                            width: 22.0,
                            semanticsLabel: 'A red up arrow'),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Text('Credit Card',textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey[900],
                                fontWeight: FontWeight.w700
                            ),),
                        ),
                      ],
                    ),
                    SizedBox(height: 8,),

                  ],
                ),
              ),
              Divider(height: 42,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:  [
                        const Text('ORDER SUMMARY ',style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w800
                    ),),
                    const SizedBox(
                      height: 12.0,
                    ),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Subtitle',textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[700],
                              fontWeight: FontWeight.w700
                          ),),
                        Spacer(),
                        Text('QAR ${widget.Order['total']}',textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[700],
                              fontWeight: FontWeight.w700
                          ),),
                      ],
                    ),
                    SizedBox(height: 14,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Shipping Fee',textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[700],
                              fontWeight: FontWeight.w700
                          ),),
                        Spacer(),
                        Text('FREE',textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 13,
                              color: myHexColor,
                              fontWeight: FontWeight.w700
                          ),),
                      ],
                    ),

                    SizedBox(height: 8,),
                    const SizedBox(
                      height: 12.0,
                    ),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('TOTAL',textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[900],
                              fontWeight: FontWeight.w700
                          ),),
                        Spacer(),
                        Text('QAR ${widget.Order['total']}',textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[900],
                              fontWeight: FontWeight.w700
                          ),),
                      ],
                    ),
                    SizedBox(height: 8,),

                  ],
                ),
              ),
              SizedBox(height: 18,),
              const Padding(
                padding: EdgeInsets.all(12.0),
                child: Text('PRODUCTS ORDER',style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800
                ),),
              ),
              SizedBox(
                  height: 200,
                  child: _buildOrderProductsList(screenSize))

            ],
          ):Container(
            child: const CircularProgressIndicator.adaptive(),
          ),
        ),
      ),
    );
  }

   Widget _buildOrderProductsList(screenSize) {
     return CustomScrollView(
       key: const Key('b'),

       scrollDirection: Axis.horizontal,
       physics: ScrollPhysics(),

       slivers: [
         Obx(
               () => SliverList(
             delegate: SliverChildBuilderDelegate(
                   (context, index) {
                 var price = widget.Order['listProduct'][index]["price"] *
                     widget.Order['listProduct'][index]["offer"] /
                     100;
                 return InkWell(
                   onTap: () {

                   },
                   child:  Row(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                      Container(
                        height: 100,
                        width: 2,
                        color: Colors.blueGrey,
                      ),
                       Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           SizedBox(
                             height: 3,
                           ),
                           Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [

                               ///to do
                               Padding(
                                 padding: const EdgeInsets.only(left: 4.0),
                                 child: ClipRRect(
                                   borderRadius: BorderRadius.circular(10),
                                   child: Container(
                                     width: 80,
                                     child: Image.network(
                                       "$baseURL/${widget.Order['listProduct'][index]['image']}",
                                       height: 122,
                                       fit: BoxFit.fill,
                                     ),
                                   ),
                                 ),
                               ),
                               const SizedBox(
                                 width: 6,
                               ),
                               Padding(
                                 padding: const EdgeInsets.only(left: 8.0),
                                 child: Container(
                                   height: screenSize.height *0.1+30,

                                   child: Column(
                                     crossAxisAlignment: CrossAxisAlignment.start,
                                     mainAxisAlignment: MainAxisAlignment.spaceAround,
                                     children: [
                                       Text(
                                         "${widget.Order['listProduct'][index]['product']}",
                                         style: const TextStyle(
                                             color: Colors.black54,
                                             fontWeight: FontWeight.bold,
                                             fontSize: 14),
                                       ),

                                       const SizedBox(
                                         height: 8,
                                       ),
                                       SizedBox(
                                         width: screenSize.width * 0.4.w + 20,
                                         child: Row(
                                           children: [
                                             Expanded(
                                               child: Text(
                                                 "${widget.Order['listProduct'][index]["price"]} QAR".toUpperCase(),
                                                 overflow: TextOverflow.ellipsis,
                                                 maxLines: 1,
                                                 textAlign: TextAlign.left,
                                                 style: const TextStyle(
                                                     decoration: TextDecoration.lineThrough,
                                                     fontFamily: 'Montserrat-Arabic Regular',
                                                     color: Colors.grey,
                                                     fontSize: 13),
                                               ),
                                             ),
                                             const SizedBox(
                                               width: 7.0,
                                             ),
                                             Text(
                                               "Discount ${widget.Order['listProduct'][index]["offer"]}%",
                                               overflow: TextOverflow.ellipsis,
                                               maxLines: 1,
                                               textAlign: TextAlign.left,
                                               style: TextStyle(
                                                   fontFamily: 'Montserrat-Arabic Regular',
                                                   color: myHexColor3,
                                                   fontSize: 13),
                                             ),
                                           ],
                                         ),
                                       ),
                                       Text(
                                         "${widget.Order['listProduct'][index]["price"] - price} QAR",
                                         style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                       ),

                                       const SizedBox(
                                         height: 12,
                                       ),
                                     ],
                                   ),
                                 ),
                               ),

                             ],
                           ),



                         ],
                       ),
                     ],
                   ),
                 );

               },
               childCount: widget.Order['listProduct'].length,
               semanticIndexOffset: 2,
             ),
           ),
         )
       ],
     );
   }
}

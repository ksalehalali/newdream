import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Assistants/globals.dart';

class NeuButton extends StatefulWidget {
  final onTap;
  final onTap2;
  final onTap3;
  bool btnPressed;
  bool btnPressed2;
  bool btnPressed3;

   NeuButton({Key? key,this.onTap,this.onTap2,this.onTap3,required this.btnPressed,required this.btnPressed2,required this.btnPressed3}) : super(key: key);

  @override
  State<NeuButton> createState() => _NeuButtonState();
}

class _NeuButtonState extends State<NeuButton> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            GestureDetector(
              onTap: widget.onTap,
              child: AnimatedContainer(
                duration: 200.milliseconds,
                height: 60,
                width: 60,
                child: Icon(Icons.payments_outlined,size: 28,color:widget.btnPressed ==true ?myHexColor: myHexColor5,),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: widget.btnPressed3 ?Colors.grey.shade300:Colors.grey.shade400,width: 0.3),
                  boxShadow:widget.btnPressed ?[]: [
                    // BoxShadow(
                    //   color: Colors.grey.shade500,
                    //   offset: Offset(6,6),
                    //   blurRadius: 15,
                    //   spreadRadius: 1,
                    // ),

                    //lighter shadow
                    const BoxShadow(
                      color: Colors.white,
                      offset: Offset(-6,-6),
                      blurRadius: 15,
                      spreadRadius: 1,
                    ),
                  ]
                ),
              ),
            ),
             Padding(padding: EdgeInsets.only(top: 14),
                child: Text('orders_btn'.tr,style: TextStyle(fontWeight: FontWeight.normal,color: Colors.black),
                )),
          ],
        ),
        Column(
          children: [
            GestureDetector(
              onTap: widget.onTap2,
              child: AnimatedContainer(
                duration: 200.milliseconds,
                height: 60,
                width: 60,
                child: Icon(Icons.wallet,size: 28,color:widget.btnPressed2 ==true ?myHexColor: myHexColor5,),
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: widget.btnPressed3 ?Colors.grey.shade300:Colors.grey.shade400,width: 0.3),
                    boxShadow:widget.btnPressed2 ?[]: [
                      // BoxShadow(
                      //   color: Colors.grey.shade500,
                      //   offset: Offset(6,6),
                      //   blurRadius: 15,
                      //   spreadRadius: 1,
                      // ),

                      //lighter shadow
                      BoxShadow(
                        color: Colors.white,
                        offset: Offset(-6,-6),
                        blurRadius: 15,
                        spreadRadius: 1,
                      ),
                    ]
                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 14),
                child: Text('wallet_btn'.tr,style: TextStyle(fontWeight: FontWeight.normal,color: Colors.black),
                )),
          ],
        ),
        Column(
          children: [
            GestureDetector(
              onTap: widget.onTap3,
              child: AnimatedContainer(
                duration: 200.milliseconds,
                height: 60,
                width: 60,
                child: Icon(Icons.favorite_border_outlined,size: 28,color:widget.btnPressed3 ==true ?myHexColor: myHexColor5,),
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: widget.btnPressed3 ?Colors.grey.shade300:Colors.grey.shade400,width: 0.3),
                    boxShadow:widget.btnPressed3 ?[]: [
                      // BoxShadow(
                      //   color: Colors.grey.shade500,
                      //   offset: Offset(6,6),
                      //   blurRadius: 15,
                      //   spreadRadius: 1,
                      // ),

                      //lighter shadow
                      BoxShadow(
                        color: Colors.white,
                        offset: Offset(-6,-6),
                        blurRadius: 15,
                        spreadRadius: 1,
                      ),
                    ]
                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 14),
            child: Text('favorite_btn'.tr,style: TextStyle(fontWeight: FontWeight.normal,color: Colors.black),
            )),
          ],
        ),
      ],
    );
  }
}

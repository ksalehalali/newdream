import 'package:flutter/material.dart';

class FlashMessageScreen extends StatelessWidget {
  const FlashMessageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

Widget customSnackBarContent(BuildContext context){
  final screenSize = MediaQuery.of(context).size;

  return Stack(
    clipBehavior: Clip.none,
    children: [
      Container(
        padding: EdgeInsets.all(16),
        height: 100,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.red),
        child: Row(
          children: [
            const SizedBox(
              width: 12,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: const [
                  Text(
                    'ASASASASAAS',
                    style: TextStyle(
                        color: Colors.white, fontSize: 14),
                  ),
                  Text(
                    'HHHHHHHHH asasasa',
                    style: TextStyle(
                        color: Colors.white, fontSize: 14),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      // Positioned(
      //   bottom: 0,
      //   child: ClipRRect(
      //       borderRadius: const BorderRadius.only(
      //         topLeft: Radius.circular(12),
      //         topRight: Radius.circular(12),
      //       ),
      //       child: SvgPicture.asset(
      //         'assets/images/store.svg',
      //         color: Colors.white,
      //         height: 55,
      //         width: 55,
      //       )),
      // ),

      Positioned(
        top: -20,
        child: Stack(
          alignment: Alignment.center,
          children: [
            ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(22)
                  ),
                  height: 34,
                  width: 34,
                )),
             Positioned(
                top:1,
                child: InkWell(
                    onTap: (){
                      print('close');
                      ScaffoldMessenger.of(context).clearSnackBars();
                    },
                    child: Text('x',style: TextStyle(fontSize: 22),)))
          ],
        ),
      )
    ],
  );
}

Widget customCanceledOrderSnackBarContent(BuildContext context){

  return Stack(
    clipBehavior: Clip.none,
    children: [
      Container(
        padding: EdgeInsets.all(16),
        height: 100,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white),
        child: Row(
          children: [
            const SizedBox(
              width: 18,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Done',
                    style: TextStyle(
                        color: Colors.black87, fontSize: 14),
                  ),
                  Text(
                    'Your order Canceled',
                    style: TextStyle(
                        color: Colors.black87, fontSize: 14),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      // Positioned(
      //   bottom: 0,
      //   child: ClipRRect(
      //       borderRadius: const BorderRadius.only(
      //         topLeft: Radius.circular(12),
      //         topRight: Radius.circular(12),
      //       ),
      //       child: SvgPicture.asset(
      //         'assets/images/store.svg',
      //         color: Colors.white,
      //         height: 55,
      //         width: 55,
      //       )),
      // ),

      Positioned(
        top: -20,
        child: Stack(
          alignment: Alignment.center,
          children: [
            ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(22)
                  ),
                  height: 34,
                  width: 34,
                )),
            Positioned(
                top:1,
                child: InkWell(
                    onTap: (){
                      print('close');
                      ScaffoldMessenger.of(context).clearSnackBars();
                    },
                    child: Text('x',style: TextStyle(fontSize: 22),)))
          ],
        ),
      )
    ],
  );
}
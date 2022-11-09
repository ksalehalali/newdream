import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/product_controller.dart';

class FlyingCart extends StatefulWidget {
  final indexListImages;
  const FlyingCart({
    Key? key,required this.indexListImages
  }) : super(key: key);

  @override
  _FlyingCartState createState() => _FlyingCartState();
}

class _FlyingCartState extends State<FlyingCart> with TickerProviderStateMixin {
  AnimationController? _controller;

  @override
  void initState() {
    super.initState();
    _controller =
    AnimationController(duration: const Duration(seconds: 1), vsync: this)
      ..forward();
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  final ProductsController productController = Get.find();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          //code here
          final Size biggest = constraints.biggest;
          return Stack(
            children: [
              PositionedTransition(
                  rect: RelativeRectTween(
                    begin:
                    //flying cart fly from bottom to top
                    RelativeRect.fromSize(
                        Rect.fromLTRB(
                            biggest.width / 2 - 60,
                            biggest.height - 60,
                            biggest.width / 2,
                            biggest.height),
                        biggest),
                    end: RelativeRect.fromSize(
                        Rect.fromLTRB(
                            biggest.width - 48, 10, biggest.width + 10, 70),
                        biggest),
                  ).animate(
                      CurvedAnimation(parent: _controller!, curve: Curves.ease)),
                  child: Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                    child: productController.imagesWidget.value[widget.indexListImages][0],
                  ))
            ],
          );
        });
  }
}

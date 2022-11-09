
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/product_controller.dart';
import '../../../models/product_model.dart';
import '../show_product/product_details.dart';
import '../show_product/product_item.dart';

class ViewAllScreen extends StatelessWidget {
  final int dep;
  final List <ProductModel> list;
   ViewAllScreen({Key? key,required this.dep,required this.list}) : super(key: key);

  final ProductsController productController = Get.find();

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Container(
      child: Scaffold(
        appBar: AppBar(foregroundColor: Colors.grey[800],
        backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        body:  SizedBox(
          width: screenSize.width,
          height: screenSize.height * 0.9 - 10,
          child: _buildDepartmentProductsList(list),
          ),

      ),
    );
  }
}



Widget _buildDepartmentProductsList(List<ProductModel> list) {
  final ProductsController productController = Get.find();

  return Padding(
    padding: const EdgeInsets.only(top: 12.0, bottom: 0.0),
    child: Container(
      color: Colors.grey[50],
      child: GridView.builder(
          itemCount: list.length,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          semanticChildCount: 0,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 1,
              crossAxisSpacing: 6.1,
              childAspectRatio: 0.6),
          itemBuilder: (context, index) {
            return Padding(
                padding: EdgeInsets.zero,
                child: ProductItemCard(
                  product: list[index],
                  fromDetails: false,
                  from: 'dep',
                  press: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        transitionDuration: const Duration(milliseconds: 500),
                        reverseTransitionDuration:
                        const Duration(milliseconds: 500),
                        pageBuilder:
                            (context, animation, secondaryAnimation) =>
                            FadeTransition(
                              opacity: animation,
                              child: ProductDetails(
                                product:
                                list[index],
                              ),
                            ),
                      ),
                    );
                  },
                ));
          },
        ),

    ),
  );
}
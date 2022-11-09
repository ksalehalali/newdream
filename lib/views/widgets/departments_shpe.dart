import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Assistants/globals.dart';
import '../../controllers/catgories_controller.dart';
import '../../controllers/product_controller.dart';
import '../screens/show_product/products_of_department_screen.dart';

class DepartmentShapeTile extends StatelessWidget {
  final Color? color;
  final String? title;
  final String? assetPath;
  final String depId;

   DepartmentShapeTile({Key? key, this.color, this.title, this.assetPath,required this.depId})
      : super(key: key);
  final CategoriesController categoriesController = Get.find();
  final ProductsController productController = Get.find();

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return InkWell(
      onTap: (){
        productController.catProducts.value.clear();
        categoriesController.categories.clear();
        categoriesController.departments2.clear();

        //categoriesController.getListCategoryByCategory(depId);

        Get.to(()=> ProductsOfDepartmentScreen(depId: depId, haveChildren: true,));
      },
      child: Column(
        children: <Widget>[
          Container(
            height: screenSize.height *0.1 -16,
            width:  screenSize.height *0.1 -16,
            padding:  EdgeInsets.all(0.1),
            decoration:  BoxDecoration(
              color: myHexColor,
              borderRadius: BorderRadius.all(Radius.circular(100)),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(100)),
              child: Image.network(
                this.assetPath!,
                fit: BoxFit.fill,
              ),
            ),
          ),
          SizedBox(height: 5),
          SizedBox(
            width: screenSize.width *0.2+10,

              child: Text(this.title!,overflow: TextOverflow.fade,style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),textAlign: TextAlign.center,))
        ],
      ),
    );
  }
}
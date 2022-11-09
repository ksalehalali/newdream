import 'package:flutter/material.dart';

import '../../Assistants/globals.dart';

Widget buildDepartmentsListR() {
  List<Map<String,String>> categories =[
    {'catName': 'Women\'s Fashion','imagePath':'assets/images/agelesspix-PlcByunJ78c-unsplash.jpg'},
    {'catName': 'Men\'s Fashion','imagePath':'assets/images/austin-wade-d2s8NQ6WD24-unsplash.jpg'},
    {'catName': 'Kids, Baby & Toys','imagePath':'assets/images/robo-wunderkind-3EuPcI31MQU-unsplash.jpg'},
    {'catName': 'Accessories and gifts','imagePath':'assets/images/freestocks-PxM8aeJbzvk-unsplash.jpg'},
    {'catName': 'beauty supplies','imagePath':'assets/images/laura-chouette-RkINI2JZwss-unsplash.jpg'},
    {'catName': 'Men\'s stuff','imagePath':'assets/images/aniket-narula-XjNI-C5G6mI-unsplash.jpg'},
    {'catName': 'Mobiles & Accessories','imagePath':'assets/images/mehrshad-rajabi-cLrcbfSwBxU-unsplash.jpg'},
    {'catName': 'Home & Kitchen','imagePath':'assets/images/ryan-christodoulou-68CDDj03rks-unsplash.jpg'},
    {'catName': 'Brands','imagePath':'assets/images/zara-outlet.png'},
    {'catName': 'Watches & Bags','imagePath':'assets/images/aniket-narula-XjNI-C5G6mI-unsplash.jpg'},
    {'catName': 'Women\'s Fashion','imagePath':'assets/images/agelesspix-PlcByunJ78c-unsplash.jpg'},
    {'catName': 'Men\'s Fashion','imagePath':'assets/images/austin-wade-d2s8NQ6WD24-unsplash.jpg'},
    {'catName': 'Kids, Baby & Toys','imagePath':'assets/images/robo-wunderkind-3EuPcI31MQU-unsplash.jpg'},
    {'catName': 'Accessories and gifts','imagePath':'assets/images/freestocks-PxM8aeJbzvk-unsplash.jpg'},
    {'catName': 'beauty supplies','imagePath':'assets/images/laura-chouette-RkINI2JZwss-unsplash.jpg'},
    {'catName': 'Men\'s stuff','imagePath':'assets/images/aniket-narula-XjNI-C5G6mI-unsplash.jpg'},
    {'catName': 'Mobiles & Accessories','imagePath':'assets/images/mehrshad-rajabi-cLrcbfSwBxU-unsplash.jpg'},
    {'catName': 'Home & Kitchen','imagePath':'assets/images/ryan-christodoulou-68CDDj03rks-unsplash.jpg'},
    {'catName': 'Brands','imagePath':'assets/images/zara-outlet.png'},
    {'catName': 'Watches & Bags','imagePath':'assets/images/aniket-narula-XjNI-C5G6mI-unsplash.jpg'},
    {'catName': 'Women\'s Fashion','imagePath':'assets/images/agelesspix-PlcByunJ78c-unsplash.jpg'},
    {'catName': 'Men\'s Fashion','imagePath':'assets/images/austin-wade-d2s8NQ6WD24-unsplash.jpg'},
    {'catName': 'Kids, Baby & Toys','imagePath':'assets/images/robo-wunderkind-3EuPcI31MQU-unsplash.jpg'},
    {'catName': 'Accessories and gifts','imagePath':'assets/images/freestocks-PxM8aeJbzvk-unsplash.jpg'},
    {'catName': 'beauty supplies','imagePath':'assets/images/laura-chouette-RkINI2JZwss-unsplash.jpg'},
    {'catName': 'Men\'s stuff','imagePath':'assets/images/aniket-narula-XjNI-C5G6mI-unsplash.jpg'},
    {'catName': 'Mobiles & Accessories','imagePath':'assets/images/mehrshad-rajabi-cLrcbfSwBxU-unsplash.jpg'},
    {'catName': 'Home & Kitchen','imagePath':'assets/images/ryan-christodoulou-68CDDj03rks-unsplash.jpg'},
    {'catName': 'Brands','imagePath':'assets/images/zara-outlet.png'},
    {'catName': 'Watches & Bags','imagePath':'assets/images/aniket-narula-XjNI-C5G6mI-unsplash.jpg'},
    {'catName': 'Women\'s Fashion','imagePath':'assets/images/agelesspix-PlcByunJ78c-unsplash.jpg'},

  ];
  return Padding(
    padding: const EdgeInsets.only(top: 12.0),
    child: Container(
      color: Colors.grey[50],
      child: GridView.builder(
        itemCount: categories.length,
        scrollDirection: Axis.vertical,
        primary: false,
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        semanticChildCount: 0,

        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 2,
            crossAxisSpacing: 0.3,
            childAspectRatio: 1.0),
        itemBuilder: (context, index) {
          return Padding(
              padding: EdgeInsets.zero,
              child: Column(
                children: <Widget>[
                  Container(
                    height: 59,
                    width: 59,
                    //padding:  EdgeInsets.all(0.1),
                    decoration:  BoxDecoration(
                      color: myHexColor,
                      borderRadius: BorderRadius.all(Radius.circular(6)),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(6)),
                      child: Image.asset(
                        categories[index]['imagePath'].toString(),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(categories[index]['catName'].toString(),style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),textAlign: TextAlign.center,)
                ],
              ));
        },
      ),
    ),
  );
}
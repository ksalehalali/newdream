import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Assistants/globals.dart';
import '../../search/productsSearch.dart';

class SearchAreaDesign extends StatefulWidget {
  const SearchAreaDesign({Key? key}) : super(key: key);

  @override
  _SearchAreaDesignState createState() => _SearchAreaDesignState();
}

class _SearchAreaDesignState extends State<SearchAreaDesign> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const SearchProductScreen()));
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        child: Container(
          height: 41,
          // width: 330,
          decoration: BoxDecoration(
              border: Border.all(width: 0.1,color: myHexColor),

              borderRadius: BorderRadius.circular(5), color: Colors.blue[50]!.withOpacity(0.5)),
          child: Center(
            child: Row(
              children:  <Widget>[
                SizedBox(width: 10.0,),

                Icon(
                  Icons.search,
                  size: 25,
                  color: Colors.grey,
                ),
                Text('What are you looking for?_txt'.tr,
                    style: TextStyle(fontSize: 12,color: Colors.grey,letterSpacing: 1)),
                SizedBox(width: 10.0,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
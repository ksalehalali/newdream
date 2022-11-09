import 'package:flutter/material.dart';

Widget searchAreaDes(){
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.blue[50],
        border: Border.all(width: 0.5,color: Colors.red),
        borderRadius: BorderRadius.only(topRight: Radius.circular(12),topLeft:Radius.circular(12) ,bottomRight: const Radius.circular(12),bottomLeft: Radius.circular(12))
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(Icons.location_on_outlined,color: Colors.grey[700]),
            SizedBox(width: 12.0,),
            Text('Search for your location',style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold,color: Colors.grey[700]),)
          ],
        ),
      ),
    ),
  );
}
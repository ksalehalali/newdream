
import 'dart:convert';

class PlacePredictions {
  String? place_name;
  String? text;
  String? id;
  double? lat;
  double? lng;

  PlacePredictions({this.text, this.place_name ,this.id});
  PlacePredictions.fromJson(Map<String, dynamic> json){
    id =json["id"];
    text =json["text"];
    place_name =json["place_name"];
    lat = json["center"][1] as double;
    lng = json["center"][0] as double;

  }

}


class ProductPredictions {
   String? id;
   String? en_name;
   String? ar_name;
   String? userName;
   String? userId;
   String? modelName;
   String? imageUrl;
   double? price;
   int? offer;
   String? brand;
   String? categoryNameEN;
   String? categoryNameAR;

  ProductPredictions(
      {this.id,
      this.en_name,
      this.ar_name,
      this.userName,
      this.userId,
      this.modelName,
      this.imageUrl,
      this.price,
      this.offer,
      this.brand,
      this.categoryNameEN,
      this.categoryNameAR});
  ProductPredictions.fromJson(Map<String, dynamic> json){
    id =json["id"];
    en_name =json["name_EN"];
    ar_name =json["name_AR"];
    userName =json["userName"];
    price =json["price"].toDouble();
    brand =json["brandNameEN"];
    offer=json['offer'];
    imageUrl =json['image'];

  }

}
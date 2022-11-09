import '../models/product_colors_data.dart';

class ProductModel {
  final String? id;
  final String? en_name;
  final String? ar_name;
  final String? desc_EN;
  final String? desc_AR;
  final String? userName;
  final String? userId;
  final String? modelId;
  final String? modelName;
  final String? imageUrl;
  final double? price;
  final int? offer;
  final String? brand;
  final String? catId;
  final String? colorId;
  final String? sizeId;
  final String? categoryNameEN;
  final String? categoryNameAR;
  final List? special;
  final List? general;
  final String? providerName;
  final String? providerId;
  final List? colorsData;

  ProductModel(
      {this.id,
      this.en_name,
        this.colorsData,
        this.general,
        this.special,
        this.desc_AR,
        this.desc_EN,
      this.ar_name,
      this.modelId,
      this.imageUrl,
      this.price,
      this.offer,
        this.providerName,
        this.providerId,
      this.brand,
        this.catId,
        this.colorId,
        this.sizeId,
        this.userName,
        this.categoryNameAR,
        this.categoryNameEN,
        this.modelName,
        this.userId,
    });


}

class SizesQyts{
  late final int? qyt;
  late final String? sizeID;
  late final String? size;
  late final String? colorID;
  late final String? color;

  SizesQyts({this.qyt, this.sizeID, this.size,this.colorID, this.color});
}


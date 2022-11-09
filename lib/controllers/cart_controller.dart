import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Assistants/globals.dart';
import '../Data/current_data.dart';
import '../models/product_model.dart';
import '../views/screens/order/order_summary.dart';
import '../views/widgets/flash_messages_screen.dart';
import 'base_controller.dart';

class CartController extends GetxController with BaseController {
  var isCartEmpty = false.obs;
  var gotMyCart = false.obs;
  var itemsInserted = false.obs;
  var gotMyOrders = false.obs;
  var cartItems = <Widget>[].obs;
  var orderItems = <Widget>[].obs;

  var myPrCartProducts = [].obs;
  var myOrders = [].obs;
  var myOrdersDetails = [].obs;
  var ordersProdsWidget = [];
  var listOfListOrdersWidget = [[], []];

  var oneOrderDetails = {}.obs;
  var cartProducts = [];
  var cartProductsCounts =[].obs;
  var fullPrice = 0.0.obs;
  var countFromItem = 1.obs;
  var optionReasonSelected =0.obs;
  var processing =false.obs;
  var gotOrderDetails =false.obs;


  Future<bool> addToCart(String prodId, colorId, sizeId, langCode) async {
    print('prodId: $prodId, colorId: $colorId, sizeId: $sizeId ... ');

    var headers = {
      'Authorization': 'Bearer ${user.accessToken}',
      'Content-Type': 'application/json'
    };
    var request = http.Request(
        'POST', Uri.parse('https://dashcommerce.click68.com/api/AddCart'));
    request.body = json.encode(
        {"Number": 1, "ProdID": prodId.toString(), "ColorID": colorId.toString(), "SizeID": sizeId.toString()});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      getMyCartProds(true,langCode);
      return true;
    } else {
      print(response.reasonPhrase);
      return false;
    }
  }

  Future deleteProdFromCart(String prodId,String langCode) async {
    showLoading('loading');

    var headers = {
      'Authorization': 'Bearer ${user.accessToken}',
      'Content-Type': 'application/json'
    };
    var request = http.Request(
        'POST', Uri.parse('https://dashcommerce.click68.com/api/DeleteCart'));
    request.body = json.encode({"id": prodId});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      getMyCartProds(false,langCode);
      hideLoading();
    } else {
      hideLoading();
      print(response.reasonPhrase);
    }
  }

  Future getMyCartProds(bool fromAdd,String langCode) async {
    if (fromAdd) {

    } else {
      Future.delayed(5.milliseconds, () {
        showLoading('loading');
      });
    }

    gotMyCart.value = false;
    var headers = {
      'Authorization': 'Bearer ${user.accessToken}',
      'Content-Type': 'application/json',
      'Lang': langCode

    };
    var request = http.Request(
        'POST', Uri.parse('https://dashcommerce.click68.com/api/ListCart'));
    request.body = json.encode({"PageNumber": "1", "SizeNumber": "15"});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      myPrCartProducts.value = [];
      cartProducts = [];
      cartItems.value = [];
      var json = jsonDecode(await response.stream.bytesToString());
      print(json);
      if (json['status'] == true) {
        myPrCartProducts.value = json['description'];
        cartProducts = json['description'];
        gotMyCart.value = true;

        print('cart items = ${myPrCartProducts.length}');
        if(cartProducts.length >0){
          calculateFulPriceProducts(0);
          isCartEmpty.value =false;
        }else{
          fullPrice.value =0.0;
          isCartEmpty.value =true;
        }
        if (fromAdd) {
        } else {
          hideLoading();
        }
        update();
      } else {
        if (fromAdd) {
        } else {
          hideLoading();
        }
      }
    } else {
      if (fromAdd) {
      } else {
        hideLoading();
      }

      print('error in get cart items');
      print(response.reasonPhrase);
    }
  }

  calculateFulPriceProducts(int index) {
    fullPrice.value = 0.0;
    var offer = num.parse(myPrCartProducts[index]['offer']);
    for (int i = 0; i < myPrCartProducts.length; i++) {
      fullPrice.value = fullPrice.value +
          num.parse(myPrCartProducts[i]['price']) -
          num.parse(myPrCartProducts[i]['price']) * offer / 100;
    }
  }

  Future editProdCountCart(String id, int count,double price,bool isIncrease) async {
    var headers = {
      'Authorization': 'Bearer ${user.accessToken}',
      'Content-Type': 'application/json'
    };
    var request = http.Request(
        'POST', Uri.parse('https://dashcommerce.click68.com/api/EditCart'));
    request.body = json.encode({"id": id, "Number": count});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      if(isIncrease){
        fullPrice.value = fullPrice.value + price;
      }else{
        fullPrice.value = fullPrice.value - price;
      }
      update();
    } else {
      print(response.reasonPhrase);
    }
  }

  final storage = GetStorage();

  Future<bool> addNewOrder(
      String invoiceId, String paymentGateway, double invoiceValue,int payType,String langCode) async {
    processing.value =true;
    String addressId = storage.read("idAddressSelected");
    Future.delayed(5.milliseconds, () {
      showLoading('loading');
    });

    var headers = {
      'Authorization': 'Bearer ${user.accessToken}',
      'Content-Type': 'application/json'
    };
    var request = http.Request(
        'POST', Uri.parse('https://dashcommerce.click68.com/api/AddOrder'));
    request.body = json.encode({
      "api_key": "u#XW|27@vl*8>n,sCr]qq)K@c^tpC}",
      "api_secret": "/IIOpP`[(9]e`#S1&Yx{zm_w(mkbMO",
      "invoiceValue": invoiceValue,
      "invoiceId": 0,
      "paymentGateway": paymentGateway,
      "AddressID": addressId,
      "Payment": payType
    });

    request.headers.addAll(headers);
    print('invoiceId $invoiceId -- paymentGateway $paymentGateway -- invoice value $invoiceValue payment $payType --- adressId $addressId');

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var json = jsonDecode(await response.stream.bytesToString());
      print(json);
      var data = json['description'];

      lastOrder.addressID = storage.read("idAddressSelected");
      lastOrder.id = data['message'];
      lastOrder.invoiceValue = invoiceValue;
      lastOrder.invoiceId = invoiceId;
      lastOrder.payment = 0;
      await getOneOrder(data['message'],langCode);
      Get.offAll(OrderSummary(fromOrdersList: false, Order:oneOrderDetails));
      print(" order done .--- ${data}");
      processing.value =false;
      hideLoading();
      return true;
    } else {
      print('error add order');
      print(response.reasonPhrase);
      print(response.statusCode);
      hideLoading();
      return false;
    }
  }

  Future getMyOrders(String langCode) async {
    print('ang code is ......$langCode');
    gotMyOrders.value = false;
    myOrdersDetails.value = [];
    myOrders.value =[];
    var headers = {
      'Authorization': 'Bearer ${user.accessToken}',
      'Content-Type': 'application/json',
      'Lang': langCode
    };
    var request = http.Request('POST',
        Uri.parse('https://dashcommerce.click68.com/api/ListOrderByUser'));
    request.body = json.encode({"PageNumber": "0", "SizeNumber": "22"});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var json = jsonDecode(await response.stream.bytesToString());
      var data = json['description'];
      print('my list orders == $json');
      if(data.length >0){
        myOrders.value = data;
        print(myOrdersDetails.length);
        gotMyOrders.value = true;
        update();
      }
      // for(int i =0; i<myOrders.length; i++){
      //   await getOneOrder(myOrders[i]['id']);
      //   print(myOrdersDetails[i]['listProduct'][0]['product']);
      // }

    } else {
      print(response.reasonPhrase);
    }
  }

  Future getOneOrder(String id,String langCode) async {
    gotOrderDetails.value = false;
    var headers = {
      'Authorization': 'Bearer ${user.accessToken}',
      'Content-Type': 'application/json'
    };
    var request = http.Request(
        'POST', Uri.parse('https://dashcommerce.click68.com/api/GetOrder'));
    request.body = json.encode({"id": id});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var json = jsonDecode(await response.stream.bytesToString());
      var data = json['description'];
      print("order == $data");
      oneOrderDetails.value = data;
      gotOrderDetails.value = true;

      print(oneOrderDetails);
    } else {
      print(response.reasonPhrase);
    }
  }

  Future deleteOrder(String id,BuildContext context,String langCode)async{
    var headers = {
      'Authorization': 'Bearer ${user.accessToken}',
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse('https://dashcommerce.click68.com/api/DeleteOrder'));
    request.body = json.encode({
      "id": id
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      getMyOrders(langCode);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: customCanceledOrderSnackBarContent(context),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ));
    }
    else {
      print(response.reasonPhrase);
    }

  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
}

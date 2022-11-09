import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:http/http.dart' as http;

import '../Data/current_data.dart';
class PaymentController extends GetxController{
var myBalance = 0.obs;
var gotMyCredits = false.obs;
var gotMyTransfers = false.obs;

var credits =[].obs;
var transfers =[].obs;


  Future initiatePayment()async{
    var headers = {
      'Authorization': ' bearer rLtt6JWvbUHDDhsZnfpAhpYk4dxYDQkbcPTyGaKp2TYqQgG7FGZ5Th_WD53Oq8Ebz6A53njUoo1w3pjU1D4vs_ZMqFiz_j0urb_BH9Oq9VZoKFoJEDAbRZepGcQanImyYrry7Kt6MnMdgfG5jn4HngWoRdKduNNyP4kzcp3mRv7x00ahkm9LAK7ZRieg7k1PDAnBIOG3EyVSJ5kK4WLMvYr7sCwHbHcu4A5WwelxYK0GMJy37bNAarSJDFQsJ2ZvJjvMDmfWwDVFEVe_5tOomfVNt6bOg9mexbGjMrnHBnKnZR1vQbBtQieDlQepzTZMuQrSuKn-t5XZM7V6fCW7oP-uXGX-sMOajeX65JOf6XVpk29DP6ro8WTAflCDANC193yof8-f5_EYY-3hXhJj7RBXmizDpneEQDSaSz5sFk0sV5qPcARJ9zGG73vuGFyenjPPmtDtXtpx35A-BVcOSBYVIWe9kndG3nclfefjKEuZ3m4jL9Gg1h2JBvmXSMYiZtp9MR5I6pvbvylU_PP5xJFSjVTIz7IQSjcVGO41npnwIxRXNRxFOdIUHn0tjQ-7LwvEcTXyPsHXcMD8WtgBh-wxR8aKX7WPSsT1O8d8reb2aR7K3rkV3K82K_0OgawImEpwSvp9MNKynEAJQS6ZHe_J_l77652xwPNxMRTMASk1ZsJL',
      'Content-Type': 'application/json',
      'Cookie': 'ApplicationGatewayAffinity=61939aeb6b7c5f38617144d210b01e24; ApplicationGatewayAffinityCORS=61939aeb6b7c5f38617144d210b01e24'
    };
    var request = http.Request('POST', Uri.parse('https://apitest.myfatoorah.com/v2/InitiatePayment'));
    request.body = json.encode({
      "InvoiceAmount": 100,
      "CurrencyIso": "KWD"
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
    }

  }
  Future pay()async{

  }

  Future getMyWallet()async{
    gotMyCredits.value =false;
    var headers = {
      'Authorization': 'Bearer ${user.accessToken}'
    };
    var request = http.Request('GET', Uri.parse('https://dashcommerce.click68.com/api/MyWallet'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var json = jsonDecode(await response.stream.bytesToString());
      //print("my charge ${json['description']['total']}");
      var data = json['description'];
      myBalance.value = data['total'];
      gotMyCredits.value =true;
      update();
    }
    else {
      print(response.reasonPhrase);
    }

  }
  Future getListChargeMyWallet()async{
    var headers = {
      'Authorization': 'Bearer ${user.accessToken}',
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse('https://dashcommerce.click68.com/api/ListChargMyWallet'));
    request.body = json.encode({
      "PageNumber": "1",
      "SizeNumber": "3"
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var json = jsonDecode(await response.stream.bytesToString());
      print("my charge $json");
      var data = json['description'];
      credits.value = data;
      print('my list of charge is  :: ${data}');
    }
    else {
      print(response.reasonPhrase);
    }

  }

}
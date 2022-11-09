import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

import '../Assistants/globals.dart';
import '../Data/current_data.dart';
import 'product_controller.dart';

class CategoriesController extends GetxController {
  var departments = [].obs;
  var departments2 = [].obs;
  var categories = [].obs;
  var mainCategories = [].obs;
  var departmentsListOfCategories = [].obs;


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getListAllCategories();
  }
  Future getListCategoryByCategory(String catId) async {
    var headers = {
      'Authorization': 'bearer ${user.accessToken}',
      'Content-Type': 'application/json'
    };
    var request =
        http.Request('POST', Uri.parse('$baseURL/api/ListCategoryByCategory'));
    request.body = json.encode({"id": catId});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      departments.value = [];

      var json = jsonDecode(await response.stream.bytesToString());
      var data = json['description'];

      for (int i = 0; i < data.length; i++) {
        departments.add(data[i]);
      }
      update();

      print('cat length :: ${departments.length}');

    } else {
      print('error in category controller ::: ListCategoryByCategory');
      print(response.reasonPhrase);
    }

    update();
  }

  //get list of small departments
  Future getListDepartmentsByDepartmentId(String catId) async {
    var headers = {
      'Authorization': 'bearer ${user.accessToken}',
      'Content-Type': 'application/json'
    };
    var request =
    http.Request('POST', Uri.parse('$baseURL/api/ListCategoryByCategory'));
    request.body = json.encode({"id": catId});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      departments2.value = [];

      var json = jsonDecode(await response.stream.bytesToString());
      var data = json['description'];

      for (int i = 0; i < data.length; i++) {
        departments2.add(data[i]);
      }
      update();
      print('departments2 length :===: ${departments2.length}');
    } else {
      print('error in departments2 controller ::: ListCategoryByCategory');
      print(response.reasonPhrase);
    }

    update();
  }

  //get list of all categories
  Future getListAllCategories() async {
    var headers = {
      'Content-Type': 'application/json'
    };
    var request =
    http.Request('GET', Uri.parse('$baseURL/api/ListCategory'));
    //request.body = json.encode({"id": catId});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      departments2.value = [];

      var json = jsonDecode(await response.stream.bytesToString());
      var data = json['description'];
      print("all categories length :${data.length}");
      for (int i = 0; i < data.length; i++) {
        categories.add(data[i]);
      }
      for(int i =0; i< categories.length; i++) {
        if(categories[i]["category"]==null) {
          mainCategories.add(categories[i]);
        }
      }
      print("main categories length :: ${mainCategories.length}");

      update();
      print('departments2 length :===: ${departments2.length}');
      getListDepartmentsByCatyId();
    } else {
      print('error controller ::: ListCategory');
      print(response.reasonPhrase);
    }

    update();
  }

  //get list  departments
  Future getListDepartmentsByCatyId() async {
    for (int i = 0; i < mainCategories.length ; i++) {
      var headers = {
        'Authorization': 'bearer ${user.accessToken}',
        'Content-Type': 'application/json'
      };
      var request =
      http.Request('POST', Uri.parse('$baseURL/api/ListCategoryByCategory'));
      request.body = json.encode({"id": mainCategories[i]['id']});
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        departments2.value = [];

        var json = jsonDecode(await response.stream.bytesToString());
        var data = json['description'];
        departmentsListOfCategories.add(data);
        update();
        print('departmentsListOfCategories length :===: ${departmentsListOfCategories.length}');
      } else {
        print('error in departmentsListOfCategories controller ::: departmentsListOfCategories');
        print(response.reasonPhrase);
      }

      update();
    }
  }
}

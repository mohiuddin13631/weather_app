import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'DataModel.dart';

class ApiController extends GetxController{
  var isLoading = false.obs;
  var dataList = <DataModel>[].obs;

  // @override
  // void onInit(){
  //   super.onInit();
  //   loadData();
  // }
  Future<void> loadData()async {
    String apiLink = "https://jsonplaceholder.typicode.com/comments";
    var response = await http.get(Uri.parse(apiLink));
    if(response.statusCode == 200){
      var decodeData = jsonDecode(response.body);
      // print(decodeData);
      // print(dataList.runtimeType);
      dataList.value = List.from(decodeData).map((e) => DataModel.fromMap(e)).toList();
      isLoading.value = true;
    }
    else{
      Get.snackbar("Error", response.statusCode.toString());
    }
  }
}
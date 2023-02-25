import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../model/PhotoModel.dart';
class UnsplashApiController extends GetxController{
  String accessKey = "2HYmB5McO8MeHDRcPdLxr-YGpE8doe6s6QWfMeh9qio";
  var isDataloading = false.obs;
  var photoList = <PhotoModel>[].obs;

  // @override //todo: when controller will initilized loaddata() automaticlly will call
  // void onInit(){
  //   super.onInit();
  //   loadData();
  // }

  Future<void>loadData()async{
    String apiLink = "https://api.unsplash.com/photos/?client_id=" + accessKey;
    var response = await http.get(Uri.parse(apiLink)); //call api
    if(response.statusCode == 200){
      var decodedData = jsonDecode(response.body);
      // print(decodedData);
      photoList.value = List.from(decodedData).map((e) => PhotoModel.fromMap(e)).toList();
      isDataloading.value = true;
      // print(photoList[1]);
    }
    else{
      Get.snackbar("Error", response.statusCode.toString());
    }
  }
}
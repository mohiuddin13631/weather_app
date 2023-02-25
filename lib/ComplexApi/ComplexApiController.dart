import 'dart:convert';

import 'package:api_integration/ComplexApi/ModelComplexApi.dart';
import 'package:http/http.dart' as http;

class ComplexApiController{
  static var userList = <ModelComplexApi>[];
  static Future<List<ModelComplexApi>> loadApiData() async{
    var response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));
    if(response.statusCode == 200){
      var decodeData = jsonDecode(response.body);
      for(Map i in decodeData){
        userList.add(ModelComplexApi.fromJson(i));
      }
      return userList;
    }
    else{
      return userList;
    }
  }
}
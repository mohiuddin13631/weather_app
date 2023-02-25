import 'dart:convert';

import 'package:http/http.dart' as http;
class ApiWithoudModelController{
  static var dataList;
  static Future<void>loadData()async{
    var response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));
    if(response.statusCode == 200){
      dataList = jsonDecode(response.body.toString());
    }
  }
}
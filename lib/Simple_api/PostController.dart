import 'dart:convert';

import 'PostModel.dart';
import 'package:http/http.dart' as http;

class PostController{
  static var postList = <PostModel>[];

  static Future<List<PostModel>> getpostApi() async{
    var response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));
    if(response.statusCode == 200){
      var decodeData = jsonDecode(response.body);
      for(Map i in decodeData){
        postList.add(PostModel.fromJson(i));
      }
      return postList;
    }
    else{
      return postList;
    }
  }
}
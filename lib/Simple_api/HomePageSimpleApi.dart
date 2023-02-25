import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'PostController.dart';
import 'PostModel.dart';
class HomePageSimpleApi extends StatelessWidget {
  HomePageSimpleApi({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: PostController.getpostApi(),
              builder: (context, snapshot) {
                if(!snapshot.hasData){
                  return Center(child: CircularProgressIndicator());
                }
                else{
                  return ListView.builder(
                    itemCount: PostController.postList.length,
                    itemBuilder: (context, index) {
                      var data = PostController.postList[index];
                      return ListTile(
                        title: Text(PostController.postList[index].title.toString()),
                        subtitle: Text(data.body.toString()),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

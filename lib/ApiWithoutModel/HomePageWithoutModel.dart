import 'dart:convert';

import 'package:api_integration/ApiWithoutModel/ApiWithoudModelController.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class HomePageWithoutModel extends StatelessWidget {
  HomePageWithoutModel({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              // future: ApiWithoudModelController.loadData(),
              future: ApiWithoudModelController.loadData(),
              builder: (context, snapshot) {
                if(snapshot.connectionState == ConnectionState.waiting){
                  return Center(child: CircularProgressIndicator());
                }else{
                  return ListView.builder(
                    // itemCount:dataList.length,
                    itemCount: ApiWithoudModelController.dataList.length,
                    itemBuilder: (context,index){
                      var data = ApiWithoudModelController.dataList[index];
                      return Container(
                        margin: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                // blurRadius:2,
                                  spreadRadius: 2,
                                  color: Colors.teal
                              )
                            ]
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Name: "+data['Name'].toString()),
                              SizedBox(height: 7,),
                              Text("Email: "+data['email'].toString()),
                              SizedBox(height: 7,),
                              Text("City: "+data['address']['city'].toString()),
                              SizedBox(height: 7,),
                              Text("lat: "+data['address']['geo']['lat'].toString()),
                              SizedBox(height: 7,),
                              Text("Company Name: "+data['company']['name'].toString()),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'ApiController.dart';

class HomePagePlaceHolder extends StatefulWidget {
  HomePagePlaceHolder({Key? key}) : super(key: key);

  @override
  State<HomePagePlaceHolder> createState() => _HomePagePlaceHolderState();
}

class _HomePagePlaceHolderState extends State<HomePagePlaceHolder> {
  ApiController apiController = Get.find();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apiController.loadData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(()=>
          apiController.isLoading == true? ListView.builder(
            itemCount: apiController.dataList.length,
            itemBuilder: (context, index) {
              var data = apiController.dataList[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: EdgeInsets.all(8),
                  color: Colors.grey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Name: ${data.name}"),
                      Text("Email: ${data.email}"),
                      Text("Body: ${data.body}")
                    ],
                  ),
                ),
              );
            },
          ):Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}

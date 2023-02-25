import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../controller/UnsplashApiController.dart';

class HomePageUnsplash extends StatelessWidget {
  HomePageUnsplash({Key? key}) : super(key: key);
  // UnsplashApiController unsplashApiController =
  //     Get.put(UnsplashApiController());
  UnsplashApiController unsplashApiController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.maxFinite,
          height: double.maxFinite,
          child: Obx(()=> unsplashApiController.isDataloading == true?
            GridView.builder(
              itemCount: unsplashApiController.photoList.length,
                gridDelegate:
                    SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                itemBuilder: (context, index) {
                  return Card(
                    child: Image.network(unsplashApiController.photoList[index].urls['small'],fit: BoxFit.cover,),
                  );
                },):Center(child: CircularProgressIndicator()),
          ),
        ),
      ),
    );
  }
}

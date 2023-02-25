import 'package:api_integration/ApiWithoutModel/HomePageWithoutModel.dart';
import 'package:flutter/material.dart';

import 'ComplexApi/HomePage.dart';
import 'Simple_api/HomePageSimpleApi.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePageWithoutModel(),
    );
  }
}


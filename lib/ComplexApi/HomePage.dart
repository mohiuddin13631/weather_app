import 'package:api_integration/ComplexApi/ComplexApiController.dart';
import 'package:flutter/material.dart';

class HomePageComplexApi extends StatelessWidget {
  const HomePageComplexApi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: FutureBuilder(
              future: ComplexApiController.loadApiData(),
              builder: (context, snapshot) {
                if(!snapshot.hasData){
                  return Center(child: CircularProgressIndicator());
                }else{
                  return ListView.builder(
                    itemCount: ComplexApiController.userList.length,
                    itemBuilder: (context,index){
                      var data = ComplexApiController.userList[index];
                      return Container(
                        margin: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(

                          boxShadow: [
                            BoxShadow(
                              // blurRadius:2,
                              spreadRadius: 2,
                              color: Colors.orange
                            )
                          ]
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Name: "+data.name.toString()),
                              SizedBox(height: 7,),
                              Text("Email: "+data.email.toString()),
                              SizedBox(height: 7,),
                              Text("City: "+data.address!.city.toString()),
                              SizedBox(height: 7,),
                              Text("lat: "+data.address!.geo!.lat.toString()),
                              SizedBox(height: 7,),
                              Text("Company Name: "+data.company!.name.toString()),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      )
    );
  }
}

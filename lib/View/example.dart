import 'dart:convert';

import 'package:covid_19_tracker_app/Model/Example.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ExampleScreen extends StatefulWidget{
  const ExampleScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ExampleScreenState();
  }
}

class ExampleScreenState extends State<ExampleScreen>{
  Example userData = Example();
  Future<Example> getProductData() async{
    final response = await http.get(Uri.parse("https://randomuser.me/api/?results=50"));
    var data = jsonDecode(response.body);
    if(response.statusCode == 200){
      print(response.body);
      userData = Example.fromJson(data);
      return userData;
    }
    else{
      return userData;
    }
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<Example>(
              future: getProductData(),
              builder: (BuildContext context , snapshot){
                if(snapshot.hasData){
                  return ListView.builder(
                      shrinkWrap: true,
                      // itemCount: userData.results!.length,
                      itemCount: snapshot.data!.results!.length,
                      itemBuilder: (context , index){
                        return ListTile(
                          // title: Text(userData.results![index].gender.toString()),
                          title: Text(snapshot.data!.results![index].gender.toString()),
                        );
                      });
                }
                else if(snapshot.hasError){
                  print(snapshot.error.toString());
                  print(snapshot.hasError.toString());
                  return Center(child: Text(snapshot.error.toString()),);
                }
                else{
                  return const Center(
                    child: CircularProgressIndicator(),
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
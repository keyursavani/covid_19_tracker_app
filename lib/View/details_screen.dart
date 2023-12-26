import 'package:covid_19_tracker_app/View/world_state_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatefulWidget{
  String image;
  String name;
  int totalCases , totalDeaths , totalRecovered , active , critical , todayRecovered , test;

  DetailsScreen({super.key ,  required this.name , required this.image, required this.todayRecovered ,
    required this.critical, required this.active, required this.test, required this.totalCases,
    required this.totalDeaths, required this.totalRecovered});


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
   return DetailsScreenState();
  }
}

class DetailsScreenState extends State<DetailsScreen>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                  padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height * .067),
                child: Card(
                  child: Column(
                    children: [
                      ReusableRow(title: "Cases", value: widget.totalCases.toString()),
                      ReusableRow(title: "Recovered", value: widget.totalRecovered.toString()),
                      ReusableRow(title: "Deaths", value: widget.totalDeaths.toString()),
                      ReusableRow(title: "Critical", value: widget.critical.toString()),
                      ReusableRow(title: "Today Recovered", value: widget.todayRecovered.toString()),
                    ],
                  ),
                ),
              ),
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(widget.image),
              )
            ],
          ),
        ],
      ),
    );
  }
}
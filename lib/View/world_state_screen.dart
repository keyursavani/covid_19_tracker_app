import 'package:covid_19_tracker_app/Model/world_states_model.dart';
import 'package:covid_19_tracker_app/Services/Utilities/states_services.dart';
import 'package:covid_19_tracker_app/View/countries_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

class WorldStateScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return WorldStateScreenState();
  }
}

class WorldStateScreenState extends State<WorldStateScreen> with TickerProviderStateMixin{

  late final AnimationController controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this
  )..repeat();


  @override
  void initState() {
    super.initState();
    getData();
  }

  late WorldStatesModel userData;
  void getData() async{
    StateServices stateServices = StateServices();
    final response = await stateServices.fetchWorldStateRecords(context);
    userData =  response;
  }
  @override
  void dispose(){
    controller.dispose();
    super.dispose();
  }

  final colorList = <Color>[
    const Color(0xFF4285f4),
    const Color(0xFFaaa260),
    const Color(0xFFde5246)
  ];

  @override
  Widget build(BuildContext context) {
    StateServices stateServices = StateServices();
    // TODO: implement build
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * .01),
              FutureBuilder(
                  future: stateServices.fetchWorldStateRecords(context),
                  builder: (context , snapshot){
                    if(!snapshot.hasData){
                      return Expanded(
                          child: SpinKitFadingCircle(
                            controller: controller,
                            color: Colors.white,
                            size: 50,
                          ),
                      );
                    }
                    else{
                      return Column(
                        children: [
                          PieChart(
                            dataMap: {
                              "Total":double.parse(snapshot.data!.cases!.toString()),
                              "Recovered":double.parse(snapshot.data!.recovered.toString()),
                              "Deaths":double.parse(snapshot.data!.deaths.toString()),
                            },
                            chartValuesOptions: const ChartValuesOptions(
                              showChartValuesInPercentage: true,
                            ),
                            chartRadius: MediaQuery.of(context).size.width / 3.2,
                            legendOptions: const LegendOptions(
                                legendPosition: LegendPosition.left
                            ),
                            animationDuration: const Duration(milliseconds: 1200),
                            chartType: ChartType.ring,
                            colorList: colorList,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * .06),
                            child: Card(
                              child: Column(
                                children: [
                                  // ReusableRow(title: "Total", value:snapshot.data!.cases.toString()),
                                  // ReusableRow(title: "Deaths", value: snapshot.data!.deaths.toString()),
                                  // ReusableRow(title: "Recovered", value: snapshot.data!.recovered.toString()),
                                  // ReusableRow(title: "Active", value:snapshot.data!.active.toString()),
                                  // ReusableRow(title: "Critical", value: snapshot.data!.critical.toString()),
                                  // ReusableRow(title: "Today Death", value: snapshot.data!.todayDeaths.toString()),
                                  // ReusableRow(title: "Today Recovered", value: snapshot.data!.todayRecovered.toString()),
                                  ReusableRow(title: "Total", value:userData.cases.toString()),
                                  ReusableRow(title: "Deaths", value: userData.deaths.toString()),
                                  ReusableRow(title: "Recovered", value: userData.recovered.toString()),
                                  ReusableRow(title: "Active", value:userData.active.toString()),
                                  ReusableRow(title: "Critical", value: userData.critical.toString()),
                                  ReusableRow(title: "Today Death", value: userData.todayDeaths.toString()),
                                  ReusableRow(title: "Today Recovered", value: userData.todayRecovered.toString()),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: (){
                              Navigator.push(context,
                              MaterialPageRoute(builder: (context){
                                return CountriesList();
                              }));
                    },

                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                color: const Color(0xFF1aa260),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Center(
                                child: Text("Track Countires"),
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                  }),
            ],
          ),
        ),
      )
    );
  }
}

class ReusableRow extends StatelessWidget{
  String title, value;
   ReusableRow({super.key , required this.title , required this.value});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   return Padding(
     padding: const EdgeInsets.all(10),
     child: Column(
       children: [
       Row(
         mainAxisAlignment: MainAxisAlignment.spaceBetween,
         children: [
           Text(title),
           Text(value),
         ],
       ),
         SizedBox(height: 5,),
         Divider(),
       ],
     ),
   );
  }
}
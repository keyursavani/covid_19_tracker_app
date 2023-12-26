import 'package:covid_19_tracker_app/Services/Utilities/states_services.dart';
import 'package:covid_19_tracker_app/View/details_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CountriesList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CountriesListState();
  }
}

class CountriesListState extends State<CountriesList> {
  late final name1;
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    name1 = "keyur";
    name1 = "";
    StateServices stateServices = StateServices();
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme
            .of(context)
            .scaffoldBackgroundColor,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: TextFormField(
                controller: searchController,
                onChanged: (value) {
                  setState(() {

                  });
                },
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                  hintText: "Search with country name",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0),
                      borderSide: BorderSide(color: Colors.black54)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0),
                      borderSide: BorderSide(color: Colors.black54)),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0),
                    borderSide: BorderSide(color: Colors.black54),),
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: stateServices.countriesListApi(),
                builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                  if (!snapshot.hasData) {
                    return ListView.builder(
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return Shimmer.fromColors(
                            baseColor: Colors.grey.shade700,
                            highlightColor: Colors.grey.shade700,
                            child: Column(
                              children: [
                                ListTile(
                                  title: Container(height: 10,
                                    width: 85,
                                    color: Colors.white,),
                                  subtitle: Container(height: 10,
                                    width: 85,
                                    color: Colors.white,),
                                  leading: Container(height: 10,
                                    width: 85,
                                    color: Colors.white,),
                                ),
                              ],
                            ),
                          );
                        });
                  } else {
                    return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          String name = snapshot.data![index]['country'];
                          if (searchController.text.isEmpty) {
                            return Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                          return DetailsScreen(
                                              name: snapshot.data![index]['country'],
                                              image: snapshot.data![index]['countryInfo']['flag'],
                                              todayRecovered: snapshot.data![index]['todayRecovered'],
                                              critical: snapshot.data![index]['critical'],
                                              active:  snapshot.data![index]['active'],
                                              test: snapshot.data![index]['tests'],
                                              totalCases:  snapshot.data![index]['cases'],
                                              totalDeaths: snapshot.data![index]['deaths'],
                                              totalRecovered: snapshot.data![index]['recovered']
                                          );
                                        }
                                        )
                                    );
                                  },
                                  child: ListTile(
                                    title: Text(
                                        snapshot.data![index]['country']),
                                    subtitle: Text(
                                        snapshot.data![index]['cases']
                                            .toString()),
                                    leading: Image(image: NetworkImage(
                                      snapshot
                                          .data![index]['countryInfo']['flag'],
                                    ),
                                      height: 50,
                                      width: 50,),
                                  ),
                                )
                              ],
                            );
                          }
                          else if (name.toLowerCase().contains(searchController
                              .text.toLowerCase())) {
                            return Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                          return DetailsScreen(
                                              name: snapshot.data![index]['country'],
                                              image: snapshot.data![index]['countryInfo']['flag'],
                                              todayRecovered: snapshot.data![index]['todayRecovered'],
                                              critical: snapshot.data![index]['critical'],
                                              active:  snapshot.data![index]['active'],
                                              test: snapshot.data![index]['tests'],
                                              totalCases:  snapshot.data![index]['cases'],
                                              totalDeaths: snapshot.data![index]['deaths'],
                                              totalRecovered: snapshot.data![index]['recovered']
                                          );
                                        }
                                        )
                                    );
                                  },
                                  child: ListTile(
                                    title: Text(snapshot.data![index]['country']),
                                    subtitle: Text(snapshot.data![index]['cases']
                                        .toString()),
                                    leading: Image(image: NetworkImage(
                                      snapshot
                                          .data![index]['countryInfo']['flag'],
                                    ),
                                      height: 50,
                                      width: 50,),
                                  ),
                                )
                              ],
                            );
                          }
                          else {
                            return Container();
                          }
                        });
                  }
                },

              ),
            ),
          ],
        ),
      ),
    );
  }
}
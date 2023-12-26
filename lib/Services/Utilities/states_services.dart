import 'dart:convert';

import 'package:covid_19_tracker_app/Model/world_states_model.dart';
import 'package:covid_19_tracker_app/Services/Utilities/app_url.dart';
import 'package:http/http.dart' as http;

class StateServices{
  Future<WorldStatesModel> fetchWorldStateRecords(context) async{
    late WorldStatesModel userData;
    final response = await http.get(Uri.parse(AppUrl.worldStateApi));
    if(response.statusCode == 200){
      var data = jsonDecode(response.body);
      userData = WorldStatesModel.fromJson(data);
      return userData;
    }
    else{
    throw Exception("Error in WorldState Api Calling");
    }
  }



  Future<List<dynamic>> countriesListApi() async{
   var data;
    final response = await http.get(Uri.parse(AppUrl.countriesList));
    if(response.statusCode == 200){
       data = jsonDecode(response.body);
      return data;
    }
    else{
      throw Exception("Error in WorldState Api Calling");
    }
  }
}
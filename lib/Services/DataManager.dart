import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';


import '../Models/CountryModel.dart';

class DataManager {

  Future<String> loadContentAsset(String path) async {
    return await rootBundle.loadString(path);
  }

  Future<DataModel> loadCountries() async {
    String jsonString = await loadContentAsset('assets/countries_data/countries.json');
    final jsonResponse = json.decode(jsonString);
    debugPrint("jsonResponse"+jsonResponse.toString());
    return DataModel.fromJson(jsonResponse);
  }



}
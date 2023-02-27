import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import '../Utils/AppSettings.dart';


class GetCountryIP {

  //const IPCountryApiURL ='http://ip-api.com/json';
  Future<String> getCurrentCountry() async {
    final uri = Uri.parse('http://ip-api.com/json');
    var client = http.Client();
    var jsonString = "";
    try {
      var response = await client.get(uri);

      if (response.statusCode == 200) {
        jsonString = response.body;
      }
    } on SocketException {
      throw Exception('No Internet Connection');
    } on Exception catch (e) {
      print("Error fetching");
      throw Exception(e);
    }

    return json.decode(jsonString)['country'].toString();
  }

}







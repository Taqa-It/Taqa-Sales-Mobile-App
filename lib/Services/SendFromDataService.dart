import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mrad_internal/Models/FormData.dart';
import 'package:localstorage/localstorage.dart';
import 'package:http/http.dart' as http;
import 'package:nb_utils/nb_utils.dart';

import '../Utils/AppColors.dart';
var token="";
Submitform(String JWTtoken,String bodyData,BuildContext context) async {
  print("token 1"+JWTtoken.toString());

  try {
    http.Response responseJson;
    responseJson = await http.post(
        Uri.parse('http://energy.mrad-services.com:1990/mobtms/sales/datareq'),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
        },
        body: {
         'cmd': 'simulation',
          'jwtToken':  JWTtoken,
          'userid': '1',
          'reqdata': bodyData,
        } );

    final jsonData = jsonDecode(responseJson.body);
    print(jsonData.toString());
    print(jsonData[0]['reply'].toString()+"Reeply");

    if (jsonData[0]['reply']=="USRCHKOK")
    {
      print("Logged in successfully!");



      Fluttertoast.showToast(
        msg: "Submitted Successfull " ,
        toastLength: Toast.LENGTH_SHORT, // length
        gravity: ToastGravity.BOTTOM,    // location
        backgroundColor: colorSecondary,
      );





    }
    else{
      print("Failed to submit !");
      Fluttertoast.showToast(
        msg: "Login Error " ,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: colorSecondary,
      );
    }
  }

  on Exception catch (e) {
    print(e);
    print("Failed to Login !"+ e.toString());
    Fluttertoast.showToast(
        msg: "Failed to Login !"+e.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: appDividerColor ,
        textColor: Colors.black87,
        fontSize: 16.0
    );
  }

}

Future<String> GetUserToken() async{
  LocalStorage localStorage =  LocalStorage('UserInfo');

  await localStorage.ready;
  var token =  localStorage.getItem('access_token').toString();

  return token;

}
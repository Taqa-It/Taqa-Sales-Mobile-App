

import 'dart:async';

import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

import 'View/Screens/SplashScreenn2.dart';

//StreamController<List<String>> streamController = StreamController<List<String>>();

/// To verify that your messages are being received, you ought to see a notification appearon your device/emulator
/// via the flutter_local_notifications plugin.
/// Define a top-level named handler which background/terminated messages will
/// call.


// void main() {
//  // ClassBuilder.registerClasses();
//   runApp( MyApp());
// }

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();


  final LocalStorage storage =  new LocalStorage('user_info');

  // This method will be called when the app is closed.


  _clearStorage() async {
    await storage.clear();


  }
  // Register the method to be called on app exit.
  ProcessSignal.sigterm.watch().listen((_) => _clearStorage());
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Energy App',
      // theme: ThemeData(
      //   // This is the theme of your application.
      //   //
      //   // Try running your application with "flutter run". You'll see the
      //   // application has a blue toolbar. Then, without quitting the app, try
      //   // changing the primarySwatch below to Colors.green and then invoke
      //   // "hot reload" (press "r" in the console where you ran "flutter run",
      //   // or simply save your changes to "hot reload" in a Flutter IDE).
      //   // Notice that the counter didn't reset back to zero; the application
      //   // is not restarted.
      //  // primarySwatch: Colors.blue,
      // ),
      home:

      SplashScreenn2(),

    );
  }
}
















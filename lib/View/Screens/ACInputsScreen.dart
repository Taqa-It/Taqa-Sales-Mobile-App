import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:localstorage/localstorage.dart';
import 'package:mrad_internal/Models/FormData.dart';
//import 'package:flutter_svg/svg.dart';
import 'package:nb_utils/nb_utils.dart';


import '../../Models/CountryModel.dart';
import '../../Services/DataManager.dart';
import '../../Services/GetCountryIPService.dart';
import '../../Services/SendFromDataService.dart';
import '../../Utils/AppColors.dart';
import '../../Utils/AppImages.dart';
import '../../Utils/AppSettings.dart';


class ACInputsScreen extends StatefulWidget {
  FormDataModel form;
  ACInputsScreen(this.form);

  @override
  ACInputsScreenState createState() => ACInputsScreenState();
}

class ACInputsScreenState extends State<ACInputsScreen> {
  bool _showPassword = false;
  bool _showConfPassword=false;
  TextEditingController locationCont = TextEditingController();
  TextEditingController areaCont = TextEditingController();
  TextEditingController loadCont = TextEditingController();



  FocusNode locationFocusNode = FocusNode();
  FocusNode areaFocusNode = FocusNode();
  FocusNode  loadFocusNode = FocusNode();

  @override
  void dispose() {
    super.dispose();
    locationFocusNode.dispose();
    areaFocusNode.dispose();
    loadFocusNode.dispose();

  }


  List<DataModel> dataList = [];
  List<Countries> countriesList = [];
  Countries dropdownValue = new Countries(id: 1,
      currencyId: 1,
      name: "name",
      code: "code",
      numCode: 1,
      phoneCode: 1,
      timezoneCode: "0");

  fetchData() async {
    final dynamic tooltip = _toolTipKey.currentState;
    tooltip.ensureTooltipVisible();


    final dynamic tooltip2 = _toolTipKey2.currentState;
    tooltip2.ensureTooltipVisible();


    final dynamic tooltip3 = _toolTipKey3.currentState;
    tooltip3.ensureTooltipVisible();
    DataManager().loadCountries().then((country) {
      setState(() {
        dataList.clear();
        dataList.add(country);
        for (var c in dataList)
          for (var i = 0; i < c.countries.length; i++) {
            countriesList.add(c.countries[i]);
            debugPrint(countriesList[i].name + "   " + (countriesList[i].code));
          }
        dropdownValue = countriesList[1];
        GetCountryIP().getCurrentCountry().then((value) {
          setState(() {
            dropdownValue = countriesList
                .where((cn) => cn.name == value.toString())
                .first as Countries;
          });
        });
      });
    }).catchError((error) {
      debugPrint(error.toString());
    });
  }
  GlobalKey _toolTipKey = GlobalKey();
  GlobalKey _toolTipKey2 = GlobalKey();  GlobalKey _toolTipKey3 = GlobalKey();

  @override
  initState() {
    print("bibi");
    print(widget.form.applchecked!);
    super.initState();
    fetchData();
    SchedulerBinding.instance!.addPostFrameCallback((_) {
      // Flutter get callback here when screen initialized.

    });
  }



  Completer<GoogleMapController> _controller = Completer();
  String location = "Search Location";

  // Define a key to access the form
  final _formKey = GlobalKey<FormState>();


  bool? _valueEdl = false;
  bool? _valueg1 = false;
  bool? _valueg2 = false;



  // This function is triggered when the user press the "Sign Up" button
  Future<void> _trySubmitForm() async {
    final bool? isValid = _formKey.currentState?.validate();
    if (isValid == true) {
      debugPrint('Everything looks good!');
      debugPrint(_valueEdl.toString());
      debugPrint(_valueg1.toString());
      debugPrint(_valueg2.toString());

      var bodyData={
"clientdata": {
  "firstname": widget.form.userInfo[0],
  "lastname": widget.form.userInfo[1],
  "email": widget.form.userInfo[2],
  "province": widget.form.userInfo[3],
  "casa": widget.form.userInfo[4],
  "city": widget.form.userInfo[5],
  "addressdetails": widget.form.userInfo[6],
  "prefix":widget.form.userInfo[6],
  "phonenumber": widget.form.userInfo[7],
},
      "locationdata": {
      "location":widget.form.systemReq![0],
      "area":widget.form.systemReq![1]
      },

      "loaddata": {
        "load":widget.form.systemReq![2],
      "appliances":widget.form.applchecked!
      },

      "acdata": {
        "edl":_valueEdl.toString(),
        "homegenerator":_valueg1.toString(),
        "districtgenerator":_valueg2.toString(),},
      };

      LocalStorage localStorage =  LocalStorage('user_info');
    //  LocalStorage localStoragee =  LocalStorage('user_location');
      await localStorage.ready;
      //await localStoragee.ready;
      String xx= localStorage.getItem('jwtToken').toString();
      String xxx= localStorage.getItem('longitude').toString();
      String xxxx= localStorage.getItem('ulocation').toString();
print("jwy"+xx.toString()); print("xxx"+xxxx.toString());print(widget.form.applchecked!);
   await Submitform(xx,jsonEncode(bodyData),context);

    }
  }




  bool _valu = false;
  // bool validatePhoneNumber(int phoneCode,String number){
  //
  //   if (phoneCode==961)
  //     if (!RegExp(LebanonRegex).hasMatch(number))
  //       return false;
  //     else  return true;
  //
  //   else if (phoneCode==357)
  //     if (!RegExp(CyprusRegex).hasMatch(number))
  //       return false;
  //     else  return true;
  //
  //   else return false;
  // }
  @override
  Widget build(BuildContext context) {


    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text("AC Inputs"), backgroundColor: colorSecondary,),
        backgroundColor: colorSecondary,
        body: Stack(
          children: <Widget>[
            Column(children: [       Container(
              margin: EdgeInsets.only(top: 5),
              child: Align(
                alignment: Alignment.topCenter,
                // child: SvgPicture.asset(ic_logo, color: white.withOpacity(0.8), height: 150, width: 150),
                child:       Image.asset("images/appimages/acinput2.png", height: 140),
                //commonCacheImageWidget(ic_logo_white, 150),
              ),
            ),
            Text("AC Inputs",style: boldTextStyle(color: Colors.white,size: 25,fontFamily: 'Semibold'),)

            ],),


            Container(
              margin: EdgeInsets.only(top: 200),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topRight: Radius.circular(15), topLeft: Radius.circular(15)),
                color: whiteColor,
              ),
              child: SingleChildScrollView(
                child:
                Form(
                  key: _formKey,
                  child:Column(
                  children: <Widget>[



                    // Container(
                    //   decoration: BoxDecoration(
                    //     border: Border.all(color: Colors.greenAccent),
                    //     borderRadius: BorderRadius.circular(20),
                    //   ), //BoxDecoration
                    //
                    //   /** CheckboxListTile Widget **/
                    //   child: CheckboxListTile(
                    //     title: const Text('GeeksforGeeks'),
                    //     subtitle:
                    //     const Text('A computer science portal for geeks. '),
                    //     secondary: CircleAvatar(
                    //       backgroundImage: NetworkImage(
                    //           "https://pbs.twimg.com/profile_images/1304985167476523008/QNHrwL2q_400x400.jpg"), //NetworkImage
                    //       radius: 20,
                    //     ),
                    //     autofocus: false,
                    //     activeColor: Colors.green,
                    //     checkColor: Colors.white,
                    //     selected: _value,
                    //     dense: true,
                    //     value: _value,
                    //     onChanged: (bool? value) {
                    //       setState(() {
                    //         _value = value;
                    //       });
                    //     },
                    //   ), //CheckboxListTile
                    // ),

                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        // boxShadow: [
                        //   BoxShadow(
                        //     color: Colors.black,
                        //     offset: const Offset(
                        //       3.0,
                        //       3.0,
                        //     ), //Offset
                        //     blurRadius: 10.0,
                        //     spreadRadius: 2.0,
                        //   ), //BoxShadow
                        //   BoxShadow(
                        //     color: Colors.white,
                        //     offset: const Offset(0.0, 0.0),
                        //     blurRadius: 0.0,
                        //     spreadRadius: 0.0,
                        //   ), //BoxShadow
                        // ],
                      ), //BoxDecoration

                      /** CheckboxListTile Widget **/
                      child:   CheckboxListTile(

                        title:  Text('EDL',style: boldTextStyle(color: _valueEdl == false ?  Colors.black45 : colorSecondary,size: 20),),
                       // value: timeDilation != 1.0,
                        value: _valueEdl,
                        activeColor: colorSecondary,
                        onChanged: (bool? value) {
                          setState(() {
                            _valueEdl = value! ;
                          });
                        },
                        secondary:Image.asset('images/appimages/power-line.png'),
                      )
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          // boxShadow: [
                          //   BoxShadow(
                          //     color: Colors.black,
                          //     offset: const Offset(
                          //       3.0,
                          //       3.0,
                          //     ), //Offset
                          //     blurRadius: 10.0,
                          //     spreadRadius: 2.0,
                          //   ), //BoxShadow
                          //   BoxShadow(
                          //     color: Colors.white,
                          //     offset: const Offset(0.0, 0.0),
                          //     blurRadius: 0.0,
                          //     spreadRadius: 0.0,
                          //   ), //BoxShadow
                          // ],
                        ), //BoxDecoration

                        /** CheckboxListTile Widget **/
                        child:   CheckboxListTile(

                          title:  Text('Home Generator',style: boldTextStyle(color: _valueg1 == false ?  Colors.black45 : colorSecondary,size: 20),),
                          // value: timeDilation != 1.0,
                          value: _valueg1,
                          activeColor: colorSecondary,
                          onChanged: (bool? value) {
                            setState(() {
                              _valueg1 = value! ;
                            });
                          },
                          secondary: CircleAvatar(
                            backgroundColor: Colors.blueAccent.withOpacity(0.6),
radius: 30,
                            child:Image.asset('images/appimages/batteryg.png',) ,) ,
                        )
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          // boxShadow: [
                          //   BoxShadow(
                          //     color: Colors.black,
                          //     offset: const Offset(
                          //       3.0,
                          //       3.0,
                          //     ), //Offset
                          //     blurRadius: 10.0,
                          //     spreadRadius: 2.0,
                          //   ), //BoxShadow
                          //   BoxShadow(
                          //     color: Colors.white,
                          //     offset: const Offset(0.0, 0.0),
                          //     blurRadius: 0.0,
                          //     spreadRadius: 0.0,
                          //   ), //BoxShadow
                          // ],
                        ), //BoxDecoration

                        /** CheckboxListTile Widget **/
                        child:   CheckboxListTile(

                          title:  Text('District Generator',style: boldTextStyle(color: _valueg2 == false ?  Colors.black45 : colorSecondary,size: 20),),
                          // value: timeDilation != 1.0,
                          value: _valueg2,
                          activeColor: colorSecondary,

                          onChanged: (bool? value) {
                            setState(() {
                              _valueg2 = value! ;
                            });
                          },
                          secondary: Image.asset('images/appimages/electric-generator.png'),
                        )
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.all(12),
                          primary: colorSecondary,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                        ),
                        onPressed: () {
                          _trySubmitForm();
                        },
                        child: Text(
                          "Submit",
                          style: TextStyle(color: whiteColor, fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),)
          ],
        ),
      ),
    );
  }

}

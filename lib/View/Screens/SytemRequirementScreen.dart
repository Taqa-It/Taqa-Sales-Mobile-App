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
//import 'package:flutter_svg/svg.dart';
import 'package:nb_utils/nb_utils.dart';


import '../../Models/CountryModel.dart';
import '../../Models/FormData.dart';
import '../../Models/LoadAppliance.dart';
import '../../Services/DataManager.dart';
import '../../Services/GetCountryIPService.dart';
import '../../Utils/AppColors.dart';
import '../../Utils/AppImages.dart';
import '../../Utils/AppSettings.dart';
import '../Widgets/overlay.dart';
import 'ACInputsScreen.dart';
import 'googlemapsSimulator.dart';


class SytemRequirementScreen extends StatefulWidget {
List<String> clientform;
final Stream<String>? stream;

SytemRequirementScreen(this.clientform,this.stream);



  @override
  SytemRequirementScreenState createState() => SytemRequirementScreenState();
}

class SytemRequirementScreenState extends State<SytemRequirementScreen> {


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

  List<String> countriesList = ["ALWAYS",'Day','Night'];
  String dropdownValue = "Always";

  // fetchData() async {
  //   DataManager().loadCountries().then((country) {
  //     setState(() {
  //       dataList.clear();
  //       dataList.add(country);
  //       for (var c in dataList)
  //         for (var i = 0; i < c.countries.length; i++) {
  //           countriesList.add(c.countries[i]);
  //           debugPrint(countriesList[i].name + "   " + (countriesList[i].code));
  //         }
  //       dropdownValue = countriesList[1];
  //       GetCountryIP().getCurrentCountry().then((value) {
  //         setState(() {
  //           dropdownValue = countriesList
  //               .where((cn) => cn.name == value.toString())
  //               .first as Countries;
  //         });
  //       });
  //     });
  //   }).catchError((error) {
  //     debugPrint(error.toString());
  //   });
  // }
  GlobalKey _toolTipKey = GlobalKey();
  GlobalKey _toolTipKey2 = GlobalKey();  GlobalKey _toolTipKey3 = GlobalKey();

  List<LoadAppliance> appls=[];
  List<LoadAppliance> checkedappls=[];
int totalAppLoad=0;
  LocalStorage localStoragee =  LocalStorage('user_info');
  String _loc= '';
  String _area = '';
  String _load = '';
  bool? _valueRef = false;
  void getlocx() async{


    await localStoragee.ready;
    String xxx= localStoragee.getItem('ulocation').toString();
    String longlat= localStoragee.getItem('longitude').toString()+","+localStoragee.getItem('latitude').toString();


    setState(() {
      locationCont.text=xxx;
      _loc=longlat;

      //  areaCont.text=localStoragee.getItem('area').toString() == 'null' ? " " :localStoragee.getItem('area').toString() ;
      //  _area=localStoragee.getItem('area').toString() == 'null' ? " " :localStoragee.getItem('area').toString() ;
    });
  }
  void generateAppliances(){

    LoadAppliance Refrigerator = new LoadAppliance(applianceId:'1',  applianceName: 'Refrigerator',averagePower:	'500',	quantity:'1',timeUsed:	'ALWAYS',	dayNight:'ALWAYS', checked: false   );
    LoadAppliance RefrigeratorInverter = new LoadAppliance(applianceId:'2',  applianceName: 'Refrigerator Inverter',averagePower:	'200',	quantity:'1',timeUsed:	'ALWAYS',	dayNight:'ALWAYS', checked: false   );
    LoadAppliance Fridge = new LoadAppliance(applianceId:'3',  applianceName: 'Fridge',averagePower:	'400',	quantity:'1',timeUsed:	'ALWAYS',	dayNight:'ALWAYS' , checked: false  );
    LoadAppliance FridgeInverter = new LoadAppliance(applianceId:'4',  applianceName: 'Fridge Inverter',averagePower:	'120',	quantity:'1',timeUsed:	'ALWAYS',	dayNight:'Night'  , checked: false );
    LoadAppliance AC9000 = new LoadAppliance(applianceId:'5',  applianceName: 'AC 9000',averagePower:	'600',	quantity:'1',timeUsed:	'ALWAYS',	dayNight:'ALWAYS' , checked: false  );
    LoadAppliance AC9000Inverter = new LoadAppliance(applianceId:'6',  applianceName: 'AC 9000 Inverter',averagePower:	'200',	quantity:'1',timeUsed:	'ALWAYS',	dayNight:'ALWAYS' , checked: false  );
    LoadAppliance AC12000 = new LoadAppliance(applianceId:'7',  applianceName: 'AC 12000',averagePower:	'1000',	quantity:'1',timeUsed:	'ALWAYS',	dayNight:'ALWAYS' , checked: false  );
    LoadAppliance AC12000Inverter = new LoadAppliance(applianceId:'8',  applianceName: 'AC 12000 Inverter',averagePower:	'300',	quantity:'1',timeUsed:	'ALWAYS',	dayNight:'ALWAYS' , checked: false  );
    LoadAppliance AC18000 = new LoadAppliance(applianceId:'9',  applianceName: 'AC 18000',averagePower:	'2800',	quantity:'1',timeUsed:	'ALWAYS',	dayNight:'ALWAYS', checked: false   );
    LoadAppliance   AC18000Inverter = new LoadAppliance(applianceId:'10',  applianceName: 'AC 18000 Inverter',averagePower:	'1700',	quantity:'1',timeUsed:	'ALWAYS',	dayNight:'ALWAYS'  , checked: false );
    LoadAppliance AC24000 = new LoadAppliance(applianceId:'11',  applianceName: 'AC 24000',averagePower:	'3400',	quantity:'1',timeUsed:	'ALWAYS',	dayNight:'ALWAYS' , checked: false  );
    LoadAppliance  AC24000Inverter = new LoadAppliance(applianceId:'12',  applianceName: 'AC 24000 Inverter',averagePower:	'2600',	quantity:'1',timeUsed:	'ALWAYS',	dayNight:'ALWAYS', checked: false   );
    LoadAppliance Light = new LoadAppliance(applianceId:'13',  applianceName: 'Light',averagePower:	'30',	quantity:'1',timeUsed:	'ALWAYS',	dayNight:'ALWAYS' , checked: false  );
    LoadAppliance LED = new LoadAppliance(applianceId:'14',  applianceName: 'LED',averagePower:	'60',	quantity:'1',timeUsed:	'ALWAYS',	dayNight:'ALWAYS'  , checked: false );
    LoadAppliance Heater = new LoadAppliance(applianceId:'15',  applianceName: 'Heater',averagePower:	'1500',	quantity:'1',timeUsed:	'ALWAYS',	dayNight:'ALWAYS'   , checked: false);
    LoadAppliance Washingmachine = new LoadAppliance(applianceId:'16',  applianceName: 'Washing machine',averagePower:	'800',	quantity:'1',timeUsed:	'ALWAYS',	dayNight:'ALWAYS', checked: false   );
    LoadAppliance  Laundrydryer = new LoadAppliance(applianceId:'17',  applianceName: 'Laundry dryer',averagePower:	'2000',	quantity:'1',timeUsed:	'ALWAYS',	dayNight:'ALWAYS'  , checked: false );
    LoadAppliance Other = new LoadAppliance(applianceId:'19',  applianceName: 'Other',averagePower:	'100',	quantity:'1',timeUsed:	'ALWAYS',	dayNight:'ALWAYS', checked: false   );


    appls.add(Refrigerator);
    appls.add(RefrigeratorInverter);
    appls.add(Fridge);
    appls.add(FridgeInverter);
    appls.add(AC9000);
    appls.add(AC9000Inverter);
    appls.add(AC12000);
    appls.add(AC12000Inverter);
    appls.add(AC18000);
    appls.add(AC18000Inverter);
    appls.add(AC24000);
    appls.add(AC24000Inverter);
    appls.add(Light);
    appls.add(LED);
    appls.add(Heater);
    appls.add(Washingmachine);
    appls.add(Laundrydryer);
    appls.add(Other);

for(int i=0;i<appls.length;i++)
  print("trtrt+"+jsonEncode(appls[i]).toString());

  }
  void calculateTotalLoad(){
    totalAppLoad=0;
    for(int i=0;i<appls.length;i++)
      if(appls[i].checked==true)
      {
        //checkedappls.add(appls[i]);
        totalAppLoad += appls[i].averagePower.toInt() * appls[i].quantity.toInt();
      }
  }
  @override
  initState() {
    print("helooinitsys");
  //  _initialposition =  CameraPosition(target: LatLng(double.parse(localStorage.getItem('latitude').toString()), double.parse(localStorage.getItem('longitude').toString())), zoom: 19.0);
    widget.stream?.listen((index) {
      mySetState(index);
      print("timetotime from "+_area.toString());
      print("timetotime to "+_area.toString());
    });
  //  getloc();
    super.initState();
    //fetchData();

    getlocx();


    generateAppliances();
    SchedulerBinding.instance!.addPostFrameCallback((_) {
      // Flutter get callback here when screen initialized.
      final dynamic tooltip = _toolTipKey.currentState;
      tooltip.ensureTooltipVisible();


      final dynamic tooltip2 = _toolTipKey2.currentState;
      tooltip2.ensureTooltipVisible();


      final dynamic tooltip3 = _toolTipKey3.currentState;
      tooltip3.ensureTooltipVisible();
    });
  }
  void mySetState(String index) {
    setState(() {
      areaCont.text = index;
      _area = index;
      print("timetotime froOm " + areaCont.text.toString());
      print("timetotime toO " + areaCont.text.splitAfter(",").toString());
    });
  }
  Completer<GoogleMapController> _controller = Completer();
  String location = "Search Location";

  // Define a key to access the form
  final _formKey = GlobalKey<FormState>();


  // This function is triggered when the user press the "Sign Up" button
  void _trySubmitForm() {

    final bool? isValid = _formKey.currentState?.validate();
    if (isValid == true) {
      debugPrint('Everything looks good!');
      debugPrint(_loc);
      debugPrint(_area);
    //  List<String> appdata=[];
      var appdata=[];
      debugPrint(_load);
        for(int i=0;i<checkedappls.length;i++) {
          // appdata.add('[' + checkedappls[i].applianceName.toString() + "," +
          //     checkedappls[i].averagePower.toString() + "," +
          //     checkedappls[i].quantity.toString() + "," +
          //     checkedappls[i].timeUsed.toString() + "," +
          //     checkedappls[i].dayNight.toString() + ']');
          appdata.add(jsonEncode(checkedappls[i]));
        }

      for(int i=0;i<appdata.length;i++) {
        // appdata.add('[' + checkedappls[i].applianceName.toString() + "," +
        //     checkedappls[i].averagePower.toString() + "," +
        //     checkedappls[i].quantity.toString() + "," +
        //     checkedappls[i].timeUsed.toString() + "," +
        //     checkedappls[i].dayNight.toString() + ']');
      print( "bvbvbv"+ appdata[i]);
      }
      print(  appdata);
      // for(int i=0;i<checkedappls.length;i++) {
      //  print("bub" + appdata[i].toString());
      // }
      List<String> sysreq=[_loc,_area,_load];
 FormDataModel form2=new FormDataModel(userInfo: widget.clientform,systemReq:sysreq,applchecked: appdata);


     // localStoragee.setItem('area','');

      ACInputsScreen(form2).launch(context);

    }
  }


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

  void _showOverlay(BuildContext context) {
    Navigator.of(context).push(TutorialOverlay());
  }
  @override
  Widget build(BuildContext context) {


  // areaCont.text=localStoragee.getItem('area').toString() == 'null' ? " " :localStoragee.getItem('area').toString() ;
   // _area=localStoragee.getItem('area').toString() == 'null' ? " " :localStoragee.getItem('area').toString() ;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text("System Requirement"), backgroundColor: colorSecondary,),
        backgroundColor: colorSecondary,
        body: Stack(
          children: <Widget>[
            Column(children: [       Container(
              margin: EdgeInsets.only(top: 5),
              child: Align(
                alignment: Alignment.topCenter,
                // child: SvgPicture.asset(ic_logo, color: white.withOpacity(0.8), height: 150, width: 150),
                child:       Image.asset("images/appimages/solar-panels.png", height: 150),
                //commonCacheImageWidget(ic_logo_white, 150),
              ),
            ),
            Text("System Requirement",style: boldTextStyle(color: Colors.white,size: 25,fontFamily: 'Semibold'),)

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
    Stack(
    children: <Widget>[
    TextFormField(
  controller: locationCont,
  focusNode: locationFocusNode,
  keyboardType: TextInputType.text,
  textInputAction: TextInputAction.next,
      onTap: () async {
        // Prediction? p = await PlacesAutocomplete.show(
        //   context: context,
        //   radius: 10000000,
        //   types: [],
        //   strictbounds: false,
        //   apiKey: 'AIzaSyCAXCaiTtRVRVSXyf3IEOt0CTu_XkXDePE',
        //   mode: Mode.overlay,
        //   language: "eng",
        //   components: [Component(Component.country, "lb")],
        // );
        // setState(() { locationCont.text = p!.description.toString();});

      },
  onFieldSubmitted: (value) {
    FocusScope.of(context).requestFocus(areaFocusNode);
  },
  validator: (value) {


    if (value == null || value.trim().isEmpty) {
      return 'This field is required';
    }

    return null;
  },
  onChanged: (value) async {
    _loc = value;

    // Prediction? p = await PlacesAutocomplete.show(
    //   context: context,
    //   radius: 10000000,
    //   types: [],
    //   strictbounds: false,
    //   apiKey: 'AIzaSyCAXCaiTtRVRVSXyf3IEOt0CTu_XkXDePE',
    //   mode: Mode.overlay,
    //   language: "eng",
    //   components: [Component(Component.country, "lb")],
    // );
    // setState(() { locationCont.text = p!.description.toString();});
  } ,
  style: TextStyle(color: blackColor),
  decoration: InputDecoration(
    enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color:colorSecondary)),
    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: colorSecondary)),
    labelText: "Location",
    hintText: '',
    labelStyle: TextStyle(color: colorSecondary, fontSize: 14),
    suffixIcon: InkWell(child: Icon(Icons.my_location, color: colorSecondary, size: 25),

      onTap: () async {
        Prediction? p = await PlacesAutocomplete.show(
          context: context,
          radius: 10000000,
          types: [],
          strictbounds: false,
          apiKey: 'AIzaSyCAXCaiTtRVRVSXyf3IEOt0CTu_XkXDePE',
          mode: Mode.overlay,
          language: "eng",
          components: [Component(Component.country, "lb")],
        );
        GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: 'AIzaSyCAXCaiTtRVRVSXyf3IEOt0CTu_XkXDePE');
        var s= await _places.getDetailsByPlaceId(p!.placeId.toString());;
        setState(() { locationCont.text = p!.description.toString();

        _loc=s.result.geometry!.location.lat.toString()+" , "+s.result.geometry!.location.lng.toString();
        });



      },),
  ),
),







      Positioned(
        right: 0,
        top: 0,
        bottom: 20,
        child: Tooltip(
          key: _toolTipKey,

          message: "or click here to search a location",
          // child: Icon(
          //   Icons.info,
          //   size: 20,
          // ),
        ),
      ),


    ]),











          Stack(
          children: <Widget>[    TextFormField(
           // initialValue: localStoragee.getItem('area').toString() == null ? " " :localStoragee.getItem('area').toString(),

            controller: areaCont,
            focusNode: areaFocusNode,
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            onFieldSubmitted: (value) {
              FocusScope.of(context).requestFocus(loadFocusNode);
            },
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'This field is required';
              }
              // if (value.trim().length < 3) {
              //   return 'area must be a mu,brt';
              // }
              return null;
            },
            onChanged: (value) => _area = value,
            style: TextStyle(color: blackColor),
            decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color:colorSecondary)),
              focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: colorSecondary)),
              labelText: "Area",
              hintText: 'ex: 400 m2',
              labelStyle: TextStyle(color: colorSecondary, fontSize: 14),
              suffixIcon:     InkWell(child:Icon(Icons.map, color: colorSecondary, size: 25),

                  onTap: () async {
                googlemapsSimulator(  ).launch(context);


                //   _showOverlay(context);

                  }),


            ),
          ),Positioned(
            right: 0,
            top: 0,
            bottom: 20,
            child: Tooltip(
              key: _toolTipKey2,

              message: "or click here to calculate area from the simulator",
              // child: Icon(
              //   Icons.info,
              //   size: 20,
              // ),
            ),
          ),]),



                    Stack(
                        children: <Widget>[

                          TextFormField(
                       //   initialValue: '500',
                      controller: loadCont,
                      focusNode: loadFocusNode,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (value) {
                        //FocusScope.of(context).requestFocus(phoneFocusNode);
                      },
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'This field is required';
                              }
                              // if (value.trim().length < 3) {
                              //   return 'area must be a mu,brt';
                              // }
                              return null;
                            },
                      onChanged: (value) => _load = value,
                      style: TextStyle(color: blackColor),
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: colorSecondary)),
                        focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: colorSecondary)),
                        labelText: "Load",
                        labelStyle: TextStyle(color: colorSecondary, fontSize: 14),
                        suffixIcon:InkWell(child:Icon( Icons.home , color: colorSecondary, size: 25) ,onTap: (){

                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return
                                  StatefulBuilder ( builder: (context,setState)
                                  =>

                                      AlertDialog(
                                        title: Text('Calculate load from appliance'),
                                        actions: [
                                          new  TextButton(
                                            // textColor: Colors.black,
                                            onPressed: () {

                                              loadCont.text="456";
                                              Navigator.of(context).pop();
                                            },
                                            child: Text('Cancel'),
                                          ),
                                          new  TextButton(
                                            // textColor: Colors.black,
                                            onPressed: () {
                                              checkedappls=[];
                                              loadCont.text=totalAppLoad.toString();
                                              _load=totalAppLoad.toString();

                                              for(int i=0;i<appls.length;i++)
                                                  if(appls[i].checked==true)
                                                  {
                                                  checkedappls.add(appls[i]);}
                                              Navigator.of(context).pop();

                                            },
                                            child: Text('Done'),
                                          ),

                                                          ],






                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(16),
                                        ),
                                        elevation: 0.0,
                                        backgroundColor: Colors.white,
                                        content:
                                        Scrollbar(
                                          //   controller: controller2,
                                          isAlwaysShown: true,
                                          child: SingleChildScrollView(
                                            //  controller: controller2,
                                            scrollDirection: Axis.horizontal,
                                            child:

                                            SingleChildScrollView(
                                                child: DataTable(
                                                    columns: const <DataColumn>[
                                                      DataColumn(
                                                        label: Expanded(
                                                          child: Text(
                                                            'Appliance',
                                                            style: TextStyle(fontStyle: FontStyle.italic),
                                                          ),
                                                        ),
                                                      ),
                                                      DataColumn(
                                                        label: Expanded(
                                                          child: Text(
                                                            'Avrg \nPower',
                                                            style: TextStyle(fontStyle: FontStyle.italic),
                                                          ),
                                                        ),
                                                      ),
                                                      DataColumn(
                                                        label: Expanded(
                                                          child: Text(
                                                            'Quantity',
                                                            style: TextStyle(fontStyle: FontStyle.italic),
                                                          ),
                                                        ),
                                                      ),
                                                      DataColumn(
                                                        label: Expanded(
                                                          child: Text(
                                                            'Time \n used',
                                                            style: TextStyle(fontStyle: FontStyle.italic),
                                                          ),
                                                        ),
                                                      ),
                                                      DataColumn(
                                                        label: Expanded(
                                                          child: Text(
                                                            'Day/Night',
                                                            style: TextStyle(fontStyle: FontStyle.italic),
                                                          ),
                                                        ),
                                                      ),
                                                      DataColumn(
                                                        label: Expanded(
                                                          child: Text(
                                                            '',
                                                            style: TextStyle(fontStyle: FontStyle.italic),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                    rows:  <DataRow>[
                                                      for(int i=0; i<appls.length;i++)
                                                      DataRow(
                                                        cells: <DataCell>[
                                                          DataCell(Text(appls[i].applianceName)),
                                                          DataCell(
                                                              TextFormField(
                                                                initialValue: appls[i].averagePower,
                                                                style: TextStyle(fontSize: 14),


                                                                onChanged: (value) {
                                                                  appls[i].averagePower = value;
                                                                  calculateTotalLoad();

                                                                }
                                                              )

                                                          ),
                                                          DataCell(TextFormField(initialValue: appls[i].quantity,keyboardType: TextInputType.number,
                                                              style: TextStyle(fontSize: 14),
                                                              onChanged: (value) {
                                                                appls[i].quantity = value;
                                                                calculateTotalLoad();

                                                              }

                                                          )),
                                                          DataCell(TextFormField(initialValue: appls[i].timeUsed,keyboardType: TextInputType.number,
                                                              style: TextStyle(fontSize: 14),
                                                              onChanged: (value) {
                                                                appls[i].timeUsed = value;
                                                                calculateTotalLoad();

                                                              })),
                                                          DataCell(
                                                              Theme(

                                                                data: Theme.of(context).copyWith(
                                                                  canvasColor: Colors.white,
                                                                  primaryColor: Colors.black,
                                                                  accentColor: Colors.black,
                                                                  hintColor: Colors.black,
                                                                  // textSelectionColor: Colors.black,
                                                                  toggleableActiveColor: colorSecondary,
                                                                  //  cursorColor: Colors.black,
                                                                  textTheme: TextTheme(
                                                                    headline5: TextStyle(color: colorSecondary),
                                                                    headline6: TextStyle(color:colorSecondary),
                                                                  ),
                                                                  inputDecorationTheme: InputDecorationTheme(
                                                                    enabledBorder: UnderlineInputBorder(
                                                                      borderSide: BorderSide(color: colorSecondary),
                                                                    ),
                                                                    focusedBorder: UnderlineInputBorder(
                                                                      borderSide: BorderSide(color: colorSecondary),
                                                                    ),
                                                                    border: UnderlineInputBorder(
                                                                      borderSide: BorderSide(color: colorSecondary),
                                                                    ),
                                                                  ),
                                                                ),
                                                                child:

                                                                DropdownButtonFormField<String>(
                                                                  isExpanded: true,
                                                                  elevation: 10,
                                                                  focusColor: colorSecondary,
                                                                  value:   appls[i].dayNight,
                                                                  icon: Icon(Icons.arrow_drop_down,color: colorSecondary, size: 34),
                                                                  // underline: Container(
                                                                  //   height: 2,
                                                                  //   color: colorPrimary,
                                                                  // ),
                                                                  onChanged: ( data) {
                                                                    setState(() {
                                                                      appls[i].dayNight = data! ;
                                                                      //_country=data.name;
                                                                    });
                                                                  },
                                                                  items: countriesList.map<DropdownMenuItem<String>>((String value) {
                                                                    //   String flagName= 'images/flags/'+value.code.toLowerCase()+".png";
                                                                    return DropdownMenuItem<String>(
                                                                      value: value,
                                                                      child: Row(
                                                                          children: <Widget>[
                                                                        //   Image.asset(flagName, height: 15, fit: BoxFit.cover),
                                                                        Text(value.toString(),
                                                                            style:TextStyle(color:blackColor, fontSize: 14)),
                                                                      ]),
                                                                    );
                                                                  }).toList(),
                                                                ),

                                                              )),
                                                          DataCell( CheckboxListTile(

                                                            title:  Text('',style: boldTextStyle(color: colorSecondary,size: 0),),
                                                            // value: timeDilation != 1.0,
                                                            value:   appls[i].checked,
                                                            activeColor: colorSecondary,

                                                            secondary:Image.asset('images/appimages/power-line.png',color: Colors.transparent,height: 0,width: 0,),
                                                            onChanged: (bool? value) {

                                                              setState(() {
                                                                appls[i].checked = value! ;
                                                                calculateTotalLoad();
                                                              });
                                                            },
                                                          )),
                                                        ],
                                                      ),
                                                      // DataRow(
                                                      //   cells: <DataCell>[
                                                      //     DataCell(Text('Refrigerator\nInverter')),
                                                      //     DataCell(
                                                      //         TextFormField(initialValue: '200',
                                                      //             style: TextStyle(fontSize: 14))
                                                      //
                                                      //     ),
                                                      //     DataCell(TextFormField(initialValue: '1',keyboardType: TextInputType.number,
                                                      //         style: TextStyle(fontSize: 14))),
                                                      //     DataCell(TextFormField(initialValue: 'Always',keyboardType: TextInputType.number,
                                                      //         style: TextStyle(fontSize: 14))),
                                                      //     DataCell(
                                                      //         Theme(
                                                      //
                                                      //           data: Theme.of(context).copyWith(
                                                      //             canvasColor: Colors.white,
                                                      //             primaryColor: Colors.black,
                                                      //             accentColor: Colors.black,
                                                      //             hintColor: Colors.black,
                                                      //             // textSelectionColor: Colors.black,
                                                      //             toggleableActiveColor: colorSecondary,
                                                      //             //  cursorColor: Colors.black,
                                                      //             textTheme: TextTheme(
                                                      //               headline5: TextStyle(color: colorSecondary),
                                                      //               headline6: TextStyle(color:colorSecondary),
                                                      //             ),
                                                      //             inputDecorationTheme: InputDecorationTheme(
                                                      //               enabledBorder: UnderlineInputBorder(
                                                      //                 borderSide: BorderSide(color: colorSecondary),
                                                      //               ),
                                                      //               focusedBorder: UnderlineInputBorder(
                                                      //                 borderSide: BorderSide(color: colorSecondary),
                                                      //               ),
                                                      //               border: UnderlineInputBorder(
                                                      //                 borderSide: BorderSide(color: colorSecondary),
                                                      //               ),
                                                      //             ),
                                                      //           ),
                                                      //           child:
                                                      //
                                                      //           DropdownButtonFormField<String>(
                                                      //             isExpanded: true,
                                                      //             elevation: 10,
                                                      //             focusColor: colorSecondary,
                                                      //             value: dropdownValue,
                                                      //             icon: Icon(Icons.arrow_drop_down,color: colorSecondary, size: 34),
                                                      //             // underline: Container(
                                                      //             //   height: 2,
                                                      //             //   color: colorPrimary,
                                                      //             // ),
                                                      //             onChanged: ( data) {
                                                      //               setState(() {
                                                      //                 dropdownValue = data! ;
                                                      //                 //_country=data.name;
                                                      //               });
                                                      //             },
                                                      //             items: countriesList.map<DropdownMenuItem<String>>((String value) {
                                                      //               //   String flagName= 'images/flags/'+value.code.toLowerCase()+".png";
                                                      //               return DropdownMenuItem<String>(
                                                      //                 value: value,
                                                      //                 child: Row(    children: <Widget>[
                                                      //                   //   Image.asset(flagName, height: 15, fit: BoxFit.cover),
                                                      //                   Text(value.toString(),style:TextStyle(color:blackColor, fontSize: 14)),
                                                      //                 ]),
                                                      //               );
                                                      //             }).toList(),
                                                      //           ),
                                                      //
                                                      //         )),
                                                      //     DataCell( CheckboxListTile(
                                                      //
                                                      //       title:  Text('',style: boldTextStyle(color: colorSecondary,size: 20),),
                                                      //       // value: timeDilation != 1.0,
                                                      //       value:  _valueRef,
                                                      //       activeColor: colorSecondary,
                                                      //
                                                      //       secondary:Image.asset('images/appimages/power-line.png',color: Colors.transparent,),
                                                      //       onChanged: (bool? value) {
                                                      //         print("tPTAPAT[");
                                                      //         setState(() {
                                                      //           _valueRef = value! ;
                                                      //         });
                                                      //       },
                                                      //     )),
                                                      //   ],
                                                      // ),
                                                      // DataRow(
                                                      //   cells: <DataCell>[
                                                      //     DataCell(Text('Fridge')),
                                                      //     DataCell(TextFormField(initialValue: '400', style: TextStyle(fontSize: 14))
                                                      //
                                                      //     ),
                                                      //     DataCell(TextFormField(initialValue: '1',keyboardType: TextInputType.number, style: TextStyle(fontSize: 14))),
                                                      //     DataCell(TextFormField(initialValue: 'Always',keyboardType: TextInputType.number,
                                                      //         style: TextStyle(fontSize: 14))),
                                                      //     DataCell(Theme(
                                                      //           data: Theme.of(context).copyWith(
                                                      //             canvasColor: Colors.white,
                                                      //             primaryColor: Colors.black,
                                                      //             accentColor: Colors.black,
                                                      //             hintColor: Colors.black,
                                                      //             // textSelectionColor: Colors.black,
                                                      //             toggleableActiveColor: colorSecondary,
                                                      //             //  cursorColor: Colors.black,
                                                      //             textTheme: TextTheme(
                                                      //               headline5: TextStyle(color: colorSecondary),
                                                      //               headline6: TextStyle(color:colorSecondary),
                                                      //             ),
                                                      //             inputDecorationTheme: InputDecorationTheme(
                                                      //               enabledBorder: UnderlineInputBorder(
                                                      //                 borderSide: BorderSide(color: colorSecondary),
                                                      //               ),
                                                      //               focusedBorder: UnderlineInputBorder(
                                                      //                 borderSide: BorderSide(color: colorSecondary),
                                                      //               ),
                                                      //               border: UnderlineInputBorder(
                                                      //                 borderSide: BorderSide(color: colorSecondary),
                                                      //               ),
                                                      //             ),
                                                      //           ),
                                                      //           child:
                                                      //
                                                      //           DropdownButtonFormField<String>(
                                                      //             isExpanded: true,
                                                      //             elevation: 10,
                                                      //             focusColor: colorSecondary,
                                                      //             value: dropdownValue,
                                                      //             icon: Icon(Icons.arrow_drop_down,color: colorSecondary, size: 34),
                                                      //             // underline: Container(
                                                      //             //   height: 2,
                                                      //             //   color: colorPrimary,
                                                      //             // ),
                                                      //             onChanged: ( data) {
                                                      //               setState(() {
                                                      //                 dropdownValue = data! ;
                                                      //                 //_country=data.name;
                                                      //               });
                                                      //             },
                                                      //             items: countriesList.map<DropdownMenuItem<String>>((String value) {
                                                      //               //   String flagName= 'images/flags/'+value.code.toLowerCase()+".png";
                                                      //               return DropdownMenuItem<String>(
                                                      //                 value: value,
                                                      //                 child: Row(    children: <Widget>[
                                                      //                   //   Image.asset(flagName, height: 15, fit: BoxFit.cover),
                                                      //                   Text(value.toString(),style:TextStyle(color:blackColor, fontSize: 14)),
                                                      //                 ]),
                                                      //               );
                                                      //             }).toList(),
                                                      //           ),
                                                      //
                                                      //         )),
                                                      //     DataCell( CheckboxListTile(
                                                      //
                                                      //       title:  Text('',style: boldTextStyle(color: colorSecondary,size: 20),),
                                                      //       // value: timeDilation != 1.0,
                                                      //       value:  _valueRef,
                                                      //       activeColor: colorSecondary,
                                                      //
                                                      //       secondary:Image.asset('images/appimages/power-line.png',color: Colors.transparent,),
                                                      //       onChanged: (bool? value) {
                                                      //         print("tPTAPAT[");
                                                      //         setState(() {
                                                      //           _valueRef = value! ;
                                                      //         });
                                                      //       },
                                                      //     )),
                                                      //   ],
                                                      // ),
                                                      // DataRow(
                                                      //   cells: <DataCell>[
                                                      //     DataCell(Text('Fridge\nInverter')),
                                                      //     DataCell(
                                                      //         TextFormField(initialValue: '120',
                                                      //             style: TextStyle(fontSize: 14))
                                                      //
                                                      //     ),
                                                      //     DataCell(TextFormField(initialValue: '1',keyboardType: TextInputType.number,
                                                      //         style: TextStyle(fontSize: 14))),
                                                      //     DataCell(TextFormField(initialValue: 'Always',keyboardType: TextInputType.number,
                                                      //         style: TextStyle(fontSize: 14))),
                                                      //     DataCell(
                                                      //         Theme(
                                                      //
                                                      //           data: Theme.of(context).copyWith(
                                                      //             canvasColor: Colors.white,
                                                      //             primaryColor: Colors.black,
                                                      //             accentColor: Colors.black,
                                                      //             hintColor: Colors.black,
                                                      //             // textSelectionColor: Colors.black,
                                                      //             toggleableActiveColor: colorSecondary,
                                                      //             //  cursorColor: Colors.black,
                                                      //             textTheme: TextTheme(
                                                      //               headline5: TextStyle(color: colorSecondary),
                                                      //               headline6: TextStyle(color:colorSecondary),
                                                      //             ),
                                                      //             inputDecorationTheme: InputDecorationTheme(
                                                      //               enabledBorder: UnderlineInputBorder(
                                                      //                 borderSide: BorderSide(color: colorSecondary),
                                                      //               ),
                                                      //               focusedBorder: UnderlineInputBorder(
                                                      //                 borderSide: BorderSide(color: colorSecondary),
                                                      //               ),
                                                      //               border: UnderlineInputBorder(
                                                      //                 borderSide: BorderSide(color: colorSecondary),
                                                      //               ),
                                                      //             ),
                                                      //           ),
                                                      //           child:
                                                      //
                                                      //           DropdownButtonFormField<String>(
                                                      //             isExpanded: true,
                                                      //             elevation: 10,
                                                      //             focusColor: colorSecondary,
                                                      //             value: dropdownValue,
                                                      //             icon: Icon(Icons.arrow_drop_down,color: colorSecondary, size: 34),
                                                      //             // underline: Container(
                                                      //             //   height: 2,
                                                      //             //   color: colorPrimary,
                                                      //             // ),
                                                      //             onChanged: ( data) {
                                                      //               setState(() {
                                                      //                 dropdownValue = data! ;
                                                      //                 //_country=data.name;
                                                      //               });
                                                      //             },
                                                      //             items: countriesList.map<DropdownMenuItem<String>>((String value) {
                                                      //               //   String flagName= 'images/flags/'+value.code.toLowerCase()+".png";
                                                      //               return DropdownMenuItem<String>(
                                                      //                 value: value,
                                                      //                 child: Row(    children: <Widget>[
                                                      //                   //   Image.asset(flagName, height: 15, fit: BoxFit.cover),
                                                      //                   Text(value.toString(),style:TextStyle(color:blackColor, fontSize: 14)),
                                                      //                 ]),
                                                      //               );
                                                      //             }).toList(),
                                                      //           ),
                                                      //
                                                      //         )),
                                                      //     DataCell( CheckboxListTile(
                                                      //
                                                      //       title:  Text('',style: boldTextStyle(color: colorSecondary,size: 20),),
                                                      //       // value: timeDilation != 1.0,
                                                      //       value:  _valueRef,
                                                      //       activeColor: colorSecondary,
                                                      //
                                                      //       secondary:Image.asset('images/appimages/power-line.png',color: Colors.transparent,),
                                                      //       onChanged: (bool? value) {
                                                      //         print("tPTAPAT[");
                                                      //         setState(() {
                                                      //           _valueRef = value! ;
                                                      //         });
                                                      //       },
                                                      //     )),
                                                      //   ],
                                                      // ),
                                                      // DataRow(
                                                      //   cells: <DataCell>[
                                                      //     DataCell(Text('AC 9000')),
                                                      //     DataCell(
                                                      //         TextFormField(initialValue: '600',
                                                      //             style: TextStyle(fontSize: 14))
                                                      //
                                                      //     ),
                                                      //     DataCell(TextFormField(initialValue: '1',keyboardType: TextInputType.number,
                                                      //         style: TextStyle(fontSize: 14))),
                                                      //     DataCell(TextFormField(initialValue: 'Always',keyboardType: TextInputType.number,
                                                      //         style: TextStyle(fontSize: 14))),
                                                      //     DataCell(
                                                      //         Theme(
                                                      //
                                                      //           data: Theme.of(context).copyWith(
                                                      //             canvasColor: Colors.white,
                                                      //             primaryColor: Colors.black,
                                                      //             accentColor: Colors.black,
                                                      //             hintColor: Colors.black,
                                                      //             // textSelectionColor: Colors.black,
                                                      //             toggleableActiveColor: colorSecondary,
                                                      //             //  cursorColor: Colors.black,
                                                      //             textTheme: TextTheme(
                                                      //               headline5: TextStyle(color: colorSecondary),
                                                      //               headline6: TextStyle(color:colorSecondary),
                                                      //             ),
                                                      //             inputDecorationTheme: InputDecorationTheme(
                                                      //               enabledBorder: UnderlineInputBorder(
                                                      //                 borderSide: BorderSide(color: colorSecondary),
                                                      //               ),
                                                      //               focusedBorder: UnderlineInputBorder(
                                                      //                 borderSide: BorderSide(color: colorSecondary),
                                                      //               ),
                                                      //               border: UnderlineInputBorder(
                                                      //                 borderSide: BorderSide(color: colorSecondary),
                                                      //               ),
                                                      //             ),
                                                      //           ),
                                                      //           child:
                                                      //
                                                      //           DropdownButtonFormField<String>(
                                                      //             isExpanded: true,
                                                      //             elevation: 10,
                                                      //             focusColor: colorSecondary,
                                                      //             value: dropdownValue,
                                                      //             icon: Icon(Icons.arrow_drop_down,color: colorSecondary, size: 34),
                                                      //             // underline: Container(
                                                      //             //   height: 2,
                                                      //             //   color: colorPrimary,
                                                      //             // ),
                                                      //             onChanged: ( data) {
                                                      //               setState(() {
                                                      //                 dropdownValue = data! ;
                                                      //                 //_country=data.name;
                                                      //               });
                                                      //             },
                                                      //             items: countriesList.map<DropdownMenuItem<String>>((String value) {
                                                      //               //   String flagName= 'images/flags/'+value.code.toLowerCase()+".png";
                                                      //               return DropdownMenuItem<String>(
                                                      //                 value: value,
                                                      //                 child: Row(    children: <Widget>[
                                                      //                   //   Image.asset(flagName, height: 15, fit: BoxFit.cover),
                                                      //                   Text(value.toString(),style:TextStyle(color:blackColor, fontSize: 14)),
                                                      //                 ]),
                                                      //               );
                                                      //             }).toList(),
                                                      //           ),
                                                      //
                                                      //         )
                                                      //     ),
                                                      //     DataCell( CheckboxListTile(
                                                      //
                                                      //       title:  Text('',style: boldTextStyle(color: colorSecondary,size: 20),),
                                                      //       // value: timeDilation != 1.0,
                                                      //       value:  _valueRef,
                                                      //       activeColor: colorSecondary,
                                                      //
                                                      //       secondary:Image.asset('images/appimages/power-line.png',color: Colors.transparent,),
                                                      //       onChanged: (bool? value) {
                                                      //         print("tPTAPAT[");
                                                      //         setState(() {
                                                      //           _valueRef = value! ;
                                                      //         });
                                                      //       },
                                                      //     )),
                                                      //   ],
                                                      // ),
                                                      // DataRow(
                                                      //   cells: <DataCell>[
                                                      //     DataCell(Text('AC 9000\nInverter')),
                                                      //     DataCell(
                                                      //         TextFormField(initialValue: '200',
                                                      //             style: TextStyle(fontSize: 14))
                                                      //
                                                      //     ),
                                                      //     DataCell(TextFormField(initialValue: '1',keyboardType: TextInputType.number,
                                                      //         style: TextStyle(fontSize: 14))),
                                                      //     DataCell(TextFormField(initialValue: 'Always',keyboardType: TextInputType.number,
                                                      //         style: TextStyle(fontSize: 14))),
                                                      //     DataCell(
                                                      //         Theme(
                                                      //
                                                      //           data: Theme.of(context).copyWith(
                                                      //             canvasColor: Colors.white,
                                                      //             primaryColor: Colors.black,
                                                      //             accentColor: Colors.black,
                                                      //             hintColor: Colors.black,
                                                      //             // textSelectionColor: Colors.black,
                                                      //             toggleableActiveColor: colorSecondary,
                                                      //             //  cursorColor: Colors.black,
                                                      //             textTheme: TextTheme(
                                                      //               headline5: TextStyle(color: colorSecondary),
                                                      //               headline6: TextStyle(color:colorSecondary),
                                                      //             ),
                                                      //             inputDecorationTheme: InputDecorationTheme(
                                                      //               enabledBorder: UnderlineInputBorder(
                                                      //                 borderSide: BorderSide(color: colorSecondary),
                                                      //               ),
                                                      //               focusedBorder: UnderlineInputBorder(
                                                      //                 borderSide: BorderSide(color: colorSecondary),
                                                      //               ),
                                                      //               border: UnderlineInputBorder(
                                                      //                 borderSide: BorderSide(color: colorSecondary),
                                                      //               ),
                                                      //             ),
                                                      //           ),
                                                      //           child:
                                                      //
                                                      //           DropdownButtonFormField<String>(
                                                      //             isExpanded: true,
                                                      //             elevation: 10,
                                                      //             focusColor: colorSecondary,
                                                      //             value: dropdownValue,
                                                      //             icon: Icon(Icons.arrow_drop_down,color: colorSecondary, size: 34),
                                                      //             // underline: Container(
                                                      //             //   height: 2,
                                                      //             //   color: colorPrimary,
                                                      //             // ),
                                                      //             onChanged: ( data) {
                                                      //               setState(() {
                                                      //                 dropdownValue = data! ;
                                                      //                 //_country=data.name;
                                                      //               });
                                                      //             },
                                                      //             items: countriesList.map<DropdownMenuItem<String>>((String value) {
                                                      //               //   String flagName= 'images/flags/'+value.code.toLowerCase()+".png";
                                                      //               return DropdownMenuItem<String>(
                                                      //                 value: value,
                                                      //                 child: Row(    children: <Widget>[
                                                      //                   //   Image.asset(flagName, height: 15, fit: BoxFit.cover),
                                                      //                   Text(value.toString(),style:TextStyle(color:blackColor, fontSize: 14)),
                                                      //                 ]),
                                                      //               );
                                                      //             }).toList(),
                                                      //           ),
                                                      //
                                                      //         )),
                                                      //     DataCell( CheckboxListTile(
                                                      //
                                                      //       title:  Text('',style: boldTextStyle(color: colorSecondary,size: 20),),
                                                      //       // value: timeDilation != 1.0,
                                                      //       value:  _valueRef,
                                                      //       activeColor: colorSecondary,
                                                      //
                                                      //       secondary:Image.asset('images/appimages/power-line.png',color: Colors.transparent,),
                                                      //       onChanged: (bool? value) {
                                                      //         print("tPTAPAT[");
                                                      //         setState(() {
                                                      //           _valueRef = value! ;
                                                      //         });
                                                      //       },
                                                      //     )),
                                                      //   ],
                                                      // ),
                                                      // DataRow(
                                                      //   cells: <DataCell>[
                                                      //     DataCell(Text('AC 12000')),
                                                      //     DataCell(
                                                      //         TextFormField(initialValue: '1000',
                                                      //             style: TextStyle(fontSize: 14))
                                                      //
                                                      //     ),
                                                      //     DataCell(TextFormField(initialValue: '1',keyboardType: TextInputType.number,
                                                      //         style: TextStyle(fontSize: 14))),
                                                      //     DataCell(TextFormField(initialValue: 'Always',keyboardType: TextInputType.number,
                                                      //         style: TextStyle(fontSize: 14))),
                                                      //     DataCell(
                                                      //         Theme(
                                                      //
                                                      //           data: Theme.of(context).copyWith(
                                                      //             canvasColor: Colors.white,
                                                      //             primaryColor: Colors.black,
                                                      //             accentColor: Colors.black,
                                                      //             hintColor: Colors.black,
                                                      //             // textSelectionColor: Colors.black,
                                                      //             toggleableActiveColor: colorSecondary,
                                                      //             //  cursorColor: Colors.black,
                                                      //             textTheme: TextTheme(
                                                      //               headline5: TextStyle(color: colorSecondary),
                                                      //               headline6: TextStyle(color:colorSecondary),
                                                      //             ),
                                                      //             inputDecorationTheme: InputDecorationTheme(
                                                      //               enabledBorder: UnderlineInputBorder(
                                                      //                 borderSide: BorderSide(color: colorSecondary),
                                                      //               ),
                                                      //               focusedBorder: UnderlineInputBorder(
                                                      //                 borderSide: BorderSide(color: colorSecondary),
                                                      //               ),
                                                      //               border: UnderlineInputBorder(
                                                      //                 borderSide: BorderSide(color: colorSecondary),
                                                      //               ),
                                                      //             ),
                                                      //           ),
                                                      //           child:
                                                      //
                                                      //           DropdownButtonFormField<String>(
                                                      //             isExpanded: true,
                                                      //             elevation: 10,
                                                      //             focusColor: colorSecondary,
                                                      //             value: dropdownValue,
                                                      //             icon: Icon(Icons.arrow_drop_down,color: colorSecondary, size: 34),
                                                      //             // underline: Container(
                                                      //             //   height: 2,
                                                      //             //   color: colorPrimary,
                                                      //             // ),
                                                      //             onChanged: ( data) {
                                                      //               setState(() {
                                                      //                 dropdownValue = data! ;
                                                      //                 //_country=data.name;
                                                      //               });
                                                      //             },
                                                      //             items: countriesList.map<DropdownMenuItem<String>>((String value) {
                                                      //               //   String flagName= 'images/flags/'+value.code.toLowerCase()+".png";
                                                      //               return DropdownMenuItem<String>(
                                                      //                 value: value,
                                                      //                 child: Row(    children: <Widget>[
                                                      //                   //   Image.asset(flagName, height: 15, fit: BoxFit.cover),
                                                      //                   Text(value.toString(),style:TextStyle(color:blackColor, fontSize: 14)),
                                                      //                 ]),
                                                      //               );
                                                      //             }).toList(),
                                                      //           ),
                                                      //
                                                      //         )),
                                                      //     DataCell( CheckboxListTile(
                                                      //
                                                      //       title:  Text('',style: boldTextStyle(color: colorSecondary,size: 20),),
                                                      //       // value: timeDilation != 1.0,
                                                      //       value:  _valueRef,
                                                      //       activeColor: colorSecondary,
                                                      //
                                                      //       secondary:Image.asset('images/appimages/power-line.png',color: Colors.transparent,),
                                                      //       onChanged: (bool? value) {
                                                      //         print("tPTAPAT[");
                                                      //         setState(() {
                                                      //           _valueRef = value! ;
                                                      //         });
                                                      //       },
                                                      //     )),
                                                      //   ],
                                                      // ),
                                                      // DataRow(
                                                      //   cells: <DataCell>[
                                                      //     DataCell(Text('AC 12000\nInverter')),
                                                      //     DataCell(
                                                      //         TextFormField(initialValue: '300',
                                                      //             style: TextStyle(fontSize: 14))
                                                      //
                                                      //     ),
                                                      //     DataCell(TextFormField(initialValue: '1',keyboardType: TextInputType.number,
                                                      //         style: TextStyle(fontSize: 14))),
                                                      //     DataCell(TextFormField(initialValue: 'Always',keyboardType: TextInputType.number,
                                                      //         style: TextStyle(fontSize: 14))),
                                                      //     DataCell(
                                                      //         Theme(
                                                      //
                                                      //           data: Theme.of(context).copyWith(
                                                      //             canvasColor: Colors.white,
                                                      //             primaryColor: Colors.black,
                                                      //             accentColor: Colors.black,
                                                      //             hintColor: Colors.black,
                                                      //             // textSelectionColor: Colors.black,
                                                      //             toggleableActiveColor: colorSecondary,
                                                      //             //  cursorColor: Colors.black,
                                                      //             textTheme: TextTheme(
                                                      //               headline5: TextStyle(color: colorSecondary),
                                                      //               headline6: TextStyle(color:colorSecondary),
                                                      //             ),
                                                      //             inputDecorationTheme: InputDecorationTheme(
                                                      //               enabledBorder: UnderlineInputBorder(
                                                      //                 borderSide: BorderSide(color: colorSecondary),
                                                      //               ),
                                                      //               focusedBorder: UnderlineInputBorder(
                                                      //                 borderSide: BorderSide(color: colorSecondary),
                                                      //               ),
                                                      //               border: UnderlineInputBorder(
                                                      //                 borderSide: BorderSide(color: colorSecondary),
                                                      //               ),
                                                      //             ),
                                                      //           ),
                                                      //           child:
                                                      //
                                                      //           DropdownButtonFormField<String>(
                                                      //             isExpanded: true,
                                                      //             elevation: 10,
                                                      //             focusColor: colorSecondary,
                                                      //             value: dropdownValue,
                                                      //             icon: Icon(Icons.arrow_drop_down,color: colorSecondary, size: 34),
                                                      //             // underline: Container(
                                                      //             //   height: 2,
                                                      //             //   color: colorPrimary,
                                                      //             // ),
                                                      //             onChanged: ( data) {
                                                      //               setState(() {
                                                      //                 dropdownValue = data! ;
                                                      //                 //_country=data.name;
                                                      //               });
                                                      //             },
                                                      //             items: countriesList.map<DropdownMenuItem<String>>((String value) {
                                                      //               //   String flagName= 'images/flags/'+value.code.toLowerCase()+".png";
                                                      //               return DropdownMenuItem<String>(
                                                      //                 value: value,
                                                      //                 child: Row(    children: <Widget>[
                                                      //                   //   Image.asset(flagName, height: 15, fit: BoxFit.cover),
                                                      //                   Text(value.toString(),style:TextStyle(color:blackColor, fontSize: 14)),
                                                      //                 ]),
                                                      //               );
                                                      //             }).toList(),
                                                      //           ),
                                                      //
                                                      //         )),
                                                      //     DataCell( CheckboxListTile(
                                                      //
                                                      //       title:  Text('',style: boldTextStyle(color: colorSecondary,size: 20),),
                                                      //       // value: timeDilation != 1.0,
                                                      //       value:  _valueRef,
                                                      //       activeColor: colorSecondary,
                                                      //
                                                      //       secondary:Image.asset('images/appimages/power-line.png',color: Colors.transparent,),
                                                      //       onChanged: (bool? value) {
                                                      //         print("tPTAPAT[");
                                                      //         setState(() {
                                                      //           _valueRef = value! ;
                                                      //         });
                                                      //       },
                                                      //     )),
                                                      //   ],
                                                      // ),
                                                      // DataRow(
                                                      //   cells: <DataCell>[
                                                      //     DataCell(Text('AC 18000')),
                                                      //     DataCell(
                                                      //         TextFormField(initialValue: '2800',
                                                      //             style: TextStyle(fontSize: 14))
                                                      //
                                                      //     ),
                                                      //     DataCell(TextFormField(initialValue: '1',keyboardType: TextInputType.number,
                                                      //         style: TextStyle(fontSize: 14))),
                                                      //     DataCell(TextFormField(initialValue: 'Always',keyboardType: TextInputType.number,
                                                      //         style: TextStyle(fontSize: 14))),
                                                      //     DataCell(
                                                      //         Theme(
                                                      //
                                                      //           data: Theme.of(context).copyWith(
                                                      //             canvasColor: Colors.white,
                                                      //             primaryColor: Colors.black,
                                                      //             accentColor: Colors.black,
                                                      //             hintColor: Colors.black,
                                                      //             // textSelectionColor: Colors.black,
                                                      //             toggleableActiveColor: colorSecondary,
                                                      //             //  cursorColor: Colors.black,
                                                      //             textTheme: TextTheme(
                                                      //               headline5: TextStyle(color: colorSecondary),
                                                      //               headline6: TextStyle(color:colorSecondary),
                                                      //             ),
                                                      //             inputDecorationTheme: InputDecorationTheme(
                                                      //               enabledBorder: UnderlineInputBorder(
                                                      //                 borderSide: BorderSide(color: colorSecondary),
                                                      //               ),
                                                      //               focusedBorder: UnderlineInputBorder(
                                                      //                 borderSide: BorderSide(color: colorSecondary),
                                                      //               ),
                                                      //               border: UnderlineInputBorder(
                                                      //                 borderSide: BorderSide(color: colorSecondary),
                                                      //               ),
                                                      //             ),
                                                      //           ),
                                                      //           child:
                                                      //
                                                      //           DropdownButtonFormField<String>(
                                                      //             isExpanded: true,
                                                      //             elevation: 10,
                                                      //             focusColor: colorSecondary,
                                                      //             value: dropdownValue,
                                                      //             icon: Icon(Icons.arrow_drop_down,color: colorSecondary, size: 34),
                                                      //             // underline: Container(
                                                      //             //   height: 2,
                                                      //             //   color: colorPrimary,
                                                      //             // ),
                                                      //             onChanged: ( data) {
                                                      //               setState(() {
                                                      //                 dropdownValue = data! ;
                                                      //                 //_country=data.name;
                                                      //               });
                                                      //             },
                                                      //             items: countriesList.map<DropdownMenuItem<String>>((String value) {
                                                      //               //   String flagName= 'images/flags/'+value.code.toLowerCase()+".png";
                                                      //               return DropdownMenuItem<String>(
                                                      //                 value: value,
                                                      //                 child: Row(    children: <Widget>[
                                                      //                   //   Image.asset(flagName, height: 15, fit: BoxFit.cover),
                                                      //                   Text(value.toString(),style:TextStyle(color:blackColor, fontSize: 14)),
                                                      //                 ]),
                                                      //               );
                                                      //             }).toList(),
                                                      //           ),
                                                      //
                                                      //         )),
                                                      //     DataCell( CheckboxListTile(
                                                      //
                                                      //       title:  Text('',style: boldTextStyle(color: colorSecondary,size: 20),),
                                                      //       // value: timeDilation != 1.0,
                                                      //       value:  _valueRef,
                                                      //       activeColor: colorSecondary,
                                                      //
                                                      //       secondary:Image.asset('images/appimages/power-line.png',color: Colors.transparent,),
                                                      //       onChanged: (bool? value) {
                                                      //         print("tPTAPAT[");
                                                      //         setState(() {
                                                      //           _valueRef = value! ;
                                                      //         });
                                                      //       },
                                                      //     )),
                                                      //   ],
                                                      // ),
                                                      // DataRow(
                                                      //   cells: <DataCell>[
                                                      //     DataCell(Text('AC 18000\nInverter')),
                                                      //     DataCell(
                                                      //         TextFormField(initialValue: '1700',
                                                      //             style: TextStyle(fontSize: 14))
                                                      //
                                                      //     ),
                                                      //     DataCell(TextFormField(initialValue: '1',keyboardType: TextInputType.number,
                                                      //         style: TextStyle(fontSize: 14))),
                                                      //     DataCell(TextFormField(initialValue: 'Always',keyboardType: TextInputType.number,
                                                      //         style: TextStyle(fontSize: 14))),
                                                      //     DataCell(
                                                      //         Theme(
                                                      //
                                                      //           data: Theme.of(context).copyWith(
                                                      //             canvasColor: Colors.white,
                                                      //             primaryColor: Colors.black,
                                                      //             accentColor: Colors.black,
                                                      //             hintColor: Colors.black,
                                                      //             // textSelectionColor: Colors.black,
                                                      //             toggleableActiveColor: colorSecondary,
                                                      //             //  cursorColor: Colors.black,
                                                      //             textTheme: TextTheme(
                                                      //               headline5: TextStyle(color: colorSecondary),
                                                      //               headline6: TextStyle(color:colorSecondary),
                                                      //             ),
                                                      //             inputDecorationTheme: InputDecorationTheme(
                                                      //               enabledBorder: UnderlineInputBorder(
                                                      //                 borderSide: BorderSide(color: colorSecondary),
                                                      //               ),
                                                      //               focusedBorder: UnderlineInputBorder(
                                                      //                 borderSide: BorderSide(color: colorSecondary),
                                                      //               ),
                                                      //               border: UnderlineInputBorder(
                                                      //                 borderSide: BorderSide(color: colorSecondary),
                                                      //               ),
                                                      //             ),
                                                      //           ),
                                                      //           child:
                                                      //
                                                      //           DropdownButtonFormField<String>(
                                                      //             isExpanded: true,
                                                      //             elevation: 10,
                                                      //             focusColor: colorSecondary,
                                                      //             value: dropdownValue,
                                                      //             icon: Icon(Icons.arrow_drop_down,color: colorSecondary, size: 34),
                                                      //             // underline: Container(
                                                      //             //   height: 2,
                                                      //             //   color: colorPrimary,
                                                      //             // ),
                                                      //             onChanged: ( data) {
                                                      //               setState(() {
                                                      //                 dropdownValue = data! ;
                                                      //                 //_country=data.name;
                                                      //               });
                                                      //             },
                                                      //             items: countriesList.map<DropdownMenuItem<String>>((String value) {
                                                      //               //   String flagName= 'images/flags/'+value.code.toLowerCase()+".png";
                                                      //               return DropdownMenuItem<String>(
                                                      //                 value: value,
                                                      //                 child: Row(    children: <Widget>[
                                                      //                   //   Image.asset(flagName, height: 15, fit: BoxFit.cover),
                                                      //                   Text(value.toString(),style:TextStyle(color:blackColor, fontSize: 14)),
                                                      //                 ]),
                                                      //               );
                                                      //             }).toList(),
                                                      //           ),
                                                      //
                                                      //         )),
                                                      //     DataCell( CheckboxListTile(
                                                      //
                                                      //       title:  Text('',style: boldTextStyle(color: colorSecondary,size: 20),),
                                                      //       // value: timeDilation != 1.0,
                                                      //       value:  _valueRef,
                                                      //       activeColor: colorSecondary,
                                                      //
                                                      //       secondary:Image.asset('images/appimages/power-line.png',color: Colors.transparent,),
                                                      //       onChanged: (bool? value) {
                                                      //         print("tPTAPAT[");
                                                      //         setState(() {
                                                      //           _valueRef = value! ;
                                                      //         });
                                                      //       },
                                                      //     )),
                                                      //   ],
                                                      // ),
                                                      // DataRow(
                                                      //   cells: <DataCell>[
                                                      //     DataCell(Text('AC 24000')),
                                                      //     DataCell(
                                                      //         TextFormField(initialValue: '3400',
                                                      //             style: TextStyle(fontSize: 14))
                                                      //
                                                      //     ),
                                                      //     DataCell(TextFormField(initialValue: '1',keyboardType: TextInputType.number,
                                                      //         style: TextStyle(fontSize: 14))),
                                                      //     DataCell(TextFormField(initialValue: 'Always',keyboardType: TextInputType.number,
                                                      //         style: TextStyle(fontSize: 14))),
                                                      //     DataCell(
                                                      //         Theme(
                                                      //
                                                      //           data: Theme.of(context).copyWith(
                                                      //             canvasColor: Colors.white,
                                                      //             primaryColor: Colors.black,
                                                      //             accentColor: Colors.black,
                                                      //             hintColor: Colors.black,
                                                      //             // textSelectionColor: Colors.black,
                                                      //             toggleableActiveColor: colorSecondary,
                                                      //             //  cursorColor: Colors.black,
                                                      //             textTheme: TextTheme(
                                                      //               headline5: TextStyle(color: colorSecondary),
                                                      //               headline6: TextStyle(color:colorSecondary),
                                                      //             ),
                                                      //             inputDecorationTheme: InputDecorationTheme(
                                                      //               enabledBorder: UnderlineInputBorder(
                                                      //                 borderSide: BorderSide(color: colorSecondary),
                                                      //               ),
                                                      //               focusedBorder: UnderlineInputBorder(
                                                      //                 borderSide: BorderSide(color: colorSecondary),
                                                      //               ),
                                                      //               border: UnderlineInputBorder(
                                                      //                 borderSide: BorderSide(color: colorSecondary),
                                                      //               ),
                                                      //             ),
                                                      //           ),
                                                      //           child:
                                                      //
                                                      //           DropdownButtonFormField<String>(
                                                      //             isExpanded: true,
                                                      //             elevation: 10,
                                                      //             focusColor: colorSecondary,
                                                      //             value: dropdownValue,
                                                      //             icon: Icon(Icons.arrow_drop_down,color: colorSecondary, size: 34),
                                                      //             // underline: Container(
                                                      //             //   height: 2,
                                                      //             //   color: colorPrimary,
                                                      //             // ),
                                                      //             onChanged: ( data) {
                                                      //               setState(() {
                                                      //                 dropdownValue = data! ;
                                                      //                 //_country=data.name;
                                                      //               });
                                                      //             },
                                                      //             items: countriesList.map<DropdownMenuItem<String>>((String value) {
                                                      //               //   String flagName= 'images/flags/'+value.code.toLowerCase()+".png";
                                                      //               return DropdownMenuItem<String>(
                                                      //                 value: value,
                                                      //                 child: Row(    children: <Widget>[
                                                      //                   //   Image.asset(flagName, height: 15, fit: BoxFit.cover),
                                                      //                   Text(value.toString(),style:TextStyle(color:blackColor, fontSize: 14)),
                                                      //                 ]),
                                                      //               );
                                                      //             }).toList(),
                                                      //           ),
                                                      //
                                                      //         )),
                                                      //     DataCell( CheckboxListTile(
                                                      //
                                                      //       title:  Text('',style: boldTextStyle(color: colorSecondary,size: 20),),
                                                      //       // value: timeDilation != 1.0,
                                                      //       value:  _valueRef,
                                                      //       activeColor: colorSecondary,
                                                      //
                                                      //       secondary:Image.asset('images/appimages/power-line.png',color: Colors.transparent,),
                                                      //       onChanged: (bool? value) {
                                                      //         print("tPTAPAT[");
                                                      //         setState(() {
                                                      //           _valueRef = value! ;
                                                      //         });
                                                      //       },
                                                      //     )),
                                                      //   ],
                                                      // ),
                                                      // DataRow(
                                                      //   cells: <DataCell>[
                                                      //     DataCell(Text('AC 24000\nInverter')),
                                                      //     DataCell(
                                                      //         TextFormField(initialValue: '2600',
                                                      //             style: TextStyle(fontSize: 14))
                                                      //
                                                      //     ),
                                                      //     DataCell(TextFormField(initialValue: '1',keyboardType: TextInputType.number,
                                                      //         style: TextStyle(fontSize: 14))),
                                                      //     DataCell(TextFormField(initialValue: 'Always',keyboardType: TextInputType.number,
                                                      //         style: TextStyle(fontSize: 14))),
                                                      //     DataCell(
                                                      //         Theme(
                                                      //
                                                      //           data: Theme.of(context).copyWith(
                                                      //             canvasColor: Colors.white,
                                                      //             primaryColor: Colors.black,
                                                      //             accentColor: Colors.black,
                                                      //             hintColor: Colors.black,
                                                      //             // textSelectionColor: Colors.black,
                                                      //             toggleableActiveColor: colorSecondary,
                                                      //             //  cursorColor: Colors.black,
                                                      //             textTheme: TextTheme(
                                                      //               headline5: TextStyle(color: colorSecondary),
                                                      //               headline6: TextStyle(color:colorSecondary),
                                                      //             ),
                                                      //             inputDecorationTheme: InputDecorationTheme(
                                                      //               enabledBorder: UnderlineInputBorder(
                                                      //                 borderSide: BorderSide(color: colorSecondary),
                                                      //               ),
                                                      //               focusedBorder: UnderlineInputBorder(
                                                      //                 borderSide: BorderSide(color: colorSecondary),
                                                      //               ),
                                                      //               border: UnderlineInputBorder(
                                                      //                 borderSide: BorderSide(color: colorSecondary),
                                                      //               ),
                                                      //             ),
                                                      //           ),
                                                      //           child:
                                                      //
                                                      //           DropdownButtonFormField<String>(
                                                      //             isExpanded: true,
                                                      //             elevation: 10,
                                                      //             focusColor: colorSecondary,
                                                      //             value: dropdownValue,
                                                      //             icon: Icon(Icons.arrow_drop_down,color: colorSecondary, size: 34),
                                                      //             // underline: Container(
                                                      //             //   height: 2,
                                                      //             //   color: colorPrimary,
                                                      //             // ),
                                                      //             onChanged: ( data) {
                                                      //               setState(() {
                                                      //                 dropdownValue = data! ;
                                                      //                 //_country=data.name;
                                                      //               });
                                                      //             },
                                                      //             items: countriesList.map<DropdownMenuItem<String>>((String value) {
                                                      //               //   String flagName= 'images/flags/'+value.code.toLowerCase()+".png";
                                                      //               return DropdownMenuItem<String>(
                                                      //                 value: value,
                                                      //                 child: Row(    children: <Widget>[
                                                      //                   //   Image.asset(flagName, height: 15, fit: BoxFit.cover),
                                                      //                   Text(value.toString(),style:TextStyle(color:blackColor, fontSize: 14)),
                                                      //                 ]),
                                                      //               );
                                                      //             }).toList(),
                                                      //           ),
                                                      //
                                                      //         )),
                                                      //     DataCell( CheckboxListTile(
                                                      //
                                                      //       title:  Text('',style: boldTextStyle(color: colorSecondary,size: 20),),
                                                      //       // value: timeDilation != 1.0,
                                                      //       value:  _valueRef,
                                                      //       activeColor: colorSecondary,
                                                      //
                                                      //       secondary:Image.asset('images/appimages/power-line.png',color: Colors.transparent,),
                                                      //       onChanged: (bool? value) {
                                                      //         print("tPTAPAT[");
                                                      //         setState(() {
                                                      //           _valueRef = value! ;
                                                      //         });
                                                      //       },
                                                      //     )),
                                                      //   ],
                                                      // ),
                                                      // DataRow(
                                                      //   cells: <DataCell>[
                                                      //     DataCell(Text('Light')),
                                                      //     DataCell(
                                                      //         TextFormField(initialValue: '30',
                                                      //             style: TextStyle(fontSize: 14))
                                                      //
                                                      //     ),
                                                      //     DataCell(TextFormField(initialValue: '1',keyboardType: TextInputType.number,
                                                      //         style: TextStyle(fontSize: 14))),
                                                      //     DataCell(TextFormField(initialValue: 'Always',keyboardType: TextInputType.number,
                                                      //         style: TextStyle(fontSize: 14))),
                                                      //     DataCell(
                                                      //         Theme(
                                                      //
                                                      //           data: Theme.of(context).copyWith(
                                                      //             canvasColor: Colors.white,
                                                      //             primaryColor: Colors.black,
                                                      //             accentColor: Colors.black,
                                                      //             hintColor: Colors.black,
                                                      //             // textSelectionColor: Colors.black,
                                                      //             toggleableActiveColor: colorSecondary,
                                                      //             //  cursorColor: Colors.black,
                                                      //             textTheme: TextTheme(
                                                      //               headline5: TextStyle(color: colorSecondary),
                                                      //               headline6: TextStyle(color:colorSecondary),
                                                      //             ),
                                                      //             inputDecorationTheme: InputDecorationTheme(
                                                      //               enabledBorder: UnderlineInputBorder(
                                                      //                 borderSide: BorderSide(color: colorSecondary),
                                                      //               ),
                                                      //               focusedBorder: UnderlineInputBorder(
                                                      //                 borderSide: BorderSide(color: colorSecondary),
                                                      //               ),
                                                      //               border: UnderlineInputBorder(
                                                      //                 borderSide: BorderSide(color: colorSecondary),
                                                      //               ),
                                                      //             ),
                                                      //           ),
                                                      //           child:
                                                      //
                                                      //           DropdownButtonFormField<String>(
                                                      //             isExpanded: true,
                                                      //             elevation: 10,
                                                      //             focusColor: colorSecondary,
                                                      //             value: dropdownValue,
                                                      //             icon: Icon(Icons.arrow_drop_down,color: colorSecondary, size: 34),
                                                      //             // underline: Container(
                                                      //             //   height: 2,
                                                      //             //   color: colorPrimary,
                                                      //             // ),
                                                      //             onChanged: ( data) {
                                                      //               setState(() {
                                                      //                 dropdownValue = data! ;
                                                      //                 //_country=data.name;
                                                      //               });
                                                      //             },
                                                      //             items: countriesList.map<DropdownMenuItem<String>>((String value) {
                                                      //               //   String flagName= 'images/flags/'+value.code.toLowerCase()+".png";
                                                      //               return DropdownMenuItem<String>(
                                                      //                 value: value,
                                                      //                 child: Row(    children: <Widget>[
                                                      //                   //   Image.asset(flagName, height: 15, fit: BoxFit.cover),
                                                      //                   Text(value.toString(),style:TextStyle(color:blackColor, fontSize: 14)),
                                                      //                 ]),
                                                      //               );
                                                      //             }).toList(),
                                                      //           ),
                                                      //
                                                      //         )),
                                                      //     DataCell( CheckboxListTile(
                                                      //
                                                      //       title:  Text('',style: boldTextStyle(color: colorSecondary,size: 20),),
                                                      //       // value: timeDilation != 1.0,
                                                      //       value:  _valueRef,
                                                      //       activeColor: colorSecondary,
                                                      //
                                                      //       secondary:Image.asset('images/appimages/power-line.png',color: Colors.transparent,),
                                                      //       onChanged: (bool? value) {
                                                      //         print("tPTAPAT[");
                                                      //         setState(() {
                                                      //           _valueRef = value! ;
                                                      //         });
                                                      //       },
                                                      //     )),
                                                      //   ],
                                                      // ),
                                                      // DataRow(
                                                      //   cells: <DataCell>[
                                                      //     DataCell(Text('LED')),
                                                      //     DataCell(
                                                      //         TextFormField(initialValue: '60',
                                                      //             style: TextStyle(fontSize: 14))
                                                      //
                                                      //     ),
                                                      //     DataCell(TextFormField(initialValue: '1',keyboardType: TextInputType.number,
                                                      //         style: TextStyle(fontSize: 14))),
                                                      //     DataCell(TextFormField(initialValue: 'Always',keyboardType: TextInputType.number,
                                                      //         style: TextStyle(fontSize: 14))),
                                                      //     DataCell(
                                                      //         Theme(
                                                      //
                                                      //           data: Theme.of(context).copyWith(
                                                      //             canvasColor: Colors.white,
                                                      //             primaryColor: Colors.black,
                                                      //             accentColor: Colors.black,
                                                      //             hintColor: Colors.black,
                                                      //             // textSelectionColor: Colors.black,
                                                      //             toggleableActiveColor: colorSecondary,
                                                      //             //  cursorColor: Colors.black,
                                                      //             textTheme: TextTheme(
                                                      //               headline5: TextStyle(color: colorSecondary),
                                                      //               headline6: TextStyle(color:colorSecondary),
                                                      //             ),
                                                      //             inputDecorationTheme: InputDecorationTheme(
                                                      //               enabledBorder: UnderlineInputBorder(
                                                      //                 borderSide: BorderSide(color: colorSecondary),
                                                      //               ),
                                                      //               focusedBorder: UnderlineInputBorder(
                                                      //                 borderSide: BorderSide(color: colorSecondary),
                                                      //               ),
                                                      //               border: UnderlineInputBorder(
                                                      //                 borderSide: BorderSide(color: colorSecondary),
                                                      //               ),
                                                      //             ),
                                                      //           ),
                                                      //           child:
                                                      //
                                                      //           DropdownButtonFormField<String>(
                                                      //             isExpanded: true,
                                                      //             elevation: 10,
                                                      //             focusColor: colorSecondary,
                                                      //             value: dropdownValue,
                                                      //             icon: Icon(Icons.arrow_drop_down,color: colorSecondary, size: 34),
                                                      //             // underline: Container(
                                                      //             //   height: 2,
                                                      //             //   color: colorPrimary,
                                                      //             // ),
                                                      //             onChanged: ( data) {
                                                      //               setState(() {
                                                      //                 dropdownValue = data! ;
                                                      //                 //_country=data.name;
                                                      //               });
                                                      //             },
                                                      //             items: countriesList.map<DropdownMenuItem<String>>((String value) {
                                                      //               //   String flagName= 'images/flags/'+value.code.toLowerCase()+".png";
                                                      //               return DropdownMenuItem<String>(
                                                      //                 value: value,
                                                      //                 child: Row(    children: <Widget>[
                                                      //                   //   Image.asset(flagName, height: 15, fit: BoxFit.cover),
                                                      //                   Text(value.toString(),style:TextStyle(color:blackColor, fontSize: 14)),
                                                      //                 ]),
                                                      //               );
                                                      //             }).toList(),
                                                      //           ),
                                                      //
                                                      //         )),
                                                      //     DataCell( CheckboxListTile(
                                                      //
                                                      //       title:  Text('',style: boldTextStyle(color: colorSecondary,size: 20),),
                                                      //       // value: timeDilation != 1.0,
                                                      //       value:  _valueRef,
                                                      //       activeColor: colorSecondary,
                                                      //
                                                      //       secondary:Image.asset('images/appimages/power-line.png',color: Colors.transparent,),
                                                      //       onChanged: (bool? value) {
                                                      //         print("tPTAPAT[");
                                                      //         setState(() {
                                                      //           _valueRef = value! ;
                                                      //         });
                                                      //       },
                                                      //     )),
                                                      //   ],
                                                      // ),
                                                      // DataRow(
                                                      //   cells: <DataCell>[
                                                      //     DataCell(Text('Heater')),
                                                      //     DataCell(
                                                      //         TextFormField(initialValue: '1500',
                                                      //             style: TextStyle(fontSize: 14))
                                                      //
                                                      //     ),
                                                      //     DataCell(TextFormField(initialValue: '1',keyboardType: TextInputType.number,
                                                      //         style: TextStyle(fontSize: 14))),
                                                      //     DataCell(TextFormField(initialValue: 'Always',keyboardType: TextInputType.number,
                                                      //         style: TextStyle(fontSize: 14))),
                                                      //     DataCell(
                                                      //         Theme(
                                                      //
                                                      //           data: Theme.of(context).copyWith(
                                                      //             canvasColor: Colors.white,
                                                      //             primaryColor: Colors.black,
                                                      //             accentColor: Colors.black,
                                                      //             hintColor: Colors.black,
                                                      //             // textSelectionColor: Colors.black,
                                                      //             toggleableActiveColor: colorSecondary,
                                                      //             //  cursorColor: Colors.black,
                                                      //             textTheme: TextTheme(
                                                      //               headline5: TextStyle(color: colorSecondary),
                                                      //               headline6: TextStyle(color:colorSecondary),
                                                      //             ),
                                                      //             inputDecorationTheme: InputDecorationTheme(
                                                      //               enabledBorder: UnderlineInputBorder(
                                                      //                 borderSide: BorderSide(color: colorSecondary),
                                                      //               ),
                                                      //               focusedBorder: UnderlineInputBorder(
                                                      //                 borderSide: BorderSide(color: colorSecondary),
                                                      //               ),
                                                      //               border: UnderlineInputBorder(
                                                      //                 borderSide: BorderSide(color: colorSecondary),
                                                      //               ),
                                                      //             ),
                                                      //           ),
                                                      //           child:
                                                      //
                                                      //           DropdownButtonFormField<String>(
                                                      //             isExpanded: true,
                                                      //             elevation: 10,
                                                      //             focusColor: colorSecondary,
                                                      //             value: dropdownValue,
                                                      //             icon: Icon(Icons.arrow_drop_down,color: colorSecondary, size: 34),
                                                      //             // underline: Container(
                                                      //             //   height: 2,
                                                      //             //   color: colorPrimary,
                                                      //             // ),
                                                      //             onChanged: ( data) {
                                                      //               setState(() {
                                                      //                 dropdownValue = data! ;
                                                      //                 //_country=data.name;
                                                      //               });
                                                      //             },
                                                      //             items: countriesList.map<DropdownMenuItem<String>>((String value) {
                                                      //               //   String flagName= 'images/flags/'+value.code.toLowerCase()+".png";
                                                      //               return DropdownMenuItem<String>(
                                                      //                 value: value,
                                                      //                 child: Row(    children: <Widget>[
                                                      //                   //   Image.asset(flagName, height: 15, fit: BoxFit.cover),
                                                      //                   Text(value.toString(),style:TextStyle(color:blackColor, fontSize: 14)),
                                                      //                 ]),
                                                      //               );
                                                      //             }).toList(),
                                                      //           ),
                                                      //
                                                      //         )),
                                                      //     DataCell( CheckboxListTile(
                                                      //
                                                      //       title:  Text('',style: boldTextStyle(color: colorSecondary,size: 20),),
                                                      //       // value: timeDilation != 1.0,
                                                      //       value:  _valueRef,
                                                      //       activeColor: colorSecondary,
                                                      //
                                                      //       secondary:Image.asset('images/appimages/power-line.png',color: Colors.transparent,),
                                                      //       onChanged: (bool? value) {
                                                      //         print("tPTAPAT[");
                                                      //         setState(() {
                                                      //           _valueRef = value! ;
                                                      //         });
                                                      //       },
                                                      //     )),
                                                      //   ],
                                                      // ),
                                                      // DataRow(
                                                      //   cells: <DataCell>[
                                                      //     DataCell(Text('Washing\nmachine')),
                                                      //     DataCell(
                                                      //         TextFormField(initialValue: '800',
                                                      //             style: TextStyle(fontSize: 14))
                                                      //
                                                      //     ),
                                                      //     DataCell(TextFormField(initialValue: '1',keyboardType: TextInputType.number,
                                                      //         style: TextStyle(fontSize: 14))),
                                                      //     DataCell(TextFormField(initialValue: 'Always',keyboardType: TextInputType.number,
                                                      //         style: TextStyle(fontSize: 14))),
                                                      //     DataCell(
                                                      //         Theme(
                                                      //
                                                      //           data: Theme.of(context).copyWith(
                                                      //             canvasColor: Colors.white,
                                                      //             primaryColor: Colors.black,
                                                      //             accentColor: Colors.black,
                                                      //             hintColor: Colors.black,
                                                      //             // textSelectionColor: Colors.black,
                                                      //             toggleableActiveColor: colorSecondary,
                                                      //             //  cursorColor: Colors.black,
                                                      //             textTheme: TextTheme(
                                                      //               headline5: TextStyle(color: colorSecondary),
                                                      //               headline6: TextStyle(color:colorSecondary),
                                                      //             ),
                                                      //             inputDecorationTheme: InputDecorationTheme(
                                                      //               enabledBorder: UnderlineInputBorder(
                                                      //                 borderSide: BorderSide(color: colorSecondary),
                                                      //               ),
                                                      //               focusedBorder: UnderlineInputBorder(
                                                      //                 borderSide: BorderSide(color: colorSecondary),
                                                      //               ),
                                                      //               border: UnderlineInputBorder(
                                                      //                 borderSide: BorderSide(color: colorSecondary),
                                                      //               ),
                                                      //             ),
                                                      //           ),
                                                      //           child:
                                                      //
                                                      //           DropdownButtonFormField<String>(
                                                      //             isExpanded: true,
                                                      //             elevation: 10,
                                                      //             focusColor: colorSecondary,
                                                      //             value: dropdownValue,
                                                      //             icon: Icon(Icons.arrow_drop_down,color: colorSecondary, size: 34),
                                                      //             // underline: Container(
                                                      //             //   height: 2,
                                                      //             //   color: colorPrimary,
                                                      //             // ),
                                                      //             onChanged: ( data) {
                                                      //               setState(() {
                                                      //                 dropdownValue = data! ;
                                                      //                 //_country=data.name;
                                                      //               });
                                                      //             },
                                                      //             items: countriesList.map<DropdownMenuItem<String>>((String value) {
                                                      //               //   String flagName= 'images/flags/'+value.code.toLowerCase()+".png";
                                                      //               return DropdownMenuItem<String>(
                                                      //                 value: value,
                                                      //                 child: Row(    children: <Widget>[
                                                      //                   //   Image.asset(flagName, height: 15, fit: BoxFit.cover),
                                                      //                   Text(value.toString(),style:TextStyle(color:blackColor, fontSize: 14)),
                                                      //                 ]),
                                                      //               );
                                                      //             }).toList(),
                                                      //           ),
                                                      //
                                                      //         )),
                                                      //     DataCell( CheckboxListTile(
                                                      //
                                                      //       title:  Text('',style: boldTextStyle(color: colorSecondary,size: 20),),
                                                      //       // value: timeDilation != 1.0,
                                                      //       value:  _valueRef,
                                                      //       activeColor: colorSecondary,
                                                      //
                                                      //       secondary:Image.asset('images/appimages/power-line.png',color: Colors.transparent,),
                                                      //       onChanged: (bool? value) {
                                                      //         print("tPTAPAT[");
                                                      //         setState(() {
                                                      //           _valueRef = value! ;
                                                      //         });
                                                      //       },
                                                      //     )),
                                                      //   ],
                                                      // ),
                                                      // DataRow(
                                                      //   cells: <DataCell>[
                                                      //     DataCell(Text('Laundry\ndryer')),
                                                      //     DataCell(
                                                      //         TextFormField(initialValue: '2000',
                                                      //             style: TextStyle(fontSize: 14))
                                                      //
                                                      //     ),
                                                      //     DataCell(TextFormField(initialValue: '1',keyboardType: TextInputType.number,
                                                      //         style: TextStyle(fontSize: 14))),
                                                      //     DataCell(TextFormField(initialValue: 'Always',keyboardType: TextInputType.number,
                                                      //         style: TextStyle(fontSize: 14))),
                                                      //     DataCell(
                                                      //         Theme(
                                                      //
                                                      //           data: Theme.of(context).copyWith(
                                                      //             canvasColor: Colors.white,
                                                      //             primaryColor: Colors.black,
                                                      //             accentColor: Colors.black,
                                                      //             hintColor: Colors.black,
                                                      //             // textSelectionColor: Colors.black,
                                                      //             toggleableActiveColor: colorSecondary,
                                                      //             //  cursorColor: Colors.black,
                                                      //             textTheme: TextTheme(
                                                      //               headline5: TextStyle(color: colorSecondary),
                                                      //               headline6: TextStyle(color:colorSecondary),
                                                      //             ),
                                                      //             inputDecorationTheme: InputDecorationTheme(
                                                      //               enabledBorder: UnderlineInputBorder(
                                                      //                 borderSide: BorderSide(color: colorSecondary),
                                                      //               ),
                                                      //               focusedBorder: UnderlineInputBorder(
                                                      //                 borderSide: BorderSide(color: colorSecondary),
                                                      //               ),
                                                      //               border: UnderlineInputBorder(
                                                      //                 borderSide: BorderSide(color: colorSecondary),
                                                      //               ),
                                                      //             ),
                                                      //           ),
                                                      //           child:
                                                      //
                                                      //           DropdownButtonFormField<String>(
                                                      //             isExpanded: true,
                                                      //             elevation: 10,
                                                      //             focusColor: colorSecondary,
                                                      //             value: dropdownValue,
                                                      //             icon: Icon(Icons.arrow_drop_down,color: colorSecondary, size: 34),
                                                      //             // underline: Container(
                                                      //             //   height: 2,
                                                      //             //   color: colorPrimary,
                                                      //             // ),
                                                      //             onChanged: ( data) {
                                                      //               setState(() {
                                                      //                 dropdownValue = data! ;
                                                      //                 //_country=data.name;
                                                      //               });
                                                      //             },
                                                      //             items: countriesList.map<DropdownMenuItem<String>>((String value) {
                                                      //               //   String flagName= 'images/flags/'+value.code.toLowerCase()+".png";
                                                      //               return DropdownMenuItem<String>(
                                                      //                 value: value,
                                                      //                 child: Row(    children: <Widget>[
                                                      //                   //   Image.asset(flagName, height: 15, fit: BoxFit.cover),
                                                      //                   Text(value.toString(),style:TextStyle(color:blackColor, fontSize: 14)),
                                                      //                 ]),
                                                      //               );
                                                      //             }).toList(),
                                                      //           ),
                                                      //
                                                      //         )),
                                                      //     DataCell( CheckboxListTile(
                                                      //
                                                      //       title:  Text('',style: boldTextStyle(color: colorSecondary,size: 20),),
                                                      //       // value: timeDilation != 1.0,
                                                      //       value:  _valueRef,
                                                      //       activeColor: colorSecondary,
                                                      //
                                                      //       secondary:Image.asset('images/appimages/power-line.png',color: Colors.transparent,),
                                                      //       onChanged: (bool? value) {
                                                      //         print("tPTAPAT[");
                                                      //         setState(() {
                                                      //           _valueRef = value! ;
                                                      //         });
                                                      //       },
                                                      //     )),
                                                      //   ],
                                                      // ),
                                                      // DataRow(
                                                      //   cells: <DataCell>[
                                                      //     DataCell(
                                                      //         TextFormField(initialValue: 'Other',
                                                      //             style: TextStyle(fontSize: 14))
                                                      //
                                                      //     ),
                                                      //     DataCell(
                                                      //         TextFormField(initialValue: '100',
                                                      //             style: TextStyle(fontSize: 14))
                                                      //
                                                      //     ),
                                                      //     DataCell(TextFormField(initialValue: '1',keyboardType: TextInputType.number,
                                                      //         style: TextStyle(fontSize: 14))),
                                                      //     DataCell(TextFormField(initialValue: 'Always',keyboardType: TextInputType.number,
                                                      //         style: TextStyle(fontSize: 14))),
                                                      //     DataCell(
                                                      //         Theme(
                                                      //
                                                      //           data: Theme.of(context).copyWith(
                                                      //             canvasColor: Colors.white,
                                                      //             primaryColor: Colors.black,
                                                      //             accentColor: Colors.black,
                                                      //             hintColor: Colors.black,
                                                      //             // textSelectionColor: Colors.black,
                                                      //             toggleableActiveColor: colorSecondary,
                                                      //             //  cursorColor: Colors.black,
                                                      //             textTheme: TextTheme(
                                                      //               headline5: TextStyle(color: colorSecondary),
                                                      //               headline6: TextStyle(color:colorSecondary),
                                                      //             ),
                                                      //             inputDecorationTheme: InputDecorationTheme(
                                                      //               enabledBorder: UnderlineInputBorder(
                                                      //                 borderSide: BorderSide(color: colorSecondary),
                                                      //               ),
                                                      //               focusedBorder: UnderlineInputBorder(
                                                      //                 borderSide: BorderSide(color: colorSecondary),
                                                      //               ),
                                                      //               border: UnderlineInputBorder(
                                                      //                 borderSide: BorderSide(color: colorSecondary),
                                                      //               ),
                                                      //             ),
                                                      //           ),
                                                      //           child:
                                                      //
                                                      //           DropdownButtonFormField<String>(
                                                      //             isExpanded: true,
                                                      //             elevation: 10,
                                                      //             focusColor: colorSecondary,
                                                      //             value: dropdownValue,
                                                      //             icon: Icon(Icons.arrow_drop_down,color: colorSecondary, size: 34),
                                                      //             // underline: Container(
                                                      //             //   height: 2,
                                                      //             //   color: colorPrimary,
                                                      //             // ),
                                                      //             onChanged: ( data) {
                                                      //               setState(() {
                                                      //                 dropdownValue = data! ;
                                                      //                 //_country=data.name;
                                                      //               });
                                                      //             },
                                                      //             items: countriesList.map<DropdownMenuItem<String>>((String value) {
                                                      //               //   String flagName= 'images/flags/'+value.code.toLowerCase()+".png";
                                                      //               return DropdownMenuItem<String>(
                                                      //                 value: value,
                                                      //                 child: Row(    children: <Widget>[
                                                      //                   //   Image.asset(flagName, height: 15, fit: BoxFit.cover),
                                                      //                   Text(value.toString(),style:TextStyle(color:blackColor, fontSize: 14)),
                                                      //                 ]),
                                                      //               );
                                                      //             }).toList(),
                                                      //           ),
                                                      //
                                                      //         )),
                                                      //     DataCell( CheckboxListTile(
                                                      //
                                                      //       title:  Text('',style: boldTextStyle(color: colorSecondary,size: 20),),
                                                      //       // value: timeDilation != 1.0,
                                                      //       value:  _valueRef,
                                                      //       activeColor: colorSecondary,
                                                      //
                                                      //       secondary:Image.asset('images/appimages/power-line.png',color: Colors.transparent,),
                                                      //       onChanged: (bool? value) {
                                                      //         print("tPTAPAT[");
                                                      //         setState(() {
                                                      //           _valueRef = value! ;
                                                      //         });
                                                      //       },
                                                      //     )),
                                                      //   ],
                                                      // ),

                                                    ],
                                                  )




                                            ),
                                          ),),
                                        // Container(
                                        //  color:Colors.white,
                                        //   child:
                                        //   Column(children: [
                                        //     Row(
                                        //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        //       crossAxisAlignment: CrossAxisAlignment.center,
                                        //       children: [
                                        //         Column(children: [Text("",style: boldTextStyle(),)],),
                                        //         Column(children: [Text("Appliance",style: boldTextStyle(color: colorSecondary),),
                                        //           Text("Refrigerator",style: boldTextStyle(color: colorSecondary),),
                                        //           Text("Refrigerator Inverter",style: boldTextStyle(color: colorSecondary),),
                                        //           Text("Appliance",style: boldTextStyle(color: colorSecondary),),
                                        //           Text("Appliance",style: boldTextStyle(color: colorSecondary),),
                                        //           Text("Appliance",style: boldTextStyle(color: colorSecondary),),
                                        //           Text("Appliance",style: boldTextStyle(color: colorSecondary),),
                                        //           Text("Appliance",style: boldTextStyle(color: colorSecondary),),
                                        //           Text("Appliance",style: boldTextStyle(color: colorSecondary),),
                                        //           Text("Appliance",style: boldTextStyle(color: colorSecondary),),
                                        //           Text("Appliance",style: boldTextStyle(color: colorSecondary),),
                                        //
                                        //         ],),
                                        //         Column(children: [Text("Avg Power" ,style: boldTextStyle(color: colorSecondary))],),
                                        //         Column(children: [Text("Qty",style: boldTextStyle(color: colorSecondary))],),
                                        //         Column(children: [Text("Time used (hrs)",style: boldTextStyle(color: colorSecondary))],),
                                        //         Column(children: [Text("Day/Night",style: boldTextStyle(color: colorSecondary))],),
                                        //         Column(children: [Text("",style: boldTextStyle())],),
                                        //
                                        //       ],
                                        //
                                        //     ),
                                        //
                                        //
                                        //   ],)
                                        //
                                        //
                                        //
                                        // ),
                                      ),);
                              }
                          );



                        },),
                        hintText: 'ex: 1000 W',

                      ),
                    ),
                          Positioned(
                      right: 0,
                      top: 0,
                      bottom: 20,
                      child: Tooltip(
                        key: _toolTipKey3,

                        message: "or click here to get estimated load from home appliances",
                        // child: Icon(
                        //   Icons.info,
                        //   size: 20,
                        // ),
                      ),
                    ),]),

//
//                     Row(children: [
//                       Expanded(child:  TextFormField(
//                         controller: addressCont,
//                         focusNode: addressFocusNode,
//                         keyboardType: TextInputType.emailAddress,
//                         textInputAction: TextInputAction.next,
//                         onFieldSubmitted: (value) {
//                           FocusScope.of(context).requestFocus(phoneFocusNode);
//                         },
//                         validator: (value) {
//                           if (value == null || value.trim().isEmpty) {
//                             return 'Please enter your  address';
//                           }
//                           // if (!RegExp(EmailRegex).hasMatch(value)) {
//                           //   return 'Please enter a valid email address';
//                           // }
//                           return null;
//                         },
//                         onChanged: (value) => _userEmail = value,
//                         style: TextStyle(color: blackColor),
//                         decoration: InputDecoration(
//                           enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: colorSecondary)),
//                           focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: colorSecondary)),
//                           labelText: "Province",
//                           labelStyle: TextStyle(color: colorSecondary, fontSize: 14),
//                         ///  suffixIcon:Icon( Icons.location_on , color: colorSecondary, size: 20),
//                         ),
//                       )),
//                       SizedBox(width: 10,),
//                       Expanded(child:  TextFormField(
//                         controller: addressCont,
//                         focusNode: addressFocusNode,
//                         keyboardType: TextInputType.emailAddress,
//                         textInputAction: TextInputAction.next,
//                         onFieldSubmitted: (value) {
//                           FocusScope.of(context).requestFocus(phoneFocusNode);
//                         },
//                         validator: (value) {
//                           if (value == null || value.trim().isEmpty) {
//                             return 'Please enter your  address';
//                           }
//                           // if (!RegExp(EmailRegex).hasMatch(value)) {
//                           //   return 'Please enter a valid email address';
//                           // }
//                           return null;
//                         },
//                         onChanged: (value) => _userEmail = value,
//                         style: TextStyle(color: blackColor),
//                         decoration: InputDecoration(
//                           enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: colorSecondary)),
//                           focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: colorSecondary)),
//                           labelText: "Casa",
//                           labelStyle: TextStyle(color: colorSecondary, fontSize: 14),
//                        //   suffixIcon:Icon( Icons.location_on , color: colorSecondary, size: 20),
//                         ),
//                       )),
//                       SizedBox(width: 10,),
//                       Expanded(child:  TextFormField(
//                         controller: addressCont,
//                         focusNode: addressFocusNode,
//                         keyboardType: TextInputType.emailAddress,
//                         textInputAction: TextInputAction.next,
//                         onFieldSubmitted: (value) {
//                           FocusScope.of(context).requestFocus(phoneFocusNode);
//                         },
//                         validator: (value) {
//                           if (value == null || value.trim().isEmpty) {
//                             return 'Please enter your  address';
//                           }
//                           // if (!RegExp(EmailRegex).hasMatch(value)) {
//                           //   return 'Please enter a valid email address';
//                           // }
//                           return null;
//                         },
//                         onChanged: (value) => _userEmail = value,
//                         style: TextStyle(color: blackColor),
//                         decoration: InputDecoration(
//                           enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: colorSecondary)),
//                           focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: colorSecondary)),
//                           labelText: "City/Village",
//                           labelStyle: TextStyle(color: colorSecondary, fontSize: 14),
//                           suffixIcon:Icon( Icons.location_on , color: colorSecondary, size: 20),
//                         ),
//                       )),
//                     ],),
//                     TextFormField(
//                       controller: addressCont,
//                       focusNode: addressFocusNode,
//                       keyboardType: TextInputType.emailAddress,
//                       textInputAction: TextInputAction.next,
//                       onFieldSubmitted: (value) {
//                         FocusScope.of(context).requestFocus(phoneFocusNode);
//                       },
//                       validator: (value) {
//                         if (value == null || value.trim().isEmpty) {
//                           return 'Please enter your  address';
//                         }
//                         // if (!RegExp(EmailRegex).hasMatch(value)) {
//                         //   return 'Please enter a valid email address';
//                         // }
//                         return null;
//                       },
//                       onChanged: (value) => _userEmail = value,
//                       style: TextStyle(color: blackColor),
//                       decoration: InputDecoration(
//                         enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: colorSecondary)),
//                         focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: colorSecondary)),
//                         labelText: "Address Details",
//                         labelStyle: TextStyle(color: colorSecondary, fontSize: 14),
//                         //   suffixIcon:Icon( Icons.location_on , color: colorSecondary, size: 20),
//                       ),
//                     ),
//                     // TextFormField(
//                     //   controller:passwordCont,
//                     //   focusNode: passwordFocusNode,
//                     //   obscureText: !_showPassword,
//                     //   keyboardType: TextInputType.text,
//                     //   validator: (value) {
//                     //     if (value == null || value.trim().isEmpty) {
//                     //       return 'This field is required';
//                     //     }
//                     //     // if (value.trim().length < 7) {
//                     //     //   return 'Password must be at least 7 characters in length';
//                     //     // }
//                     //     if (!RegExp(PasswordRegex).hasMatch(value)) {
//                     //       return 'Password should be at least 7 characters'
//                     //           '\n with 1 capital letter, one number, and one special character';
//                     //     }
//                     //     return null;
//                     //   },
//                     //   onChanged: (value) => _password = value,
//                     //   style: TextStyle(color: blackColor),
//                     //   decoration: InputDecoration(
//                     //     labelText: "Password",
//                     //     labelStyle: TextStyle(color: colorSecondary, fontSize: 14),
//                     //     suffixIcon: GestureDetector(
//                     //       onTap: () {
//                     //         setState(() {
//                     //           _showPassword = !_showPassword;
//                     //         });
//                     //       },
//                     //       child: Icon(_showPassword ? Icons.visibility : Icons.visibility_off, color: colorSecondary, size: 20),
//                     //     ),
//                     //     enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: colorSecondary)),
//                     //     focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: colorSecondary)),
//                     //   ),
//                     // ),
//                     // TextFormField(
//                     //   controller: confirmPasswordCont,
//                     //   focusNode: confirmpasswordFocusNode,
//                     //   obscureText: !_showConfPassword,
//                     //   keyboardType: TextInputType.text,
//                     //   validator: (value) {
//                     //     if (value == null || value.isEmpty) {
//                     //       return 'This field is required';
//                     //     }
//                     //     if (value != _password) {
//                     //       return 'Confirmation password doesn\'t match';
//                     //     }
//                     //     return null;
//                     //   },
//                     //   onChanged: (value) => _confirmPassword = value,
//                     //   style: TextStyle(color: blackColor),
//                     //   decoration: InputDecoration(
//                     //     labelText: "Confirm Password",
//                     //     labelStyle: TextStyle(color: colorSecondary, fontSize: 14),
//                     //     suffixIcon: GestureDetector(
//                     //       onTap: () {
//                     //         setState(() {
//                     //           _showConfPassword = !_showConfPassword;
//                     //         });
//                     //       },
//                     //       child: Icon(_showConfPassword ? Icons.visibility : Icons.visibility_off, color: colorSecondary, size: 20),
//                     //     ),
//                     //     enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: colorSecondary)),
//                     //     focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: colorSecondary)),
//                     //   ),
//                     // ),
//
//                     Row(
//                       children: <Widget>[
//
//                         Expanded(
//                           flex: 1,
//                       child:
// SizedBox(height: 48,child:
//                       Theme(
//
//                         data: Theme.of(context).copyWith(
//                           canvasColor: Colors.white,
//                           primaryColor: Colors.black,
//                           accentColor: Colors.black,
//                           hintColor: Colors.black,
//                          // textSelectionColor: Colors.black,
//                           toggleableActiveColor: colorSecondary,
//                         //  cursorColor: Colors.black,
//                           textTheme: TextTheme(
//                             headline5: TextStyle(color: colorSecondary),
//                             headline6: TextStyle(color:colorSecondary),
//                           ),
//                           inputDecorationTheme: InputDecorationTheme(
//                             enabledBorder: UnderlineInputBorder(
//                               borderSide: BorderSide(color: colorSecondary),
//                             ),
//                             focusedBorder: UnderlineInputBorder(
//                               borderSide: BorderSide(color: colorSecondary),
//                             ),
//                             border: UnderlineInputBorder(
//                               borderSide: BorderSide(color: colorSecondary),
//                             ),
//                           ),
//                         ),
//                         child:
//
//                       DropdownButtonFormField<Countries>(
//                             isExpanded: true,
//                             elevation: 10,
//                             focusColor: colorSecondary,
//                             value: dropdownValue,
//                             icon: Icon(Icons.arrow_drop_down,color: colorSecondary, size: 34),
//                             // underline: Container(
//                             //   height: 2,
//                             //   color: colorPrimary,
//                             // ),
//                             onChanged: ( data) {
//                               setState(() {
//                                 dropdownValue = data! ;
//                                 //_country=data.name;
//                               });
//                             },
//                             items: countriesList.map<DropdownMenuItem<Countries>>((Countries value) {
//                               String flagName= 'images/flags/'+value.code.toLowerCase()+".png";
//                               return DropdownMenuItem<Countries>(
//                                 value: value,
//                                 child: Row(    children: <Widget>[
//                                   Image.asset(flagName, height: 15, fit: BoxFit.cover),
//                                   Text("  "+value.name+" (+"+value.phoneCode.toString()+")",style:TextStyle(color:blackColor, fontSize: 14)),
//                                 ]),
//                               );
//                             }).toList(),
//                           ),
//
//                       )),
//                         ),
//                         SizedBox( width:10),
//                         Expanded(
//                           flex: 2,
//                           child:
//                               SizedBox(height: 49 , child:
//                           TextFormField(
//                             controller: phoneCont,
//                             focusNode: phoneFocusNode,
//                             keyboardType: TextInputType.phone,
//                             textInputAction: TextInputAction.next,
//                             validator: (value) {
//                               if (value == null || value.trim().isEmpty) {
//                                 return 'This field is required';
//                               }
//
//                               // if(!validatePhoneNumber(dropdownValue.phoneCode,value))
//                               //   return 'Enter a valid phone number ';
//                             },
//                             onChanged: (value) => _phoneNumber = value,
//                             style: TextStyle(color: blackColor),
//                             decoration: InputDecoration(
//                               enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: colorSecondary)),
//                               focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: colorSecondary)),
//                               labelText: "Phone Number",
//                               labelStyle: TextStyle(color: colorSecondary, fontSize: 14),
//                               suffixIcon:Icon( Icons.phone , color: colorSecondary, size: 20),
//                             ),
//                           ),)
//                         ),
//
//                       ],  ),
                    16.height,
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
                          "Next",
                          style: TextStyle(color: whiteColor, fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    24.height,
                    // Align(
                    //   alignment: Alignment.bottomCenter,
                    //   child: GestureDetector(
                    //     onTap: () {
                    //      // finish(context);
                    //       _trySubmitForm();
                    //     },
                    //     child: Text.rich(
                    //       TextSpan(
                    //         text: "BHTxtAccount",
                    //         style: TextStyle(color: colorSecondary),
                    //         children: <TextSpan>[TextSpan(text: "SignIn", style: TextStyle(color: colorPrimary))],
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    // 8.height,
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

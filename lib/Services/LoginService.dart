import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:http/http.dart' as http;
import '../Models/MenuTreeModel.dart';
import '../Utils/AppColors.dart';
import '../View/Widgets/TreeView.dart';




var token="";

Login2(String username, String password, BuildContext context) async {

  final LocalStorage storage = new LocalStorage('user_info');
   String jwtToken = '';

  try {
    http.Response responseJson;
    responseJson = await http.post(
        Uri.parse('http://energy.mrad-services.com:1990/mobtms/login'),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
        },
        body: {

            'cmd': 'intlogin',
            'userid': username.toString(),
            'passid': password.toString(),

        }

    );

    final jsonData = jsonDecode(responseJson.body);
    print(jsonData.toString());

    List<MenuTreeModel> tree=[];
    if (jsonData[0]['reply']=="USRCHKOK")
    {
      print("Logged in successfully!");
      print(jsonData[1]['USRDATA']);
       jwtToken=jsonData[1]['USRDATA'];
       storage.setItem('jwtToken', jwtToken);



      Fluttertoast.showToast(
        msg: "Employee Login Successfull " ,
        toastLength: Toast.LENGTH_SHORT, // length
        gravity: ToastGravity.BOTTOM,    // location
        backgroundColor: colorSecondary,
      );
      // var   reqdata2={
      //
      //   "userID": "1",
      //   "systemID": "2205079085",
      // };
      //
      //
      //
      // token=jsonData[1]['USRDATA'];
      // await RealTimeService().httpTaqaReqload(context,"datareq","LOADMGTDATA",jsonEncode(reqdata2),token.toString());
       var JWTDATA=jsonData[1]['USRDATA'];
      // print("token 2222"+token.toString());
       Map<String, dynamic> jwtData = {};
       JwtDecoder.decode(JWTDATA.toString())!.forEach((key, value) async{
        jwtData[key] = value;
      //   // print(key);
      //   // print('$key : ${jwtData[key]}');
      //   ///the key data will be holding the user data, locations, systems....
      //   ///so once key is equal to data we need to convert to JSON this array of objects
      //   ///Object 0 for the user info
      //   ///Object 1 for the locations
      //   ///Object 2 for the systems
      //   ///Object 3 for the components
      //   ///
      //
        if(key=='data') {
          var USRData = jsonDecode(jwtData[key]);
          print("user1 ");
          print(USRData[0]);
          print("u2 ");
          print(USRData[1].length.toString());
          print(USRData[1][0]);
          print(USRData[1][1]);
          print(USRData[1][2]);
          print(USRData[1][3]);
          print(USRData[1][4]);
              for (var i=0;i<USRData[1].length;i++)
              {


                 tree.add(MenuTreeModel.fromJson(USRData[1][i]));}
        }
      //     // print(USRData[1][0]);
      //     //
      //     // print("Locations length ");
      //     // print(USRData[1].length);
      //     // print("systems xxxxxxxxx ");
      //     // print(USRData[2]);
      //     // print("systems111 ");
      //     // print(USRData[2][0]);
      //     //
      //     // print("components xxxxxxxxx ");
      //     // print(USRData[3]);
      //     // print("components length");
      //     // print(USRData[3].length);
      //     // print("components 1");
      //     // print(USRData[3][0]);
      //     // print("USRData[3][i][0]");
      //     // print(USRData[3][0]['AHLINEID']);
      //     // print(USRData[3][1]['AHLINEID']);
      //     // print(USRData[3][2]['AHLINEID']);
      //     // print("components 2");
      //     // print(USRData[3][1]);
      //     // print("components 3");
      //     // print(USRData[3][2]);
      //
      //     for (var i=0;i<USRData[1].length;i++)
      //     {
      //
      //
      //       var locationn=LocationModel.fromDatabaseJson(USRData[1][i]);
      //       // var locationn=LocationModel(
      //       //        AFLOCID: (USRData[1][0]['AFLOCID']).toString(),
      //       //        AFUSERID:  (USRData[1][0]['AFUSERID']).toString(),
      //       //        AFLONG: (USRData[1][0]['AFLONG']).toString(),
      //       //        AFLAT:  (USRData[1][0]['AFLAT']).toString(),
      //       //        AFPOWER: (USRData[1][0]['AFPOWER']).toString(),
      //       //        AFINSTDATE:  (USRData[1][0]['AFINSTDATE']).toString(),
      //       //        AFTYPE:  (USRData[1][0]['AFTYPE']).toString(),
      //       //        AFSTATUS: (USRData[1][0]['AFSTATUS']).toString(),
      //       //        AFALERT:(USRData[1][0]['AFALERT']).toString(),
      //       //        AFADDRESS:(USRData[1][0]['AFADDRESS']).toString(),
      //       //        AFDESC1:(USRData[1][0]['AFDESC1']).toString(),
      //       //        AFDESC2:(USRData[1][0]['AFDESC2']).toString(),
      //       //        AFLOC1:(USRData[1][0]['AFLOC1']).toString(),
      //       //        AFLOC2:(USRData[1][0]['AFLOC2']).toString(),
      //       //        AFLOC3:(USRData[1][0]['AFLOC3']).toString(),
      //       //        AFLOC4:(USRData[1][0]['AFLOC4']).toString(),
      //       //        AFSTAT:(USRData[1][0]['AFSTAT']).toString(),
      //       //        AFCAT1: (USRData[1][0]['AFCAT1']).toString(),
      //       //        AFCAT2:  (USRData[1][0]['AFCAT2']).toString(),
      //       //        AFCAT3: (USRData[1][0]['AFCAT3']).toString(),
      //       //        AFCAT4:  (USRData[1][0]['AFCAT4']).toString(),
      //       //        AFCAT5:  (USRData[1][0]['AFCAT5']).toString(),
      //       //        AFUPDATEDBY:  (USRData[1][0]['AFUPDATEDBY']).toString(),
      //       //        AFDATEUPDATED:  (USRData[1][0]['AFDATEUPDATED']).toString()
      //       //    );
      //       todoBloc.addTodo(locationn);}
      //
      //     var userr = User(
      //       TOKEN: jsonData[1]['USRDATA'].toString(),
      //       ACUSERID: (USRData[0]['ACUSERID']).toString(),
      //       ACADDRESSNB: (USRData[0]['ACADDRESSNB']).toString(),
      //       ACUSERNAME: (USRData[0]['ACUSERNAME']).toString(),
      //       ACUSERTYPE: (USRData[0]['ACUSERTYPE']).toString(),
      //       ACCAT1: (USRData[0]['ACCAT1']).toString(),
      //       ACCAT2: (USRData[0]['ACCAT2']).toString(),
      //       ACCAT3: (USRData[0]['ACCAT3']).toString(),
      //       ACCAT4: (USRData[0]['ACCAT4']).toString(),
      //       ACCAT5: (USRData[0]['ACCAT5']).toString(),
      //       ACUPDATEDBY: (USRData[0]['ACUPDATEDBY']).toString(),
      //       ABADDRESSNB: (USRData[0]['ABADDRESSNB']).toString(),
      //       ABADDRESSTYPE: (USRData[0]['ABADDRESSTYPE']).toString(),
      //       ABFNAME: (USRData[0]['ABFNAME']).toString(),
      //       ABMNAME: (USRData[0]['ABMNAME']).toString(),
      //       ABLNAME: (USRData[0]['ABLNAME']).toString(),
      //       ABBIRTHDATE: (USRData[0]['ABBIRTHDATE']).toString(),
      //       ABEMAIL: (USRData[0]['ABEMAIL']).toString(),
      //       ABCAZA: (USRData[0]['ABCAZA']).toString(),
      //       ABSTREET: (USRData[0]['ABSTREET']).toString(),
      //       ABPROVINCE: (USRData[0]['ABPROVINCE']).toString(),
      //       ABVILLAGE: (USRData[0]['ABVILLAGE']).toString(),
      //       ABBUILDING: (USRData[0]['ABBUILDING']).toString(),
      //       ABFLOOR: (USRData[0]['ABFLOOR']).toString(),
      //       ABPHONEPREF: (USRData[0]['ABPHONEPREF']).toString(),
      //       ABPHONENB: (USRData[0]['ABPHONENB']).toString(),
      //       ABCAT1: (USRData[0]['ABCAT1']).toString(),
      //       ABCAT2: (USRData[0]['ABCAT2']).toString(),
      //       ABCAT3: (USRData[0]['ABCAT4']).toString(),
      //       ABCAT5: (USRData[0]['ABCAT5']).toString(),
      //       ABSTAT: (USRData[0]['ABSTAT']).toString(),
      //       ABPROGRAMID:( USRData[0]['ABPROGRAMID']).toString(),
      //       ABUPDATEDBY: (USRData[0]['ABUPDATEDBY']).toString(),
      //       ABDATEUPDATED:( USRData[0]['ABDATEUPDATED']).toString(),
      //       ADUSERID: (USRData[0]['ADSYSTEMUSER']).toString(),
      //       ADENABLEDUSER: (USRData[0]['ADENABLEDUSER']).toString(),
      //       ADPASS: (USRData[0]['ADSEC1']).toString(),
      //       ADSEC2: (USRData[0]['ADSEC2:']).toString(),
      //       ADSEC3: (USRData[0]['ADSEC3']).toString(),
      //       ADSEC4: (USRData[0]['ADSEC4']).toString(),
      //       ADCAT1: (USRData[0]['ADCAT1']).toString(),
      //       ADCAT2: (USRData[0]['ADCAT2']).toString(),
      //       ADCAT3: (USRData[0]['ADCAT3']).toString(),
      //       ADCAT4: (USRData[0]['ADCAT4']).toString(),
      //       ADCAT5: (USRData[0]['ADCAT5']).toString(),
      //       ADSTAT: (USRData[0]['ADSTAT']).toString(),
      //       ADPLATFORM: (USRData[0]['ADPLATFORM']).toString(),
      //       ADSOCKETID: (USRData[0]['ADSOCKETID']).toString(),
      //       ADPUSHTOKEN: (USRData[0]['ADPUSHTOKEN']).toString(),
      //       ADSOCKETSTAT: (USRData[0]['ADSOCKETSTAT']).toString(),
      //       ADPUSHSTAT: (USRData[0]['ADPUSHSTAT']).toString(),
      //       ADBRAND: (USRData[0]['ADBRAND']).toString(),
      //       ADDEVICE: (USRData[0]['ADDEVICE']).toString(),
      //       ADDEVICEID: (USRData[0]['ADDEVICEID']).toString(),
      //       ADMODEL: (USRData[0]['ADMODEL']).toString(),
      //       ADOSID: (USRData[0]['ADOSID']).toString(),
      //       ADHOSTID: (USRData[0]['ADDATEUPDATED']).toString(),
      //       ADDATEUPDATED: (USRData[0]['ADDATEUPDATED']).toString(),
      //     );
      //
      //     userBloc.addUser(userr);
      //
      //     for (var i=0;i<USRData[2].length;i++)
      //     { var syss= System.fromDatabaseJson(USRData[2][i]);
      //     // {          var sys=    System(
      //     //             AGLINEID: (USRData[2][i]['AGLINEID']).toString(),
      //     //              AGLOCID:  (USRData[2][i]['AGLOCID']).toString(),
      //     //            AGUSERID: (USRData[2][i]['AGUSERID']).toString(),
      //     //          AGMMSID:  (USRData[2][i]['AGMMSID']).toString(),
      //     //         AGLONG: (USRData[2][i]['AGLONG']).toString(),
      //     //            AGLAT:  (USRData[2][i]['AGLAT']).toString(),
      //     //   AGPOWER:  (USRData[2][i]['AGPOWER']).toString(),
      //     //   AGSTATUS: (USRData[2][i]['AGSTATUS']).toString(),
      //     //   AGALERT:(USRData[2][i]['AGALERT']).toString(),
      //     //   AGDESC1:(USRData[2][i]['AGDESC1']).toString(),
      //     //   AGDESC2:(USRData[2][i]['AGDESC2']).toString(),
      //     //   AGSYS1:(USRData[2][i]['AGSYS1']).toString(),
      //     //   AGSYS2:(USRData[2][i]['AGSYS2']).toString(),
      //     //   AGSYS3:(USRData[2][i]['AGSYS3']).toString(),
      //     //   AGSYS4:(USRData[2][i]['AGSYS4']).toString(),
      //     //   AGCAT1:(USRData[2][i]['AGCAT1']).toString(),
      //     //   AGCAT2:(USRData[2][i]['AGCAT2']).toString(),
      //     //   AGCAT3: (USRData[2][i]['AGCAT3']).toString(),
      //     //   AGCAT4:  (USRData[2][i]['AGCAT4']).toString(),
      //     //   AGCAT5: (USRData[2][i]['AGCAT5']).toString(),
      //     //   AGUPDATEDBY:  (USRData[2][i]['AGUPDATEDBY']).toString(),
      //     //   AGDATEUPDATED:  (USRData[2][i]['AGDATEUPDATED']).toString(),
      //     //   AGSYSTEMID:  (USRData[2][i]['AGSYSTEMID']).toString(),
      //     //             AFLOCID: (USRData[2][i]['AFLOCID']).toString(),
      //     //             AFUSERID:  (USRData[2][i]['AFUSERID']).toString(),
      //     //       AFLONG: (USRData[2][i]['AFLONG']).toString(),
      //     //       AFLAT:  (USRData[2][i]['AFLAT']).toString(),
      //     //       AFPOWER: (USRData[2][i]['AFPOWER']).toString(),
      //     //       AFINSTDATE:  (USRData[2][i]['AFINSTDATE']).toString(),
      //     //       AFTYPE:  (USRData[2][i]['AFTYPE']).toString(),
      //     //       AFSTATUS: (USRData[2][i]['AFSTATUS']).toString(),
      //     //       AFALERT:(USRData[2][i]['AFALERT']).toString(),
      //     //       AFADDRESS:(USRData[2][i]['AFADDRESS']).toString(),
      //     //       AFDESC1:(USRData[2][i]['AFDESC1']).toString(),
      //     //       AFDESC2:(USRData[2][i]['AFDESC2']).toString(),
      //     //       AFLOC1:(USRData[2][i]['AFLOC1']).toString(),
      //     //       AFLOC2:(USRData[2][i]['AFLOC2']).toString(),
      //     //       AFLOC3:(USRData[2][i]['AFLOC3']).toString(),
      //     //       AFLOC4:(USRData[2][i]['AFLOC4']).toString(),
      //     //       AFSTAT:(USRData[2][i]['AFSTAT']).toString(),
      //     //       AFCAT1: (USRData[2][i]['AFCAT1']).toString(),
      //     //       AFCAT2:  (USRData[2][i]['AFCAT2']).toString(),
      //     //       AFCAT3: (USRData[2][i]['AFCAT3']).toString(),
      //     //       AFCAT4:  (USRData[2][i]['AFCAT4']).toString(),
      //     //       AFCAT5:  (USRData[2][i]['AFCAT5']).toString(),
      //     //       AFUPDATEDBY:  (USRData[2][i]['AFUPDATEDBY']).toString(),
      //     //       AFDATEUPDATED:  (USRData[2][i]['AFDATEUPDATED']).toString()
      //     //         );
      //     systemBloc.addSystem(syss);}
      //
      //
      //
      //     for (var i=0;i<USRData[3].length;i++)
      //     {
      //       var comp=    Component.fromDatabaseJson(USRData[3][i]);
      //       //   var comp=    Component(
      //       //     AHLINEID: (USRData[3][i]['AHLINEID']).toString(),
      //       //     AHEQUIPID:  (USRData[3][i]['AHEQUIPID']).toString(),
      //       //     AHSYSTEMID: (USRData[3][i]['AHSYSTEMID']).toString(),
      //       //     AHLOCID:  (USRData[3][i]['AHLOCID']).toString(),
      //       //     AHUSERID: (USRData[3][i]['AHUSERID']).toString(),
      //       //     AHEQUIPNB:  (USRData[3][i]['AHEQUIPNB']).toString(),
      //       //     AHPOWER:  (USRData[3][i]['AHPOWER']).toString(),
      //       //     AHSTATUS: (USRData[3][i]['AHSTATUS']).toString(),
      //       //     AHTEMP:(USRData[3][i]['AHTEMP']).toString(),
      //       //     AHEFFICIENCY:(USRData[3][i]['AHEFFICIENCY']).toString(),
      //       //     AHALERT:(USRData[3][i]['AHALERT']).toString(),
      //       //     AHDESC1:(USRData[3][i]['AHDESC1']).toString(),
      //       //     AHDESC2:(USRData[3][i]['AHDESC2']).toString(),
      //       //     AHCATEGORY1:(USRData[3][i]['AHCATEGORY1']).toString(),
      //       //     AHSERIALID:(USRData[3][i]['AHSERIALID']).toString(),
      //       //     AHIPADDRESS:(USRData[3][i]['AHIPADDRESS']).toString(),
      //       //     AHCOMTYPE:(USRData[3][i]['AHCOMTYPE']).toString(),
      //       //     AHCATEGORY2: (USRData[3][i]['AHCATEGORY2']).toString(),
      //       //     AHTYPE:  (USRData[3][i]['AHTYPE']).toString(),
      //       //     AHMPTTNB: (USRData[3][i]['AHMPTTNB']).toString(),
      //       //     AHVOC:  (USRData[3][i]['AHVOC']).toString(),
      //       //     AHISC:  (USRData[3][i]['AHISC']).toString(),
      //       //     AHSTRINGSNB:  (USRData[3][i]['AHSTRINGSNB']).toString(),
      //       //     AHBATPERSTR: (USRData[3][i]['AHBATPERSTR']).toString(),
      //       //     AHEQUIP1:  (USRData[3][i]['AHEQUIP1']).toString(),
      //       //     AHEQUIP2: (USRData[3][i]['AHEQUIP2']).toString(),
      //       //     AHEQUIP3:  (USRData[3][i]['AHEQUIP3']).toString(),
      //       //     AHEQUIP4: (USRData[3][i]['AHEQUIP4']).toString(),
      //       //     AHCAT1:  (USRData[3][i]['AHCAT1']).toString(),
      //       //     AHCAT2:  (USRData[3][i]['AHCAT2']).toString(),
      //       //     AHCAT3: (USRData[3][i]['AHCAT3']).toString(),
      //       //     AHCAT4:(USRData[3][i]['AHCAT4']).toString(),
      //       //     AHCAT5:(USRData[3][i]['AHCAT5']).toString(),
      //       //     AHUPDATEDBY:(USRData[3][i]['AHUPDATEDBY']).toString(),
      //       //     AHDATEUPDATED:(USRData[3][i]['AHDATEUPDATED']).toString()
      //       // );
      //       compBloc.addComponent(comp);
      //     }
      //
      //   }
      // });
       });
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TREEWidget( tree: tree)),
      );
    }
    else{
      print("Failed to Login !");
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





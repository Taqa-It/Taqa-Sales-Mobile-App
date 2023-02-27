import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//import 'package:flutter_svg/svg.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../Utils/AppColors.dart';
import '../../Utils/AppImages.dart';
import '../../Utils/AppSettings.dart';
import 'ClientInfoScreen.dart';
import 'T1Profile.dart';


class CustomerTypeScreen extends StatefulWidget{


  @override
  CustomerTypeScreenState createState() => CustomerTypeScreenState();
}

class CustomerTypeScreenState extends State<CustomerTypeScreen> {
  bool _showPassword = false;
  bool _showConfPassword=false;
  TextEditingController emailCont = TextEditingController();
  TextEditingController passwordCont = TextEditingController();
  TextEditingController fullNameCont = TextEditingController();
  TextEditingController dateOfBirthCont = TextEditingController();
  TextEditingController addressCont = TextEditingController();
  TextEditingController phoneCont = TextEditingController();
  TextEditingController confirmPasswordCont = TextEditingController();


  FocusNode fullNameFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode dobFocusNode = FocusNode();
  FocusNode addressFocusNode = FocusNode();
  FocusNode phoneFocusNode = FocusNode();
  FocusNode confirmpasswordFocusNode = FocusNode();
  @override
  void dispose() {
    super.dispose();
    fullNameFocusNode.dispose();
    passwordFocusNode.dispose();
    emailFocusNode.dispose();
    dobFocusNode.dispose();
    addressFocusNode.dispose();
    phoneFocusNode.dispose();
    confirmpasswordFocusNode.dispose();
  }


  // List<DataModel> dataList = [];
  // List<Countries> countriesList = [];
  // Countries dropdownValue = new Countries(id: 1,
  //     currencyId: 1,
  //     name: "name",
  //     code: "code",
  //     numCode: 1,
  //     phoneCode: 1,
  //     timezoneCode: "0");

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

  @override
  initState() {
    super.initState();
  //  fetchData();
  }





  // Define a key to access the form
  final _formKey = GlobalKey<FormState>();

  String _userEmail = '';
  String _userName = '';
  String _password = '';
  String _confirmPassword = '';
  String _country='';
  String _phoneNumber=' ';

  // This function is triggered when the user press the "Sign Up" button
  void _trySubmitForm() {
    final bool? isValid = _formKey.currentState?.validate();
    if (isValid == true) {
      debugPrint('Everything looks good!');
      debugPrint(_userEmail);
      debugPrint(_userName);
      debugPrint(_password);
      debugPrint(_confirmPassword);
      debugPrint(_country);
      debugPrint(_phoneNumber);

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
  @override
  Widget build(BuildContext context) {


    return SafeArea(
      child: Scaffold(
    //     appBar: AppBar(
    //     // leading:    IconButton(
    //     //   icon: Image.asset(menu, width: 25, height:25, color: whiteColor), onPressed: () { debugPrint("ddss") ;},
    //     // ),
    //       backgroundColor: colorSecondary,
    //     leading:ClipRRect(
    //     borderRadius: BorderRadius.all(Radius.circular(32.0)),
    // child: Material(
    // shadowColor: Colors.transparent,
    // color: Colors.transparent,
    // child: IconButton(
    // icon:
    // // Icon(
    // //   Icons.menu,
    // //   color: Colors.black,
    // // ),
    // Image.asset(menu, width: 25, height:25, color: whiteColor),
    // onPressed: widget.onMenuPressed,
    // ),
    // ),
    // ),),
        backgroundColor:  colorSecondary,
        body:
        Stack(
            children: <Widget>[
        Column(children: [       Container(
        margin: EdgeInsets.only(top: 10),
        child: Align(
          alignment: Alignment.topCenter,
          // child: SvgPicture.asset(ic_logo, color: white.withOpacity(0.8), height: 150, width: 150),
          child:       Image.asset("images/appimages/client.png", height: 155),
          //commonCacheImageWidget(ic_logo_white, 150),
        ),
      ),
    //  Text("Clients",style: boldTextStyle(color: Colors.white,size: 25,fontFamily: 'Semibold'),)

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
    child:


Center(child:
    SingleChildScrollView(
    child:
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
        InkWell(child:
              Column(children: [
                Image.asset("images/appimages/newclient.png", height: 180),
                SizedBox(),
             //   Text("New Customer",style: boldTextStyle(size: 20,color: colorSecondary),),

              ]), onTap: () { BHRegistrationScreen().launch(context);}),
       //       SizedBox(width: 50,),
              InkWell(child:
              Column(children: [
                Image.asset("images/appimages/exclient.png", height: 180),
                SizedBox(),

             //   Text("Existing Customer",style: boldTextStyle(size: 20,color: colorSecondary),),

              ],),
                  onTap: () { T1Profile().launch(context);}
                  ,)
            ],)
          ],
        ),   ),),)
                  ],
    ),
    ),
    );
  }

}

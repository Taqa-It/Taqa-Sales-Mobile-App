
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
//import 'package:flutter_svg/svg.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../Models/CountryModel.dart';
import '../../Models/FormData.dart';
import '../../Services/DataManager.dart';
import '../../Services/GetCountryIPService.dart';
import '../../Utils/AppColors.dart';
import '../../Utils/AppImages.dart';
import '../../Utils/AppSettings.dart';
import 'SytemRequirementScreen.dart';
StreamController<String> streamController = StreamController<String>.broadcast();

class BHRegistrationScreen extends StatefulWidget {


  @override
  NewRegistrationScreenState createState() => NewRegistrationScreenState();
}

class NewRegistrationScreenState extends State<BHRegistrationScreen> {
  bool _showPassword = false;
  bool _showConfPassword=false;
  TextEditingController emailCont = TextEditingController();
  TextEditingController passwordCont = TextEditingController();
  TextEditingController fullNameCont = TextEditingController();
  TextEditingController lastNameCont = TextEditingController();
  TextEditingController dateOfBirthCont = TextEditingController();
  TextEditingController provinceCont = TextEditingController();
  TextEditingController casaCont = TextEditingController();
  TextEditingController cityCont = TextEditingController();
  TextEditingController addressCont = TextEditingController();
  TextEditingController phoneCont = TextEditingController();
  TextEditingController confirmPasswordCont = TextEditingController();


  FocusNode fullNameFocusNode = FocusNode();
  FocusNode lastNameFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode dobFocusNode = FocusNode();
  FocusNode addressFocusNode = FocusNode();
  FocusNode casaFocusNode = FocusNode();
  FocusNode cityFocusNode = FocusNode();
  FocusNode provinceFocusNode = FocusNode();
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


  @override
  initState() {

    emailCont.text = 'a@gmail.com';

     fullNameCont.text  = 'aaa';
     lastNameCont.text  = 'bbb';

    provinceCont.text  = 'ppp';
     casaCont.text  = 'ccc';
   cityCont.text  = 'ttt';
   addressCont.text  = 'ggg';
     phoneCont.text  = '0123456';

    super.initState();
    fetchData();
  }





  // Define a key to access the form
  final _formKey = GlobalKey<FormState>();
  String _userfName = '';
  String _userlName = '';
  String _userEmail = '';
  String _userprovince = '';
  String _usercasa = '';

  String _usercity = '';
  String _useraddressDetails= '';
  String _prefix=' ';
  String _phoneNumber=' ';

  // This function is triggered when the user press the "Sign Up" button
  Future<void> _trySubmitForm() async {


    final bool? isValid = _formKey.currentState?.validate();
    if (isValid == true) {
      debugPrint('Everything looks good!');
      debugPrint(_userEmail);
      debugPrint(_userlName);
      debugPrint(_userfName);
      debugPrint(_userprovince);
      debugPrint(_usercasa+_useraddressDetails);
      debugPrint(dropdownValue.phoneCode.toString()+_phoneNumber);
      _prefix='00'+dropdownValue.phoneCode.toString();
      List<String> userInfo=[_userfName,_userlName,_userEmail,_userprovince,_usercasa,_usercity,_useraddressDetails,_prefix,_phoneNumber];
  //    FormDataModel formData= new FormDataModel( userInfo: userInfo);

      SytemRequirementScreen(userInfo,streamController.stream).launch(context);
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
        appBar: AppBar(title: Text("Add New Client"), backgroundColor: colorSecondary,),
        backgroundColor: colorSecondary,
        body: Stack(
          children: <Widget>[
            Column(children: [       Container(
              margin: EdgeInsets.only(top: 5),
              child: Align(
                alignment: Alignment.topCenter,
                // child: SvgPicture.asset(ic_logo, color: white.withOpacity(0.8), height: 150, width: 150),
                child:       Image.asset("images/appimages/customer.png", height: 150),
                //commonCacheImageWidget(ic_logo_white, 150),
              ),
            ),
            Text("Add New Client",style: boldTextStyle(color: Colors.white,size: 25,fontFamily: 'Semibold'),)

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

                    TextFormField(
                      controller: fullNameCont,
                      focusNode: fullNameFocusNode,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (value) {
                        FocusScope.of(context).requestFocus(lastNameFocusNode);
                      },
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'This field is required';
                        }
                        if (value.trim().length < 3) {
                          return 'first name must be at least 3 characters in length';
                        }
                        return null;
                      },
                     onChanged: (value) => _userfName = value,
                      style: TextStyle(color: blackColor),
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color:colorSecondary)),
                        focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: colorSecondary)),
                        labelText: "First Name",
                        labelStyle: TextStyle(color: colorSecondary, fontSize: 14),
                  //      suffixIcon: Icon(Icons.person, color: colorSecondary, size: 18),
                      ),
                    ),
                    TextFormField(
                      controller: lastNameCont,
                      focusNode: lastNameFocusNode,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (value) {
                        FocusScope.of(context).requestFocus(emailFocusNode);
                      },
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'This field is required';
                        }
                        if (value.trim().length < 3) {
                          return 'last name must be at least 3 characters in length';
                        }
                        return null;
                      },
                      onChanged: (value) => _userlName = value,
                      style: TextStyle(color: blackColor),
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color:colorSecondary)),
                        focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: colorSecondary)),
                        labelText: "Last Name",
                        labelStyle: TextStyle(color: colorSecondary, fontSize: 14),
                      //  suffixIcon: Icon(Icons.person, color: colorSecondary, size: 18),
                      ),
                    ),
                    TextFormField(
                      controller: emailCont,
                      focusNode: emailFocusNode,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (value) {
                        FocusScope.of(context).requestFocus(provinceFocusNode);
                      },
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter your email address';
                        }
                        if (!RegExp(EmailRegex).hasMatch(value)) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                      onChanged: (value) => _userEmail = value,
                      style: TextStyle(color: blackColor),
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: colorSecondary)),
                        focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: colorSecondary)),
                        labelText: "Email",
                        labelStyle: TextStyle(color: colorSecondary, fontSize: 14),
                     //   suffixIcon:Icon( Icons.email , color: colorSecondary, size: 20),
                      ),
                    ),

                    Row(children: [
                      Expanded(child:  TextFormField(
                        controller: provinceCont,
                        focusNode:provinceFocusNode,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (value) {
                          FocusScope.of(context).requestFocus(casaFocusNode);
                        },
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter your  address';
                          }
                          // if (!RegExp(EmailRegex).hasMatch(value)) {
                          //   return 'Please enter a valid email address';
                          // }
                          return null;
                        },
                        onChanged: (value) => _userprovince = value,
                        style: TextStyle(color: blackColor),
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: colorSecondary)),
                          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: colorSecondary)),
                          labelText: "Province",
                          labelStyle: TextStyle(color: colorSecondary, fontSize: 14),
                        ///  suffixIcon:Icon( Icons.location_on , color: colorSecondary, size: 20),
                        ),
                      )),
                      SizedBox(width: 10,),
                      Expanded(child:  TextFormField(
                        controller:casaCont,
                        focusNode: casaFocusNode,
                        keyboardType: TextInputType.streetAddress,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (value) {
                          FocusScope.of(context).requestFocus(cityFocusNode);
                        },
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter your  address';
                          }
                          // if (!RegExp(EmailRegex).hasMatch(value)) {
                          //   return 'Please enter a valid email address';
                          // }
                          return null;
                        },
                        onChanged: (value) => _usercasa = value,
                        style: TextStyle(color: blackColor),
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: colorSecondary)),
                          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: colorSecondary)),
                          labelText: "Casa",
                          labelStyle: TextStyle(color: colorSecondary, fontSize: 14),
                       //   suffixIcon:Icon( Icons.location_on , color: colorSecondary, size: 20),
                        ),
                      )),
                      SizedBox(width: 10,),
                      Expanded(child:  TextFormField(
                        controller: cityCont,
                        focusNode: cityFocusNode,
                        keyboardType: TextInputType.streetAddress,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (value) {
                          FocusScope.of(context).requestFocus(addressFocusNode);
                        },
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter your  address';
                          }
                          // if (!RegExp(EmailRegex).hasMatch(value)) {
                          //   return 'Please enter a valid email address';
                          // }
                          return null;
                        },
                        onChanged: (value) => _usercity = value,
                        style: TextStyle(color: blackColor),
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: colorSecondary)),
                          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: colorSecondary)),
                          labelText: "City/Village",
                          labelStyle: TextStyle(color: colorSecondary, fontSize: 14),
                          //suffixIcon:Icon( Icons.location_on , color: colorSecondary, size: 20),
                        ),
                      )),
                    ],),
                    TextFormField(

                      controller: addressCont,
                      focusNode: addressFocusNode,
                      keyboardType: TextInputType.streetAddress,
                      textInputAction: TextInputAction.next,
                      maxLines: 1,
                      onFieldSubmitted: (value) {
                        FocusScope.of(context).requestFocus(phoneFocusNode);
                      },
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter your  address';
                        }
                        // if (!RegExp(EmailRegex).hasMatch(value)) {
                        //   return 'Please enter a valid email address';
                        // }
                        return null;
                      },
                      onChanged: (value) => _useraddressDetails = value,
                      style: TextStyle(color: blackColor),
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: colorSecondary)),
                        focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: colorSecondary)),

                        // prefixIcon: Padding(
                        //   padding: EdgeInsets.all(0.0),
                        //   child: Icon(
                        //     Icons.pin_drop,
                        //     color: colorSecondary,
                        //   ), // icon is 48px widget.
                        // ),
                        labelText: "Address Details",

                        labelStyle: TextStyle(color: colorSecondary, fontSize: 14),
                        //   suffixIcon:Icon( Icons.location_on , color: colorSecondary, size: 20),
                      ),
                    ),
                    // TextFormField(
                    //   controller:passwordCont,
                    //   focusNode: passwordFocusNode,
                    //   obscureText: !_showPassword,
                    //   keyboardType: TextInputType.text,
                    //   validator: (value) {
                    //     if (value == null || value.trim().isEmpty) {
                    //       return 'This field is required';
                    //     }
                    //     // if (value.trim().length < 7) {
                    //     //   return 'Password must be at least 7 characters in length';
                    //     // }
                    //     if (!RegExp(PasswordRegex).hasMatch(value)) {
                    //       return 'Password should be at least 7 characters'
                    //           '\n with 1 capital letter, one number, and one special character';
                    //     }
                    //     return null;
                    //   },
                    //   onChanged: (value) => _password = value,
                    //   style: TextStyle(color: blackColor),
                    //   decoration: InputDecoration(
                    //     labelText: "Password",
                    //     labelStyle: TextStyle(color: colorSecondary, fontSize: 14),
                    //     suffixIcon: GestureDetector(
                    //       onTap: () {
                    //         setState(() {
                    //           _showPassword = !_showPassword;
                    //         });
                    //       },
                    //       child: Icon(_showPassword ? Icons.visibility : Icons.visibility_off, color: colorSecondary, size: 20),
                    //     ),
                    //     enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: colorSecondary)),
                    //     focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: colorSecondary)),
                    //   ),
                    // ),
                    // TextFormField(
                    //   controller: confirmPasswordCont,
                    //   focusNode: confirmpasswordFocusNode,
                    //   obscureText: !_showConfPassword,
                    //   keyboardType: TextInputType.text,
                    //   validator: (value) {
                    //     if (value == null || value.isEmpty) {
                    //       return 'This field is required';
                    //     }
                    //     if (value != _password) {
                    //       return 'Confirmation password doesn\'t match';
                    //     }
                    //     return null;
                    //   },
                    //   onChanged: (value) => _confirmPassword = value,
                    //   style: TextStyle(color: blackColor),
                    //   decoration: InputDecoration(
                    //     labelText: "Confirm Password",
                    //     labelStyle: TextStyle(color: colorSecondary, fontSize: 14),
                    //     suffixIcon: GestureDetector(
                    //       onTap: () {
                    //         setState(() {
                    //           _showConfPassword = !_showConfPassword;
                    //         });
                    //       },
                    //       child: Icon(_showConfPassword ? Icons.visibility : Icons.visibility_off, color: colorSecondary, size: 20),
                    //     ),
                    //     enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: colorSecondary)),
                    //     focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: colorSecondary)),
                    //   ),
                    // ),

                    Row(
                      children: <Widget>[

                        Expanded(
                          flex: 1,
                      child:
SizedBox(height: 48,child:
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

                      DropdownButtonFormField<Countries>(
                            isExpanded: true,
                            elevation: 10,
                            focusColor: colorSecondary,
                            value: dropdownValue,
                            icon: Icon(Icons.arrow_drop_down,color: colorSecondary, size: 34),
                            // underline: Container(
                            //   height: 2,
                            //   color: colorPrimary,
                            // ),
                            onChanged: ( data) {
                              setState(() {
                                dropdownValue = data! ;
                                //_country=data.name;
                              });
                            },
                            items: countriesList.map<DropdownMenuItem<Countries>>((Countries value) {
                              String flagName= 'images/flags/'+value.code.toLowerCase()+".png";
                              return DropdownMenuItem<Countries>(
                                value: value,
                                child: Row(    children: <Widget>[
                                  Image.asset(flagName, height: 15, fit: BoxFit.cover),
                                  Text("  "+value.name+" (+"+value.phoneCode.toString()+")",style:TextStyle(color:blackColor, fontSize: 10)),
                                ]),
                              );
                            }).toList(),
                          ),

                      )),
                        ),
                        SizedBox( width:10),
                        Expanded(
                          flex: 2,
                          child:
                              SizedBox(height: 49 , child:
                          TextFormField(

                            controller: phoneCont,
                            focusNode: phoneFocusNode,
                            keyboardType: TextInputType.phone,
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'This field is required';
                              }

                              // if(!validatePhoneNumber(dropdownValue.phoneCode,value))
                              //   return 'Enter a valid phone number ';
                            },
                            onChanged: (value) => _phoneNumber = value,
                            style: TextStyle(color: blackColor),
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: colorSecondary)),
                              focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: colorSecondary)),
                              labelText: "Phone Number",
                              labelStyle: TextStyle(color: colorSecondary, fontSize: 14),
                             // suffixIcon:Icon( Icons.phone , color: colorSecondary, size: 20),
                            ),
                          ),)
                        ),

                      ],  ),
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

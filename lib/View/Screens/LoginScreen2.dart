import 'dart:convert';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../Services/LoginService.dart';
import '../../Utils/AppColors.dart';
import '../../Utils/AppImages.dart';
import '../../Utils/AppSettings.dart';
import 'package:flutter/services.dart';
class LoginScreen2 extends StatefulWidget {


  @override
  LoginScreen2State createState() => LoginScreen2State();
}

class LoginScreen2State extends State<LoginScreen2> {
  bool _isChecked = false;
  TextEditingController emailCont = TextEditingController();
  TextEditingController passwordCont = TextEditingController();
  bool _showPassword = false;
  FocusNode emailFocusNode = FocusNode();
  FocusNode passWordFocusNode = FocusNode();
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  Map<String, dynamic> _deviceData = <String, dynamic>{};
  String device="";
  String brand="";
  String host="";
  String id="";
  String model="";
  @override
  void dispose() {
    super.dispose();
    emailFocusNode.dispose();
    passWordFocusNode.dispose();
  }
  @override
  void initState() {

   _loadUserEmailPassword();


    super.initState();
  }
  final _formKey = GlobalKey<FormState>();
  void _handleRemeberme(bool? value) {
    _isChecked = value!;
    SharedPreferences.getInstance().then(
          (prefs) {
        prefs.setBool("remember_me", value);
        prefs.setString('email', emailCont.text);
        prefs.setString('password', passwordCont.text);
      },
    );
    setState(() {
      _isChecked = value;
    });
  }

  //load email and password
  void _loadUserEmailPassword() async {
    try {
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      var _email = _prefs.getString("email") ?? "";
      var _password = _prefs.getString("password") ?? "";
      var _remeberMe = _prefs.getBool("remember_me") ?? false;
      print(_remeberMe);
      print(_email);
      print(_password);
      if (_remeberMe) {
        setState(() {
          _isChecked = true;
        });

        emailCont.text = _email ?? "";
        passwordCont.text = _password ?? "";

        Login2(emailCont.text,passwordCont.text,context);
      }



    } catch (e)
    {
      print(e);
    }
  }




  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        backgroundColor: colorSecondary,
        body: Stack(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 40),
              child: Align(
                alignment: Alignment.topCenter,
                child:  Image.asset(ic_logo_white,height: 90,),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 170),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topRight: Radius.circular(15), topLeft: Radius.circular(15)),
                color: whiteColor,
              ),
              child:
              SingleChildScrollView(
                child:
                Form(
                  key: _formKey,
                  child: Column(
                  children: <Widget>[
                    TextFormField(
                      controller: emailCont,
                      focusNode: emailFocusNode,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (value) {
                        FocusScope.of(context).requestFocus(passWordFocusNode);
                      },
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'This field is required';
                        }
                        if (!RegExp(EmailRegex).hasMatch(value)) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                      style: TextStyle(color: blackColor),
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppDividerColor)),
                        focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: colorSecondary)),
                        labelText: "Email",
                        labelStyle: TextStyle(color: GreyColor, fontSize: 14),
                      ),
                    ),
                    TextFormField(
                      controller: passwordCont,
                      focusNode: passWordFocusNode,
                      obscureText: !_showPassword,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'This field is required';
                        }
                        if (!RegExp(PasswordRegex).hasMatch(value)) {
                          return 'Enter a valid password';
                        }
                        return null;
                      },
                      style: TextStyle(color: blackColor),
                      decoration: InputDecoration(
                        labelText: "Password",
                        labelStyle: TextStyle(color: GreyColor, fontSize: 14),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              _showPassword = !_showPassword;
                            });
                          },
                          child: Icon(_showPassword ? Icons.visibility : Icons.visibility_off, color: colorSecondary, size: 20),
                        ),
                        enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppDividerColor)),
                        focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: colorSecondary)),
                      ),
                    ),
                    SizedBox(height: 16),
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {
                        //  BHForgotPasswordScreen().launch(context);
                        },
                        child: Text("Forget Password?", style: TextStyle(color: AppTextColorSecondary, fontSize: 14)),
                      ),
                    ),
                    16.height,
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: colorSecondary,
                          padding: EdgeInsets.all(12),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                        ),
                        onPressed: () async {
                         // Prints a list that include Fido.

print("pressing");
                          Login2(emailCont.text,passwordCont.text,context);
print("pressing2");




                        },
                        child: Text("Sign In", style: TextStyle(color: whiteColor, fontSize: 15, fontWeight: FontWeight.bold)),
                      ),
                    ),

                    16.height,

                        Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                          SizedBox(
                              height: 24.0,
                              width: 24.0,
                              child: Theme(
                                data: ThemeData(
                                    unselectedWidgetColor:colorSecondary // Your color
                                ),
                                child: Checkbox(
                                    activeColor:colorBlue,
                                    value: _isChecked,
                                    onChanged: _handleRemeberme),
                              )),
                          SizedBox(width: 10.0),
                          Text("Remember Me Auto Sign In",
                              style: TextStyle(
                                  color: Color(0xff646464),
                                  fontSize: 12,
                                  fontFamily: 'Rubic'))
                        ])

                  ],
                ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}

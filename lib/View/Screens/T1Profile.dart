import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../Utils/AppColors.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../Utils/auto_size_text/auto_size_text.dart';


class T1Profile extends StatelessWidget {
  static var tag = "/T1Profile";

  // Widget counter(String counter, String counterName) {
  //   return Column(
  //     children: <Widget>[
  //       profile(counter),
  //       text(counterName, textColor: appStore.textPrimaryColor, fontSize: textSizeMedium, fontFamily: fontMedium),
  //     ],
  //   );
  // }

  @override
  Widget build(BuildContext context) {
   // changeStatusColor(appStore.appBarColor!);
    final profileImg = Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0),
      alignment: FractionalOffset.center,
      child: CircleAvatar(
        backgroundColor: colorSecondary.withOpacity(0.2),
          child:    Image.asset("images/appimages/client.png"),
        radius: 50,
      ),
    );
    final profileContent = Container(
      margin: EdgeInsets.only(top: 55.0),
      decoration: BoxDecoration(color: colorWhite, ),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            SizedBox(height: 50),
            Text('Client name',style: boldTextStyle(), ),
            SizedBox(height: 10,),
            Text('client@hotmail.com',style: boldTextStyle(color: colorSecondary), ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Divider(color: Colors.grey, height: 0.5),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Column(
                      children: <Widget>[
                      Text("Solar Panels",style: boldTextStyle(color: colorSecondary),), Text("5")

                      ],),
                Column(
                  children: <Widget>[

                    Text("Batteries",style: boldTextStyle(color: colorSecondary),), Text("2")
                  ],),

                Column(
                  children: <Widget>[

                    Text("Systems",style: boldTextStyle(color: colorSecondary),), Text("2")
                  ],),
              ],
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
    return Scaffold(
      appBar: AppBar(title: Text("Existing Customer"), backgroundColor: colorSecondary,),
      body:SingleChildScrollView(
          padding: EdgeInsets.only(top: 0, left: 2, right: 2),
          physics: ScrollPhysics(),
          child: Container(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
            //    SizedBox(height: 16),

                Container(
                  margin: EdgeInsets.fromLTRB(16, 16, 16, 8),
                  child: Stack(
                    children: <Widget>[profileContent, profileImg],
                  ),
                ),
                SizedBox(height: 8),
                Container(
                  width:  MediaQuery.of(context).size.width,
                  margin: EdgeInsets.fromLTRB(16, 8, 16, 8),
                  decoration: BoxDecoration(color: white, ),

                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 8),
                        Text("Personal",style: boldTextStyle(size: 18),),
                        SizedBox(height: 16),
                        Text("username"),
                        Padding(
                          padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
                          child: SizedBox(),
                        ),
                        SizedBox(height: 8),
                        Text("Male"),
                        Padding(
                          padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
                          child: SizedBox(),
                        ),
                        SizedBox(height: 8),
                        AutoSizeText('address', maxLines: 2),
                        SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Container(
                  width:  MediaQuery.of(context).size.width,
                  margin: EdgeInsets.fromLTRB(16, 8, 16, 8),
                  decoration: BoxDecoration(color: white, ),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 8),
                        Text('Contacts',style: boldTextStyle(size: 18),),
                        SizedBox(height: 16),
                        Text("+961 3723688"),
                        Padding(
                          padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
                          child: SizedBox(),
                        ),
                        SizedBox(height: 8),
                       Text("user@gmail.com"),
                        SizedBox(height: 8),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16),
              ],
            ),
          ),
        ),

    );
  }
}

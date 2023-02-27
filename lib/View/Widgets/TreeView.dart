

import '../../Models/MenuTreeModel.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:nb_utils/nb_utils.dart';
import '../../Utils/AppColors.dart';

import '../Screens/LoginScreen2.dart';
import '../Screens/customerTypeScreen.dart';


class TREEWidget extends StatefulWidget {
  List<MenuTreeModel> tree;
  TREEWidget( {required this.tree});

  @override
  _TREEWidgetState createState() => _TREEWidgetState();
}

class _TREEWidgetState extends State<TREEWidget> with TickerProviderStateMixin {
  //final TodoBloc todoBloc = TodoBloc();
  // final UserBloc userBloc = UserBloc();
  // late User user=User();
  //
  // late KFDrawerController _drawerController;
  /// Your server data
  final serverData = [
    {
      "checked": true,
      "children": [
        {
          "checked": true,
          "show": true,
          "children": [],
          "id": 11,
          "pid": 1,
          "text": "Clients",
        },
        {
          "checked": true,
          "show": true,
          "children": [],
          "id": 11,
          "pid": 1,
          "text": "Reports",
        },
        {
          "checked": true,
          "show": true,
          "children": [],
          "id": 11,
          "pid": 1,
          "text": "Dashboard",
        },
        {
          "checked": true,
          "show": true,
          "children": [],
          "id": 11,
          "pid": 1,
          "text": "Company",
        },
      ],
      "id": 1,
      "pid": 0,
      "show": true,
      "text": "Sales",
    },
    // {
    //   "checked": true,
    //   "show": true,
    //   "children": [],
    //   "id": 2,
    //   "pid": 0,
    //   "text": "Parent title 2",
    // },
    // {
    //   "checked": true,
    //   "children": [],
    //   "id": 3,
    //   "pid": 0,
    //   "show": true,
    //   "text": "Parent title 3",
    // },
  ];
//  late List<TreeNodeData> treeData ;
  late List<MenuTreeModel> parents =[];
  late List<MenuTreeModel> childs = [];
  @override
  initState()  {

    for(int i =0;i<widget.tree.length;i++)
      {

        print("hellod");
        if(widget.tree[i].AFLINEID==widget.tree[i].AFPARENTLINEID)
          parents.add(widget.tree[i]);

        else childs.add(widget.tree[i]);
        //print("I am the paremt"+widget.tree.where((element) => element.AFPARENTLINEID == element.AFLINEID).first.AFPAGEDESC.toString());
      }

    for(int i =0;i<parents.length;i++)
      print("I am the paremt"+parents[i].AFPAGEDESC.toString());


    for(int i =0;i<childs.length;i++)
      print("I am the child"+childs[i].AFPAGEDESC.toString());

    super.initState();
    // treeData = List.generate(
    //   serverData.length,
    //       (index) => mapServerDataToTreeData(serverData[index]),
    // );
//_asyncMethod();
 //   ClassBuilder.registerClasses();
    // _drawerController = KFDrawerController(
    //   initialPage: ClassBuilder.fromString('CustomerTypeScreen'),
    //   items: [
    //     KFDrawerItem.initWithPage(
    //       text: Text('Sales', style: boldTextStyle(color:   colorSecondary,size: 16)),
    //      icon: Icon(Icons.home, color:  colorSecondary,size: 20,),
    //       page: CustomerTypeScreen(),
    //     ),
    //     KFDrawerItem.initWithPage(
    //       text: Text(
    //         'Clients',
    //         style: boldTextStyle(color:colorSecondary,size: 14),
    //       ),
    //       icon: Icon(Icons.subdirectory_arrow_right_outlined, color:colorSecondary,size: 18,),
    //       page: ClassBuilder.fromString('NewsPage'),
    //     ),
    //     KFDrawerItem.initWithPage(
    //       text: Text(
    //         'Reports',
    //         style: TextStyle(color:colorSecondary),
    //       ),
    //       icon: Icon(Icons.subdirectory_arrow_right_outlined, color:colorSecondary,size: 18,),
    //       page: ClassBuilder.fromString('NewsPage'),
    //     ),
    //     KFDrawerItem.initWithPage(
    //       text: Text(
    //         'Dashboard',
    //         style: TextStyle(color:colorSecondary),
    //       ),
    //       icon: Icon(Icons.subdirectory_arrow_right_outlined, color:colorSecondary,size: 18,),
    //       page: ClassBuilder.fromString('SettingsPage'),
    //     ),
    //     KFDrawerItem.initWithPage(
    //       text: Text(
    //         'Company',
    //         style: TextStyle(color:colorSecondary),
    //       ),
    //    icon: Icon(Icons.subdirectory_arrow_right_outlined, color:colorSecondary,size: 18,),
    //       page: LocationsScreen(),
    //     ),
    //
    //     // KFDrawerItem.initWithPage(
    //     //   text: Text(
    //     //     '                  Portfolio',
    //     //     style: TextStyle(color:colorSecondary),
    //     //   ),
    //     // //  icon: Icon(Icons.subdirectory_arrow_right_outlined, color:colorSecondary),
    //     //   page: LocationsScreen(),
    //     // ),
    //     // KFDrawerItem.initWithPage(
    //     //   text: Text(
    //     //     '                  Presentation',
    //     //     style: TextStyle(color:colorSecondary),
    //     //   ),
    //     //   //icon: Icon(Icons.subdirectory_arrow_right_outlined, color:colorSecondary),
    //     //   page: LocationsScreen(),
    //     // ),
    //
    //
    //
    //   ],
    // );
    //   print("user init");
  }
//   _asyncMethod() async {
//    // userr=await getuser();
// print("user async");
//   }
//   Future<List<TreeNodeData>> _load(TreeNodeData parent) async {
//     await Future.delayed(const Duration(seconds: 1));
//     final data = [
//       TreeNodeData(
//         title: 'Load node 1',
//         expaned: false,
//         checked: true,
//         children: [],
//         extra: null,
//       ),
//       TreeNodeData(
//         title: 'Load node 2',
//         expaned: false,
//         checked: false,
//         children: [],
//         extra: null,
//       ),
//     ];
//
//     return data;
//   }
//   /// Map server data to tree node data
//   TreeNodeData mapServerDataToTreeData(Map data) {
//     return TreeNodeData(
//       extra: data,
//       title: data['text'],
//       expaned: data['show'],
//       checked: data['checked'],
//       children:
//       List.from(data['children'].map((x) => mapServerDataToTreeData(x))),
//     );
//   }

  /// Generate tree data

  @override
  Widget build(BuildContext context) {
    //print("user build");
    double width = MediaQuery. of(context). size. width ;
    double height = MediaQuery. of(context). size. height ;

    return Scaffold(
    appBar: AppBar(title: Text(''),backgroundColor: colorSecondary,bottomOpacity: 0,),
    body: CustomerTypeScreen(),
    drawer: Drawer(
    // Add a ListView to the drawer. This ensures the user can scroll
    // through the options in the drawer if there isn't enough vertical
    // space to fit everything.
    child:



    ListView(
    // Important: Remove any padding from the ListView.
    padding: EdgeInsets.zero,
    children: [
    const DrawerHeader(
    decoration: BoxDecoration(
    color: colorSecondary,
    ),
    child: CircleAvatar(
      backgroundColor: whiteColor,
      radius: 40,

      child:Icon(Icons.person,size:80,color: GreyColor,),
      // Text(
      //   "S",
      //   style: TextStyle(fontSize: 40.0,color: colorPrimary),
      // ),
    )).cornerRadiusWithClipRRectOnly(bottomLeft: 0),
      // TreeView(
      //
      //   data: treeData,
      //   lazy: true,
      //  icon:	Icon(Icons.subdirectory_arrow_right),
      //  // load: _load,
      //   //   showActions: true,
      //   //   showCheckBox: true,
      //   // showFilter: true,
      //   // append: (parent) {
      //   //   print(parent.extra);
      //   //   return TreeNodeData(
      //   //     title: 'Appended',
      //   //     expaned: true,
      //   //     checked: true,
      //   //     children: [],
      //   //   );
      //   // },
      //   onLoad: (node) {
      //     print('onLoad');
      //     print(node);
      //   },
      //   onAppend: (node, parent) {
      //     print('onAppend');
      //     print(node);
      //   },
      //   onCheck: (checked, node) {
      //     print('checked');
      //     print('onCheck');
      //     print(node);
      //   },
      //   onCollapse: (node) {
      //     print('onCollapse');
      //     print(node);
      //   },
      //   onExpand: (node) {
      //     print('onExpand');
      //     print(node);
      //   },
      //   onRemove: (node, parent) {
      //     print('onRemove');
      //     print(node);
      //   },
      //   onTap: (node) {
      //     print('onTap');
      //     print(node);
      //   },
      // ),
//       Theme(
//         data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
//         child:
//       ExpansionTile(
//         initiallyExpanded: true,
//         trailing: Icon(Icons.subdirectory_arrow_right,color: Colors.transparent,size: 15,),
//         leading:Icon(Icons.subdirectory_arrow_right,color: colorSecondary,) ,
//         title: Text('Sales',style: boldTextStyle(color: colorSecondary,size: 15),),
//        // subtitle: Text('Sales'),
//         children: <Widget>[
// Padding(padding:EdgeInsets.only(left: 26.0) ,
//   child:ListTile(title: Align(
//     child: new Text('Clients'),
//     alignment: Alignment(-1.2, 0),
//   ),
//   leading: Icon(Icons.subdirectory_arrow_right,size: 18,color: colorSecondary,),
//
//   onTap: (){
//
//     TREEWidget(tree:widget.tree).launch(context);
//
//   },
//   ),),
//           Padding(padding:EdgeInsets.only(left: 26.0) ,
//             child:ListTile(title: Align(
//               child: new Text('Reports'),
//               alignment: Alignment(-1.2, 0),
//             ),
//               leading: Icon(Icons.subdirectory_arrow_right,size: 18,color: colorSecondary,),),),Padding(padding:EdgeInsets.only(left: 26.0) ,
//             child:ListTile(title: Align(
//               child: new Text('Dashboard'),
//               alignment: Alignment(-1.2, 0),
//             ),
//               leading: Icon(Icons.subdirectory_arrow_right,size: 18,color: colorSecondary,),),),
//           Padding(padding:EdgeInsets.only(left: 26.0) ,
//             child:ListTile(title: Align(
//               child: new Text('Company'),
//               alignment: Alignment(-1.2, 0),
//             ),
//               leading: Icon(Icons.subdirectory_arrow_right,size: 18,color: colorSecondary,),),),
//         ],
//       )),
     for(int i =0;i<parents.length;i++)
       Theme(
           data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
           child:
           ExpansionTile(
             initiallyExpanded: true,
             trailing: Icon(Icons.subdirectory_arrow_right,color: Colors.transparent,size: 15,),
             leading:Icon(Icons.subdirectory_arrow_right,color: colorSecondary,) ,
             title: Text(parents[i].AFPAGEDESC.toString(),style: boldTextStyle(color: colorSecondary,size: 15),),
             // subtitle: Text('Sales'),
             children: <Widget>[
               for(int j =0;j<childs.where((element) => element.AFPARENTLINEID==parents[i].AFLINEID).length;j++)
               Padding(padding:EdgeInsets.only(left: 26.0) ,
                 child:ListTile(title: Align(
                   child: new Text(childs[j].AFPAGEDESC.toString().toString()),
                   alignment: Alignment(-1.2, 0),
                 ),
                   leading: Icon(Icons.subdirectory_arrow_right,size: 18,color: colorSecondary,),

                   onTap: (){

                     TREEWidget(tree:widget.tree).launch(context);

                   },
                 ),),
               // Padding(padding:EdgeInsets.only(left: 26.0) ,
               //   child:ListTile(title: Align(
               //     child: new Text('Reports'),
               //     alignment: Alignment(-1.2, 0),
               //   ),
               //     leading: Icon(Icons.subdirectory_arrow_right,size: 18,color: colorSecondary,),),),
               // Padding(padding:EdgeInsets.only(left: 26.0) ,
               //   child:ListTile(title: Align(
               //     child: new Text('Dashboard'),.where((element) => element.AFPARENTLINEID==parents[i].AFLINEID)
               //     alignment: Alignment(-1.2, 0),
               //   ),
               //     leading: Icon(Icons.subdirectory_arrow_right,size: 18,color: colorSecondary,),),),
               // Padding(padding:EdgeInsets.only(left: 26.0) ,
               //   child:ListTile(title: Align(
               //     child: new Text('Company'),
               //     alignment: Alignment(-1.2, 0),
               //   ),
               //     leading: Icon(Icons.subdirectory_arrow_right,size: 18,color: colorSecondary,),),),
             ],
           )),


      Divider(height: 10,color: Colors.transparent,),

     InkWell(child:   Row(children: [
       SizedBox(width: 20,),
       Icon(Icons.input,size: 14,),
       Text("     Logout")],),onTap: (){
       // Navigator.of(context).push(CupertinoPageRoute(
       //   fullscreenDialog: true,
       //   builder: (BuildContext context) {
       //     //return AuthPage();
       //
       //     return LoginScreen2();
       //   },
       // ));
       SharedPreferences.getInstance().then(
             (prefs) {
           prefs.setBool("remember_me", false);
           prefs.setString('email', "");
           prefs.setString('password', "");
         },
       );
       Navigator.of(context).push(CupertinoPageRoute(
         fullscreenDialog: true,
         builder: (BuildContext context) {
           //return AuthPage();

           return LoginScreen2();
         },
       ));

     },)


    ],
    ),
    ),
    );





  }




}

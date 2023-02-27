import 'dart:async';
import 'package:localstorage/localstorage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/directions.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:nb_utils/nb_utils.dart';
import 'dart:math' as Math;

import '../../Utils/AppColors.dart';
class TutorialOverlay extends ModalRoute<void> {

  late CameraPosition _initialposition ;

 // LocalStorage localStorage =  LocalStorage('user_info');
  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;

  void getloc() async {

    print("getegtet");
    Position position = await _geolocatorPlatform.getCurrentPosition();


    setState(() {
      _initialposition =  CameraPosition(target: LatLng(position.latitude, position.longitude), zoom: 19.0);

    });
  }
  Future<CameraPosition> getData() async {
    print("getegtet");
    Position position = await _geolocatorPlatform.getCurrentPosition();


    return   CameraPosition(target: LatLng(position.latitude, position.longitude), zoom: 19.0);


  }
  Completer<GoogleMapController> _controller = Completer();
  static const LatLng _center = const LatLng(45.521563, -122.677433);
  final Set<Marker> _markers = {};
  final Set<Polygon> _polygons = {};
  LatLng _lastMapPosition = _center;
  MapType _currentMapType = MapType.normal;
  List<LatLng> polyPoints = [];
  String location = "Search Location";


  static final CameraPosition _position1 = CameraPosition(
      bearing: 192.833,
      target: LatLng(33.8930754, 35.4862055),
      zoom: 19.0,
      tilt: 59.440
  );
  Future<void> _goToPosition1() async {

    setState(() {
      location ="Search Location";});
    final GoogleMapController controller = await _controller.future;
    CameraPosition cp= await getData();
    controller.animateCamera(CameraUpdate.newCameraPosition(cp));
  }

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(33.8930754, 35.4862055),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);
  _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }

  _onMapTypeButtonPressed() {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal
          ? MapType.satellite
          : MapType.normal;
    });
  }
  _onTapMarkerAdd(LatLng latLng) {
    setState(() {
      polyPoints.add(latLng);
      _drawPolygon(polyPoints);
      _markers.add(
        Marker(
          draggable: true,
          markerId: MarkerId(latLng.toString()),
          position: latLng,
          //infoWindow: InfoWindow(title: 'Marker', snippet: ''),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
          onDragEnd: (LatLng latLng) {
            print(latLng);
            print(latLng.toString());
          },
        ),
      );
    });
  }

  _clearAllMarkers() {
    setState(() {
      _markers.clear();
      _polygons.clear();
      polyPoints.clear();
    });
  }

  _drawPolygon(List<LatLng> listLatLng) {
    setState(() {
      _polygons.add(Polygon(
          polygonId: PolygonId('123'),
          points: listLatLng,
          fillColor: Colors.transparent,
          strokeColor: colorBlue));
    });
  }

  _calculateArea() {


    polyPoints.add(polyPoints[0]);
    print(calculatePolygonArea(polyPoints));
    Fluttertoast.showToast(
        msg: calculatePolygonArea(polyPoints).toString() +
            " m2",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: colorBlue,
        textColor: Colors.white,
        fontSize: 16.0);

  //  localStorage.setItem("area", calculatePolygonArea(polyPoints).round().toString());

   // print(    localStorage.getItem("area").toString());
  }

  static double calculatePolygonArea(List coordinates) {
    double area = 0;

    if (coordinates.length > 2) {
      for (var i = 0; i < coordinates.length - 1; i++) {
        var p1 = coordinates[i];
        var p2 = coordinates[i + 1];
        area += convertToRadian(p2.longitude - p1.longitude) *
            (2 +
                Math.sin(convertToRadian(p1.latitude)) +
                Math.sin(convertToRadian(p2.latitude)));
      }

      area = area * 6378137 * 6378137 / 2;
    }
    // * 0.000247105
    return area.abs();  //sq meters to Acres
  }

  static double convertToRadian(double input) {
    return input * Math.pi / 180;
  }

  Widget button(void Function() function, IconData icon) {
    return FloatingActionButton(
      onPressed: function,
      materialTapTargetSize: MaterialTapTargetSize.padded,
      backgroundColor: Colors.blue,
      child: Icon(icon, size: 36.0),
      heroTag:icon.toString(),

    );
  }

  LocalStorage localStorage =  LocalStorage('user_info');

  @override
  Duration get transitionDuration => Duration(milliseconds: 500);

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => false;

  @override
  Color get barrierColor => Colors.black.withOpacity(0.5);

  @override
  String get barrierLabel => 'null';

  @override
  bool get maintainState => true;

  @override
  Widget buildPage(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      ) {
    // This makes sure that text and other content follows the material style
    return Material(
      type: MaterialType.card,
      // make sure that the overlay content is not cut off
      child: SafeArea(
        child: _buildOverlayContent(context),
      ),
    );
  }

  Widget _buildOverlayContent(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          // Text(
          //   'This is a nice overlay',
          //   style: TextStyle(color: Colors.white, fontSize: 30.0),
          // ),




          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Dismiss'),
          )
        ],
      ),
    );
  }

  @override
  Widget buildTransitions(
      BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    // You can add your own animations for the overlay content
    return FadeTransition(
      opacity: animation,
      child: ScaleTransition(
        scale: animation,
        child: child,
      ),
    );
  }
}



// class TestPage extends StatelessWidget {
//   void _showOverlay(BuildContext context) {
//     Navigator.of(context).push(TutorialOverlay());
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Test')),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Center(
//           child: RaisedButton(
//             onPressed: () => _showOverlay(context),
//             child: Text('Show Overlay'),
//           ),
//         ),
//       ),
//     );
//   }


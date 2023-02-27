import 'dart:async';
import 'dart:ffi';


import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:geocoding/geocoding.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:localstorage/localstorage.dart';
import '../../Utils/AppColors.dart';
import 'package:nb_utils/nb_utils.dart';
import 'dart:math' as Math;

import 'ClientInfoScreen.dart';

class googlemapsSimulator extends StatefulWidget {
//  final Stream<String>? stream;
 // googlemapsSimulator();
  @override
  _googlemapsSimulatorState createState() => _googlemapsSimulatorState();
}

class _googlemapsSimulatorState extends State<googlemapsSimulator> {
    late CameraPosition _initialposition ;

    LocalStorage localStorage =  LocalStorage('user_info');
    final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;
  @override
  void initState() {


    _initialposition =  CameraPosition(target: LatLng(double.parse(localStorage.getItem('latitude').toString()), double.parse(localStorage.getItem('longitude').toString())), zoom: 19.0);

   getloc();

    super.initState();


  }
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
    String areay="";
    void mySetState(String index) {
      setState(() {
        areay=index;
        print("timetotime froOm "+areay.toString());

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

 // localStorage.setItem("area", calculatePolygonArea(polyPoints).round().toString());

    streamController.sink.add(calculatePolygonArea(polyPoints).round().toString());

 //   print(    localStorage.getItem("area").toString());
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

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("Simulator"),
        backgroundColor: colorSecondary,

          leading:  BackButton(
            color: Colors.white, // <-- SEE HERE
              onPressed:() {
              Navigator.pop(context);
              setState(() {

              });
              } ,
          ),



          ) ,


      body:
      Stack(
        children: <Widget>[
          // FutureBuilder(
          //   builder: (ctx, snapshot) {
          //     // Checking if future is resolved or not
          //     if (snapshot.connectionState == ConnectionState.done) {
          //       // If we got an error
          //       if (snapshot.hasError) {
          //         return Center(
          //           child: Text(
          //             '${snapshot.error} occurred',
          //             style: TextStyle(fontSize: 18),
          //           ),
          //         );
          //
          //         // if we got our data
          //       } else if (snapshot.hasData) {
          //         // Extracting data from snapshot object
          //         final data = snapshot.data as CameraPosition;
          //        return GoogleMap(
          //           onMapCreated: _onMapCreated,
          //           initialCameraPosition:data,
          //           mapType: _currentMapType,
          //           markers: _markers,
          //           polygons: _polygons,
          //           onCameraMove: _onCameraMove,
          //           myLocationEnabled: true,
          //           onTap: (LatLng latLng) {
          //             _onTapMarkerAdd(latLng);
          //           },
          //         );
          //       }
          //     }
          //
          //     // Displaying LoadingSpinner to indicate waiting state
          //     return Center(
          //       child: CircularProgressIndicator(),
          //     );
          //   },
          //
          //   // Future that needs to be resolved
          //   // inorder to display something on the Canvas
          //   future: getData(),
          // ),


    GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition:_initialposition,
            mapType: _currentMapType,
            markers: _markers,
            polygons: _polygons,
            onCameraMove: _onCameraMove,
            myLocationEnabled: true,
            onTap: (LatLng latLng) {
              _onTapMarkerAdd(latLng);
            },
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.bottomRight,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 16.0),
                  SizedBox(height: 16.0),
                  SizedBox(height: 16.0),
                  SizedBox(height: 16.0),
                  button(_onMapTypeButtonPressed, Icons.map),
                  SizedBox(height: 16.0),
                  button(_goToPosition1, Icons.location_searching),
                  SizedBox(height: 16.0),
                  button(_clearAllMarkers, Icons.location_off),
                  SizedBox(height: 16.0),
                  button(_calculateArea, Icons.av_timer),
                ],
              ),
            ),
          ),
          //search autoconplete input

          Positioned(  //search input bar
              top:10,
              child: InkWell(
                  onTap: () async {
                    var place = await PlacesAutocomplete.show(
                        context: context,
                        apiKey: 'AIzaSyCAXCaiTtRVRVSXyf3IEOt0CTu_XkXDePE',
                        mode: Mode.overlay,
                        types: [],
                        strictbounds: false,
                       components: [new Component(Component.country, "lb")],

                    //google_map_webservice package
                        onError: (err){
                          print(err);
                        }
                    );

                    if(place != null){
                      setState(() {
                        location = place.description.toString();
                      });

                      //form google_maps_webservice package
                      final plist = GoogleMapsPlaces(

                        apiKey:'AIzaSyCAXCaiTtRVRVSXyf3IEOt0CTu_XkXDePE',
                        apiHeaders: await GoogleApiHeaders().getHeaders(),
                        //from google_api_headers package
                      );
                      String placeid = place.placeId ?? "0";
                      final detail = await plist.getDetailsByPlaceId(placeid);
                      final geometry = detail.result.geometry!;
                      final lat = geometry.location.lat;
                      final lang = geometry.location.lng;
                      var newlatlang = LatLng(lat, lang);

                      final GoogleMapController controllerr = await _controller.future;

                      //move map camera to selected place with animation
                      controllerr.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: newlatlang, zoom: 19)));
                    }
                  },
                  child:Padding(
                    padding: EdgeInsets.all(15),
                    child: Card(
                      child: Container(
                          padding: EdgeInsets.all(0),
                          width: MediaQuery.of(context).size.width - 40,
                          child: ListTile(
                            title:Text(location, style: TextStyle(fontSize: 18),),
                            trailing: Icon(Icons.search),
                            dense: true,
                          )
                      ),
                    ),
                  )
              )
          ),


        ],
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
  }

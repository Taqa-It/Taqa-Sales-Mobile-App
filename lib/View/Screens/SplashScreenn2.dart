import 'dart:async';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:localstorage/localstorage.dart';
import '../../Utils/AppColors.dart';
import '../../Utils/AppImages.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:geolocator/geolocator.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:geocoding/geocoding.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'LoginScreen2.dart';
class SplashScreenn2 extends StatefulWidget {

  @override
  _SplashScreenn2State createState() => _SplashScreenn2State();
}

class _SplashScreenn2State extends State<SplashScreenn2> with SingleTickerProviderStateMixin {
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  Map<String, dynamic> _deviceData = <String, dynamic>{};

  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;
  // Future<Position> getPosition() async {
  //   Position position = await _geolocatorPlatform.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  //   return position;
  // }
  String _locality = '';


  Future<Placemark> getPlacemark(double latitude, double longitude) async {
    final List<Placemark> placemark = await placemarkFromCoordinates(latitude, longitude);
    print("pddpdpddp"+placemark.length.toString());
    print("pddpdpddqp"+placemark[0].toString());
    print("pddpdpddp"+placemark[1].toString());
    print("pddpdpddp"+placemark[2].toString());
    print("pddpdpddp"+placemark[3].toString());
    print("pddpdpddp"+placemark[4].toString());
    return placemark[0];
  }





  Future<Position> _getCurrentPosition() async {
    final hasPermission = await _handlePermission();

    if (!hasPermission) {
      return Position(longitude: 0, latitude: 0, timestamp: null, accuracy: 0.0, altitude:  0.0, heading:  0.0, speed:  0.0, speedAccuracy:  0.0) ;
    }

    Position position = await _geolocatorPlatform.getCurrentPosition();
    // _updatePositionList(
    //   _PositionItemType.position,
    return position;
    //   position.toString(),
    // );
  }

  Future<bool> _handlePermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await _geolocatorPlatform.isLocationServiceEnabled();
 //   await Permission.locationWhenInUse.serviceStatus.isEnabled;
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.

print("lalalalaa");

Fluttertoast.showToast(
  msg: "Please turn on Location services from settings and restart the app  " ,
  toastLength: Toast.LENGTH_LONG, // length
  gravity: ToastGravity.BOTTOM,    // location
  backgroundColor: colorSecondary,
);
      return false;
    }
    permission = await _geolocatorPlatform.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await _geolocatorPlatform.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.


        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.


      return false;
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.

    return true;
    }

    // String _locality = '';

  // Future<Placemark> getPlacemark(double latitude, double longitude) async {
  //   List<Placemark> placemark = await Geolocator()
  //       .placemarkFromCoordinates(latitude, longitude);
  //   return placemark[0];
  //}
  startTime() async {

    var _duration = Duration(seconds: 5);
    return Timer(_duration, navigationPage);
  }

  @override
  void initState() {

    super.initState();
    initPlatformState();
   getloc();
    startTime();

  }


  final LocalStorage storage =  LocalStorage('user_info');
  String lat = '';
  String long='';
  String location = '';

void getloc()  async{

  var f=await _getCurrentPosition();
  debugPrint("location");
 debugPrint(f.latitude.toString());
 debugPrint(f.longitude.toString());
  debugPrint(f.accuracy.toString());
 var p=await getPlacemark(f.latitude,f.longitude);
 // 33.885820

//  TodoDao daoo=TodoDao();
//  List<LocationModel> us= await daoo.getLocs();
  // var p=await getPlacemark(double.parse(us[0].AFLONG.toString()) ,double.parse(f.latitude.toString()));
  //  var w=await getData(double.parse(us[0].AFLONG.toString()) ,double.parse(us[0].AFLAT.toString()));
  //var p=await getPlacemark( 33.885820,35.489136);

  print(p.country);
  print(p.name);
  print(p.administrativeArea);
  print(p.locality);
  print(p.postalCode);
  print(p.subAdministrativeArea);
  print(p.subLocality);
  print(p.subThoroughfare);


   lat = f.latitude.toString();
   long=f.longitude.toString();
   location = p.street.toString();
 await storage.setItem('latitude', lat);
  await storage.setItem('longitude', long);
  await  storage.setItem('ulocation', location);

  String xx= storage.getItem('ulocation').toString();
print('l'+location);
print(xx);

}





  void navigationPage() {
    finish(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
    //    SleepTrackerSample(),
        LoginScreen2()
  //MainWidget(),
      //  SliderPage(),
        //FabmenuPage(),
        // Pagination(),
           //MainWidget()
      //    HomePage(),
      ),
    );
  }
  Future<void> initPlatformState() async {
    var deviceData = <String, dynamic>{};

    try {
      if (kIsWeb) {
        deviceData = _readWebBrowserInfo(await deviceInfoPlugin.webBrowserInfo);
      } else {
        if (Platform.isAndroid) {
          deviceData =
              _readAndroidBuildData(await deviceInfoPlugin.androidInfo);
        } else if (Platform.isIOS) {
          deviceData = _readIosDeviceInfo(await deviceInfoPlugin.iosInfo);
        } else if (Platform.isLinux) {
          deviceData = _readLinuxDeviceInfo(await deviceInfoPlugin.linuxInfo);
        } else if (Platform.isMacOS) {
          deviceData = _readMacOsDeviceInfo(await deviceInfoPlugin.macOsInfo);
        } else if (Platform.isWindows) {
          deviceData =
              _readWindowsDeviceInfo(await deviceInfoPlugin.windowsInfo);
        }
      }
    } on PlatformException {
      deviceData = <String, dynamic>{
        'Error:': 'Failed to get platform version.'
      };
    }

    if (!mounted) return;

    setState(() {
      _deviceData = deviceData;
    });
    print(  Platform.isAndroid
        ? 'Android Device Info'
        : Platform.isIOS
        ? 'iOS Device Info'
        : '');
    for (dynamic property in   _deviceData.keys) {
      print("cfrr");  print('model'+'${_deviceData['model']}');
    }
    // _deviceData.keys.map(
    //         (String property) {
    //
    //
    //         });
  }

  Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo build) {
    return <String, dynamic>{
      'version.securityPatch': build.version.securityPatch,
      'version.sdkInt': build.version.sdkInt,
      'version.release': build.version.release,
      'version.previewSdkInt': build.version.previewSdkInt,
      'version.incremental': build.version.incremental,
      'version.codename': build.version.codename,
      'version.baseOS': build.version.baseOS,
      'board': build.board,
      'bootloader': build.bootloader,
      'brand': build.brand,
      'device': build.device,
      'display': build.display,
      'fingerprint': build.fingerprint,
      'hardware': build.hardware,
      'host': build.host,
      'id': build.id,
      'manufacturer': build.manufacturer,
      'model': build.model,
      'product': build.product,
      'supported32BitAbis': build.supported32BitAbis,
      'supported64BitAbis': build.supported64BitAbis,
      'supportedAbis': build.supportedAbis,
      'tags': build.tags,
      'type': build.type,
      'isPhysicalDevice': build.isPhysicalDevice,
      'systemFeatures': build.systemFeatures,
      'displaySizeInches':
      ((build.displayMetrics.sizeInches * 10).roundToDouble() / 10),
      'displayWidthPixels': build.displayMetrics.widthPx,
      'displayWidthInches': build.displayMetrics.widthInches,
      'displayHeightPixels': build.displayMetrics.heightPx,
      'displayHeightInches': build.displayMetrics.heightInches,
      'displayXDpi': build.displayMetrics.xDpi,
      'displayYDpi': build.displayMetrics.yDpi,
    };
  }

  Map<String, dynamic> _readIosDeviceInfo(IosDeviceInfo data) {
    return <String, dynamic>{
      'name': data.name,
      'systemName': data.systemName,
      'systemVersion': data.systemVersion,
      'model': data.model,
      'localizedModel': data.localizedModel,
      'identifierForVendor': data.identifierForVendor,
      'isPhysicalDevice': data.isPhysicalDevice,
      'utsname.sysname:': data.utsname.sysname,
      'utsname.nodename:': data.utsname.nodename,
      'utsname.release:': data.utsname.release,
      'utsname.version:': data.utsname.version,
      'utsname.machine:': data.utsname.machine,
    };
  }

  Map<String, dynamic> _readLinuxDeviceInfo(LinuxDeviceInfo data) {
    return <String, dynamic>{
      'name': data.name,
      'version': data.version,
      'id': data.id,
      'idLike': data.idLike,
      'versionCodename': data.versionCodename,
      'versionId': data.versionId,
      'prettyName': data.prettyName,
      'buildId': data.buildId,
      'variant': data.variant,
      'variantId': data.variantId,
      'machineId': data.machineId,
    };
  }

  Map<String, dynamic> _readWebBrowserInfo(WebBrowserInfo data) {
    return <String, dynamic>{
      'browserName': describeEnum(data.browserName),
      'appCodeName': data.appCodeName,
      'appName': data.appName,
      'appVersion': data.appVersion,
      'deviceMemory': data.deviceMemory,
      'language': data.language,
      'languages': data.languages,
      'platform': data.platform,
      'product': data.product,
      'productSub': data.productSub,
      'userAgent': data.userAgent,
      'vendor': data.vendor,
      'vendorSub': data.vendorSub,
      'hardwareConcurrency': data.hardwareConcurrency,
      'maxTouchPoints': data.maxTouchPoints,
    };
  }

  Map<String, dynamic> _readMacOsDeviceInfo(MacOsDeviceInfo data) {
    return <String, dynamic>{
      'computerName': data.computerName,
      'hostName': data.hostName,
      'arch': data.arch,
      'model': data.model,
      'kernelVersion': data.kernelVersion,
      'osRelease': data.osRelease,
      'activeCPUs': data.activeCPUs,
      'memorySize': data.memorySize,
      'cpuFrequency': data.cpuFrequency,
      'systemGUID': data.systemGUID,
    };
  }

  Map<String, dynamic> _readWindowsDeviceInfo(WindowsDeviceInfo data) {
    return <String, dynamic>{
      'numberOfCores': data.numberOfCores,
      'computerName': data.computerName,
      'systemMemoryInMegabytes': data.systemMemoryInMegabytes,
      'userName': data.userName,
      'majorVersion': data.majorVersion,
      'minorVersion': data.minorVersion,
      'buildNumber': data.buildNumber,
      'platformId': data.platformId,
      'csdVersion': data.csdVersion,
      'servicePackMajor': data.servicePackMajor,
      'servicePackMinor': data.servicePackMinor,
      'suitMask': data.suitMask,
      'productType': data.productType,
      'reserved': data.reserved,
      'buildLab': data.buildLab,
      'buildLabEx': data.buildLabEx,
      'digitalProductId': data.digitalProductId,
      'displayVersion': data.displayVersion,
      'editionId': data.editionId,
      'installDate': data.installDate,
      'productId': data.productId,
      'productName': data.productName,
      'registeredOwner': data.registeredOwner,
      'releaseId': data.releaseId,
      'deviceId': data.deviceId,
    };
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: whiteColor,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Image.asset(ic_logo,  width: 250,height: 150,),
               SizedBox(height: 10),
                SpinKitFadingFour(
                  itemBuilder: (BuildContext context, int index) {
                    return DecoratedBox(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: index.isEven ? colorBlue : colorGreen
                      ),
                    );
                  },),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

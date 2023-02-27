class LoadAppliance {


  String applianceId;
  String applianceName;
  String  averagePower;
  String quantity;
  String timeUsed;
  String dayNight;
  bool checked;


  LoadAppliance({
    required this.applianceId,
    required this.applianceName,
    required this.averagePower,
    required this.quantity,
    required this.timeUsed,
    required this.dayNight,
    required this.checked,

  });
  Map<String, dynamic> toJson() => {

    'applianceName': applianceName,
    'averagePower': averagePower,
    'quantity': quantity,
    'timeUsed': timeUsed,
    'dayNight': dayNight,



  };
}
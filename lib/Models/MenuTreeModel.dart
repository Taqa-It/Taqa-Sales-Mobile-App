class MenuTreeModel {

  // "MONDAY": {
  // "AMFROMTIME": "00:01:01",
  // "AMTOTIME": "00:01:01",
  // "STATUS": "Y"
  String? ACUSERID;
  String? ACADDRESSNB;
  String? ACUSERNAME;
  String? ACUSERTYPE;
  String? ACCAT1;
  String? ACCAT2;
  String? ACCAT3;
  String? ACCAT4;
  String? ACCAT5;

  String? ACUPDATEDBY;
  String? ACUPDATEDDATE;
  String? ACSTAT;
  String? AFLINEID;
  String? AFUSERID;

  String? AFPAGE;
  String? AFPAGEDESC;
  String? AFSTAT;

  String? AFCAT1;
  String? AFCAT2;
  String? AFCAT3;
  String? AFCAT4;
  String? AFCAT5;


  String? AFPLATFORM;
  String? AFTYPE;
  String? AFPARENTLINEID;

  MenuTreeModel({
    this.ACUSERID,
    this.ACADDRESSNB,
    this.ACUSERNAME,
    this.ACUSERTYPE,
    this.ACCAT1,
    this.ACCAT2,
    this.ACCAT3,
    this.ACCAT4,
    this.ACCAT5,

    this.ACUPDATEDBY,
    this.ACUPDATEDDATE,
    this.ACSTAT,
    this.AFLINEID,
    this.AFUSERID,

    this.AFPAGE,
    this.AFPAGEDESC,
    this.AFSTAT,
    this.AFCAT1,
    this.AFCAT2,
    this.AFCAT3,
    this.AFCAT4,
    this.AFCAT5,
    this.AFPLATFORM,
    this.AFTYPE,
    this.AFPARENTLINEID,
  });

  factory MenuTreeModel.fromJson(Map<String, dynamic> data) => MenuTreeModel(
      ACUSERID: (data['ACUSERID']).toString(),
      ACADDRESSNB: (data['ACADDRESSNB']).toString(),
      ACUSERNAME: (data['ACUSERNAME']).toString(),
      ACUSERTYPE: (data['ACUSERTYPE']).toString(),
      ACCAT1: (data['ACCAT1']).toString(),
      ACCAT2: (data['ACCAT2']).toString(),
      ACCAT3: (data['ACCAT3']).toString(),
      ACCAT4: (data['ACCAT4']).toString(),
      ACCAT5: (data['ACCAT5']).toString(),
      ACUPDATEDBY: (data['ACUPDATEDBY']).toString(),
      ACUPDATEDDATE: (data['ACUPDATEDDATE']).toString(),
      ACSTAT: (data['ACSTAT']).toString(),
      AFLINEID: (data['AFLINEID']).toString(),
      AFUSERID: (data['AFUSERID']).toString(),
      AFPAGE: (data['AFPAGE']).toString(),
      AFPAGEDESC: (data['AFPAGEDESC']).toString(),
      AFSTAT: (data['AFSTAT']).toString(),
      AFCAT1: (data['AFCAT1']).toString(),
      AFCAT2: (data['AFCAT2']).toString(),
      AFCAT3: (data['AFCAT3']).toString(),
      AFCAT4: (data['AFCAT4']).toString(),
      AFCAT5: (data['AFCAT5']).toString(),
      AFPLATFORM: (data['AFPLATFORM']).toString(),
      AFTYPE: (data['AFTYPE']).toString(),
      AFPARENTLINEID:   (data['AFPARENTLINEID']).toString(),

  );

  Map<String, dynamic> toJson() => {
    "ACUSERID": ACUSERID,
    "ACADDRESSNB": ACADDRESSNB,
    'ACUSERNAME' : ACUSERNAME,
    'ACUSERTYPE': ACUSERTYPE,
    "ACCAT1": ACCAT1,
    "ACCAT2": ACCAT2,
    "ACCAT3":ACCAT3,
    "ACCAT4": ACCAT4,
    "ACCAT5": ACCAT5,
    "ACUPDATEDBY": ACUPDATEDBY,
    "ACUPDATEDDATE": ACUPDATEDDATE,
    "AFLINEID": AFLINEID,
    "AFUSERID": AFUSERID,
    "AFPAGE": AFPAGE,
    "AFPAGEDESC": AFPAGEDESC,
    "AFSTAT": AFSTAT,
    "AFCAT1": AFCAT1,
    "AFCAT2": AFCAT2,
    "AFCAT3": AFCAT3,
    'AFCAT4': AFCAT4,
    "AFCAT5": AFCAT5,
    "AFPLATFORM": AFPLATFORM,
    "AFTYPE": AFTYPE,
    "AFPARENTLINEID": AFPARENTLINEID,

  };
}
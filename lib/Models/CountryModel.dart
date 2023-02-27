// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

// import 'dart:convert';
//
// DataModel welcomeFromJson(String str) => DataModel.fromJson(json.decode(str));
//
// String welcomeToJson(DataModel data) => json.encode(data.toJson());
//
// class DataModel {
//   DataModel({
//     required this.isChanged,
//     required this.countryHash,
//     required this.languageHash,
//     required this.currenciesHash,
//     required this.retCodeMessagesHash,
//     required this.countries,
//     required this.languages,
//     required this.currencies,
//     required this.retCodeMessages,
//   });
//
//   bool isChanged;
//   int countryHash;
//   int languageHash;
//   int currenciesHash;
//   int retCodeMessagesHash;
//   List<Country> countries;
//   List<Language> languages;
//   List<Currency> currencies;
//   RetCodeMessages retCodeMessages;
//
//   factory DataModel.fromJson(Map<String, dynamic> json) => DataModel(
//     isChanged: json["isChanged"],
//     countryHash: json["countryHash"],
//     languageHash: json["languageHash"],
//     currenciesHash: json["currenciesHash"],
//     retCodeMessagesHash: json["retCodeMessagesHash"],
//     countries: List<Country>.from(json["countries"].map((x) => Country.fromJson(x))),
//     languages: List<Language>.from(json["languages"].map((x) => Language.fromJson(x))),
//     currencies: List<Currency>.from(json["currencies"].map((x) => Currency.fromJson(x))),
//     retCodeMessages: RetCodeMessages.fromJson(json["retCodeMessages"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "isChanged": isChanged,
//     "countryHash": countryHash,
//     "languageHash": languageHash,
//     "currenciesHash": currenciesHash,
//     "retCodeMessagesHash": retCodeMessagesHash,
//     "countries": List<dynamic>.from(countries.map((x) => x.toJson())),
//     "languages": List<dynamic>.from(languages.map((x) => x.toJson())),
//     "currencies": List<dynamic>.from(currencies.map((x) => x.toJson())),
//     "retCodeMessages": retCodeMessages.toJson(),
//   };
// }
//
// class Country {
//   Country({
//     required this.id,
//     required this.currencyId,
//     required this.name,
//     required this.code,
//     required this.numCode,
//     required this.phoneCode,
//     required this.timezoneCode,
//   });
//
//   int id;
//   int currencyId;
//   String name;
//   String code;
//   int numCode;
//   int phoneCode;
//   String timezoneCode;
//
//   factory Country.fromJson(Map<String, dynamic> json) => Country(
//     id: json["id"],
//     currencyId: json["currencyId"],
//     name: json["name"],
//     code: json["code"],
//     numCode: json["num_code"],
//     phoneCode: json["phone_code"],
//     timezoneCode: json["timezone_code"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "currencyId": currencyId,
//     "name": name,
//     "code": code,
//     "num_code": numCode,
//     "phone_code": phoneCode,
//     "timezone_code": timezoneCode,
//   };
// }
//
// class Currency {
//   Currency({
//     required this.id,
//     required this.name,
//     required this.code,
//     required this.status,
//     required  this.countries,
//   });
//
//   int id;
//   String name;
//   String code;
//   int status;
//   dynamic countries;
//
//   factory Currency.fromJson(Map<String, dynamic> json) => Currency(
//     id: json["id"],
//     name: json["name"],
//     code: json["code"],
//     status: json["status"],
//     countries: json["countries"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "name": name,
//     "code": code,
//     "status": status,
//     "countries": countries,
//   };
// }
//
// class Language {
//   Language({
//     required this.id,
//     required  this.code,
//     required  this.languageName,
//     required this.asciiName,
//     required this.status,
//   });
//
//   int id;
//   String code;
//   String languageName;
//   String asciiName;
//   int status;
//
//   factory Language.fromJson(Map<String, dynamic> json) => Language(
//     id: json["id"],
//     code: json["code"],
//     languageName: json["language_name"],
//     asciiName: json["ascii_name"],
//     status: json["status"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "code": code,
//     "language_name": languageName,
//     "ascii_name": asciiName,
//     "status": status,
//   };
// }
//
// class RetCodeMessages {
//   RetCodeMessages({
//     required  this.successfullyRegistered,
//     required  this.userAlreadyExists,
//     required this.notConfirmed,
//     required this.invalidUser,
//     required this.validUser,
//     required this.successfullyReset,
//   });
//
//   String successfullyRegistered;
//   String userAlreadyExists;
//   String notConfirmed;
//   String invalidUser;
//   String validUser;
//   String successfullyReset;
//
//   factory RetCodeMessages.fromJson(Map<String, dynamic> json) => RetCodeMessages(
//     successfullyRegistered: json["SUCCESSFULLY_REGISTERED"],
//     userAlreadyExists: json["USER_ALREADY_EXISTS"],
//     notConfirmed: json["NOT_CONFIRMED"],
//     invalidUser: json["INVALID_USER"],
//     validUser: json["VALID_USER"],
//     successfullyReset: json["SUCCESSFULLY_RESET"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "SUCCESSFULLY_REGISTERED": successfullyRegistered,
//     "USER_ALREADY_EXISTS": userAlreadyExists,
//     "NOT_CONFIRMED": notConfirmed,
//     "INVALID_USER": invalidUser,
//     "VALID_USER": validUser,
//     "SUCCESSFULLY_RESET": successfullyReset,
//   };
// }
//

class DataModel {
  DataModel({
    required this.isChanged,
    required this.countryHash,
    required this.languageHash,
    required this.currenciesHash,
    required this.retCodeMessagesHash,
    required this.countries,
    required this.languages,
    required this.currencies,
    required this.retCodeMessages,
  });
  late final bool isChanged;
  late final int countryHash;
  late final int languageHash;
  late final int currenciesHash;
  late final int retCodeMessagesHash;
  late final List<Countries> countries;
  late final List<Languages> languages;
  late final List<Currencies> currencies;
  late final RetCodeMessages retCodeMessages;

  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(
    isChanged : json['isChanged'],
    countryHash : json['countryHash'],
    languageHash : json['languageHash'],
    currenciesHash : json['currenciesHash'],
    retCodeMessagesHash : json['retCodeMessagesHash'],
    countries : List.from(json['countries']).map((e)=>Countries.fromJson(e)).toList(),
    languages : List.from(json['languages']).map((e)=>Languages.fromJson(e)).toList(),
    currencies : List.from(json['currencies']).map((e)=>Currencies.fromJson(e)).toList(),
    retCodeMessages : RetCodeMessages.fromJson(json['retCodeMessages'] )  );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = new Map<String, dynamic>();
    _data['isChanged'] = isChanged;
    _data['countryHash'] = countryHash;
    _data['languageHash'] = languageHash;
    _data['currenciesHash'] = currenciesHash;
    _data['retCodeMessagesHash'] = retCodeMessagesHash;
    _data['countries'] = countries.map((e)=>e.toJson()).toList();
    _data['languages'] = languages.map((e)=>e.toJson()).toList();
    _data['currencies'] = currencies.map((e)=>e.toJson()).toList();
    _data['retCodeMessages'] = retCodeMessages.toJson();
    return _data;
  }
}

class Countries {
  Countries({
    required this.id,
    required this.currencyId,
    required this.name,
    required this.code,
    required this.numCode,
    required this.phoneCode,
    required this.timezoneCode,
  });
  late final int id;
  late final int currencyId;
  late final String name;
  late final String code;
  late final int numCode;
  late final int phoneCode;
  late final String timezoneCode;

  Countries.fromJson(Map<String, dynamic> json){
    id = json['id'];
    currencyId = json['currencyId'];
    name = json['name'];
    code = json['code'];
    numCode = json['num_code'];
    phoneCode = json['phone_code'];
    timezoneCode = json['timezone_code'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['currencyId'] = currencyId;
    _data['name'] = name;
    _data['code'] = code;
    _data['num_code'] = numCode;
    _data['phone_code'] = phoneCode;
    _data['timezone_code'] = timezoneCode;
    return _data;
  }
}

class Languages {
  Languages({
    required this.id,
    required this.code,
    required this.languageName,
    required this.asciiName,
    required this.status,
  });
  late final int id;
  late final String code;
  late final String languageName;
  late final String asciiName;
  late final int status;

  Languages.fromJson(Map<String, dynamic> json){
    id = json['id'];
    code = json['code'];
    languageName = json['language_name'];
    asciiName = json['ascii_name'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['code'] = code;
    _data['language_name'] = languageName;
    _data['ascii_name'] = asciiName;
    _data['status'] = status;
    return _data;
  }
}

class Currencies {
  Currencies({
     this.id,
     this.name,
     this.code,
     this.status,
    countries,
  });
  late final int? id;
  late final String? name;
  late final String? code;
  late final int? status;
  late final dynamic? countries;

  Currencies.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    code = json['code'];
    status = json['status'];
    countries = null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['code'] = code;
    _data['status'] = status;
    _data['countries'] = countries;
    return _data;
  }
}

class RetCodeMessages {
  RetCodeMessages({
    required this.SUCCESSFULLYREGISTERED,
    required this.USERALREADYEXISTS,
    required this.NOTCONFIRMED,
    required this.INVALIDUSER,
    required this.VALIDUSER,
    required this.SUCCESSFULLYRESET,
  });
  late final String SUCCESSFULLYREGISTERED;
  late final String USERALREADYEXISTS;
  late final String NOTCONFIRMED;
  late final String INVALIDUSER;
  late final String VALIDUSER;
  late final String SUCCESSFULLYRESET;

  RetCodeMessages.fromJson(Map<String, dynamic> json){
    SUCCESSFULLYREGISTERED = json['SUCCESSFULLY_REGISTERED'];
    USERALREADYEXISTS = json['USER_ALREADY_EXISTS'];
    NOTCONFIRMED = json['NOT_CONFIRMED'];
    INVALIDUSER = json['INVALID_USER'];
    VALIDUSER = json['VALID_USER'];
    SUCCESSFULLYRESET = json['SUCCESSFULLY_RESET'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['SUCCESSFULLY_REGISTERED'] = SUCCESSFULLYREGISTERED;
    _data['USER_ALREADY_EXISTS'] = USERALREADYEXISTS;
    _data['NOT_CONFIRMED'] = NOTCONFIRMED;
    _data['INVALID_USER'] = INVALIDUSER;
    _data['VALID_USER'] = VALIDUSER;
    _data['SUCCESSFULLY_RESET'] = SUCCESSFULLYRESET;
    return _data;
  }
}
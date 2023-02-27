class FormDataModel {


  List<String> userInfo;
  List<String>? systemReq;
  List<dynamic>? applchecked;


  FormDataModel(
  { required this.userInfo,
     this.systemReq,
     this.applchecked,
} );
}
import '../UI/showStatelistPicker.dart';

class SignUpModel {
  String? odataContext;
  String? odataEtag;
  String? entryNo;
  String? companyName;
  String? companyAddress;
  String? postCode;
  String? city;
  String? state;
  String? mobileNo;
  String? iECCode;
  String? pANNo;
  String? gSTNo;
  String? contactPersonName;
  String? emailID;
  String? uploadPAN;
  bool? register;
  String? uploadGST;
  String? customerCode;
  bool? exporter;
  bool? importer;
  bool? cHA;
  bool? forwarder;
  bool? consignee;
  bool? consignor;
  bool? shippingLine;
  bool? domestic;
  bool? consolidator;
  String? lastLoginDateMobileApp;
  String? lastLoginDateWebApp;

  SignUpModel(
      {this.odataContext,
        this.odataEtag,
        this.entryNo,
        this.companyName,
        this.companyAddress,
        this.postCode,
        this.city,
        this.state,
        this.mobileNo,
        this.iECCode,
        this.pANNo,
        this.gSTNo,
        this.contactPersonName,
        this.emailID,
        this.uploadPAN,
        this.register,
        this.uploadGST,
        this.customerCode,
        this.exporter,
        this.importer,
        this.cHA,
        this.forwarder,
        this.consignee,
        this.consignor,
        this.shippingLine,
        this.domestic,
        this.consolidator,
        this.lastLoginDateMobileApp,
        this.lastLoginDateWebApp});

  SignUpModel.fromJson(Map<String, dynamic> json) {
    odataContext = json['@odata.context'];
    odataEtag = json['@odata.etag'];
    entryNo = json['Entry_No'];
    companyName = json['Company_Name'];
    companyAddress = json['Company_Address'];
    postCode = json['Post_Code'];
    city = json['City'];
    state = json['State'];
    mobileNo = json['Mobile_No'];
    iECCode = json['IEC_Code'];
    pANNo = json['PAN_No'];
    gSTNo = json['GST_No'];
    contactPersonName = json['Contact_Person_Name'];
    emailID = json['Email_ID'];
    uploadPAN = json['Upload_PAN'];
    register = json['Register'];
    uploadGST = json['Upload_GST'];
    customerCode = json['Customer_Code'];
    exporter = json['Exporter'];
    importer = json['Importer'];
    cHA = json['CHA'];
    forwarder = json['Forwarder'];
    consignee = json['Consignee'];
    consignor = json['Consignor'];
    shippingLine = json['Shipping_Line'];
    domestic = json['Domestic'];
    consolidator = json['Consolidator'];
    lastLoginDateMobileApp = json['Last_Login_Date_Mobile_App'];
    lastLoginDateWebApp = json['Last_Login_Date_Web_App'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['@odata.context'] = this.odataContext;
    data['@odata.etag'] = this.odataEtag;
    data['Entry_No'] = this.entryNo;
    data['Company_Name'] = this.companyName;
    data['Company_Address'] = this.companyAddress;
    data['Post_Code'] = this.postCode;
    data['City'] = this.city;
    data['State'] = this.state;
    data['Mobile_No'] = this.mobileNo;
    data['IEC_Code'] = this.iECCode;
    data['PAN_No'] = this.pANNo;
    data['GST_No'] = this.gSTNo;
    data['Contact_Person_Name'] = this.contactPersonName;
    data['Email_ID'] = this.emailID;
    data['Upload_PAN'] = this.uploadPAN;
    data['Register'] = this.register;
    data['Upload_GST'] = this.uploadGST;
    data['Customer_Code'] = this.customerCode;
    data['Exporter'] = this.exporter;
    data['Importer'] = this.importer;
    data['CHA'] = this.cHA;
    data['Forwarder'] = this.forwarder;
    data['Consignee'] = this.consignee;
    data['Consignor'] = this.consignor;
    data['Shipping_Line'] = this.shippingLine;
    data['Domestic'] = this.domestic;
    data['Consolidator'] = this.consolidator;
    data['Last_Login_Date_Mobile_App'] = this.lastLoginDateMobileApp;
    data['Last_Login_Date_Web_App'] = this.lastLoginDateWebApp;
    return data;
  }

  Future<SignUpModel> createSignUpModel() async {
    String? stateCode = await SetStateCode.getStateCode();
    return SignUpModel(state: stateCode);
  }

// Usage:
  void someFunction() async {
    SignUpModel signUpModel = await createSignUpModel();
  }

}
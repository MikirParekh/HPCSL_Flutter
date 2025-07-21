class ChangedateModel {
  String? odataContext;
  List<ChangedateModel1>? value;

  ChangedateModel({this.odataContext, this.value});

  ChangedateModel.fromJson(Map<String, dynamic> json) {
    odataContext = json['@odata.context'];
    if (json['value'] != null) {
      value = <ChangedateModel1>[];
      json['value'].forEach((v) {
        value?.add(new ChangedateModel1.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['@odata.context'] = this.odataContext;
    if (this.value != null) {
      data['value'] = this.value?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ChangedateModel1 {
  String? odataEtag;
  String? entryNo;
  String? companyName;
  String? companyAddress;
  String? postCode;
  String? city;
  String? state;
  String? mobileNo;
  String? customerType;
  String? iECCode;
  String? pANNo;
  String? gSTNo;
  String? contactPersonName;
  String? emailID;
  String? uploadPAN;
  String? uploadGST;
  String? customerCode;
  String? customerName;
  bool? register;
  String? noSeries;
  bool? exporter;
  bool? importer;
  bool? cHA;
  bool? forwarder;
  bool? consignee;
  bool? consignor;
  bool? shippingLine;
  String? lastLoginDateMobileApp;
  String? lastLoginDateWebApp;
  String? password;
  String? mPIN;

  ChangedateModel1(
      {this.odataEtag,
        this.entryNo,
        this.companyName,
        this.companyAddress,
        this.postCode,
        this.city,
        this.state,
        this.mobileNo,
        this.customerType,
        this.iECCode,
        this.pANNo,
        this.gSTNo,
        this.contactPersonName,
        this.emailID,
        this.uploadPAN,
        this.uploadGST,
        this.customerCode,
        this.customerName,
        this.register,
        this.noSeries,
        this.exporter,
        this.importer,
        this.cHA,
        this.forwarder,
        this.consignee,
        this.consignor,
        this.shippingLine,
        this.lastLoginDateMobileApp,
        this.lastLoginDateWebApp,
        this.password,
        this.mPIN});

  ChangedateModel1.fromJson(Map<String, dynamic> json) {
    odataEtag = json['@odata.etag'];
    entryNo = json['Entry_No'];
    companyName = json['Company_Name'];
    companyAddress = json['Company_Address'];
    postCode = json['Post_Code'];
    city = json['City'];
    state = json['State'];
    mobileNo = json['Mobile_No'];
    customerType = json['Customer_Type'];
    iECCode = json['IEC_Code'];
    pANNo = json['PAN_No'];
    gSTNo = json['GST_No'];
    contactPersonName = json['Contact_Person_Name'];
    emailID = json['Email_ID'];
    uploadPAN = json['Upload_PAN'];
    uploadGST = json['Upload_GST'];
    customerCode = json['Customer_Code'];
    customerName = json['Customer_Name'];
    register = json['Register'];
    noSeries = json['No_Series'];
    exporter = json['Exporter'];
    importer = json['Importer'];
    cHA = json['CHA'];
    forwarder = json['Forwarder'];
    consignee = json['Consignee'];
    consignor = json['Consignor'];
    shippingLine = json['Shipping_Line'];
    lastLoginDateMobileApp = json['Last_Login_Date_Mobile_App'];
    lastLoginDateWebApp = json['Last_Login_Date_Web_App'];
    password = json['Password'];
    mPIN = json['MPIN'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['@odata.etag'] = this.odataEtag;
    data['Entry_No'] = this.entryNo;
    data['Company_Name'] = this.companyName;
    data['Company_Address'] = this.companyAddress;
    data['Post_Code'] = this.postCode;
    data['City'] = this.city;
    data['State'] = this.state;
    data['Mobile_No'] = this.mobileNo;
    data['Customer_Type'] = this.customerType;
    data['IEC_Code'] = this.iECCode;
    data['PAN_No'] = this.pANNo;
    data['GST_No'] = this.gSTNo;
    data['Contact_Person_Name'] = this.contactPersonName;
    data['Email_ID'] = this.emailID;
    data['Upload_PAN'] = this.uploadPAN;
    data['Upload_GST'] = this.uploadGST;
    data['Customer_Code'] = this.customerCode;
    data['Customer_Name'] = this.customerName;
    data['Register'] = this.register;
    data['No_Series'] = this.noSeries;
    data['Exporter'] = this.exporter;
    data['Importer'] = this.importer;
    data['CHA'] = this.cHA;
    data['Forwarder'] = this.forwarder;
    data['Consignee'] = this.consignee;
    data['Consignor'] = this.consignor;
    data['Shipping_Line'] = this.shippingLine;
    data['Last_Login_Date_Mobile_App'] = this.lastLoginDateMobileApp;
    data['Last_Login_Date_Web_App'] = this.lastLoginDateWebApp;
    data['Password'] = this.password;
    data['MPIN'] = this.mPIN;
    return data;
  }
}

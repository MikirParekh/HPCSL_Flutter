class DomesticModel {
  String? odataContext;
  List<DomesticModel1>? value;

  DomesticModel({this.odataContext, this.value});

  DomesticModel.fromJson(Map<String, dynamic> json) {
    odataContext = json['@odata.context'];
    if (json['value'] != null) {
      value = <DomesticModel1>[];
      json['value'].forEach((v) {
        value?.add(new DomesticModel1.fromJson(v));
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

class DomesticModel1 {
  String? odataEtag;
  String? documentNo;
  int? lineNo;
  String? size;
  String? type;
  int ? noOfPackages;
  String? sourceOutDate;
  String? bookingType;
  String? destinationGateInDate;
  String? containerWagonNo;
  String? customerName;
  String? bookingDate;
  String? comodityCategory;
  String? cargoCode;
  String? fromLocationCode;
  String? toLocationCode;
  String? sourceOutMode;
  String? arrivalDate;
  int? tptGateInBokingEntryNo;
  String? customerNo;
  String? shippingLineNo;
  String? terminal;
  bool? doNotShow;

  DomesticModel1(
      {this.odataEtag,
        this.documentNo,
        this.lineNo,
        this.size,
        this.type,
        this.noOfPackages,
        this.sourceOutDate,
        this.bookingType,
        this.destinationGateInDate,
        this.containerWagonNo,
        this.customerName,
        this.bookingDate,
        this.comodityCategory,
        this.cargoCode,
        this.fromLocationCode,
        this.toLocationCode,
        this.sourceOutMode,
        this.arrivalDate,
        this.tptGateInBokingEntryNo,
        this.customerNo,
        this.shippingLineNo,
        this.terminal,
        this.doNotShow});

  DomesticModel1.fromJson(Map<String, dynamic> json) {
    odataEtag = json['@odata.etag'];
    documentNo = json['Document_No'];
    lineNo = json['Line_No'];
    size = json['Size'];
    type = json['Type'];
    noOfPackages = json['No_of_Packages'];
    sourceOutDate = json['Source_Out_Date'];
    bookingType = json['Booking_Type'];
    destinationGateInDate = json['Destination_Gate_In_Date'];
    containerWagonNo = json['Container_Wagon_No'];
    customerName = json['Customer_Name'];
    bookingDate = json['Booking_Date'];
    comodityCategory = json['Comodity_Category'];
    cargoCode = json['Cargo_Code'];
    fromLocationCode = json['From_Location_Code'];
    toLocationCode = json['To_Location_Code'];
    sourceOutMode = json['Source_Out_Mode'];
    arrivalDate = json['Arrival_Date'];
    tptGateInBokingEntryNo = json['Tpt_Gate_In_Boking_Entry_No'];
    customerNo = json['Customer_No'];
    shippingLineNo = json['Shipping_Line_No'];
    terminal = json['Terminal'];
    doNotShow = json['Do_Not_Show'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['@odata.etag'] = this.odataEtag;
    data['Document_No'] = this.documentNo;
    data['Line_No'] = this.lineNo;
    data['Size'] = this.size;
    data['Type'] = this.type;
    data['No_of_Packages'] = this.noOfPackages;
    data['Source_Out_Date'] = this.sourceOutDate;
    data['Booking_Type'] = this.bookingType;
    data['Destination_Gate_In_Date'] = this.destinationGateInDate;
    data['Container_Wagon_No'] = this.containerWagonNo;
    data['Customer_Name'] = this.customerName;
    data['Booking_Date'] = this.bookingDate;
    data['Comodity_Category'] = this.comodityCategory;
    data['Cargo_Code'] = this.cargoCode;
    data['From_Location_Code'] = this.fromLocationCode;
    data['To_Location_Code'] = this.toLocationCode;
    data['Source_Out_Mode'] = this.sourceOutMode;
    data['Arrival_Date'] = this.arrivalDate;
    data['Tpt_Gate_In_Boking_Entry_No'] = this.tptGateInBokingEntryNo;
    data['Customer_No'] = this.customerNo;
    data['Shipping_Line_No'] = this.shippingLineNo;
    data['Terminal'] = this.terminal;
    data['Do_Not_Show'] = this.doNotShow;
    return data;
  }
}
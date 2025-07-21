class EmptyTrackingModel {
  String? odataContext;
  List<EmptyTrackingModel1>? value;

  EmptyTrackingModel({this.odataContext, this.value});

  EmptyTrackingModel.fromJson(Map<String, dynamic> json) {
    odataContext = json['@odata.context'];
    if (json['value'] != null) {
      value = <EmptyTrackingModel1>[];
      json['value'].forEach((v) {
        value?.add(new EmptyTrackingModel1.fromJson(v));
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

class EmptyTrackingModel1 {
  String? odataEtag;
  String? bookingType;
  String? emptyBookingNo;
  int? lineNo;
  String? dONo;
  String? dODate;
  String? containerNo;
  String? type;
  String? size;
  String? shippingLineName;
  String? terminal;
  String? mode;
  String? rakeNo;
  String? dOValidityDate;
  String? dOReValidityDate;
  String? pickFromDropTo;
  String? pickDropLocation;
  String? arrivalDate;
  String? outDate;
  String? shippingLineNo;
  String? billToCustomerNo;
  String? permissionNo;
  String? emptyBookingDate;
  bool? doNotShow;
  String? vehicleNo;

  EmptyTrackingModel1(
      {this.odataEtag,
        this.bookingType,
        this.emptyBookingNo,
        this.lineNo,
        this.dONo,
        this.dODate,
        this.containerNo,
        this.type,
        this.size,
        this.shippingLineName,
        this.terminal,
        this.mode,
        this.rakeNo,
        this.dOValidityDate,
        this.dOReValidityDate,
        this.pickFromDropTo,
        this.pickDropLocation,
        this.arrivalDate,
        this.outDate,
        this.shippingLineNo,
        this.billToCustomerNo,
        this.permissionNo,
        this.emptyBookingDate,
        this.doNotShow,
        this.vehicleNo});

  EmptyTrackingModel1.fromJson(Map<String, dynamic> json) {
    odataEtag = json['@odata.etag'];
    bookingType = json['Booking_Type'];
    emptyBookingNo = json['Empty_Booking_No'];
    lineNo = json['Line_No'];
    dONo = json['DO_No'];
    dODate = json['DO_Date'];
    containerNo = json['Container_No'];
    type = json['Type'];
    size = json['Size'];
    shippingLineName = json['Shipping_Line_Name'];
    terminal = json['Terminal'];
    mode = json['Mode'];
    rakeNo = json['Rake_No'];
    dOValidityDate = json['DO_Validity_Date'];
    dOReValidityDate = json['DO_ReValidity_Date'];
    pickFromDropTo = json['Pick_From_Drop_To'];
    pickDropLocation = json['Pick_Drop_Location'];
    arrivalDate = json['Arrival_Date'];
    outDate = json['Out_Date'];
    shippingLineNo = json['Shipping_Line_No'];
    billToCustomerNo = json['Bill_to_Customer_No'];
    permissionNo = json['Permission_No'];
    emptyBookingDate = json['Empty_Booking_Date'];
    doNotShow = json['Do_Not_Show'];
    vehicleNo = json['Vehicle_No'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['@odata.etag'] = this.odataEtag;
    data['Booking_Type'] = this.bookingType;
    data['Empty_Booking_No'] = this.emptyBookingNo;
    data['Line_No'] = this.lineNo;
    data['DO_No'] = this.dONo;
    data['DO_Date'] = this.dODate;
    data['Container_No'] = this.containerNo;
    data['Type'] = this.type;
    data['Size'] = this.size;
    data['Shipping_Line_Name'] = this.shippingLineName;
    data['Terminal'] = this.terminal;
    data['Mode'] = this.mode;
    data['Rake_No'] = this.rakeNo;
    data['DO_Validity_Date'] = this.dOValidityDate;
    data['DO_ReValidity_Date'] = this.dOReValidityDate;
    data['Pick_From_Drop_To'] = this.pickFromDropTo;
    data['Pick_Drop_Location'] = this.pickDropLocation;
    data['Arrival_Date'] = this.arrivalDate;
    data['Out_Date'] = this.outDate;
    data['Shipping_Line_No'] = this.shippingLineNo;
    data['Bill_to_Customer_No'] = this.billToCustomerNo;
    data['Permission_No'] = this.permissionNo;
    data['Empty_Booking_Date'] = this.emptyBookingDate;
    data['Do_Not_Show'] = this.doNotShow;
    data['Vehicle_No'] = this.vehicleNo;
    return data;
  }
}
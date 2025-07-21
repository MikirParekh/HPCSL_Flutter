class TransportModel {
  String? odataContext;
  List<TransportModel1>? value;

  TransportModel({this.odataContext, this.value});

  TransportModel.fromJson(Map<String, dynamic> json) {
    odataContext = json['@odata.context'];
    if (json['value'] != null) {
      value = <TransportModel1>[];
      json['value'].forEach((v) {
        value?.add(new TransportModel1.fromJson(v));
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

class TransportModel1 {
  String? odataEtag;
  int? entryNo;
  String? gRNo;
  String? gRDate;
  String? consigneeName;
  String? containerNo;
  String? size;
  String? type;
  String? customerNo;
  String? consignorName;
  String? shippingLineName;
  String? transactionType;
  String? documentType;
  String? terminal;
  String? importerNo;
  String? cargoDescription;
  double? grossWeight;
  String? loadType;
  String? cHAName;
  String? dONo;
  String? dOValidityDate;
  String? dORevalidityDate;
  String? pOD;
  String? pOL;
  String? cHANo;
  String? rEDT;
  String? consignor;
  String? consignee;
  String? shippingBillNo;
  String? bLNo;
  String? exporterNo;
  String? emptyPickDropLocation;
  String? roadRouteName;
  String? factoryPlanDate;
  String? factoryPlanTime;
  String? factoryYardArrivalDatetime;
  String? factoryYardDepDatetime;
  String? shippingLineNo;
  String? vehicleNo;
  bool? doNotShow;
  String? loadingUnloadingPlanDate;
  String? tripStartDateX0026Time;
  String? portYardInGatedDate;
  String? gPSTrackingLink;
  bool? closed;
  bool? cancelled;

  TransportModel1(
      {this.odataEtag,
        this.entryNo,
        this.gRNo,
        this.gRDate,
        this.consigneeName,
        this.containerNo,
        this.size,
        this.type,
        this.customerNo,
        this.consignorName,
        this.shippingLineName,
        this.transactionType,
        this.documentType,
        this.terminal,
        this.importerNo,
        this.cargoDescription,
        this.grossWeight,
        this.loadType,
        this.cHAName,
        this.dONo,
        this.dOValidityDate,
        this.dORevalidityDate,
        this.pOD,
        this.pOL,
        this.cHANo,
        this.rEDT,
        this.consignor,
        this.consignee,
        this.shippingBillNo,
        this.bLNo,
        this.exporterNo,
        this.emptyPickDropLocation,
        this.roadRouteName,
        this.factoryPlanDate,
        this.factoryPlanTime,
        this.factoryYardArrivalDatetime,
        this.factoryYardDepDatetime,
        this.shippingLineNo,
        this.vehicleNo,
        this.doNotShow,
        this.loadingUnloadingPlanDate,
        this.tripStartDateX0026Time,
        this.portYardInGatedDate,
        this.gPSTrackingLink,
        this.closed,
        this.cancelled});

  TransportModel1.fromJson(Map<String, dynamic> json) {
    odataEtag = json['@odata.etag'];
    entryNo = json['Entry_No'];
    gRNo = json['GR_No'];
    gRDate = json['GR_Date'];
    consigneeName = json['Consignee_Name'];
    containerNo = json['Container_No'];
    size = json['Size'];
    type = json['Type'];
    customerNo = json['Customer_No'];
    consignorName = json['Consignor_Name'];
    shippingLineName = json['Shipping_Line_Name'];
    transactionType = json['Transaction_Type'];
    documentType = json['Document_Type'];
    terminal = json['Terminal'];
    importerNo = json['Importer_No'];
    cargoDescription = json['Cargo_Description'];
    grossWeight = (json['Gross_Weight'] as num?)?.toDouble();;
    loadType = json['Load_Type'];
    cHAName = json['CHA_Name'];
    dONo = json['DO_No'];
    dOValidityDate = json['DO_Validity_Date'];
    dORevalidityDate = json['DO_Revalidity_Date'];
    pOD = json['POD'];
    pOL = json['POL'];
    cHANo = json['CHA_No'];
    rEDT = json['REDT'];
    consignor = json['Consignor'];
    consignee = json['Consignee'];
    shippingBillNo = json['Shipping_Bill_No'];
    bLNo = json['BL_No'];
    exporterNo = json['Exporter_No'];
    emptyPickDropLocation = json['Empty_Pick_Drop_Location'];
    roadRouteName = json['Road_Route_Name'];
    factoryPlanDate = json['Factory_Plan_Date'];
    factoryPlanTime = json['Factory_Plan_Time'];
    factoryYardArrivalDatetime = json['Factory_Yard_Arrival_Datetime'];
    factoryYardDepDatetime = json['Factory_Yard_Dep_Datetime'];
    shippingLineNo = json['Shipping_Line_No'];
    vehicleNo = json['Vehicle_No'];
    doNotShow = json['Do_Not_Show'];
    loadingUnloadingPlanDate = json['Loading_Unloading_Plan_Date'];
    tripStartDateX0026Time = json['Trip_StartDate__x0026__Time'];
    portYardInGatedDate = json['Port_Yard_In_Gated_Date'];
    gPSTrackingLink = json['GPS_Tracking_Link'];
    closed = json['Closed'];
    cancelled = json['Cancelled'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['@odata.etag'] = this.odataEtag;
    data['Entry_No'] = this.entryNo;
    data['GR_No'] = this.gRNo;
    data['GR_Date'] = this.gRDate;
    data['Consignee_Name'] = this.consigneeName;
    data['Container_No'] = this.containerNo;
    data['Size'] = this.size;
    data['Type'] = this.type;
    data['Customer_No'] = this.customerNo;
    data['Consignor_Name'] = this.consignorName;
    data['Shipping_Line_Name'] = this.shippingLineName;
    data['Transaction_Type'] = this.transactionType;
    data['Document_Type'] = this.documentType;
    data['Terminal'] = this.terminal;
    data['Importer_No'] = this.importerNo;
    data['Cargo_Description'] = this.cargoDescription;
    data['Gross_Weight'] = this.grossWeight;
    data['Load_Type'] = this.loadType;
    data['CHA_Name'] = this.cHAName;
    data['DO_No'] = this.dONo;
    data['DO_Validity_Date'] = this.dOValidityDate;
    data['DO_Revalidity_Date'] = this.dORevalidityDate;
    data['POD'] = this.pOD;
    data['POL'] = this.pOL;
    data['CHA_No'] = this.cHANo;
    data['REDT'] = this.rEDT;
    data['Consignor'] = this.consignor;
    data['Consignee'] = this.consignee;
    data['Shipping_Bill_No'] = this.shippingBillNo;
    data['BL_No'] = this.bLNo;
    data['Exporter_No'] = this.exporterNo;
    data['Empty_Pick_Drop_Location'] = this.emptyPickDropLocation;
    data['Road_Route_Name'] = this.roadRouteName;
    data['Factory_Plan_Date'] = this.factoryPlanDate;
    data['Factory_Plan_Time'] = this.factoryPlanTime;
    data['Factory_Yard_Arrival_Datetime'] = this.factoryYardArrivalDatetime;
    data['Factory_Yard_Dep_Datetime'] = this.factoryYardDepDatetime;
    data['Shipping_Line_No'] = this.shippingLineNo;
    data['Vehicle_No'] = this.vehicleNo;
    data['Do_Not_Show'] = this.doNotShow;
    data['Loading_Unloading_Plan_Date'] = this.loadingUnloadingPlanDate;
    data['Trip_StartDate__x0026__Time'] = this.tripStartDateX0026Time;
    data['Port_Yard_In_Gated_Date'] = this.portYardInGatedDate;
    data['GPS_Tracking_Link'] = this.gPSTrackingLink;
    data['Closed'] = this.closed;
    data['Cancelled'] = this.cancelled;
    return data;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is TransportModel1 &&
              runtimeType == other.runtimeType &&
              containerNo == other.containerNo &&
              gRNo == other.gRNo;

  @override
  int get hashCode => Object.hash(containerNo, gRNo);
}
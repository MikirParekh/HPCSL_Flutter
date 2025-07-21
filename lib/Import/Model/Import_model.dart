// class ImportModel {
//   String? odataContext;
//   List<ImportModel1>? value;
//
//   ImportModel({this.odataContext, this.value});
//
//   ImportModel.fromJson(Map<String, dynamic> json) {
//     odataContext = json['@odata.context'];
//     if (json['value'] != null) {
//       value = <ImportModel1>[];
//       json['value'].forEach((v) {
//         value?.add(new ImportModel1.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['@odata.context'] = this.odataContext;
//     if (this.value != null) {
//       data['value'] = this.value?.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class ImportModel1 {
//   String? odataEtag;
//   int? iGMNo;
//   int? iGMLineNo;
//   String? iGMSubLineNo;
//   int? lineNo;
//   String? containerNo;
//   String? size;
//   String? terminal;
//   String? type;
//   String? oOC;
//   String? oOCDateRec;
//   String? oOCReceivedDate;
//   String? modeOfDeliveryDescription;
//   String? dONo;
//   String? dODate;
//   String? dOValidityDate;
//   String? dORevalidityDate;
//   bool? ownTransport;
//   String? bLNo;
//   String? bLDate;
//   String? importerName;
//   String? cHAName;
//   String? shippingLineName;
//   String? sMTPNo;
//   String? sMTPDate;
//   String? portOutMode;
//   String? linkPortName;
//   int? portOutBookingEntryNo;
//   String? rakeNo;
//   String? pOD;
//   String? wagonNo;
//   String? portOutDate;
//   String? arrivalDate;
//   String? bOENo;
//   String? gateOutDate;
//   String? vehicleNo;
//   String? importerNo;
//   String? cHANo;
//   String? shippingLineNo;
//   String? destuffingDate;
//   bool? doNotShow;
//   String? remarks;
//   String? freightForwarderNo;
//   String? importerNo2;
//   String? rEDT;
//   String? fDSEmptyInDate;
//
//   ImportModel1(
//       {this.odataEtag,
//         this.iGMNo,
//         this.iGMLineNo,
//         this.iGMSubLineNo,
//         this.lineNo,
//         this.containerNo,
//         this.size,
//         this.terminal,
//         this.type,
//         this.oOC,
//         this.oOCDateRec,
//         this.oOCReceivedDate,
//         this.modeOfDeliveryDescription,
//         this.dONo,
//         this.dODate,
//         this.dOValidityDate,
//         this.dORevalidityDate,
//         this.ownTransport,
//         this.bLNo,
//         this.bLDate,
//         this.importerName,
//         this.cHAName,
//         this.shippingLineName,
//         this.sMTPNo,
//         this.sMTPDate,
//         this.portOutMode,
//         this.linkPortName,
//         this.portOutBookingEntryNo,
//         this.rakeNo,
//         this.pOD,
//         this.wagonNo,
//         this.portOutDate,
//         this.arrivalDate,
//         this.bOENo,
//         this.gateOutDate,
//         this.vehicleNo,
//         this.importerNo,
//         this.cHANo,
//         this.shippingLineNo,
//         this.destuffingDate,
//         this.doNotShow,
//         this.remarks,
//         this.freightForwarderNo,
//         this.importerNo2,
//         this.rEDT,
//         this.fDSEmptyInDate});
//
//   ImportModel1.fromJson(Map<String, dynamic> json) {
//     odataEtag = json['@odata.etag'];
//     iGMNo = json['IGM_No'];
//     iGMLineNo = json['IGM_Line_No'];
//     iGMSubLineNo = json['IGM_Sub_Line_No'];
//     lineNo = json['Line_No'];
//     containerNo = json['Container_No'];
//     size = json['Size'];
//     terminal = json['Terminal'];
//     type = json['Type'];
//     oOC = json['OOC'];
//     oOCDateRec = json['OOC_DateRec'];
//     oOCReceivedDate = json['OOC_Received_Date'];
//     modeOfDeliveryDescription = json['Mode_of_Delivery_Description'];
//     dONo = json['DO_No'];
//     dODate = json['DO_Date'];
//     dOValidityDate = json['DO_Validity_Date'];
//     dORevalidityDate = json['DO_Revalidity_Date'];
//     ownTransport = json['Own_Transport'];
//     bLNo = json['B_L_No'];
//     bLDate = json['B_L_Date'];
//     importerName = json['Importer_Name'];
//     cHAName = json['CHA_Name'];
//     shippingLineName = json['Shipping_Line_Name'];
//     sMTPNo = json['SMTP_No'];
//     sMTPDate = json['SMTP_Date'];
//     portOutMode = json['Port_Out_Mode'];
//     linkPortName = json['Link_Port_Name'];
//     portOutBookingEntryNo = json['Port_Out_Booking_Entry_No'];
//     rakeNo = json['Rake_No'];
//     pOD = json['POD'];
//     wagonNo = json['Wagon_No'];
//     portOutDate = json['Port_Out_Date'];
//     arrivalDate = json['Arrival_Date'];
//     bOENo = json['BOE_No'];
//     gateOutDate = json['Gate_Out_Date'];
//     vehicleNo = json['Vehicle_No'];
//     importerNo = json['Importer_No'];
//     cHANo = json['CHA_No'];
//     shippingLineNo = json['Shipping_Line_No'];
//     destuffingDate = json['Destuffing_Date'];
//     doNotShow = json['Do_Not_Show'];
//     remarks = json['Remarks'];
//     freightForwarderNo = json['Freight_Forwarder_No'];
//     importerNo2 = json['Importer_No_2'];
//     rEDT = json['REDT'];
//     fDSEmptyInDate = json['FDS_Empty_In_Date'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['@odata.etag'] = this.odataEtag;
//     data['IGM_No'] = this.iGMNo;
//     data['IGM_Line_No'] = this.iGMLineNo;
//     data['IGM_Sub_Line_No'] = this.iGMSubLineNo;
//     data['Line_No'] = this.lineNo;
//     data['Container_No'] = this.containerNo;
//     data['Size'] = this.size;
//     data['Terminal'] = this.terminal;
//     data['Type'] = this.type;
//     data['OOC'] = this.oOC;
//     data['OOC_DateRec'] = this.oOCDateRec;
//     data['OOC_Received_Date'] = this.oOCReceivedDate;
//     data['Mode_of_Delivery_Description'] = this.modeOfDeliveryDescription;
//     data['DO_No'] = this.dONo;
//     data['DO_Date'] = this.dODate;
//     data['DO_Validity_Date'] = this.dOValidityDate;
//     data['DO_Revalidity_Date'] = this.dORevalidityDate;
//     data['Own_Transport'] = this.ownTransport;
//     data['B_L_No'] = this.bLNo;
//     data['B_L_Date'] = this.bLDate;
//     data['Importer_Name'] = this.importerName;
//     data['CHA_Name'] = this.cHAName;
//     data['Shipping_Line_Name'] = this.shippingLineName;
//     data['SMTP_No'] = this.sMTPNo;
//     data['SMTP_Date'] = this.sMTPDate;
//     data['Port_Out_Mode'] = this.portOutMode;
//     data['Link_Port_Name'] = this.linkPortName;
//     data['Port_Out_Booking_Entry_No'] = this.portOutBookingEntryNo;
//     data['Rake_No'] = this.rakeNo;
//     data['POD'] = this.pOD;
//     data['Wagon_No'] = this.wagonNo;
//     data['Port_Out_Date'] = this.portOutDate;
//     data['Arrival_Date'] = this.arrivalDate;
//     data['BOE_No'] = this.bOENo;
//     data['Gate_Out_Date'] = this.gateOutDate;
//     data['Vehicle_No'] = this.vehicleNo;
//     data['Importer_No'] = this.importerNo;
//     data['CHA_No'] = this.cHANo;
//     data['Shipping_Line_No'] = this.shippingLineNo;
//     data['Destuffing_Date'] = this.destuffingDate;
//     data['Do_Not_Show'] = this.doNotShow;
//     data['Remarks'] = this.remarks;
//     data['Freight_Forwarder_No'] = this.freightForwarderNo;
//     data['Importer_No_2'] = this.importerNo2;
//     data['REDT'] = this.rEDT;
//     data['FDS_Empty_In_Date'] = this.fDSEmptyInDate;
//     return data;
//   }
// }

class ImportModel {
  String? odataContext;
  List<Value>? value;
  String? odataNextLink;

  ImportModel({this.odataContext, this.value, this.odataNextLink});

  ImportModel.fromJson(Map<String, dynamic> json) {
    odataContext = json['@odata.context'];
    if (json['value'] != null) {
      value = <Value>[];
      json['value'].forEach((v) {
        value!.add(new Value.fromJson(v));
      });
    }
    odataNextLink = json['@odata.nextLink'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['@odata.context'] = this.odataContext;
    if (this.value != null) {
      data['value'] = this.value!.map((v) => v.toJson()).toList();
    }
    data['@odata.nextLink'] = this.odataNextLink;
    return data;
  }
}

class Value {
  String? odataEtag;
  int? iGMNo;
  int? iGMLineNo;
  String? iGMSubLineNo;
  int? lineNo;
  String? containerNo;
  String? size;
  String? terminal;
  String? type;
  String? oOC;
  String? oOCDateRec;
  String? oOCReceivedDate;
  String? modeOfDeliveryDescription;
  String? dONo;
  String? dODate;
  String? dOValidityDate;
  String? dORevalidityDate;
  bool? ownTransport;
  String? bLNo;
  String? bLDate;
  String? importerName;
  String? cHAName;
  String? shippingLineName;
  String? sMTPNo;
  String? sMTPDate;
  String? portOutMode;
  String? linkPortName;
  int? portOutBookingEntryNo;
  String? rakeNo;
  String? pOD;
  String? wagonNo;
  String? portOutDate;
  String? arrivalDate;
  String? bOENo;
  String? gateOutDate;
  String? vehicleNo;
  String? importerNo;
  String? cHANo;
  String? shippingLineNo;
  String? destuffingDate;
  bool? doNotShow;
  String? remarks;
  String? freightForwarderNo;
  String? importerNo2;
  String? rEDT;
  String? fDSEmptyInDate;

  Value(
      {this.odataEtag,
        this.iGMNo,
        this.iGMLineNo,
        this.iGMSubLineNo,
        this.lineNo,
        this.containerNo,
        this.size,
        this.terminal,
        this.type,
        this.oOC,
        this.oOCDateRec,
        this.oOCReceivedDate,
        this.modeOfDeliveryDescription,
        this.dONo,
        this.dODate,
        this.dOValidityDate,
        this.dORevalidityDate,
        this.ownTransport,
        this.bLNo,
        this.bLDate,
        this.importerName,
        this.cHAName,
        this.shippingLineName,
        this.sMTPNo,
        this.sMTPDate,
        this.portOutMode,
        this.linkPortName,
        this.portOutBookingEntryNo,
        this.rakeNo,
        this.pOD,
        this.wagonNo,
        this.portOutDate,
        this.arrivalDate,
        this.bOENo,
        this.gateOutDate,
        this.vehicleNo,
        this.importerNo,
        this.cHANo,
        this.shippingLineNo,
        this.destuffingDate,
        this.doNotShow,
        this.remarks,
        this.freightForwarderNo,
        this.importerNo2,
        this.rEDT,
        this.fDSEmptyInDate});

  Value.fromJson(Map<String, dynamic> json) {
    odataEtag = json['@odata.etag'];
    iGMNo = json['IGM_No'];
    iGMLineNo = json['IGM_Line_No'];
    iGMSubLineNo = json['IGM_Sub_Line_No'];
    lineNo = json['Line_No'];
    containerNo = json['Container_No'];
    size = json['Size'];
    terminal = json['Terminal'];
    type = json['Type'];
    oOC = json['OOC'];
    oOCDateRec = json['OOC_DateRec'];
    oOCReceivedDate = json['OOC_Received_Date'];
    modeOfDeliveryDescription = json['Mode_of_Delivery_Description'];
    dONo = json['DO_No'];
    dODate = json['DO_Date'];
    dOValidityDate = json['DO_Validity_Date'];
    dORevalidityDate = json['DO_Revalidity_Date'];
    ownTransport = json['Own_Transport'];
    bLNo = json['B_L_No'];
    bLDate = json['B_L_Date'];
    importerName = json['Importer_Name'];
    cHAName = json['CHA_Name'];
    shippingLineName = json['Shipping_Line_Name'];
    sMTPNo = json['SMTP_No'];
    sMTPDate = json['SMTP_Date'];
    portOutMode = json['Port_Out_Mode'];
    linkPortName = json['Link_Port_Name'];
    portOutBookingEntryNo = json['Port_Out_Booking_Entry_No'];
    rakeNo = json['Rake_No'];
    pOD = json['POD'];
    wagonNo = json['Wagon_No'];
    portOutDate = json['Port_Out_Date'];
    arrivalDate = json['Arrival_Date'];
    bOENo = json['BOE_No'];
    gateOutDate = json['Gate_Out_Date'];
    vehicleNo = json['Vehicle_No'];
    importerNo = json['Importer_No'];
    cHANo = json['CHA_No'];
    shippingLineNo = json['Shipping_Line_No'];
    destuffingDate = json['Destuffing_Date'];
    doNotShow = json['Do_Not_Show'];
    remarks = json['Remarks'];
    freightForwarderNo = json['Freight_Forwarder_No'];
    importerNo2 = json['Importer_No_2'];
    rEDT = json['REDT'];
    fDSEmptyInDate = json['FDS_Empty_In_Date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['@odata.etag'] = this.odataEtag;
    data['IGM_No'] = this.iGMNo;
    data['IGM_Line_No'] = this.iGMLineNo;
    data['IGM_Sub_Line_No'] = this.iGMSubLineNo;
    data['Line_No'] = this.lineNo;
    data['Container_No'] = this.containerNo;
    data['Size'] = this.size;
    data['Terminal'] = this.terminal;
    data['Type'] = this.type;
    data['OOC'] = this.oOC;
    data['OOC_DateRec'] = this.oOCDateRec;
    data['OOC_Received_Date'] = this.oOCReceivedDate;
    data['Mode_of_Delivery_Description'] = this.modeOfDeliveryDescription;
    data['DO_No'] = this.dONo;
    data['DO_Date'] = this.dODate;
    data['DO_Validity_Date'] = this.dOValidityDate;
    data['DO_Revalidity_Date'] = this.dORevalidityDate;
    data['Own_Transport'] = this.ownTransport;
    data['B_L_No'] = this.bLNo;
    data['B_L_Date'] = this.bLDate;
    data['Importer_Name'] = this.importerName;
    data['CHA_Name'] = this.cHAName;
    data['Shipping_Line_Name'] = this.shippingLineName;
    data['SMTP_No'] = this.sMTPNo;
    data['SMTP_Date'] = this.sMTPDate;
    data['Port_Out_Mode'] = this.portOutMode;
    data['Link_Port_Name'] = this.linkPortName;
    data['Port_Out_Booking_Entry_No'] = this.portOutBookingEntryNo;
    data['Rake_No'] = this.rakeNo;
    data['POD'] = this.pOD;
    data['Wagon_No'] = this.wagonNo;
    data['Port_Out_Date'] = this.portOutDate;
    data['Arrival_Date'] = this.arrivalDate;
    data['BOE_No'] = this.bOENo;
    data['Gate_Out_Date'] = this.gateOutDate;
    data['Vehicle_No'] = this.vehicleNo;
    data['Importer_No'] = this.importerNo;
    data['CHA_No'] = this.cHANo;
    data['Shipping_Line_No'] = this.shippingLineNo;
    data['Destuffing_Date'] = this.destuffingDate;
    data['Do_Not_Show'] = this.doNotShow;
    data['Remarks'] = this.remarks;
    data['Freight_Forwarder_No'] = this.freightForwarderNo;
    data['Importer_No_2'] = this.importerNo2;
    data['REDT'] = this.rEDT;
    data['FDS_Empty_In_Date'] = this.fDSEmptyInDate;
    return data;
  }
}



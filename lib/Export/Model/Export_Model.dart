class ExportModel {
  String? odataContext;
  List<ExportModel1>? value;

  ExportModel({this.odataContext, this.value});

  ExportModel.fromJson(Map<String, dynamic> json) {
    print('Parsing this JSON:$json');
    odataContext = json['@odata.context'];
    if (json['value'] != null) {
      value = <ExportModel1>[];
      json['value'].forEach((v) {
        value?.add(new ExportModel1.fromJson(v));
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

class ExportModel1 {
  String? odataEtag;
  String? shippingBillNo;
  int? lineNo;
  String? containerNo;
  String? size;
  String? type;
  String? exciseSealNo;
  String? gateInPermitNo;
  String? fNRNo;
  String? gatePassNo;
  String? gateInType;
  int? declaredPackages;
  double? declaredWeight;
  double? tareWeight;
  String? factoryLocation;
  String? customsSealNo;
  String? lineSealNo;
  String? iSOCode;
  String? containerType;
  String? itemNo;
  String? itemDescription;
  String? uOM;
  int? volumeKG;
  String? markNos;
  double? netWeight;
  double? grossWeight;
  String? status;
  bool? onHold;
  String? freightForwarderName;
  String? sealingDate;
  bool? bookingLink;
  String? containerStatus;
  String? commodityCategory;
  String? commodityGroup;
  bool? gateInCompleted;
  bool? stuffingCompleted;
  bool? bTTCompletedCargo;
  String? arrivalDate;
  bool? selection;
  String? lEONo;
  String? lEODate;
  String? lEOTime;
  String? activityNo;
  String? shippingBillDate;
  String? docUpdateType;
  String? bookingRefNo;
  String? tSCTillDate;
  int? lastTSCSlabStart;
  int? lastTSCSlabEnd;
  int? lastTSCChargedDays;
  bool? tHCInvoiced;
  bool? tSCInvoiced;
  String? departureDate;
  bool? otherCFSContainer;
  bool? otherCTOContainer;
  String? invoiceNo;
  String? invoiceDate;
  int? invoiceValue;
  String? shippingLineNo;
  String? shippingLineName;
  String? movementType;
  String? sealType;
  String? otherCFS;
  String? cTOType;
  String? factorySealNo;
  String? fromPortCode;
  String? cargoType;
  String? toPortCode;
  bool? railOutDone;
  String? terminal;
  String? pOL;
  String? cFSSealNo;
  String? sizeType;
  bool? lockedContainer;
  String? activityName;
  bool? destuffingCompleted;
  bool? gateOut;
  bool? gateRailOutCompleted;
  String? gateRailOutDate;
  String? journeyRefNo;
  String? leoUpdatedOn;
  bool? deStuffDeleted;
  String? journeyTransType;
  int? journeyLineNo;
  int? exportBookingLineNo;
  int? itemLedgerEntryNo;
  int? stuffedPackaginShippingBill;
  int? totalPackages;
  String? pOD;
  String? selfSealNo;
  String? exportBookingNo;
  String? railBookingNo;
  String? gateOutNo;
  String? holdDate;
  String? unHoldDate;
  String? cutOffDate;
  String? vesselName;
  String? loadingJONo;
  bool? loadingCompleted;
  bool? mailLEOReceived;
  bool? mailExportOut;
  bool? mailExpPortArrival;
  bool? selectedOnLoadingJO;
  int? railBookingLineNo;
  String? railJourneyNo;
  int? railJourneyLineNo;
  String? outDate;
  String? wagonNo;
  String? rakeNo;
  String? linkedPlatform;
  bool? cBMBilling;
  int? totalCBMOfContainer;
  int? cBMPerDocContainer;
  bool? reeferInvoiced;
  String? reeferFromDateTime;
  String? reeferToDateTime;
  bool? transitDocument;
  String? transitLocation;
  int? perDocContainerWtMT;
  int? perDocContainerPKG;
  String? portArrivalDate;
  bool? attachedRailInvoice;
  bool? postedRailInvoice;
  String? weighmentNo;
  int? weightKGS;
  double? weightTons;
  String? exporterNo;
  String? exporterName;
  String? cHANo;
  String? cHAName;
  String? fileNo;
  String? messageCode;
  bool? bTTCompletedContainer;
  bool? wHBillingDone;
  bool? whBillingCompleted;
  String? linkPortCode;
  String? linkPortName;
  String? loadedShiftingJoNo;
  bool? loadedShiftingCompleted;
  String? loadedWeighmentNo;
  bool? loadedWeighmentCompleted;
  String? resourceUsed;
  String? loadedPlugInJONo;
  int? loadedPlugInDuration;
  bool? loadedPlugInSelected;
  bool? loadedPlugInBilled;
  String? emptyPlugInJONo;
  int? emptyPlugInDuration;
  bool? emptyPlugInSelected;
  bool? emptyPlugInBilled;
  String? lEOReceivedOn;
  bool? ownTransport;
  bool? doNotShow;
  int? expBookTransBookingEntryNo;
  String? expBookTripChartNo;
  String? expBookTripSheetNo;
  int? expDocTransBookingEntryNo;
  String? expDocTripChartNo;
  String? expDocTripSheetNo;
  bool? selectTransportBooking;
  String? cancelRemarksForTPTBooking;
  String? emptyPickupLocation;
  bool? ownICD;
  String? transportLinkLocation;
  String? transportPlanningDate;
  String? freightForwarderNo;
  String? shippingBillNo2;
  String? fSOutDate;
  String? vehicleNo;
  String? remarks;
  bool? doNotShow1;

  ExportModel1(
      {this.odataEtag,
        this.shippingBillNo,
        this.lineNo,
        this.containerNo,
        this.size,
        this.type,
        this.exciseSealNo,
        this.gateInPermitNo,
        this.fNRNo,
        this.gatePassNo,
        this.gateInType,
        this.declaredPackages,
        this.declaredWeight,
        this.tareWeight,
        this.factoryLocation,
        this.customsSealNo,
        this.lineSealNo,
        this.iSOCode,
        this.containerType,
        this.itemNo,
        this.itemDescription,
        this.uOM,
        this.volumeKG,
        this.markNos,
        this.netWeight,
        this.grossWeight,
        this.status,
        this.onHold,
        this.freightForwarderName,
        this.sealingDate,
        this.bookingLink,
        this.containerStatus,
        this.commodityCategory,
        this.commodityGroup,
        this.gateInCompleted,
        this.stuffingCompleted,
        this.bTTCompletedCargo,
        this.arrivalDate,
        this.selection,
        this.lEONo,
        this.lEODate,
        this.lEOTime,
        this.activityNo,
        this.shippingBillDate,
        this.docUpdateType,
        this.bookingRefNo,
        this.tSCTillDate,
        this.lastTSCSlabStart,
        this.lastTSCSlabEnd,
        this.lastTSCChargedDays,
        this.tHCInvoiced,
        this.tSCInvoiced,
        this.departureDate,
        this.otherCFSContainer,
        this.otherCTOContainer,
        this.invoiceNo,
        this.invoiceDate,
        this.invoiceValue,
        this.shippingLineNo,
        this.shippingLineName,
        this.movementType,
        this.sealType,
        this.otherCFS,
        this.cTOType,
        this.factorySealNo,
        this.fromPortCode,
        this.cargoType,
        this.toPortCode,
        this.railOutDone,
        this.terminal,
        this.pOL,
        this.cFSSealNo,
        this.sizeType,
        this.lockedContainer,
        this.activityName,
        this.destuffingCompleted,
        this.gateOut,
        this.gateRailOutCompleted,
        this.gateRailOutDate,
        this.journeyRefNo,
        this.leoUpdatedOn,
        this.deStuffDeleted,
        this.journeyTransType,
        this.journeyLineNo,
        this.exportBookingLineNo,
        this.itemLedgerEntryNo,
        this.stuffedPackaginShippingBill,
        this.totalPackages,
        this.pOD,
        this.selfSealNo,
        this.exportBookingNo,
        this.railBookingNo,
        this.gateOutNo,
        this.holdDate,
        this.unHoldDate,
        this.cutOffDate,
        this.vesselName,
        this.loadingJONo,
        this.loadingCompleted,
        this.mailLEOReceived,
        this.mailExportOut,
        this.mailExpPortArrival,
        this.selectedOnLoadingJO,
        this.railBookingLineNo,
        this.railJourneyNo,
        this.railJourneyLineNo,
        this.outDate,
        this.wagonNo,
        this.rakeNo,
        this.linkedPlatform,
        this.cBMBilling,
        this.totalCBMOfContainer,
        this.cBMPerDocContainer,
        this.reeferInvoiced,
        this.reeferFromDateTime,
        this.reeferToDateTime,
        this.transitDocument,
        this.transitLocation,
        this.perDocContainerWtMT,
        this.perDocContainerPKG,
        this.portArrivalDate,
        this.attachedRailInvoice,
        this.postedRailInvoice,
        this.weighmentNo,
        this.weightKGS,
        this.weightTons,
        this.exporterNo,
        this.exporterName,
        this.cHANo,
        this.cHAName,
        this.fileNo,
        this.messageCode,
        this.bTTCompletedContainer,
        this.wHBillingDone,
        this.whBillingCompleted,
        this.linkPortCode,
        this.linkPortName,
        this.loadedShiftingJoNo,
        this.loadedShiftingCompleted,
        this.loadedWeighmentNo,
        this.loadedWeighmentCompleted,
        this.resourceUsed,
        this.loadedPlugInJONo,
        this.loadedPlugInDuration,
        this.loadedPlugInSelected,
        this.loadedPlugInBilled,
        this.emptyPlugInJONo,
        this.emptyPlugInDuration,
        this.emptyPlugInSelected,
        this.emptyPlugInBilled,
        this.lEOReceivedOn,
        this.ownTransport,
        this.doNotShow,
        this.expBookTransBookingEntryNo,
        this.expBookTripChartNo,
        this.expBookTripSheetNo,
        this.expDocTransBookingEntryNo,
        this.expDocTripChartNo,
        this.expDocTripSheetNo,
        this.selectTransportBooking,
        this.cancelRemarksForTPTBooking,
        this.emptyPickupLocation,
        this.ownICD,
        this.transportLinkLocation,
        this.transportPlanningDate,
        this.freightForwarderNo,
        this.shippingBillNo2,
        this.fSOutDate,
        this.vehicleNo,
        this.remarks,
        this.doNotShow1});

  ExportModel1.fromJson(Map<String, dynamic> json) {
    odataEtag = json['@odata.etag'];
    shippingBillNo = json['Shipping_Bill_No'];
    lineNo = json['Line_No'];
    containerNo = json['Container_No'];
    size = json['Size'];
    type = json['Type'];
    exciseSealNo = json['Excise_Seal_No'];
    gateInPermitNo = json['Gate_In_Permit_No'];
    fNRNo = json['FNR_No'];
    gatePassNo = json['Gate_Pass_No'];
    gateInType = json['Gate_In_Type'];
    declaredPackages = json['Declared_Packages'];
    declaredWeight = (json['Declared_Weight']as num?)?.toDouble();
    tareWeight = (json['Tare_Weight']as num?)?.toDouble();;
    factoryLocation = json['Factory_Location'];
    customsSealNo = json['Customs_Seal_No'];
    lineSealNo = json['Line_Seal_No'];
    iSOCode = json['ISO_Code'];
    containerType = json['Container_Type'];
    itemNo = json['Item_No'];
    itemDescription = json['Item_Description'];
    uOM = json['UOM'];
    volumeKG = json['Volume_K_G'];
    markNos = json['Mark_Nos'];
    netWeight = (json['Net_Weight']as num?)?.toDouble();
    grossWeight = (json['Gross_Weight']as num?)?.toDouble();
    status = json['Status'];
    onHold = json['On_Hold'];
    freightForwarderName = json['Freight_Forwarder_Name'];
    sealingDate = json['Sealing_Date'];
    bookingLink = json['Booking_Link'];
    containerStatus = json['Container_Status'];
    commodityCategory = json['Commodity_Category'];
    commodityGroup = json['Commodity_Group'];
    gateInCompleted = json['Gate_In_Completed'];
    stuffingCompleted = json['Stuffing_Completed'];
    bTTCompletedCargo = json['BTT_Completed_Cargo'];
    arrivalDate = json['Arrival_Date'];
    selection = json['Selection'];
    lEONo = json['LEO_No'];
    lEODate = json['LEO_Date'];
    lEOTime = json['LEO_Time'];
    activityNo = json['Activity_No'];
    shippingBillDate = json['Shipping_Bill_Date'];
    docUpdateType = json['Doc_Update_Type'];
    bookingRefNo = json['Booking_Ref_No'];
    tSCTillDate = json['TSC_Till_Date'];
    lastTSCSlabStart = json['Last_TSC_Slab_Start'];
    lastTSCSlabEnd = json['Last_TSC_Slab_End'];
    lastTSCChargedDays = json['Last_TSC_Charged_Days'];
    tHCInvoiced = json['THC_Invoiced'];
    tSCInvoiced = json['TSC_Invoiced'];
    departureDate = json['Departure_Date'];
    otherCFSContainer = json['Other_CFS_Container'];
    otherCTOContainer = json['Other_CTO_Container'];
    invoiceNo = json['Invoice_No'];
    invoiceDate = json['Invoice_Date'];
    invoiceValue = json['Invoice_Value'];
    shippingLineNo = json['Shipping_Line_No'];
    shippingLineName = json['Shipping_Line_Name'];
    movementType = json['Movement_Type'];
    sealType = json['Seal_Type'];
    otherCFS = json['Other_CFS'];
    cTOType = json['CTO_Type'];
    factorySealNo = json['Factory_Seal_No'];
    fromPortCode = json['From_Port_Code'];
    cargoType = json['Cargo_Type'];
    toPortCode = json['To_Port_Code'];
    railOutDone = json['Rail_Out_Done'];
    terminal = json['Terminal'];
    pOL = json['POL'];
    cFSSealNo = json['CFS_Seal_No'];
    sizeType = json['Size_Type'];
    lockedContainer = json['Locked_Container'];
    activityName = json['Activity_Name'];
    destuffingCompleted = json['Destuffing_Completed'];
    gateOut = json['Gate_Out'];
    gateRailOutCompleted = json['Gate_Rail_Out_Completed'];
    gateRailOutDate = json['Gate_Rail_Out_Date'];
    journeyRefNo = json['Journey_Ref_No'];
    leoUpdatedOn = json['Leo_Updated_On'];
    deStuffDeleted = json['DeStuff_Deleted'];
    journeyTransType = json['Journey_Trans_Type'];
    journeyLineNo = json['Journey_Line_No'];
    exportBookingLineNo = json['Export_Booking_Line_No'];
    itemLedgerEntryNo = json['Item_Ledger_Entry_No'];
    stuffedPackaginShippingBill = json['Stuffed_Packagin_Shipping_Bill'];
    totalPackages = json['Total_Packages'];
    pOD = json['POD'];
    selfSealNo = json['Self_Seal_No'];
    exportBookingNo = json['Export_Booking_No'];
    railBookingNo = json['Rail_Booking_No'];
    gateOutNo = json['Gate_Out_No'];
    holdDate = json['Hold_Date'];
    unHoldDate = json['UnHold_Date'];
    cutOffDate = json['Cut_Off_Date'];
    vesselName = json['Vessel_Name'];
    loadingJONo = json['Loading_JO_No'];
    loadingCompleted = json['Loading_Completed'];
    mailLEOReceived = json['Mail_LEO_Received'];
    mailExportOut = json['Mail_Export_Out'];
    mailExpPortArrival = json['Mail_Exp_Port_Arrival'];
    selectedOnLoadingJO = json['Selected_On_Loading_JO'];
    railBookingLineNo = json['Rail_Booking_Line_No'];
    railJourneyNo = json['Rail_Journey_No'];
    railJourneyLineNo = json['Rail_Journey_Line_No'];
    outDate = json['Out_Date'];
    wagonNo = json['Wagon_No'];
    rakeNo = json['Rake_No'];
    linkedPlatform = json['Linked_Platform'];
    cBMBilling = json['CBM_Billing'];
    totalCBMOfContainer = json['Total_CBM_Of_Container'];
    cBMPerDocContainer = json['CBM_per_Doc_Container'];
    reeferInvoiced = json['Reefer_Invoiced'];
    reeferFromDateTime = json['Reefer_From_DateTime'];
    reeferToDateTime = json['Reefer_To_DateTime'];
    transitDocument = json['Transit_Document'];
    transitLocation = json['Transit_Location'];
    perDocContainerWtMT = json['Per_Doc_Container_Wt_MT'];
    perDocContainerPKG = json['Per_Doc_Container_PKG'];
    portArrivalDate = json['Port_Arrival_Date'];
    attachedRailInvoice = json['Attached_Rail_Invoice'];
    postedRailInvoice = json['Posted_Rail_Invoice'];
    weighmentNo = json['Weighment_No'];
    weightKGS = json['Weight_KGS'];
    weightTons = (json['Weight_Tons']as num?)?.toDouble();
    exporterNo = json['Exporter_No'];
    exporterName = json['Exporter_Name'];
    cHANo = json['CHA_No'];
    cHAName = json['CHA_Name'];
    fileNo = json['File_No'];
    messageCode = json['Message_Code'];
    bTTCompletedContainer = json['BTT_Completed_Container'];
    wHBillingDone = json['WH_Billing_Done'];
    whBillingCompleted = json['Wh_Billing_Completed'];
    linkPortCode = json['Link_Port_Code'];
    linkPortName = json['Link_Port_Name'];
    loadedShiftingJoNo = json['Loaded_Shifting_Jo_No'];
    loadedShiftingCompleted = json['Loaded_Shifting_Completed'];
    loadedWeighmentNo = json['Loaded_Weighment_No'];
    loadedWeighmentCompleted = json['Loaded_Weighment_Completed'];
    resourceUsed = json['Resource_Used'];
    loadedPlugInJONo = json['Loaded_Plug_In_JO_No'];
    loadedPlugInDuration = json['Loaded_Plug_In_Duration'];
    loadedPlugInSelected = json['Loaded_Plug_In_Selected'];
    loadedPlugInBilled = json['Loaded_Plug_In_Billed'];
    emptyPlugInJONo = json['Empty_Plug_In_JO_No'];
    emptyPlugInDuration = json['Empty_Plug_In_Duration'];
    emptyPlugInSelected = json['Empty_Plug_In_Selected'];
    emptyPlugInBilled = json['Empty_Plug_In_Billed'];
    lEOReceivedOn = json['LEO_Received_On'];
    ownTransport = json['Own_Transport'];
    doNotShow = json['Do_Not_Show'];
    expBookTransBookingEntryNo = json['ExpBook_TransBooking_Entry_No'];
    expBookTripChartNo = json['ExpBook_Trip_Chart_No'];
    expBookTripSheetNo = json['ExpBook_Trip_Sheet_No'];
    expDocTransBookingEntryNo = json['ExpDoc_Trans_Booking_Entry_No'];
    expDocTripChartNo = json['ExpDoc_Trip_Chart_No'];
    expDocTripSheetNo = json['ExpDoc_Trip_Sheet_No'];
    selectTransportBooking = json['Select_Transport_Booking'];
    cancelRemarksForTPTBooking = json['Cancel_Remarks_for_TPT_Booking'];
    emptyPickupLocation = json['Empty_Pickup_Location'];
    ownICD = json['Own_ICD'];
    transportLinkLocation = json['Transport_Link_Location'];
    transportPlanningDate = json['Transport_Planning_Date'];
    freightForwarderNo = json['Freight_Forwarder_No'];
    shippingBillNo2 = json['Shipping_Bill_No_2'];
    fSOutDate = json['FS_Out_Date'];
    vehicleNo = json['Vehicle_No'];
    remarks = json['Remarks'];
    doNotShow1 = json['Do_Not_Show1'];
  }



  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['@odata.etag'] = this.odataEtag;
    data['Shipping_Bill_No'] = this.shippingBillNo;
    data['Line_No'] = this.lineNo;
    data['Container_No'] = this.containerNo;
    data['Size'] = this.size;
    data['Type'] = this.type;
    data['Excise_Seal_No'] = this.exciseSealNo;
    data['Gate_In_Permit_No'] = this.gateInPermitNo;
    data['FNR_No'] = this.fNRNo;
    data['Gate_Pass_No'] = this.gatePassNo;
    data['Gate_In_Type'] = this.gateInType;
    data['Declared_Packages'] = this.declaredPackages;
    data['Declared_Weight'] = this.declaredWeight;
    data['Tare_Weight'] = this.tareWeight;
    data['Factory_Location'] = this.factoryLocation;
    data['Customs_Seal_No'] = this.customsSealNo;
    data['Line_Seal_No'] = this.lineSealNo;
    data['ISO_Code'] = this.iSOCode;
    data['Container_Type'] = this.containerType;
    data['Item_No'] = this.itemNo;
    data['Item_Description'] = this.itemDescription;
    data['UOM'] = this.uOM;
    data['Volume_K_G'] = this.volumeKG;
    data['Mark_Nos'] = this.markNos;
    data['Net_Weight'] = this.netWeight;
    data['Gross_Weight'] = this.grossWeight;
    data['Status'] = this.status;
    data['On_Hold'] = this.onHold;
    data['Freight_Forwarder_Name'] = this.freightForwarderName;
    data['Sealing_Date'] = this.sealingDate;
    data['Booking_Link'] = this.bookingLink;
    data['Container_Status'] = this.containerStatus;
    data['Commodity_Category'] = this.commodityCategory;
    data['Commodity_Group'] = this.commodityGroup;
    data['Gate_In_Completed'] = this.gateInCompleted;
    data['Stuffing_Completed'] = this.stuffingCompleted;
    data['BTT_Completed_Cargo'] = this.bTTCompletedCargo;
    data['Arrival_Date'] = this.arrivalDate;
    data['Selection'] = this.selection;
    data['LEO_No'] = this.lEONo;
    data['LEO_Date'] = this.lEODate;
    data['LEO_Time'] = this.lEOTime;
    data['Activity_No'] = this.activityNo;
    data['Shipping_Bill_Date'] = this.shippingBillDate;
    data['Doc_Update_Type'] = this.docUpdateType;
    data['Booking_Ref_No'] = this.bookingRefNo;
    data['TSC_Till_Date'] = this.tSCTillDate;
    data['Last_TSC_Slab_Start'] = this.lastTSCSlabStart;
    data['Last_TSC_Slab_End'] = this.lastTSCSlabEnd;
    data['Last_TSC_Charged_Days'] = this.lastTSCChargedDays;
    data['THC_Invoiced'] = this.tHCInvoiced;
    data['TSC_Invoiced'] = this.tSCInvoiced;
    data['Departure_Date'] = this.departureDate;
    data['Other_CFS_Container'] = this.otherCFSContainer;
    data['Other_CTO_Container'] = this.otherCTOContainer;
    data['Invoice_No'] = this.invoiceNo;
    data['Invoice_Date'] = this.invoiceDate;
    data['Invoice_Value'] = this.invoiceValue;
    data['Shipping_Line_No'] = this.shippingLineNo;
    data['Shipping_Line_Name'] = this.shippingLineName;
    data['Movement_Type'] = this.movementType;
    data['Seal_Type'] = this.sealType;
    data['Other_CFS'] = this.otherCFS;
    data['CTO_Type'] = this.cTOType;
    data['Factory_Seal_No'] = this.factorySealNo;
    data['From_Port_Code'] = this.fromPortCode;
    data['Cargo_Type'] = this.cargoType;
    data['To_Port_Code'] = this.toPortCode;
    data['Rail_Out_Done'] = this.railOutDone;
    data['Terminal'] = this.terminal;
    data['POL'] = this.pOL;
    data['CFS_Seal_No'] = this.cFSSealNo;
    data['Size_Type'] = this.sizeType;
    data['Locked_Container'] = this.lockedContainer;
    data['Activity_Name'] = this.activityName;
    data['Destuffing_Completed'] = this.destuffingCompleted;
    data['Gate_Out'] = this.gateOut;
    data['Gate_Rail_Out_Completed'] = this.gateRailOutCompleted;
    data['Gate_Rail_Out_Date'] = this.gateRailOutDate;
    data['Journey_Ref_No'] = this.journeyRefNo;
    data['Leo_Updated_On'] = this.leoUpdatedOn;
    data['DeStuff_Deleted'] = this.deStuffDeleted;
    data['Journey_Trans_Type'] = this.journeyTransType;
    data['Journey_Line_No'] = this.journeyLineNo;
    data['Export_Booking_Line_No'] = this.exportBookingLineNo;
    data['Item_Ledger_Entry_No'] = this.itemLedgerEntryNo;
    data['Stuffed_Packagin_Shipping_Bill'] = this.stuffedPackaginShippingBill;
    data['Total_Packages'] = this.totalPackages;
    data['POD'] = this.pOD;
    data['Self_Seal_No'] = this.selfSealNo;
    data['Export_Booking_No'] = this.exportBookingNo;
    data['Rail_Booking_No'] = this.railBookingNo;
    data['Gate_Out_No'] = this.gateOutNo;
    data['Hold_Date'] = this.holdDate;
    data['UnHold_Date'] = this.unHoldDate;
    data['Cut_Off_Date'] = this.cutOffDate;
    data['Vessel_Name'] = this.vesselName;
    data['Loading_JO_No'] = this.loadingJONo;
    data['Loading_Completed'] = this.loadingCompleted;
    data['Mail_LEO_Received'] = this.mailLEOReceived;
    data['Mail_Export_Out'] = this.mailExportOut;
    data['Mail_Exp_Port_Arrival'] = this.mailExpPortArrival;
    data['Selected_On_Loading_JO'] = this.selectedOnLoadingJO;
    data['Rail_Booking_Line_No'] = this.railBookingLineNo;
    data['Rail_Journey_No'] = this.railJourneyNo;
    data['Rail_Journey_Line_No'] = this.railJourneyLineNo;
    data['Out_Date'] = this.outDate;
    data['Wagon_No'] = this.wagonNo;
    data['Rake_No'] = this.rakeNo;
    data['Linked_Platform'] = this.linkedPlatform;
    data['CBM_Billing'] = this.cBMBilling;
    data['Total_CBM_Of_Container'] = this.totalCBMOfContainer;
    data['CBM_per_Doc_Container'] = this.cBMPerDocContainer;
    data['Reefer_Invoiced'] = this.reeferInvoiced;
    data['Reefer_From_DateTime'] = this.reeferFromDateTime;
    data['Reefer_To_DateTime'] = this.reeferToDateTime;
    data['Transit_Document'] = this.transitDocument;
    data['Transit_Location'] = this.transitLocation;
    data['Per_Doc_Container_Wt_MT'] = this.perDocContainerWtMT;
    data['Per_Doc_Container_PKG'] = this.perDocContainerPKG;
    data['Port_Arrival_Date'] = this.portArrivalDate;
    data['Attached_Rail_Invoice'] = this.attachedRailInvoice;
    data['Posted_Rail_Invoice'] = this.postedRailInvoice;
    data['Weighment_No'] = this.weighmentNo;
    data['Weight_KGS'] = this.weightKGS;
    data['Weight_Tons'] = this.weightTons;
    data['Exporter_No'] = this.exporterNo;
    data['Exporter_Name'] = this.exporterName;
    data['CHA_No'] = this.cHANo;
    data['CHA_Name'] = this.cHAName;
    data['File_No'] = this.fileNo;
    data['Message_Code'] = this.messageCode;
    data['BTT_Completed_Container'] = this.bTTCompletedContainer;
    data['WH_Billing_Done'] = this.wHBillingDone;
    data['Wh_Billing_Completed'] = this.whBillingCompleted;
    data['Link_Port_Code'] = this.linkPortCode;
    data['Link_Port_Name'] = this.linkPortName;
    data['Loaded_Shifting_Jo_No'] = this.loadedShiftingJoNo;
    data['Loaded_Shifting_Completed'] = this.loadedShiftingCompleted;
    data['Loaded_Weighment_No'] = this.loadedWeighmentNo;
    data['Loaded_Weighment_Completed'] = this.loadedWeighmentCompleted;
    data['Resource_Used'] = this.resourceUsed;
    data['Loaded_Plug_In_JO_No'] = this.loadedPlugInJONo;
    data['Loaded_Plug_In_Duration'] = this.loadedPlugInDuration;
    data['Loaded_Plug_In_Selected'] = this.loadedPlugInSelected;
    data['Loaded_Plug_In_Billed'] = this.loadedPlugInBilled;
    data['Empty_Plug_In_JO_No'] = this.emptyPlugInJONo;
    data['Empty_Plug_In_Duration'] = this.emptyPlugInDuration;
    data['Empty_Plug_In_Selected'] = this.emptyPlugInSelected;
    data['Empty_Plug_In_Billed'] = this.emptyPlugInBilled;
    data['LEO_Received_On'] = this.lEOReceivedOn;
    data['Own_Transport'] = this.ownTransport;
    data['Do_Not_Show'] = this.doNotShow;
    data['ExpBook_TransBooking_Entry_No'] = this.expBookTransBookingEntryNo;
    data['ExpBook_Trip_Chart_No'] = this.expBookTripChartNo;
    data['ExpBook_Trip_Sheet_No'] = this.expBookTripSheetNo;
    data['ExpDoc_Trans_Booking_Entry_No'] = this.expDocTransBookingEntryNo;
    data['ExpDoc_Trip_Chart_No'] = this.expDocTripChartNo;
    data['ExpDoc_Trip_Sheet_No'] = this.expDocTripSheetNo;
    data['Select_Transport_Booking'] = this.selectTransportBooking;
    data['Cancel_Remarks_for_TPT_Booking'] = this.cancelRemarksForTPTBooking;
    data['Empty_Pickup_Location'] = this.emptyPickupLocation;
    data['Own_ICD'] = this.ownICD;
    data['Transport_Link_Location'] = this.transportLinkLocation;
    data['Transport_Planning_Date'] = this.transportPlanningDate;
    data['Freight_Forwarder_No'] = this.freightForwarderNo;
    data['Shipping_Bill_No_2'] = this.shippingBillNo2;
    data['FS_Out_Date'] = this.fSOutDate;
    data['Vehicle_No'] = this.vehicleNo;
    data['Remarks'] = this.remarks;
    data['Do_Not_Show1'] = this.doNotShow1;
    return data;
  }
}
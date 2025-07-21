class LoginModel {
  String? odataContext;
  List<Value>? value;

  LoginModel({this.odataContext, this.value});

  LoginModel.fromJson(Map<String, dynamic> json) {
    odataContext = json['@odata.context'];
    if (json['value'] != null) {
      value = <Value>[];
      json['value'].forEach((v) {
        value!.add(new Value.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['@odata.context'] = this.odataContext;
    if (this.value != null) {
      data['value'] = this.value!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Value {
  String? odataEtag;
  String? no;
  String? createdBy;
  String? createdDateTime;
  String? location;
  String? name;
  String? address;
  String? address2;
  String? postCode;
  String? city;
  String? countryRegionCode;
  String? stateCode;
  String? phoneNo;
  String? primaryContactNo;
  String? contact;
  String? searchName;
  bool? foreignBasedCustomer;
  String? name2;
  String? customerType;
  double? balanceLCY;
  String? globalDimension1Code;
  String? globalDimension2Code;
  int? pDABalanceLCY;
  int? creditLimitLCY;
  String? customerCategory;
  bool? primary;
  bool? affliate;
  String? iECCode;
  String? customerSubCategory;
  bool? exporter;
  bool? importera;
  bool? cHA;
  bool? freightForwarder;
  bool? shippingLine;
  bool? otherCFS;
  bool? transporter;
  bool? consignee;
  bool? consignor;
  bool? domestic;
  bool? consolidator;
  String? printAddress;
  String? salespersonCode;
  String? responsibilityCenter;
  String? serviceZoneCode;
  String? blocked;
  bool? privacyBlocked;
  String? lastDateModified;
  int? dailyCashPaymentLimit;
  String? modifiedBy;
  String? modifiedDateTime;
  String? defaultShipToAddress;
  String? gSTINSurrenderDate;
  String? phoneNo2;
  String? faxNo;
  String? eMail;
  String? homePage;
  String? iCPartnerCode;
  String? documentSendingProfile;
  String? importerEmailId;
  bool? customerImporterMailId;
  bool? cHAImporterMailId;
  bool? shippingLineImporterMailId;
  String? exporterEmailId;
  bool? customerExportMailId;
  bool? cHAExportMailId;
  bool? shippingLineExportMailId;
  String? emptyEmailId;
  bool? customerEmptyMailId;
  bool? cHAEmptyMailId;
  bool? shippingLineEmptyMailId;
  String? domesticEmailId;
  bool? customerDomesticMailId;
  bool? cHADomesticMailId;
  bool? shippingLineDomesticMailId;
  String? transportEmailId;
  bool? customerTransportMailId;
  bool? cHATransportMailId;
  bool? shippingLineTransportMailI;
  String? accountsEmailId;
  String? billToCustomerNo;
  String? vATRegistrationNo;
  String? gLN;
  int? invoiceCopies;
  String? invoiceDiscCode;
  String? copySellToAddrToQteFrom;
  String? genBusPostingGroup;
  String? vATBusPostingGroup;
  String? customerPostingGroup;
  String? customerPriceGroup;
  String? customerDiscGroup;
  bool? allowLineDisc;
  bool? pricesIncludingVAT;
  int? prepaymentPercent;
  String? applicationMethod;
  String? partnerType;
  String? paymentTermsCode;
  String? paymentMethodCode;
  String? reminderTermsCode;
  String? finChargeTermsCode;
  String? cashFlowPaymentTermsCode;
  bool? printStatements;
  int? lastStatementNo;
  bool? blockPaymentTolerance;
  String? locationCode;
  bool? combineShipments;
  String? reserve;
  String? shippingAdvice;
  String? shipmentMethodCode;
  String? shippingAgentCode;
  String? shippingAgentServiceCode;
  String? shippingTime;
  String? baseCalendarCode;
  String? currencyCode;
  String? languageCode;
  bool? wSExportTrackingScreen;
  bool? wSImportTrackingScreen;
  bool? wSDomesticTrackingScreen;
  bool? wSEmptyTrackingScreen;
  bool? wSTransportTrackingScreen;
  bool? wSOutstandingScreen;
  bool? wSInvoiceScreen;
  bool? wSWerhouseInventoryScreen;
  bool? wSEmptyCtnrInvenScrn;
  bool? wSExportBookingScreen;
  bool? wSImportBookingScreen;
  bool? wSDomesticBookingScreen;
  bool? wSEmptyBookingScreen;
  bool? wSTransportBookingScreen;
  bool? monthWiseImportArrival;
  bool? monthWiseExpDispatch;
  bool? importPendancy;
  bool? exportPendancy;
  bool? outStandings;
  bool? sAUMTYInventoryNotShow;
  bool? jDHMTYInventoryNotShow;
  bool? wPMPCustomerBlock;
  bool? wSMiscOpenJo;
  bool? wSMiscCloseJo;
  String? password;
  String? mPIN;
  bool? taxLiable;
  String? gSTCustomerType;
  String? gSTRegistrationType;
  String? gSTRegistrationNo;
  bool? eCommerceOperator;
  String? gSTINWEFDate;
  String? gSTINCancellationDate;
  String? gSTINCategory;
  String? aRNNo;
  String? pANNo;
  String? pANStatus;
  String? pANReferenceNo;
  String? globalDimension1Filter;
  String? globalDimension2Filter;
  String? currencyFilter;

  Value(
      {this.odataEtag,
        this.no,
        this.createdBy,
        this.createdDateTime,
        this.location,
        this.name,
        this.address,
        this.address2,
        this.postCode,
        this.city,
        this.countryRegionCode,
        this.stateCode,
        this.phoneNo,
        this.primaryContactNo,
        this.contact,
        this.searchName,
        this.foreignBasedCustomer,
        this.name2,
        this.customerType,
        this.balanceLCY,
        this.globalDimension1Code,
        this.globalDimension2Code,
        this.pDABalanceLCY,
        this.creditLimitLCY,
        this.customerCategory,
        this.primary,
        this.affliate,
        this.iECCode,
        this.customerSubCategory,
        this.exporter,
        this.importera,
        this.cHA,
        this.freightForwarder,
        this.shippingLine,
        this.otherCFS,
        this.transporter,
        this.consignee,
        this.consignor,
        this.domestic,
        this.consolidator,
        this.printAddress,
        this.salespersonCode,
        this.responsibilityCenter,
        this.serviceZoneCode,
        this.blocked,
        this.privacyBlocked,
        this.lastDateModified,
        this.dailyCashPaymentLimit,
        this.modifiedBy,
        this.modifiedDateTime,
        this.defaultShipToAddress,
        this.gSTINSurrenderDate,
        this.phoneNo2,
        this.faxNo,
        this.eMail,
        this.homePage,
        this.iCPartnerCode,
        this.documentSendingProfile,
        this.importerEmailId,
        this.customerImporterMailId,
        this.cHAImporterMailId,
        this.shippingLineImporterMailId,
        this.exporterEmailId,
        this.customerExportMailId,
        this.cHAExportMailId,
        this.shippingLineExportMailId,
        this.emptyEmailId,
        this.customerEmptyMailId,
        this.cHAEmptyMailId,
        this.shippingLineEmptyMailId,
        this.domesticEmailId,
        this.customerDomesticMailId,
        this.cHADomesticMailId,
        this.shippingLineDomesticMailId,
        this.transportEmailId,
        this.customerTransportMailId,
        this.cHATransportMailId,
        this.shippingLineTransportMailI,
        this.accountsEmailId,
        this.billToCustomerNo,
        this.vATRegistrationNo,
        this.gLN,
        this.invoiceCopies,
        this.invoiceDiscCode,
        this.copySellToAddrToQteFrom,
        this.genBusPostingGroup,
        this.vATBusPostingGroup,
        this.customerPostingGroup,
        this.customerPriceGroup,
        this.customerDiscGroup,
        this.allowLineDisc,
        this.pricesIncludingVAT,
        this.prepaymentPercent,
        this.applicationMethod,
        this.partnerType,
        this.paymentTermsCode,
        this.paymentMethodCode,
        this.reminderTermsCode,
        this.finChargeTermsCode,
        this.cashFlowPaymentTermsCode,
        this.printStatements,
        this.lastStatementNo,
        this.blockPaymentTolerance,
        this.locationCode,
        this.combineShipments,
        this.reserve,
        this.shippingAdvice,
        this.shipmentMethodCode,
        this.shippingAgentCode,
        this.shippingAgentServiceCode,
        this.shippingTime,
        this.baseCalendarCode,
        this.currencyCode,
        this.languageCode,
        this.wSExportTrackingScreen,
        this.wSImportTrackingScreen,
        this.wSDomesticTrackingScreen,
        this.wSEmptyTrackingScreen,
        this.wSTransportTrackingScreen,
        this.wSOutstandingScreen,
        this.wSInvoiceScreen,
        this.wSWerhouseInventoryScreen,
        this.wSEmptyCtnrInvenScrn,
        this.wSExportBookingScreen,
        this.wSImportBookingScreen,
        this.wSDomesticBookingScreen,
        this.wSEmptyBookingScreen,
        this.wSTransportBookingScreen,
        this.monthWiseImportArrival,
        this.monthWiseExpDispatch,
        this.importPendancy,
        this.exportPendancy,
        this.outStandings,
        this.sAUMTYInventoryNotShow,
        this.jDHMTYInventoryNotShow,
        this.wPMPCustomerBlock,
        this.wSMiscOpenJo,
        this.wSMiscCloseJo,
        this.password,
        this.mPIN,
        this.taxLiable,
        this.gSTCustomerType,
        this.gSTRegistrationType,
        this.gSTRegistrationNo,
        this.eCommerceOperator,
        this.gSTINWEFDate,
        this.gSTINCancellationDate,
        this.gSTINCategory,
        this.aRNNo,
        this.pANNo,
        this.pANStatus,
        this.pANReferenceNo,
        this.globalDimension1Filter,
        this.globalDimension2Filter,
        this.currencyFilter, required code, required county, required timeZone});

  Value.fromJson(Map<String, dynamic> json) {
    odataEtag = json['@odata.etag'];
    no = json['No'];
    createdBy = json['Created_By'];
    createdDateTime = json['Created_DateTime'];
    location = json['Location'];
    name = json['Name'];
    address = json['Address'];
    address2 = json['Address_2'];
    postCode = json['Post_Code'];
    city = json['City'];
    countryRegionCode = json['Country_Region_Code'];
    stateCode = json['State_Code'];
    phoneNo = json['Phone_No'];
    primaryContactNo = json['Primary_Contact_No'];
    contact = json['Contact'];
    searchName = json['Search_Name'];
    foreignBasedCustomer = json['Foreign_Based_Customer'];
    name2 = json['Name_2'];
    customerType = json['Customer_Type'];
    balanceLCY = (json['Balance_LCY'] as num?)?.toDouble();
    globalDimension1Code = json['Global_Dimension_1_Code'];
    globalDimension2Code = json['Global_Dimension_2_Code'];
    pDABalanceLCY = json['PDA_Balance_LCY'];
    creditLimitLCY = json['Credit_Limit_LCY'];
    customerCategory = json['Customer_Category'];
    primary = json['Primary'];
    affliate = json['Affliate'];
    iECCode = json['IEC_Code'];
    customerSubCategory = json['Customer_SubCategory'];
    exporter = json['Exporter'];
    importera = json['Importera'];
    cHA = json['CHA'];
    freightForwarder = json['Freight_Forwarder'];
    shippingLine = json['Shipping_Line'];
    otherCFS = json['Other_CFS'];
    transporter = json['Transporter'];
    consignee = json['Consignee'];
    consignor = json['Consignor'];
    domestic = json['Domestic'];
    consolidator = json['Consolidator'];
    printAddress = json['Print_Address'];
    salespersonCode = json['Salesperson_Code'];
    responsibilityCenter = json['Responsibility_Center'];
    serviceZoneCode = json['Service_Zone_Code'];
    blocked = json['Blocked'];
    privacyBlocked = json['Privacy_Blocked'];
    lastDateModified = json['Last_Date_Modified'];
    dailyCashPaymentLimit = json['Daily_Cash_Payment_Limit'];
    modifiedBy = json['Modified_By'];
    modifiedDateTime = json['Modified_DateTime'];
    defaultShipToAddress = json['Default_Ship_To_Address'];
    gSTINSurrenderDate = json['GSTIN_Surrender_Date'];
    phoneNo2 = json['Phone_No_2'];
    faxNo = json['Fax_No'];
    eMail = json['E_Mail'];
    homePage = json['Home_Page'];
    iCPartnerCode = json['IC_Partner_Code'];
    documentSendingProfile = json['Document_Sending_Profile'];
    importerEmailId = json['Importer_Email_Id'];
    customerImporterMailId = json['Customer_Importer_mail_Id'];
    cHAImporterMailId = json['CHA_Importer_mail_id'];
    shippingLineImporterMailId = json['Shipping_Line_Importer_mail_id'];
    exporterEmailId = json['Exporter_Email_Id'];
    customerExportMailId = json['Customer_Export_mail_id'];
    cHAExportMailId = json['CHA_Export_mail_id'];
    shippingLineExportMailId = json['Shipping_Line_Export_mail_id'];
    emptyEmailId = json['Empty_Email_Id'];
    customerEmptyMailId = json['Customer_Empty_mail_id'];
    cHAEmptyMailId = json['CHA_Empty_mail_id'];
    shippingLineEmptyMailId = json['Shipping_Line_Empty_mail_id'];
    domesticEmailId = json['Domestic_Email_Id'];
    customerDomesticMailId = json['Customer_Domestic_mail_id'];
    cHADomesticMailId = json['CHA_Domestic_mail_id'];
    shippingLineDomesticMailId = json['Shipping_Line_Domestic_mail_id'];
    transportEmailId = json['Transport_Email_Id'];
    customerTransportMailId = json['Customer_Transport_mail_id'];
    cHATransportMailId = json['CHA_Transport_mail_id'];
    shippingLineTransportMailI = json['Shipping_Line_Transport_mail_i'];
    accountsEmailId = json['Accounts_Email_Id'];
    billToCustomerNo = json['Bill_to_Customer_No'];
    vATRegistrationNo = json['VAT_Registration_No'];
    gLN = json['GLN'];
    invoiceCopies = json['Invoice_Copies'];
    invoiceDiscCode = json['Invoice_Disc_Code'];
    copySellToAddrToQteFrom = json['Copy_Sell_to_Addr_to_Qte_From'];
    genBusPostingGroup = json['Gen_Bus_Posting_Group'];
    vATBusPostingGroup = json['VAT_Bus_Posting_Group'];
    customerPostingGroup = json['Customer_Posting_Group'];
    customerPriceGroup = json['Customer_Price_Group'];
    customerDiscGroup = json['Customer_Disc_Group'];
    allowLineDisc = json['Allow_Line_Disc'];
    pricesIncludingVAT = json['Prices_Including_VAT'];
    prepaymentPercent = json['Prepayment_Percent'];
    applicationMethod = json['Application_Method'];
    partnerType = json['Partner_Type'];
    paymentTermsCode = json['Payment_Terms_Code'];
    paymentMethodCode = json['Payment_Method_Code'];
    reminderTermsCode = json['Reminder_Terms_Code'];
    finChargeTermsCode = json['Fin_Charge_Terms_Code'];
    cashFlowPaymentTermsCode = json['Cash_Flow_Payment_Terms_Code'];
    printStatements = json['Print_Statements'];
    lastStatementNo = json['Last_Statement_No'];
    blockPaymentTolerance = json['Block_Payment_Tolerance'];
    locationCode = json['Location_Code'];
    combineShipments = json['Combine_Shipments'];
    reserve = json['Reserve'];
    shippingAdvice = json['Shipping_Advice'];
    shipmentMethodCode = json['Shipment_Method_Code'];
    shippingAgentCode = json['Shipping_Agent_Code'];
    shippingAgentServiceCode = json['Shipping_Agent_Service_Code'];
    shippingTime = json['Shipping_Time'];
    baseCalendarCode = json['Base_Calendar_Code'];
    currencyCode = json['Currency_Code'];
    languageCode = json['Language_Code'];
    wSExportTrackingScreen = json['WS_Export_Tracking_Screen'];
    wSImportTrackingScreen = json['WS_Import_Tracking_Screen'];
    wSDomesticTrackingScreen = json['WS_Domestic_Tracking_Screen'];
    wSEmptyTrackingScreen = json['WS_Empty_Tracking_Screen'];
    wSTransportTrackingScreen = json['WS_Transport_Tracking_Screen'];
    wSOutstandingScreen = json['WS_Outstanding_Screen'];
    wSInvoiceScreen = json['WS_Invoice_Screen'];
    wSWerhouseInventoryScreen = json['WS_Werhouse_Inventory_Screen'];
    wSEmptyCtnrInvenScrn = json['WS_Empty_Ctnr_Inven_Scrn'];
    wSExportBookingScreen = json['WS_Export_Booking_Screen'];
    wSImportBookingScreen = json['WS_Import_Booking_Screen'];
    wSDomesticBookingScreen = json['WS_Domestic_Booking_Screen'];
    wSEmptyBookingScreen = json['WS_Empty_Booking_Screen'];
    wSTransportBookingScreen = json['WS_Transport_Booking_Screen'];
    monthWiseImportArrival = json['Month_Wise_Import_Arrival'];
    monthWiseExpDispatch = json['Month_Wise_Exp_Dispatch'];
    importPendancy = json['Import_Pendancy'];
    exportPendancy = json['Export_Pendancy'];
    outStandings = json['OutStandings'];
    sAUMTYInventoryNotShow = json['SAU_MTY_Inventory_Not_Show'];
    jDHMTYInventoryNotShow = json['JDH_MTY_Inventory_Not_Show'];
    wPMPCustomerBlock = json['WPMP_Customer_Block'];
    wSMiscOpenJo = json['WS_Misc_Open_Jo'];
    wSMiscCloseJo = json['WS_Misc_Close_Jo'];
    password = json['Password'];
    mPIN = json['MPIN'];
    taxLiable = json['Tax_Liable'];
    gSTCustomerType = json['GST_Customer_Type'];
    gSTRegistrationType = json['GST_Registration_Type'];
    gSTRegistrationNo = json['GST_Registration_No'];
    eCommerceOperator = json['e_Commerce_Operator'];
    gSTINWEFDate = json['GSTIN_w_e_f_Date'];
    gSTINCancellationDate = json['GSTIN_Cancellation_Date'];
    gSTINCategory = json['GSTIN_Category'];
    aRNNo = json['ARN_No'];
    pANNo = json['P_A_N_No'];
    pANStatus = json['P_A_N_Status'];
    pANReferenceNo = json['P_A_N_Reference_No'];
    globalDimension1Filter = json['Global_Dimension_1_Filter'];
    globalDimension2Filter = json['Global_Dimension_2_Filter'];
    currencyFilter = json['Currency_Filter'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['@odata.etag'] = this.odataEtag;
    data['No'] = this.no;
    data['Created_By'] = this.createdBy;
    data['Created_DateTime'] = this.createdDateTime;
    data['Location'] = this.location;
    data['Name'] = this.name;
    data['Address'] = this.address;
    data['Address_2'] = this.address2;
    data['Post_Code'] = this.postCode;
    data['City'] = this.city;
    data['Country_Region_Code'] = this.countryRegionCode;
    data['State_Code'] = this.stateCode;
    data['Phone_No'] = this.phoneNo;
    data['Primary_Contact_No'] = this.primaryContactNo;
    data['Contact'] = this.contact;
    data['Search_Name'] = this.searchName;
    data['Foreign_Based_Customer'] = this.foreignBasedCustomer;
    data['Name_2'] = this.name2;
    data['Customer_Type'] = this.customerType;
    data['Balance_LCY'] = this.balanceLCY;
    data['Global_Dimension_1_Code'] = this.globalDimension1Code;
    data['Global_Dimension_2_Code'] = this.globalDimension2Code;
    data['PDA_Balance_LCY'] = this.pDABalanceLCY;
    data['Credit_Limit_LCY'] = this.creditLimitLCY;
    data['Customer_Category'] = this.customerCategory;
    data['Primary'] = this.primary;
    data['Affliate'] = this.affliate;
    data['IEC_Code'] = this.iECCode;
    data['Customer_SubCategory'] = this.customerSubCategory;
    data['Exporter'] = this.exporter;
    data['Importera'] = this.importera;
    data['CHA'] = this.cHA;
    data['Freight_Forwarder'] = this.freightForwarder;
    data['Shipping_Line'] = this.shippingLine;
    data['Other_CFS'] = this.otherCFS;
    data['Transporter'] = this.transporter;
    data['Consignee'] = this.consignee;
    data['Consignor'] = this.consignor;
    data['Domestic'] = this.domestic;
    data['Consolidator'] = this.consolidator;
    data['Print_Address'] = this.printAddress;
    data['Salesperson_Code'] = this.salespersonCode;
    data['Responsibility_Center'] = this.responsibilityCenter;
    data['Service_Zone_Code'] = this.serviceZoneCode;
    data['Blocked'] = this.blocked;
    data['Privacy_Blocked'] = this.privacyBlocked;
    data['Last_Date_Modified'] = this.lastDateModified;
    data['Daily_Cash_Payment_Limit'] = this.dailyCashPaymentLimit;
    data['Modified_By'] = this.modifiedBy;
    data['Modified_DateTime'] = this.modifiedDateTime;
    data['Default_Ship_To_Address'] = this.defaultShipToAddress;
    data['GSTIN_Surrender_Date'] = this.gSTINSurrenderDate;
    data['Phone_No_2'] = this.phoneNo2;
    data['Fax_No'] = this.faxNo;
    data['E_Mail'] = this.eMail;
    data['Home_Page'] = this.homePage;
    data['IC_Partner_Code'] = this.iCPartnerCode;
    data['Document_Sending_Profile'] = this.documentSendingProfile;
    data['Importer_Email_Id'] = this.importerEmailId;
    data['Customer_Importer_mail_Id'] = this.customerImporterMailId;
    data['CHA_Importer_mail_id'] = this.cHAImporterMailId;
    data['Shipping_Line_Importer_mail_id'] = this.shippingLineImporterMailId;
    data['Exporter_Email_Id'] = this.exporterEmailId;
    data['Customer_Export_mail_id'] = this.customerExportMailId;
    data['CHA_Export_mail_id'] = this.cHAExportMailId;
    data['Shipping_Line_Export_mail_id'] = this.shippingLineExportMailId;
    data['Empty_Email_Id'] = this.emptyEmailId;
    data['Customer_Empty_mail_id'] = this.customerEmptyMailId;
    data['CHA_Empty_mail_id'] = this.cHAEmptyMailId;
    data['Shipping_Line_Empty_mail_id'] = this.shippingLineEmptyMailId;
    data['Domestic_Email_Id'] = this.domesticEmailId;
    data['Customer_Domestic_mail_id'] = this.customerDomesticMailId;
    data['CHA_Domestic_mail_id'] = this.cHADomesticMailId;
    data['Shipping_Line_Domestic_mail_id'] = this.shippingLineDomesticMailId;
    data['Transport_Email_Id'] = this.transportEmailId;
    data['Customer_Transport_mail_id'] = this.customerTransportMailId;
    data['CHA_Transport_mail_id'] = this.cHATransportMailId;
    data['Shipping_Line_Transport_mail_i'] = this.shippingLineTransportMailI;
    data['Accounts_Email_Id'] = this.accountsEmailId;
    data['Bill_to_Customer_No'] = this.billToCustomerNo;
    data['VAT_Registration_No'] = this.vATRegistrationNo;
    data['GLN'] = this.gLN;
    data['Invoice_Copies'] = this.invoiceCopies;
    data['Invoice_Disc_Code'] = this.invoiceDiscCode;
    data['Copy_Sell_to_Addr_to_Qte_From'] = this.copySellToAddrToQteFrom;
    data['Gen_Bus_Posting_Group'] = this.genBusPostingGroup;
    data['VAT_Bus_Posting_Group'] = this.vATBusPostingGroup;
    data['Customer_Posting_Group'] = this.customerPostingGroup;
    data['Customer_Price_Group'] = this.customerPriceGroup;
    data['Customer_Disc_Group'] = this.customerDiscGroup;
    data['Allow_Line_Disc'] = this.allowLineDisc;
    data['Prices_Including_VAT'] = this.pricesIncludingVAT;
    data['Prepayment_Percent'] = this.prepaymentPercent;
    data['Application_Method'] = this.applicationMethod;
    data['Partner_Type'] = this.partnerType;
    data['Payment_Terms_Code'] = this.paymentTermsCode;
    data['Payment_Method_Code'] = this.paymentMethodCode;
    data['Reminder_Terms_Code'] = this.reminderTermsCode;
    data['Fin_Charge_Terms_Code'] = this.finChargeTermsCode;
    data['Cash_Flow_Payment_Terms_Code'] = this.cashFlowPaymentTermsCode;
    data['Print_Statements'] = this.printStatements;
    data['Last_Statement_No'] = this.lastStatementNo;
    data['Block_Payment_Tolerance'] = this.blockPaymentTolerance;
    data['Location_Code'] = this.locationCode;
    data['Combine_Shipments'] = this.combineShipments;
    data['Reserve'] = this.reserve;
    data['Shipping_Advice'] = this.shippingAdvice;
    data['Shipment_Method_Code'] = this.shipmentMethodCode;
    data['Shipping_Agent_Code'] = this.shippingAgentCode;
    data['Shipping_Agent_Service_Code'] = this.shippingAgentServiceCode;
    data['Shipping_Time'] = this.shippingTime;
    data['Base_Calendar_Code'] = this.baseCalendarCode;
    data['Currency_Code'] = this.currencyCode;
    data['Language_Code'] = this.languageCode;
    data['WS_Export_Tracking_Screen'] = this.wSExportTrackingScreen;
    data['WS_Import_Tracking_Screen'] = this.wSImportTrackingScreen;
    data['WS_Domestic_Tracking_Screen'] = this.wSDomesticTrackingScreen;
    data['WS_Empty_Tracking_Screen'] = this.wSEmptyTrackingScreen;
    data['WS_Transport_Tracking_Screen'] = this.wSTransportTrackingScreen;
    data['WS_Outstanding_Screen'] = this.wSOutstandingScreen;
    data['WS_Invoice_Screen'] = this.wSInvoiceScreen;
    data['WS_Werhouse_Inventory_Screen'] = this.wSWerhouseInventoryScreen;
    data['WS_Empty_Ctnr_Inven_Scrn'] = this.wSEmptyCtnrInvenScrn;
    data['WS_Export_Booking_Screen'] = this.wSExportBookingScreen;
    data['WS_Import_Booking_Screen'] = this.wSImportBookingScreen;
    data['WS_Domestic_Booking_Screen'] = this.wSDomesticBookingScreen;
    data['WS_Empty_Booking_Screen'] = this.wSEmptyBookingScreen;
    data['WS_Transport_Booking_Screen'] = this.wSTransportBookingScreen;
    data['Month_Wise_Import_Arrival'] = this.monthWiseImportArrival;
    data['Month_Wise_Exp_Dispatch'] = this.monthWiseExpDispatch;
    data['Import_Pendancy'] = this.importPendancy;
    data['Export_Pendancy'] = this.exportPendancy;
    data['OutStandings'] = this.outStandings;
    data['SAU_MTY_Inventory_Not_Show'] = this.sAUMTYInventoryNotShow;
    data['JDH_MTY_Inventory_Not_Show'] = this.jDHMTYInventoryNotShow;
    data['WPMP_Customer_Block'] = this.wPMPCustomerBlock;
    data['WS_Misc_Open_Jo'] = this.wSMiscOpenJo;
    data['WS_Misc_Close_Jo'] = this.wSMiscCloseJo;
    data['Password'] = this.password;
    data['MPIN'] = this.mPIN;
    data['Tax_Liable'] = this.taxLiable;
    data['GST_Customer_Type'] = this.gSTCustomerType;
    data['GST_Registration_Type'] = this.gSTRegistrationType;
    data['GST_Registration_No'] = this.gSTRegistrationNo;
    data['e_Commerce_Operator'] = this.eCommerceOperator;
    data['GSTIN_w_e_f_Date'] = this.gSTINWEFDate;
    data['GSTIN_Cancellation_Date'] = this.gSTINCancellationDate;
    data['GSTIN_Category'] = this.gSTINCategory;
    data['ARN_No'] = this.aRNNo;
    data['P_A_N_No'] = this.pANNo;
    data['P_A_N_Status'] = this.pANStatus;
    data['P_A_N_Reference_No'] = this.pANReferenceNo;
    data['Global_Dimension_1_Filter'] = this.globalDimension1Filter;
    data['Global_Dimension_2_Filter'] = this.globalDimension2Filter;
    data['Currency_Filter'] = this.currencyFilter;
    return data;
  }
}

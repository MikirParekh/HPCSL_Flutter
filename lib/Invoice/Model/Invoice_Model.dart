class InvoiceModel {
  String? odataContext;
  List<InvoiceModel1>? value;

  InvoiceModel({this.odataContext, this.value});

  InvoiceModel.fromJson(Map<String, dynamic> json) {
    odataContext = json['@odata.context'];
    if (json['value'] != null) {
      value = <InvoiceModel1>[];
      json['value'].forEach((v) {
        value?.add(new InvoiceModel1.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['@odata.context'] = this.odataContext;
    if (this.value != null) {
      data['value'] = this.value?.map((v) => v?.toJson()).toList();
    }
    return data;
  }
}

class InvoiceModel1 {
  String? odataEtag;
  String? no;
  String? salesType;
  String? sellToCustomerNo;
  String? sellToCustomerName;
  String? currencyCode;
  double? amount;
  double? amountIncludingVAT;
  double? iGSTAmount;
  double? cGSTAmount;
  double? sGSTAmount;
  double? amounttocustomer;
  String? sellToPostCode;
  String? sellToCountryRegionCode;
  String? sellToContact;
  String? serviceInvoiceType;
  String? invoiceType;
  String? billToCustomerNo;
  String? billToName;
  String? billToPostCode;
  String? billToCountryRegionCode;
  String? billToContact;
  String? shipToCode;
  String? shipToName;
  String? shipToPostCode;
  String? shipToCountryRegionCode;
  String? shipToContact;
  String? postingDate;
  String? preAssignedNo;
  String? externalDocumentNo;
  String? salespersonCode;
  String? shortcutDimension1Code;
  String? shortcutDimension2Code;
  String? locationCode;
  int? noPrinted;
  String? documentDate;
  String? paymentTermsCode;
  String? dueDate;
  double? paymentDiscountPercent;
  String? shipmentMethodCode;
  String? shipmentDate;
  String? documentExchangeStatus;
  bool? coupledToCRM;
  String? shippingBillNo2;
  String? transactionType;
  String? bOENo;
  String? bookingRefNo;
  String? shippingBillNo;
  String? bLNo;
  String? bLDate;

  InvoiceModel1(
      {this.odataEtag,
        this.no,
        this.salesType,
        this.sellToCustomerNo,
        this.sellToCustomerName,
        this.currencyCode,
        this.amount,
        this.amountIncludingVAT,
        this.iGSTAmount,
        this.cGSTAmount,
        this.sGSTAmount,
        this.amounttocustomer,
        this.sellToPostCode,
        this.sellToCountryRegionCode,
        this.sellToContact,
        this.serviceInvoiceType,
        this.invoiceType,
        this.billToCustomerNo,
        this.billToName,
        this.billToPostCode,
        this.billToCountryRegionCode,
        this.billToContact,
        this.shipToCode,
        this.shipToName,
        this.shipToPostCode,
        this.shipToCountryRegionCode,
        this.shipToContact,
        this.postingDate,
        this.preAssignedNo,
        this.externalDocumentNo,
        this.salespersonCode,
        this.shortcutDimension1Code,
        this.shortcutDimension2Code,
        this.locationCode,
        this.noPrinted,
        this.documentDate,
        this.paymentTermsCode,
        this.dueDate,
        this.paymentDiscountPercent,
        this.shipmentMethodCode,
        this.shipmentDate,
        this.documentExchangeStatus,
        this.coupledToCRM,
        this.shippingBillNo2,
        this.transactionType,
        this.bOENo,
        this.bookingRefNo,
        this.shippingBillNo,
        this.bLNo,
        this.bLDate});



  InvoiceModel1.fromJson(Map<String, dynamic> json) {
    odataEtag = json['@odata.etag'];
    no = json['No'];
    salesType = json['Sales_Type'];
    sellToCustomerNo = json['Sell_to_Customer_No'];
    sellToCustomerName = json['Sell_to_Customer_Name'];
    currencyCode = json['Currency_Code'];
    amount = (json['Amount']as num?)?.toDouble();
    amountIncludingVAT = (json['Amount_Including_VAT']as num?)?.toDouble();
    iGSTAmount = (json['IGST_Amount'] as num?)?.toDouble();
    cGSTAmount = (json['CGST_Amount'] as num?)?.toDouble();
    sGSTAmount = (json['SGST_Amount'] as num?)?.toDouble();
    amounttocustomer=(json['Amount_to_Customer'] as num?)?.toDouble();
    sellToPostCode = json['Sell_to_Post_Code'];
    sellToCountryRegionCode = json['Sell_to_Country_Region_Code'];
    sellToContact = json['Sell_to_Contact'];
    serviceInvoiceType = json['Service_Invoice_Type'];
    invoiceType = json['Invoice_Type'];
    billToCustomerNo = json['Bill_to_Customer_No'];
    billToName = json['Bill_to_Name'];
    billToPostCode = json['Bill_to_Post_Code'];
    billToCountryRegionCode = json['Bill_to_Country_Region_Code'];
    billToContact = json['Bill_to_Contact'];
    shipToCode = json['Ship_to_Code'];
    shipToName = json['Ship_to_Name'];
    shipToPostCode = json['Ship_to_Post_Code'];
    shipToCountryRegionCode = json['Ship_to_Country_Region_Code'];
    shipToContact = json['Ship_to_Contact'];
    postingDate = json['Posting_Date'];
    preAssignedNo = json['Pre_Assigned_No'];
    externalDocumentNo = json['External_Document_No'];
    salespersonCode = json['Salesperson_Code'];
    shortcutDimension1Code = json['Shortcut_Dimension_1_Code'];
    shortcutDimension2Code = json['Shortcut_Dimension_2_Code'];
    locationCode = json['Location_Code'];
    noPrinted = json['No_Printed'];
    documentDate = json['Document_Date'];
    paymentTermsCode = json['Payment_Terms_Code'];
    dueDate = json['Due_Date'];
    paymentDiscountPercent = (json['Payment_Discount_Percent']as num?)?.toDouble();
    shipmentMethodCode = json['Shipment_Method_Code'];
    shipmentDate = json['Shipment_Date'];
    documentExchangeStatus = json['Document_Exchange_Status'];
    coupledToCRM = json['Coupled_to_CRM'];
    shippingBillNo2 = json['Shipping_Bill_No_2'];
    transactionType = json['Transaction_Type'];
    bOENo = json['BOE_No'];
    bookingRefNo = json['Booking_Ref_No'];
    shippingBillNo = json['Shipping_Bill_No'];
    bLNo = json['BL_No'];
    bLDate = json['BL_Date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['@odata.etag'] = this.odataEtag;
    data['No'] = this.no;
    data['Sales_Type'] = this.salesType;
    data['Sell_to_Customer_No'] = this.sellToCustomerNo;
    data['Sell_to_Customer_Name'] = this.sellToCustomerName;
    data['Currency_Code'] = this.currencyCode;
    data['Amount'] = this.amount;
    data['Amount_Including_VAT'] = this.amountIncludingVAT;
    data['IGST_Amount'] = this.iGSTAmount;
    data['CGST_Amount'] = this.cGSTAmount;
    data['SGST_Amount'] = this.sGSTAmount;
    data['Amount_to_Customer'] = this.amounttocustomer;
    data['Sell_to_Post_Code'] = this.sellToPostCode;
    data['Sell_to_Country_Region_Code'] = this.sellToCountryRegionCode;
    data['Sell_to_Contact'] = this.sellToContact;
    data['Service_Invoice_Type'] = this.serviceInvoiceType;
    data['Invoice_Type'] = this.invoiceType;
    data['Bill_to_Customer_No'] = this.billToCustomerNo;
    data['Bill_to_Name'] = this.billToName;
    data['Bill_to_Post_Code'] = this.billToPostCode;
    data['Bill_to_Country_Region_Code'] = this.billToCountryRegionCode;
    data['Bill_to_Contact'] = this.billToContact;
    data['Ship_to_Code'] = this.shipToCode;
    data['Ship_to_Name'] = this.shipToName;
    data['Ship_to_Post_Code'] = this.shipToPostCode;
    data['Ship_to_Country_Region_Code'] = this.shipToCountryRegionCode;
    data['Ship_to_Contact'] = this.shipToContact;
    data['Posting_Date'] = this.postingDate;
    data['Pre_Assigned_No'] = this.preAssignedNo;
    data['External_Document_No'] = this.externalDocumentNo;
    data['Salesperson_Code'] = this.salespersonCode;
    data['Shortcut_Dimension_1_Code'] = this.shortcutDimension1Code;
    data['Shortcut_Dimension_2_Code'] = this.shortcutDimension2Code;
    data['Location_Code'] = this.locationCode;
    data['No_Printed'] = this.noPrinted;
    data['Document_Date'] = this.documentDate;
    data['Payment_Terms_Code'] = this.paymentTermsCode;
    data['Due_Date'] = this.dueDate;
    data['Payment_Discount_Percent'] = this.paymentDiscountPercent;
    data['Shipment_Method_Code'] = this.shipmentMethodCode;
    data['Shipment_Date'] = this.shipmentDate;
    data['Document_Exchange_Status'] = this.documentExchangeStatus;
    data['Coupled_to_CRM'] = this.coupledToCRM;
    data['Shipping_Bill_No_2'] = this.shippingBillNo2;
    data['Transaction_Type'] = this.transactionType;
    data['BOE_No'] = this.bOENo;
    data['Booking_Ref_No'] = this.bookingRefNo;
    data['Shipping_Bill_No'] = this.shippingBillNo;
    data['BL_No'] = this.bLNo;
    data['BL_Date'] = this.bLDate;
    return data;
  }

  /// 👇 Add this method right after toJson()
  double? get gstAmount {
    final igst = iGSTAmount ?? 0.0;
    final cgst = cGSTAmount ?? 0.0;
    final sgst = sGSTAmount ?? 0.0;

    final total = igst + cgst + sgst;

    return (igst == 0.0 && cgst == 0.0 && sgst == 0.0) ? null : total;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is InvoiceModel1 &&
              runtimeType == other.runtimeType &&
              no == other.no &&
              shippingBillNo == other.shippingBillNo &&
              bLNo == other.bLNo;

  @override
  int get hashCode => Object.hash(no, shippingBillNo, bLNo);

}
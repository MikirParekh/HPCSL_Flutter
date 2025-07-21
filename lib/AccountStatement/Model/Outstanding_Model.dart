class OutstandingModel {
  String? odataContext;
  List<OutStandingModel1>? value;

  OutstandingModel({this.odataContext, this.value});

  OutstandingModel.fromJson(Map<String, dynamic> json) {
    odataContext = json['@odata.context'];
    if (json['value'] != null) {
      value = <OutStandingModel1>[];
      json['value'].forEach((v) {
        value?.add(new OutStandingModel1.fromJson(v));
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

class OutStandingModel1 {
  String? odataEtag;
  int? entryNo;
  String? postingDate;
  String? documentDate;
  String? documentType;
  String? documentNo;
  String? customerNo;
  String? customerName;
  String? description;
  String? globalDimension1Code;
  String? globalDimension2Code;
  String? customerPostingGroup;
  String? iCPartnerCode;
  String? salespersonCode;
  String? currencyCode;
  double? originalAmount;
  double? originalAmtLCY;
  double? amount;
  String? certificateNo;
  String? tDSCertificateRcptDate;
  int? tDSCertificateAmount;
  bool ?tDSCertificateReceivable;
  bool? tDSCertificateReceived;
  String? tDSSectionCode;
  bool? certificateReceived;
  double? amountLCY;
  double? debitAmount;
  double? debitAmountLCY;
  double? creditAmount;
  double? creditAmountLCY;
  int? runningBalanceLCY;
  double ?remainingAmount;
  double? remainingAmtLCY;
  double? salesLCY;
  String? balAccountType;
  String? balAccountNo;
  bool? paid;
  bool? postedPaid;
  String? dueDate;
  String? paymentPrediction;
  String? predictionConfidence;
  int? predictionConfidencePercent;
  String? promisedPayDate;
  String? pmtDiscountDate;
  String? pmtDiscToleranceDate;
  double? originalPmtDiscPossible;
  double? remainingPmtDiscPossible;
  int? maxPaymentTolerance;
  String? paymentMethodCode;
  bool? open;
  String? closedAtDate;
  String? disputeStatus;
  String? onHold;
  String? tANNo;
  bool? cashEntry;
  String? userID;
  String? sourceCode;
  String? reasonCode;
  bool? reversed;
  int? reversedByEntryNo;
  int? reversedEntryNo;
  bool? exportedToPaymentFile;
  String? messageToRecipient;
  String? directDebitMandateID;
  int? closedByEntryNo;
  int? dimensionSetID;
  String? externalDocumentNo;
  String? yourReference;
  String? recipientBankAccount;
  String? shortcutDimension3Code;
  String? shortcutDimension4Code;
  String? shortcutDimension5Code;
  String? shortcutDimension6Code;
  String? shortcutDimension7Code;
  String? shortcutDimension8Code;
  String? gSTGroupCode;
  String? hSNSACCode;
  bool? gSTOnAdvancePayment;
  bool? gSTWithoutPaymentOfDuty;
  String? gSTCustomerType;
  String? sellerStateCode;
  String? sellerGSTRegNo;
  String? locationCode;
  String? gSTJurisdictionType;
  String? locationStateCode;
  String? locationGSTRegNo;
  bool? recurringBilling;
  String? dateFilter;

  OutStandingModel1(
      {this.odataEtag,
        this.entryNo,
        this.postingDate,
        this.documentDate,
        this.documentType,
        this.documentNo,
        this.customerNo,
        this.customerName,
        this.description,
        this.globalDimension1Code,
        this.globalDimension2Code,
        this.customerPostingGroup,
        this.iCPartnerCode,
        this.salespersonCode,
        this.currencyCode,
        this.originalAmount,
        this.originalAmtLCY,
        this.amount,
        this.certificateNo,
        this.tDSCertificateRcptDate,
        this.tDSCertificateAmount,
        this.tDSCertificateReceivable,
        this.tDSCertificateReceived,
        this.tDSSectionCode,
        this.certificateReceived,
        this.amountLCY,
        this.debitAmount,
        this.debitAmountLCY,
        this.creditAmount,
        this.creditAmountLCY,
        this.runningBalanceLCY,
        this.remainingAmount,
        this.remainingAmtLCY,
        this.salesLCY,
        this.balAccountType,
        this.balAccountNo,
        this.paid,
        this.postedPaid,
        this.dueDate,
        this.paymentPrediction,
        this.predictionConfidence,
        this.predictionConfidencePercent,
        this.promisedPayDate,
        this.pmtDiscountDate,
        this.pmtDiscToleranceDate,
        this.originalPmtDiscPossible,
        this.remainingPmtDiscPossible,
        this.maxPaymentTolerance,
        this.paymentMethodCode,
        this.open,
        this.closedAtDate,
        this.disputeStatus,
        this.onHold,
        this.tANNo,
        this.cashEntry,
        this.userID,
        this.sourceCode,
        this.reasonCode,
        this.reversed,
        this.reversedByEntryNo,
        this.reversedEntryNo,
        this.exportedToPaymentFile,
        this.messageToRecipient,
        this.directDebitMandateID,
        this.closedByEntryNo,
        this.dimensionSetID,
        this.externalDocumentNo,
        this.yourReference,
        this.recipientBankAccount,
        this.shortcutDimension3Code,
        this.shortcutDimension4Code,
        this.shortcutDimension5Code,
        this.shortcutDimension6Code,
        this.shortcutDimension7Code,
        this.shortcutDimension8Code,
        this.gSTGroupCode,
        this.hSNSACCode,
        this.gSTOnAdvancePayment,
        this.gSTWithoutPaymentOfDuty,
        this.gSTCustomerType,
        this.sellerStateCode,
        this.sellerGSTRegNo,
        this.locationCode,
        this.gSTJurisdictionType,
        this.locationStateCode,
        this.locationGSTRegNo,
        this.recurringBilling,
        this.dateFilter});

  OutStandingModel1.fromJson(Map<String, dynamic> json) {
    odataEtag = json['@odata.etag'];
    entryNo = json['Entry_No'];
    postingDate = json['Posting_Date'];
    documentDate = json['Document_Date'];
    documentType = json['Document_Type'];
    documentNo = json['Document_No'];
    customerNo = json['Customer_No'];
    customerName = json['Customer_Name'];
    description = json['Description'];
    globalDimension1Code = json['Global_Dimension_1_Code'];
    globalDimension2Code = json['Global_Dimension_2_Code'];
    customerPostingGroup = json['Customer_Posting_Group'];
    iCPartnerCode = json['IC_Partner_Code'];
    salespersonCode = json['Salesperson_Code'];
    currencyCode = json['Currency_Code'];
    originalAmount = (json['Original_Amount'] as num?)?.toDouble();
    originalAmtLCY = (json['Original_Amt_LCY'] as num?)?.toDouble();
    amount = (json['Amount'] as num?)?.toDouble();
    certificateNo = json['Certificate_No'];
    tDSCertificateRcptDate = json['TDS_Certificate_Rcpt_Date'];
    tDSCertificateAmount = json['TDS_Certificate_Amount'];
    tDSCertificateReceivable = json['TDS_Certificate_Receivable'];
    tDSCertificateReceived = json['TDS_Certificate_Received'];
    tDSSectionCode = json['TDS_Section_Code'];
    certificateReceived = json['Certificate_Received'];
    amountLCY = (json['Amount_LCY'] as num?)?.toDouble();
    debitAmount = (json['Debit_Amount'] as num?)?.toDouble();
    debitAmountLCY = (json['Debit_Amount_LCY'] as num?)?.toDouble();
    creditAmount = (json['Credit_Amount'] as num?)?.toDouble();
    creditAmountLCY = (json['Credit_Amount_LCY'] as num?)?.toDouble();
    runningBalanceLCY = json['RunningBalanceLCY'];
    remainingAmount = (json['Remaining_Amount'] as num?)?.toDouble();
    remainingAmtLCY = (json['Remaining_Amt_LCY'] as num?)?.toDouble();
    salesLCY = (json['Sales_LCY'] as num?)?.toDouble();
    balAccountType = json['Bal_Account_Type'];
    balAccountNo = json['Bal_Account_No'];
    paid = json['Paid'];
    postedPaid = json['Posted_Paid'];
    dueDate = json['Due_Date'];
    paymentPrediction = json['Payment_Prediction'];
    predictionConfidence = json['Prediction_Confidence'];
    predictionConfidencePercent = json['Prediction_Confidence_Percent'];
    promisedPayDate = json['Promised_Pay_Date'];
    pmtDiscountDate = json['Pmt_Discount_Date'];
    pmtDiscToleranceDate = json['Pmt_Disc_Tolerance_Date'];
    originalPmtDiscPossible = (json['Original_Pmt_Disc_Possible']as num?)?.toDouble();
    remainingPmtDiscPossible = (json['Remaining_Pmt_Disc_Possible']as num?)?.toDouble();
    maxPaymentTolerance = json['Max_Payment_Tolerance'];
    paymentMethodCode = json['Payment_Method_Code'];
    open = json['Open'];
    closedAtDate = json['Closed_at_Date'];
    disputeStatus = json['Dispute_Status'];
    onHold = json['On_Hold'];
    tANNo = json['T_A_N_No'];
    cashEntry = json['Cash_Entry'];
    userID = json['User_ID'];
    sourceCode = json['Source_Code'];
    reasonCode = json['Reason_Code'];
    reversed = json['Reversed'];
    reversedByEntryNo = json['Reversed_by_Entry_No'];
    reversedEntryNo = json['Reversed_Entry_No'];
    exportedToPaymentFile = json['Exported_to_Payment_File'];
    messageToRecipient = json['Message_to_Recipient'];
    directDebitMandateID = json['Direct_Debit_Mandate_ID'];
    closedByEntryNo = json['Closed_by_Entry_No'];
    dimensionSetID = json['Dimension_Set_ID'];
    externalDocumentNo = json['External_Document_No'];
    yourReference = json['Your_Reference'];
    recipientBankAccount = json['RecipientBankAccount'];
    shortcutDimension3Code = json['Shortcut_Dimension_3_Code'];
    shortcutDimension4Code = json['Shortcut_Dimension_4_Code'];
    shortcutDimension5Code = json['Shortcut_Dimension_5_Code'];
    shortcutDimension6Code = json['Shortcut_Dimension_6_Code'];
    shortcutDimension7Code = json['Shortcut_Dimension_7_Code'];
    shortcutDimension8Code = json['Shortcut_Dimension_8_Code'];
    gSTGroupCode = json['GST_Group_Code'];
    hSNSACCode = json['HSN_SAC_Code'];
    gSTOnAdvancePayment = json['GST_on_Advance_Payment'];
    gSTWithoutPaymentOfDuty = json['GST_Without_Payment_of_Duty'];
    gSTCustomerType = json['GST_Customer_Type'];
    sellerStateCode = json['Seller_State_Code'];
    sellerGSTRegNo = json['Seller_GST_Reg_No'];
    locationCode = json['Location_Code'];
    gSTJurisdictionType = json['GST_Jurisdiction_Type'];
    locationStateCode = json['Location_State_Code'];
    locationGSTRegNo = json['Location_GST_Reg_No'];
    recurringBilling = json['Recurring_Billing'];
    dateFilter = json['Date_Filter'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['@odata.etag'] = this.odataEtag;
    data['Entry_No'] = this.entryNo;
    data['Posting_Date'] = this.postingDate;
    data['Document_Date'] = this.documentDate;
    data['Document_Type'] = this.documentType;
    data['Document_No'] = this.documentNo;
    data['Customer_No'] = this.customerNo;
    data['Customer_Name'] = this.customerName;
    data['Description'] = this.description;
    data['Global_Dimension_1_Code'] = this.globalDimension1Code;
    data['Global_Dimension_2_Code'] = this.globalDimension2Code;
    data['Customer_Posting_Group'] = this.customerPostingGroup;
    data['IC_Partner_Code'] = this.iCPartnerCode;
    data['Salesperson_Code'] = this.salespersonCode;
    data['Currency_Code'] = this.currencyCode;
    data['Original_Amount'] = this.originalAmount;
    data['Original_Amt_LCY'] = this.originalAmtLCY;
    data['Amount'] = this.amount;
    data['Certificate_No'] = this.certificateNo;
    data['TDS_Certificate_Rcpt_Date'] = this.tDSCertificateRcptDate;
    data['TDS_Certificate_Amount'] = this.tDSCertificateAmount;
    data['TDS_Certificate_Receivable'] = this.tDSCertificateReceivable;
    data['TDS_Certificate_Received'] = this.tDSCertificateReceived;
    data['TDS_Section_Code'] = this.tDSSectionCode;
    data['Certificate_Received'] = this.certificateReceived;
    data['Amount_LCY'] = this.amountLCY;
    data['Debit_Amount'] = this.debitAmount;
    data['Debit_Amount_LCY'] = this.debitAmountLCY;
    data['Credit_Amount'] = this.creditAmount;
    data['Credit_Amount_LCY'] = this.creditAmountLCY;
    data['RunningBalanceLCY'] = this.runningBalanceLCY;
    data['Remaining_Amount'] = this.remainingAmount;
    data['Remaining_Amt_LCY'] = this.remainingAmtLCY;
    data['Sales_LCY'] = this.salesLCY;
    data['Bal_Account_Type'] = this.balAccountType;
    data['Bal_Account_No'] = this.balAccountNo;
    data['Paid'] = this.paid;
    data['Posted_Paid'] = this.postedPaid;
    data['Due_Date'] = this.dueDate;
    data['Payment_Prediction'] = this.paymentPrediction;
    data['Prediction_Confidence'] = this.predictionConfidence;
    data['Prediction_Confidence_Percent'] = this.predictionConfidencePercent;
    data['Promised_Pay_Date'] = this.promisedPayDate;
    data['Pmt_Discount_Date'] = this.pmtDiscountDate;
    data['Pmt_Disc_Tolerance_Date'] = this.pmtDiscToleranceDate;
    data['Original_Pmt_Disc_Possible'] = this.originalPmtDiscPossible;
    data['Remaining_Pmt_Disc_Possible'] = this.remainingPmtDiscPossible;
    data['Max_Payment_Tolerance'] = this.maxPaymentTolerance;
    data['Payment_Method_Code'] = this.paymentMethodCode;
    data['Open'] = this.open;
    data['Closed_at_Date'] = this.closedAtDate;
    data['Dispute_Status'] = this.disputeStatus;
    data['On_Hold'] = this.onHold;
    data['T_A_N_No'] = this.tANNo;
    data['Cash_Entry'] = this.cashEntry;
    data['User_ID'] = this.userID;
    data['Source_Code'] = this.sourceCode;
    data['Reason_Code'] = this.reasonCode;
    data['Reversed'] = this.reversed;
    data['Reversed_by_Entry_No'] = this.reversedByEntryNo;
    data['Reversed_Entry_No'] = this.reversedEntryNo;
    data['Exported_to_Payment_File'] = this.exportedToPaymentFile;
    data['Message_to_Recipient'] = this.messageToRecipient;
    data['Direct_Debit_Mandate_ID'] = this.directDebitMandateID;
    data['Closed_by_Entry_No'] = this.closedByEntryNo;
    data['Dimension_Set_ID'] = this.dimensionSetID;
    data['External_Document_No'] = this.externalDocumentNo;
    data['Your_Reference'] = this.yourReference;
    data['RecipientBankAccount'] = this.recipientBankAccount;
    data['Shortcut_Dimension_3_Code'] = this.shortcutDimension3Code;
    data['Shortcut_Dimension_4_Code'] = this.shortcutDimension4Code;
    data['Shortcut_Dimension_5_Code'] = this.shortcutDimension5Code;
    data['Shortcut_Dimension_6_Code'] = this.shortcutDimension6Code;
    data['Shortcut_Dimension_7_Code'] = this.shortcutDimension7Code;
    data['Shortcut_Dimension_8_Code'] = this.shortcutDimension8Code;
    data['GST_Group_Code'] = this.gSTGroupCode;
    data['HSN_SAC_Code'] = this.hSNSACCode;
    data['GST_on_Advance_Payment'] = this.gSTOnAdvancePayment;
    data['GST_Without_Payment_of_Duty'] = this.gSTWithoutPaymentOfDuty;
    data['GST_Customer_Type'] = this.gSTCustomerType;
    data['Seller_State_Code'] = this.sellerStateCode;
    data['Seller_GST_Reg_No'] = this.sellerGSTRegNo;
    data['Location_Code'] = this.locationCode;
    data['GST_Jurisdiction_Type'] = this.gSTJurisdictionType;
    data['Location_State_Code'] = this.locationStateCode;
    data['Location_GST_Reg_No'] = this.locationGSTRegNo;
    data['Recurring_Billing'] = this.recurringBilling;
    data['Date_Filter'] = this.dateFilter;
    return data;
  }
}
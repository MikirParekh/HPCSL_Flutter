class StateListModel {
  String? odataContext;
  List<StateModel>? value;

  StateListModel({this.odataContext, this.value});

  StateListModel.fromJson(Map<String, dynamic> json) {
    odataContext = json['@odata.context'];
    if (json['value'] != null) {
      value = <StateModel>[];
      json['value'].forEach((v) {
        value?.add(new StateModel.fromJson(v));
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

class StateModel {
  String? odataEtag;
  String? code;
  String? description;
  String? stateCodeForETDSTCS;
  String? stateCodeGSTRegNo;

  StateModel(
      {this.odataEtag,
        this.code,
        this.description,
        this.stateCodeForETDSTCS,
        this.stateCodeGSTRegNo});

  StateModel.fromJson(Map<String, dynamic> json) {
    odataEtag = json['@odata.etag'];
    code = json['Code'];
    description = json['Description'];
    stateCodeForETDSTCS = json['State_Code_for_eTDS_TCS'];
    stateCodeGSTRegNo = json['State_Code_GST_Reg_No'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['@odata.etag'] = this.odataEtag;
    data['Code'] = this.code;
    data['Description'] = this.description;
    data['State_Code_for_eTDS_TCS'] = this.stateCodeForETDSTCS;
    data['State_Code_GST_Reg_No'] = this.stateCodeGSTRegNo;
    return data;
  }
}
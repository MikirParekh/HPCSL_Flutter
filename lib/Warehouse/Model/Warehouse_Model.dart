class WarehouseModel {
  String? odataContext;
  List<WarehouseModel1>? value;

  WarehouseModel ({this.odataContext, this.value});

  WarehouseModel.fromJson(Map<String, dynamic> json) {
    odataContext = json['@odata.context'];
    if (json['value'] != null) {
      value = <WarehouseModel1>[];
      json['value'].forEach((v) {
        value?.add(new WarehouseModel1.fromJson(v));
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

class WarehouseModel1 {
  String? odataEtag;
  String? code;
  String? name;
  String? name2;
  String? address;
  String? address2;
  String? stateCode;
  String? pORTCode;
  bool? blocked;
  String? terminalType;
  bool? transportBranch;
  bool? port;

  WarehouseModel1(
      {this.odataEtag,
        this.code,
        this.name,
        this.name2,
        this.address,
        this.address2,
        this.stateCode,
        this.pORTCode,
        this.blocked,
        this.terminalType,
        this.transportBranch,
        this.port});

  WarehouseModel1.fromJson(Map<String, dynamic> json) {
    odataEtag = json['@odata.etag'];
    code = json['Code'];
    name = json['Name'];
    name2 = json['Name_2'];
    address = json['Address'];
    address2 = json['Address_2'];
    stateCode = json['State_Code'];
    pORTCode = json['PORT_Code'];
    blocked = json['Blocked'];
    terminalType = json['Terminal_Type'];
    transportBranch = json['Transport_Branch'];
    port = json['Port'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['@odata.etag'] = this.odataEtag;
    data['Code'] = this.code;
    data['Name'] = this.name;
    data['Name_2'] = this.name2;
    data['Address'] = this.address;
    data['Address_2'] = this.address2;
    data['State_Code'] = this.stateCode;
    data['PORT_Code'] = this.pORTCode;
    data['Blocked'] = this.blocked;
    data['Terminal_Type'] = this.terminalType;
    data['Transport_Branch'] = this.transportBranch;
    data['Port'] = this.port;
    return data;
  }
}
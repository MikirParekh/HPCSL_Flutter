class Postcode {
  String? odataContext;
  List<Postcode1>? value;

  Postcode({this.odataContext, this.value});

  Postcode.fromJson(Map<String, dynamic> json) {
    odataContext = json['@odata.context'];
    if (json['value'] != null) {
      value = <Postcode1>[];
      json['value'].forEach((v) {
        value?.add(Postcode1.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['@odata.context'] = this.odataContext;
    if (this.value != null) {
      data['value'] = this.value?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Postcode1 {
  String? odataEtag;
  String? code;
  String? city;
  String? countryRegionCode;
  String? county;
  String? timeZone;

  Postcode1(
      {this.odataEtag,
        this.code,
        this.city,
        this.countryRegionCode,
        this.county,
        this.timeZone});

  Postcode1.fromJson(Map<String, dynamic> json) {
    odataEtag = json['@odata.etag'];
    code = json['Code'];
    city = json['City'];
    countryRegionCode = json['Country_Region_Code'];
    county = json['County'];
    timeZone = json['TimeZone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['@odata.etag'] = this.odataEtag;
    data['Code'] = this.code;
    data['City'] = this.city;
    data['Country_Region_Code'] = this.countryRegionCode;
    data['County'] = this.county;
    data['TimeZone'] = this.timeZone;
    return data;
  }
}

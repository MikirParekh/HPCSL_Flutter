class CommonResponse {
  int statusCode;
  String message;

  CommonResponse({required this.statusCode, required this.message});

  factory CommonResponse.fromJson(Map<String, dynamic> json) {
    return CommonResponse(
      statusCode: json['statusCode'],
      message: json['message'],
    );
  }
}

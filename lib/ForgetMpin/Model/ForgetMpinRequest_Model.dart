class ForgotMPINRequest {
  final String mobileNo;
  final String textLink;

  ForgotMPINRequest({required this.mobileNo, required this.textLink});

  Map<String, dynamic> toJson() {
    return {
      'mobileNo': mobileNo,
      'text_Link': textLink,
    };
  }
}

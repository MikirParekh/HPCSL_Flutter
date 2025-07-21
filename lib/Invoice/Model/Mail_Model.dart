class EmailResponse {
  bool success;
  String message;
  int? value;

  EmailResponse({
    required this.success,
    required this.message,
    this.value,
  });

  factory EmailResponse.fromJson(Map<String, dynamic> json) {
    return EmailResponse(
      success: json['value'] == 1,
      message: json['value'] == 1 ? 'Email sent successfully' : 'Failed to send email',
      value: json['value'],
    );
  }
}
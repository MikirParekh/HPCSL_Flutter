class ForgotMPINResponse {
  final bool success;
  final String message;
  final String? error;

  ForgotMPINResponse({
    required this.success,
    required this.message,
    this.error,
  });

  factory ForgotMPINResponse.fromJson(Map<String, dynamic> json) {
    return ForgotMPINResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      error: json['error'],
    );
  }
}

// models/forgot_user_request.dart
class ForgotUserRequest {
  final String value;
  final UserIdentificationType type;

  ForgotUserRequest({
    required this.value,
    required this.type,
  });

  Map<String, dynamic> toJson() {
    switch (type) {
      case UserIdentificationType.email:
        return {'emailId': value};
      case UserIdentificationType.mobile:
        return {'custMobileNo': value};
    }
  }
}

enum UserIdentificationType {
  email,
  mobile,
}
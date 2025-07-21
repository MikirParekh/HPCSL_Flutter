// signup_api.dart
import 'dart:convert';
import 'package:hpcsl_1/ALL%20URL.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

import '../../TokenRepo.dart';
import '../Model/SignUp_Model.dart';

class SignUpApi {
  // static const baseUrl = "https://api.businesscentral.dynamics.com/v2.0/6957ebc5-df56-486d-b7bb-f99a6a804f93/Production/ODataV4/Company('HPCSL')";
  static const defaultIecCode = "1312017783";

  Future<Map<String, dynamic>> registration(SignUpModel signupModel) async {
    try {
      final wpCustRegistration = "${ApiConstants.baseUrl}/WP_P_CustomerRegistration";

      final panFileName = signupModel.uploadPAN != null
          ? 'Upload/Pan_${DateTime.now().toIso8601String().replaceAll(RegExp(r'[-:.T]'), '')}.jpg'
          : null;

      final gstFileName = signupModel.uploadGST != null
          ? 'Upload/Gst_${DateTime.now().toIso8601String().replaceAll(RegExp(r'[-:.T]'), '')}.jpg'
          : null;

      final requestBody = {
        "Company_Name": signupModel.companyName,
        "Company_Address": signupModel.companyAddress,
        "Post_Code": signupModel.postCode,
        "City": signupModel.city,
        "State": signupModel.state,
        "Mobile_No": signupModel.mobileNo,
        "IEC_Code": defaultIecCode,
        "PAN_No": signupModel.pANNo,
        "GST_No": signupModel.gSTNo,
        "Contact_Person_Name": signupModel.contactPersonName,
        "Email_ID": signupModel.emailID,
        "Upload_PAN": panFileName ?? "",
        "Upload_GST": gstFileName ?? "",
        "Exporter": signupModel.exporter ?? false,
        "Importer": signupModel.importer ?? false,
        "CHA": signupModel.cHA ?? false,
        "Forwarder": signupModel.forwarder ?? false,
        "Consignee": signupModel.consignee ?? false,
        "Consignor": signupModel.consignor ?? false,
        "Shipping_Line": signupModel.shippingLine ?? false,
        "Domestic": signupModel.domestic ?? false,
        "Consolidator": signupModel.consolidator ?? false
      };

      debugPrint('REQUEST BODY: ${jsonEncode(requestBody)}');

      final tokenRepo = TokenRepository();
      final bToken = await tokenRepo.getLoginOdataToken();

      if (bToken.isEmpty) {
        throw ApiException(
            code: 'AUTH_ERROR',
            message: 'Authentication token is empty',
            statusCode: 401
        );
      }

      final headers = {
         'Content-Type': 'application/json',
         'Authorization': 'Bearer ${bToken.trim()}',
      };

      final url = Uri.parse(wpCustRegistration);
      debugPrint(' URL: $url');

      final response = await http.post(
        url,
        headers: headers,
        body: jsonEncode(requestBody),
      ).timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          throw ApiException(
              code: 'TIMEOUT',
              message: 'Request timed out after 30 seconds',
              statusCode: 408
          );
        },
      );

      debugPrint(' RESPONSE STATUS: ${response.statusCode}');
      debugPrint(' RESPONSE BODY: ${response.body}');

      if (response.statusCode != 200 && response.statusCode != 201) {
        Map<String, dynamic> errorBody;
        try {
          errorBody = json.decode(response.body);
        } catch (e) {
          throw ApiException(
              code: 'PARSE_ERROR',
              message: 'Failed to parse error response: ${response.body}',
              statusCode: response.statusCode
          );
        }

        if (errorBody['error'] != null) {
          throw ApiException(
              code: errorBody['error']['code'] ?? 'UNKNOWN_ERROR',
              message: errorBody['error']['message'] ?? 'Unknown error occurred',
              statusCode: response.statusCode
          );
        }

        throw ApiException(
            code: 'HTTP_ERROR',
            message: 'Registration failed with status code: ${response.statusCode}',
            statusCode: response.statusCode
        );
      }

      // Try to parse successful response
      try {
        final responseData = json.decode(response.body);
        return responseData;
      } catch (e) {
        throw ApiException(
            code: 'PARSE_ERROR',
            message: 'Failed to parse success response: ${response.body}',
            statusCode: response.statusCode
        );
      }

    } catch (e) {
      debugPrint(' REGISTRATION ERROR: $e');
      if (e is ApiException) {
        rethrow;
      }
      throw ApiException(
          code: 'UNEXPECTED_ERROR',
          message: 'An unexpected error occurred: ${e.toString()}',
          statusCode: 500
      );
    }
  }
}

// api_exception.dart
class ApiException implements Exception {
  final String code;
  final String message;
  final int statusCode;

  ApiException({
    required this.code,
    required this.message,
    required this.statusCode,
  });

  @override
  String toString() {
    return 'ApiException: [$code] $message (Status: $statusCode)';
  }
}



// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:flutter/foundation.dart';
//
// import '../../TokenRepo.dart';
// import '../Model/SignUp_Model.dart';
//
// class SignUpApi {
//   static const baseUrl = "https://api.businesscentral.dynamics.com/v2.0/efa11a81-6cb7-49b9-bbe4-bedfeef97f2d/SandBox16Dec2024/ODataV4/Company('CRONUS%20IN')";
//   static const defaultIecCode = "1312017783";
//
//   Future<Map<String, dynamic>> registration(SignUpModel signupModel) async {
//     try {
//       final wpCustRegistration = "$baseUrl/WP_P_CustomerRegistration";
//
//       final panFileName = signupModel.uploadPAN != null
//           ? 'Upload/Pan_${DateTime.now().toIso8601String().replaceAll(RegExp(r'[-:.T]'), '')}.jpg'
//           : null;
//
//       final gstFileName = signupModel.uploadGST != null
//           ? 'Upload/Gst_${DateTime.now().toIso8601String().replaceAll(RegExp(r'[-:.T]'), '')}.jpg'
//           : null;
//
//       final requestBody = {
//         "Company_Name": signupModel.companyName,
//         "Company_Address": signupModel.companyAddress,
//         "Post_Code": signupModel.postCode,
//         "City": signupModel.city,
//         "State": signupModel.description,
//         "Mobile_No": signupModel.mobileNo,
//         "IEC_Code": defaultIecCode,
//         "PAN_No": signupModel.pANNo,
//         "GST_No": signupModel.gSTNo,
//         "Contact_Person_Name": signupModel.contactPersonName,
//         "Email_ID": signupModel.emailID,
//         "Upload_PAN": panFileName ?? "",
//         "Upload_GST": gstFileName ?? "",
//         "Exporter": signupModel.exporter ?? false,
//         "Importer": signupModel.importer ?? false,
//         "CHA": signupModel.cHA ?? false,
//         "Forwarder": signupModel.forwarder ?? false,
//         "Consignee": signupModel.consignee ?? false,
//         "Consignor": signupModel.consignor ?? false,
//         "Shipping_Line": signupModel.shippingLine ?? false,
//         "Domestic": signupModel.domestic ?? false,
//         "Consolidator": signupModel.consolidator ?? false
//       };
//
//       final headers = {
//         'Content-Type': 'application/json'
//       };
//
//       final request = http.Request('POST', Uri.parse(wpCustRegistration));
//       request.body = json.encode(requestBody);
//       request.headers.addAll(headers);
//
//       debugPrint('REQUEST URL: ${request.url}');
//       debugPrint('REQUEST BODY: ${request.body}');
//       debugPrint('REQUEST HEADERS: ${request.headers}');
//
//       final streamedResponse = await request.send().timeout(
//         const Duration(seconds: 30),
//         onTimeout: () {
//           throw ApiException(
//               code: 'TIMEOUT',
//               message: 'Request timed out after 30 seconds',
//               statusCode: 408
//           );
//         },
//       );
//
//       final response = await http.Response.fromStream(streamedResponse);
//
//       debugPrint('RESPONSE STATUS: ${response.statusCode}');
//       debugPrint('RESPONSE BODY: ${response.body}');
//
//       if (response.statusCode == 200 || response.statusCode == 201) {
//         try {
//           final responseData = json.decode(response.body);
//           return responseData;
//         } catch (e) {
//           throw ApiException(
//               code: 'PARSE_ERROR',
//               message: 'Failed to parse success response: ${response.body}',
//               statusCode: response.statusCode
//           );
//         }
//       } else {
//         throw ApiException(
//             code: 'HTTP_ERROR',
//             message: response.reasonPhrase ?? 'Registration failed with status code: ${response.statusCode}',
//             statusCode: response.statusCode
//         );
//       }
//     } catch (e) {
//       debugPrint('REGISTRATION ERROR: $e');
//       if (e is ApiException) {
//         rethrow;
//       }
//       throw ApiException(
//           code: 'UNEXPECTED_ERROR',
//           message: 'An unexpected error occurred: ${e.toString()}',
//           statusCode: 500
//       );
//     }
//   }
// }
//
// class ApiException implements Exception {
//   final String code;
//   final String message;
//   final int statusCode;
//
//   ApiException({
//     required this.code,
//     required this.message,
//     required this.statusCode,
//   });
//
//   @override
//   String toString() {
//     return 'ApiException: [$code] $message (Status: $statusCode)';
//   }
// }
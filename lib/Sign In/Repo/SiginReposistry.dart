// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:hpcsl_1/ALL%20URL.dart';
// import 'package:hpcsl_1/SharedPreference.dart';
// import 'package:http/http.dart' as http;
// import '../../TokenRepo.dart';
// import '../../HomeScreen.dart';
// import '../Model/login_model.dart';
//
// class SignInRepo {
//
//   // Token generation function
//   Future<void> tokengenerated(BuildContext context, String userId, String password) async {
//     try {
//       if (userId.trim().isEmpty || password.trim().isEmpty) {
//         throw ValidationException('Please enter User ID and Password');
//       }
//
//       // Call TokenRepository to get Bearer Token
//       final tokenRepo = TokenRepository();
//       final token = await tokenRepo.getLoginOdataToken();
//
//       if (token == "failed") {
//         throw AuthException('Authentication failed');
//       }
//
//       debugPrint('Token generated successfully');
//       _navigateToHome(context);
//     } catch (e) {
//       _showError(context, e.toString());
//     }
//   }
//
//   // Login function
//   Future<LoginModel> login(BuildContext context, String email, String password) async {
//     try {
//       if (email.trim().isEmpty || password.trim().isEmpty) {
//         throw ValidationException('Email and password are required');
//       }
//
//       final tokenRepo = TokenRepository();
//       final bToken = await tokenRepo.getLoginOdataToken();
//
//       if (bToken == "failed") {
//         throw AuthException('Failed to obtain authentication token');
//       }
//
//       final headers = {
//         'Authorization': 'Bearer $bToken',
//         'Prefer': 'odata.include-annotations=\"*\"',
//         'Content-Type': 'application/json',
//       };
//
//       final response = await _makeAuthenticatedRequest(
//         email: email,
//         password: password,
//         headers: headers,
//       );
//
//       final loginModel = await _handleLoginResponse(response);
//       await _saveUserSession(loginModel);
//       _navigateToHome(context);
//
//       return loginModel;
//     } catch (e) {
//       _showError(context, e.toString());
//       rethrow;
//     }
//   }
//
//   Future<http.Response> _makeAuthenticatedRequest({
//     required String email,
//     required String password,
//     required Map<String, String> headers,
//   }) async {
//     // Properly encode the filter values
//     final encodedEmail = Uri.encodeComponent(email);
//     final encodedPassword = Uri.encodeComponent(password);
//
//     final uri = Uri.parse(
//         '${ApiConstants.baseUrl}/WP_P_Cust?' + '\$filter=No eq \'$encodedEmail\' and Password eq \'$encodedPassword\''
//     );
//
//     debugPrint('Making request to: ${uri.toString()}');
//
//     try {
//       final response = await http.get(uri, headers: headers);
//
//       if (response.statusCode != 200) {
//         final errorBody = response.body.isNotEmpty
//             ? jsonDecode(response.body)
//             : null;
//         throw HttpException(
//             'Request failed with status: ${response.statusCode}\n'
//                 'Error: ${errorBody?['error']?['message'] ?? response.reasonPhrase}'
//         );
//       }
//
//       return response;
//     } on http.ClientException catch (e) {
//       throw HttpException('Network error: ${e.message}');
//     }
//   }
//
//   Future<LoginModel> _handleLoginResponse(http.Response response) async {
//     final data = jsonDecode(response.body);
//     final loginModel = LoginModel.fromJson(data);
//
//     if (loginModel.value == null || loginModel.value!.isEmpty) {
//       throw ValidationException('Invalid credentials');
//     }
//
//     return loginModel;
//   }
//
//   Future<void> _saveUserSession(LoginModel loginModel) async {
//     // final prefs = await SharedPreferences.getInstance();
//     // await prefs.setString('userid', loginModel.value?[0].no ?? '');
//     StorageManager.saveData('userid', loginModel.value?[0].no ?? '' );
//     StorageManager.saveData('useremail', loginModel.value?[0].eMail ?? '' );
//
//     // await prefs.setBool('statusLogin', true);
//   }
//
//   void _navigateToHome(BuildContext context) {
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(builder: (context) => HomeScreen()),
//     );
//   }
//
//   void _showError(BuildContext context, String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text(message)),
//     );
//   }
// }
//
// class ValidationException implements Exception {
//   final String message;
//   ValidationException(this.message);
//   @override
//   String toString() => message;
// }
//
// class AuthException implements Exception {
//   final String message;
//   AuthException(this.message);
//   @override
//   String toString() => message;
// }
//
// class HttpException implements Exception {
//   final String message;
//   HttpException(this.message);
//   @override
//   String toString() => message;
// }
//

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hpcsl_1/ALL%20URL.dart';
import 'package:hpcsl_1/SharedPreference.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../../Sign Up/Model/Changedate_Model.dart';
import '../../TokenRepo.dart';
import '../../HomeScreen/UI/HomeScreen.dart';
import '../Model/login_model.dart';

class SignInRepo {

  // Main login function that handles both User ID + Password OR MPIN only
  Future<LoginModel> login(BuildContext context, String userId, String password, String mpin) async {
    try {

      if (mpin.trim().isNotEmpty) {
        return await _loginWithMPIN(context, mpin);
      }

      else if (userId.trim().isNotEmpty && password.trim().isNotEmpty) {
        return await _loginWithUserIdPassword(context, userId, password);
      }
      // Neither condition met
      else {
        throw ValidationException('Please enter either MPIN OR both User ID and Password');
      }
    } catch (e) {
      _showError(context, e.toString());
      rethrow;
    }
  }

  // Login with User ID and Password
  Future<LoginModel> _loginWithUserIdPassword(BuildContext context, String userId, String password) async {
    try {
      final tokenRepo = TokenRepository();
      final bToken = await tokenRepo.getLoginOdataToken();

      if (bToken == "failed") {
        throw AuthException('Failed to obtain authentication token');
      }

      final headers = {
        'Authorization': 'Bearer $bToken',
        'Prefer': 'odata.include-annotations=\"*\"',
        'Content-Type': 'application/json',
      };

      final response = await _makeUserIdPasswordRequest(
        userId: userId,
        password: password,
        headers: headers,
      );

      final loginModel = await _handleLoginResponse(response);
      await _saveUserSession(loginModel);

      // ✅ Add this to update the last login date
      await updateLastLoginDateAfterLogin(loginModel.value?[0].no ?? '', bToken);

      _navigateToHome(context);

      return loginModel;
    } catch (e) {
      throw e;
    }
  }

  // Login with MPIN only
  Future<LoginModel> _loginWithMPIN(BuildContext context, String mpin) async {
    try {
      final tokenRepo = TokenRepository();
      final bToken = await tokenRepo.getLoginOdataToken();

      if (bToken == "failed") {
        throw AuthException('Failed to obtain authentication token');
      }

      final headers = {
        'Authorization': 'Bearer $bToken',
        'Prefer': 'odata.include-annotations=\"*\"',
        'Content-Type': 'application/json',
      };

      final response = await _makeMPINRequest(
        mpin: mpin,
        headers: headers,
      );

      final loginModel = await _handleLoginResponse(response);
      await _saveUserSession(loginModel);

      // ✅ Add this to update the last login date
      await updateLastLoginDateAfterLogin(loginModel.value?[0].no ?? '', bToken);

      _navigateToHome(context);

      return loginModel;
    } catch (e) {
      throw e;
    }
  }

  // Make request for User ID + Password authentication
  Future<http.Response> _makeUserIdPasswordRequest({
    required String userId,
    required String password,
    required Map<String, String> headers,
  }) async {
    // Properly encode the filter values
    final encodedUserId = Uri.encodeComponent(userId);
    final encodedPassword = Uri.encodeComponent(password);

    final uri = Uri.parse(
        '${ApiConstants.baseUrl}/WP_P_Cust?' + '\$filter=No eq \'$encodedUserId\' and Password eq \'$encodedPassword\''
    );

    debugPrint('Making User ID + Password request to: ${uri.toString()}');

    try {
      final response = await http.get(uri, headers: headers);

      if (response.statusCode != 200) {
        final errorBody = response.body.isNotEmpty
            ? jsonDecode(response.body)
            : null;
        throw HttpException(
            'Request failed with status: ${response.statusCode}\n'
                'Error: ${errorBody?['error']?['message'] ?? response.reasonPhrase}'
        );
      }

      return response;
    } on http.ClientException catch (e) {
      throw HttpException('Network error: ${e.message}');
    }
  }

  // Make request for MPIN authentication
  Future<http.Response> _makeMPINRequest({
    required String mpin,
    required Map<String, String> headers,
  }) async {
    // Properly encode the filter value
    final encodedMPIN = Uri.encodeComponent(mpin);

    final uri = Uri.parse(
        '${ApiConstants.baseUrl}/WP_P_Cust?' + '\$filter=MPIN eq \'$encodedMPIN\''
    );

    debugPrint('Making MPIN request to: ${uri.toString()}');

    try {
      final response = await http.get(uri, headers: headers);

      if (response.statusCode != 200) {
        final errorBody = response.body.isNotEmpty
            ? jsonDecode(response.body)
            : null;
        throw HttpException(
            'Request failed with status: ${response.statusCode}\n'
                'Error: ${errorBody?['error']?['message'] ?? response.reasonPhrase}'
        );
      }

      return response;
    } on http.ClientException catch (e) {
      throw HttpException('Network error: ${e.message}');
    }
  }

  Future<LoginModel> _handleLoginResponse(http.Response response) async {
    final data = jsonDecode(response.body);
    final loginModel = LoginModel.fromJson(data);

    if (loginModel.value == null || loginModel.value!.isEmpty) {
      throw ValidationException('Invalid credentials');
    }

    return loginModel;
  }

  Future<void> _saveUserSession(LoginModel loginModel) async {
    StorageManager.saveData('userid', loginModel.value?[0].no ?? '');
    StorageManager.saveData('useremail', loginModel.value?[0].eMail ?? '');
    print('UserOutstanding value to be saved: ${loginModel.value?[0].wSOutstandingScreen ?? ''}');
    StorageManager.saveData('userInvoice', loginModel.value?[0].wSOutstandingScreen ?? '');
    StorageManager.saveData('TitleName', loginModel.value?[0].name ?? '');
    print('Saved Title Name: ${loginModel.value?[0].name ?? ''}');
    print('Saved UserOustanding value: ${loginModel.value?[0].wSOutstandingScreen ?? ''}');
  }



  void _navigateToHome(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );
  }

  Future<void> updateLastLoginDateAfterLogin(String userId, String bToken) async {
    final headers = {
      'Authorization': 'Bearer $bToken',
      'Accept': 'application/json'
    };

    final Uri getUrl = Uri.parse(
        "${ApiConstants.changedatebaseUrl}/WPMP_RegisteredCustomerList?\$filter=Customer_Code eq '$userId'");

    final getResponse = await http.get(getUrl, headers: headers);

    if (getResponse.statusCode == 200) {
      final changedateModel = ChangedateModel.fromJson(json.decode(getResponse.body));

      if (changedateModel.value != null && changedateModel.value!.isNotEmpty) {
        final ChangedateModel1 customer = changedateModel.value!.first;

        final String entryNo = customer.entryNo ?? '';
        final String etag = customer.odataEtag ?? '';

        // Using ISO format for full datetime
        final String lastLoginDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

        final Uri patchUrl = Uri.parse(
            "${ApiConstants.changedatebaseUrl}/WPMP_RegisteredCustomerList(Entry_No='$entryNo')");

        final patchHeaders = {
          'Authorization': 'Bearer $bToken',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'If-Match': etag,
        };

        final patchBody = jsonEncode({
          'Last_Login_Date_Mobile_App': lastLoginDate,
        });

        final patchResponse = await http.patch(
          patchUrl,
          headers: patchHeaders,
          body: patchBody,
        );

        if (patchResponse.statusCode == 200 || patchResponse.statusCode == 204) {

        } else {

        }
      } else {
      }
    } else {

    }
  }




  void _showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}

class ValidationException implements Exception {
  final String message;
  ValidationException(this.message);
  @override
  String toString() => message;
}

class AuthException implements Exception {
  final String message;
  AuthException(this.message);
  @override
  String toString() => message;
}

class HttpException implements Exception {
  final String message;
  HttpException(this.message);
  @override
  String toString() => message;
}
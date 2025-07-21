import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hpcsl_1/ALL%20URL.dart';
import 'package:http/http.dart' as http;
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../TokenRepo.dart';

class OutstandingApi {

  Future<Map<String, dynamic>> fetchCustomerOutstanding(String customerCode) async {
    try {
      final tokenRepo = TokenRepository();
      final bearerToken = await tokenRepo.getLoginOdataToken();

      if (bearerToken == null || bearerToken.isEmpty) {
        throw Exception('Bearer token is missing or invalid');
      }

      final Uri uri = Uri.parse('${ApiConstants.postbaseUrl}/Web_Development_Services_CustomerOutStanding?Company=${ApiConstants.companyName}');

      var request = http.Request('POST', uri);

      request.headers.addAll({
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $bearerToken',
      });

      request.body = json.encode({
        "customerCode": customerCode
      });


      http.StreamedResponse response = await request.send();


      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        debugPrint('Response body: $responseBody');

        final Map<String, dynamic> responseData = jsonDecode(responseBody);

        if (responseData.containsKey('value')) {
          return responseData;
        } else {
          throw Exception('Response data does not contain expected "value" key');
        }
      } else {
        throw Exception('Failed to fetch data: ${response.statusCode} - ${response.reasonPhrase}');
      }
    } catch (e) {
      debugPrint('Error fetching customer outstanding: $e');
      rethrow;
    }
  }

  // Second endpoint for customer outstanding LCY
  Future<Map<String, dynamic>> fetchCustomerOutstandingLCY(String customerCode) async {
    try {
      final tokenRepo = TokenRepository();
      final bearerToken = await tokenRepo.getLoginOdataToken();

      if (bearerToken == null || bearerToken.isEmpty) {
        throw Exception('Bearer token is missing or invalid');
      }

      final Uri uri = Uri.parse('${ApiConstants.postbaseUrl}/Web_Development_Services_CustomerOutStandingLCY?Company=${ApiConstants.companyName}');

      var request = http.Request('POST', uri);

      request.headers.addAll({
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $bearerToken',
      });

      request.body = json.encode({
        "customerCode": customerCode
      });

      debugPrint('Making customer outstanding LCY request to: ${uri.toString()}');
      debugPrint('Request body: ${request.body}');

      http.StreamedResponse response = await request.send();
      debugPrint('Response status code: ${response.statusCode}');

      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        debugPrint('Response body: $responseBody');

        final Map<String, dynamic> responseData = jsonDecode(responseBody);

        if (responseData.containsKey('value')) {
          return responseData;
        } else {
          throw Exception('Response data does not contain expected "value" key');
        }
      } else {
        throw Exception('Failed to fetch LCY data: ${response.statusCode} - ${response.reasonPhrase}');
      }
    } catch (e) {
      debugPrint('Error fetching customer outstanding LCY: $e');
      rethrow;
    }
  }

  // Combined method to fetch both types of data
  Future<Map<String, Map<String, dynamic>>> fetchAllOutstandingData(String customerCode) async {
    try {
      final outstandingData = await fetchCustomerOutstanding(customerCode);
      final outstandingLCYData = await fetchCustomerOutstandingLCY(customerCode);

      return {
        'outstanding': outstandingData,
        'outstandingLCY': outstandingLCYData,
      };
    } catch (e) {
      debugPrint('Error fetching all outstanding data: $e');
      rethrow;
    }
  }



  Future<void> downloadFileforOutStanding(String customercode) async {
    await downloadFile(customercode,
        '${ApiConstants.postbaseUrl}/Web_Development_Services_DownloadCustomerStatementPDF?Company=${ApiConstants.companyName}',
        'pdf');
  }

  Future<void> downloadFileforOutStandingExcel(String customercode) async {
    await downloadFile(customercode,
        '${ApiConstants.postbaseUrl}/Web_Development_Services_DownloadCustomerStatementExcel?Company=${ApiConstants.companyName}',
        'xlsx');
  }

  Future<void> downloadFile(String customercode, String apiUrl, String fileType) async {
    try {
      debugPrint('Getting token...');
      final tokenRepo = TokenRepository();
      final bToken = await tokenRepo.getLoginOdataToken();
      if (bToken == null || bToken.isEmpty) {
        throw Exception('Bearer token is null or empty');
      }

      debugPrint('Bearer Token retrieved successfully');

      final headers = {
        'Authorization': 'Bearer $bToken',
        'Prefer': 'odata.include-annotations="*"',
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };

      final body = json.encode({"customercode": customercode});
      debugPrint('Request Body: $body');

      final response = await http.post(Uri.parse(apiUrl), headers: headers, body: body);
      debugPrint('API Response Status Code: ${response.statusCode}');

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData.containsKey('value')) {
          final fileUrl = responseData['value'];
          debugPrint('File URL retrieved: $fileUrl');
          final filePath = await downloadAndSaveFile(fileUrl, sanitizeFileName(customercode, fileType));
          if (filePath != null) {
            await OpenFile.open(filePath);
          }
        } else {
          throw Exception('No file URL found in response');
        }
      } else {
        throw Exception('Failed to download file: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      debugPrint('Error in downloadFile: $e');
      rethrow;
    }
  }

      Future<String?> downloadAndSaveFile(String fileUrl, String fileName) async {
      try {
        debugPrint('Requesting storage permission...');
        var status = await Permission.storage.request();
        if (!status.isGranted) {
          throw Exception('Storage permission denied');
        }

        debugPrint('Downloading file from: $fileUrl');
        final response = await http.get(Uri.parse(fileUrl));

        if (response.statusCode == 200) {
          final bytes = response.bodyBytes;
          final directory = await getApplicationDocumentsDirectory();

          final downloadsDir = Directory('${directory.path}/downloads');
          if (!await downloadsDir.exists()) {
            await downloadsDir.create(recursive: true);
          }

          final filePath = '${downloadsDir.path}/$fileName';
          debugPrint('Saving file at: $filePath');

          final file = File(filePath);
          await file.writeAsBytes(bytes);
          debugPrint('File saved successfully at: $filePath');

          return filePath;
        } else {
          throw Exception('Failed to download file: ${response.statusCode}');
        }
      } catch (e) {
        debugPrint('Error downloading file: $e');
        rethrow;
      }
    }

  String sanitizeFileName(String invoiceNumber, String fileType) {
    final sanitized = invoiceNumber.replaceAll(RegExp(r'[\/\\:*?"<>|]'), '_');
    return 'invoice_${sanitized}.$fileType';
  }

}

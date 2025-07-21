import 'package:device_info_plus/device_info_plus.dart';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hpcsl_1/ALL%20URL.dart';
import 'package:http/http.dart' as http;
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../SharedPreference.dart';
import '../../TokenRepo.dart';
import '../Model/Invoice_Model.dart';
import '../Model/Mail_Model.dart';

class InvoiceApi {
  Future<Map<String, String>> _getHeaders() async {
    final tokenRepo = TokenRepository();
    final bToken = await tokenRepo.getLoginOdataToken();
    return {
      'Authorization': 'Bearer $bToken',
      'Prefer': 'odata.include-annotations="*"',
    };
  }

  // Future<List<InvoiceModel1>> _fetchInvoiceDataByField(String fieldName, String userId) async {
  //   try {
  //     final headers = await _getHeaders();
  //     final encodedFilter = Uri.encodeComponent("($fieldName eq '$userId')");
  //     final url = "${ApiConstants.baseUrl}/WP_P_SalesInvList?"
  //         "\$filter=$encodedFilter";
  //
  //     final response = await http.get(Uri.parse(url), headers: headers);
  //
  //     if (response.statusCode == 200) {
  //       final data = jsonDecode(response.body);
  //       final List<dynamic> items = data['value'];
  //       return items.map((item) => InvoiceModel1.fromJson(item)).toList();
  //     }
  //     return [];
  //   } catch (e) {
  //     debugPrint('Error in _fetchInvoiceDataByField: $e');
  //     return [];
  //   }
  // }
  //
  // Future<List<InvoiceModel1>> fetchInvoiceDataByCustomerNo() async {
  //   final userId = await StorageManager.readData('userid');
  //   return _fetchInvoiceDataByField('Sell_to_Customer_No', userId);
  // }
  //
  // Future<List<InvoiceModel1>> fetchInvoiceDataByBillToCustomer() async {
  //   final userId = await StorageManager.readData('userid');
  //   return _fetchInvoiceDataByField('Bill_to_Customer_No', userId);
  // }
  //
  // Future<List<InvoiceModel1>> _fetchInvoiceDataBySearch(String field,
  //     String searchText,
  //     String userId,) async {
  //   try {
  //     final headers = await _getHeaders();
  //     final List<InvoiceModel1> results = [];
  //
  //     // Check each customer field separately
  //     final customerFields = ['Sell_to_Customer_No', 'Bill_to_Customer_No'];
  //
  //     for (var customerField in customerFields) {
  //       final encodedFilter = Uri.encodeComponent(
  //           "contains($field,'$searchText') and $customerField eq '$userId'");
  //
  //       final url = '${ApiConstants.baseUrl}/WP_P_SalesInvList?'
  //           '\$filter=$encodedFilter';
  //
  //       debugPrint('API URL: $url');
  //
  //       final response = await http.get(Uri.parse(url), headers: headers);
  //
  //       if (response.statusCode == 200) {
  //         final data = jsonDecode(response.body);
  //         final List<dynamic> items = data['value'];
  //         results.addAll(
  //             items.map((item) => InvoiceModel1.fromJson(item)).toList());
  //       }
  //     }
  //
  //     // Remove duplicates if any
  //     final uniqueResults = results.toSet().toList();
  //     return uniqueResults;
  //   } catch (e) {
  //     debugPrint('Error in _fetchInvoiceDataBySearch: $e');
  //     rethrow;
  //   }
  // }
  //
  // Future<List<InvoiceModel1>> fetchInvoiceByNo(String searchText) async {
  //   final userId = await StorageManager.readData('userid');
  //   return _fetchInvoiceDataBySearch('No', searchText, userId);
  // }
  //
  // Future<List<InvoiceModel1>> fetchInvoiceByShippingBillNo(
  //     String searchText) async {
  //   final userId = await StorageManager.readData('userid');
  //   return _fetchInvoiceDataBySearch('Shipping_Bill_No', searchText, userId);
  // }
  //
  // Future<List<InvoiceModel1>> fetchInvoiceByBLNo(String searchText) async {
  //   final userId = await StorageManager.readData('userid');
  //   return _fetchInvoiceDataBySearch('BL_No', searchText, userId);
  // }
  //
  // Future<List<InvoiceModel1>> fetchPostingDate(String searchText) async {
  //   final userId = await StorageManager.readData('userid');
  //   return _fetchInvoiceDataBySearch('Posting_Date', searchText, userId);
  // }
  //
  //
  //
  // void _handleError(BuildContext context, dynamic error) {
  //   if (context.mounted) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Error: ${error.toString()}')),
  //     );
  //   }
  // }

  Future<List<InvoiceModel1>> _fetchInvoiceDataByField(String fieldName, String userId) async {
    try {

      final headers = await _getHeaders();
      final encodedFilter = Uri.encodeComponent("($fieldName eq '$userId')");
      final url = "${ApiConstants.baseUrl}/WP_P_SalesInvList?"
          "\$filter=$encodedFilter";

      final response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List<dynamic> items = data['value'];
        return items.map((item) => InvoiceModel1.fromJson(item)).toList();
      }
      return [];
    } catch (e) {
      debugPrint('Error in _fetchInvoiceDataByField: $e');
      return [];
    }
  }

  Future<List<InvoiceModel1>> fetchInvoiceDataByCustomerNo() async {
    final userId = await StorageManager.readData('userid');
    return _fetchInvoiceDataByField('Sell_to_Customer_No', userId);
  }

  Future<List<InvoiceModel1>> fetchInvoiceDataByBillToCustomer() async {
    final userId = await StorageManager.readData('userid');
    return _fetchInvoiceDataByField('Bill_to_Customer_No', userId);
  }

  Future<List<InvoiceModel1>> fetchInvoiceDataByBothCustomerFields() async {
    final userId = await StorageManager.readData('userid');
    final bySellTo = await _fetchInvoiceDataByField('Sell_to_Customer_No', userId);
    final byBillTo = await _fetchInvoiceDataByField('Bill_to_Customer_No', userId);

    // ✅ Merge and deduplicate using Set
    return [...bySellTo, ...byBillTo].toSet().toList();
  }

  Future<List<InvoiceModel1>> _fetchInvoiceDataBySearch(
      String field,
      String searchText,
      String userId,
      ) async {
    try {
      final headers = await _getHeaders();
      final List<InvoiceModel1> results = [];

      final customerFields = ['Sell_to_Customer_No', 'Bill_to_Customer_No'];

      for (var customerField in customerFields) {
        final encodedFilter = Uri.encodeComponent(
            "contains($field,'$searchText') and $customerField eq '$userId'");

        final url = '${ApiConstants.baseUrl}/WP_P_SalesInvList?\$filter=$encodedFilter';
        debugPrint('API URL: $url');

        final response = await http.get(Uri.parse(url), headers: headers);

        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          final List<dynamic> items = data['value'];
          results.addAll(items.map((item) => InvoiceModel1.fromJson(item)).toList());
        }
      }

      // ✅ Remove duplicates
      return results.toSet().toList();
    } catch (e) {
      debugPrint('Error in _fetchInvoiceDataBySearch: $e');
      rethrow;
    }
  }

  Future<List<InvoiceModel1>> fetchInvoiceByNo(String searchText) async {
    final userId = await StorageManager.readData('userid');
    return _fetchInvoiceDataBySearch('No', searchText, userId);
  }

  Future<List<InvoiceModel1>> fetchInvoiceByShippingBillNo(
      String searchText) async {
    final userId = await StorageManager.readData('userid');
    return _fetchInvoiceDataBySearch('Shipping_Bill_No', searchText, userId);
  }

  Future<List<InvoiceModel1>> fetchInvoiceByBLNo(String searchText) async {
    final userId = await StorageManager.readData('userid');
    return _fetchInvoiceDataBySearch('BL_No', searchText, userId);
  }



  Future<List<InvoiceModel1>> fetchInvoiceByDateRange(String fromDate, String toDate) async {
    try {
      final userId = await StorageManager.readData('userid');
      final headers = await _getHeaders();

      final encodedFilter = Uri.encodeComponent(
          "Posting_Date ge $fromDate and Posting_Date le $toDate and Sell_to_Customer_No eq '$userId'"
      );

      final url = '${ApiConstants.baseUrl}/WP_P_SalesInvList?\$filter=$encodedFilter';
      debugPrint('API URL: $url');

      final response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List<InvoiceModel1> invoices = (data['value'] as List)
            .map((item) => InvoiceModel1.fromJson(item))
            .toList();

        // Sort by date in ascending order with proper null handling
        invoices.sort((a, b) {
          if (a.postingDate == null && b.postingDate == null) return 0;
          if (a.postingDate == null) return 1;  // Nulls last
          if (b.postingDate == null) return -1; // Non-nulls first

          // Parse to DateTime for accurate comparison
          final dateA = DateTime.parse(a.postingDate!);
          final dateB = DateTime.parse(b.postingDate!);
          return dateA.compareTo(dateB);
        });

        return invoices;
      } else {
        return [];
      }
    } catch (e) {
      debugPrint('Error in fetchInvoiceByDateRange: $e');
      rethrow;
    }
  }


  Future<void> downloadFile(String sINVNo) async {
    try {
      debugPrint('Getting token...');
      final tokenRepo = TokenRepository();
      final bToken = await tokenRepo.getLoginOdataToken();
      if (bToken == null || bToken.isEmpty) {
        throw Exception('Bearer token is null or empty');
      }

      final headers = {
        'Authorization': 'Bearer $bToken',
        'Prefer': 'odata.include-annotations="*"',
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };

      final body = json.encode({"sINVNo": sINVNo});
      final url = Uri.parse(
          '${ApiConstants.postbaseUrl}/Web_Development_Services_SalesInvoiceDownLoad?Company=${ApiConstants.companyName}');

      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData.containsKey('value')) {
          final fileUrl = responseData['value'];

          // Add validation for empty file URL
          if (fileUrl == null || fileUrl.isEmpty) {
            throw Exception('No file present for this invoice');
          }

          final filePath = await downloadAndSaveFile(fileUrl, sanitizeFileName(sINVNo));
          if (filePath != null) {
            await OpenFile.open(filePath);
          }
        } else {
          throw Exception('No file URL found in response');
        }
      } else {
        throw Exception(
            'Failed to download file: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      debugPrint('Error in downloadFile: $e');

      // Convert specific error messages to user-friendly ones
      if (e.toString().contains('No host specified in URL')) {
        throw Exception('No file present for this invoice');
      }
      rethrow;
    }
  }


  Future<String?> downloadAndSaveFile(String fileUrl, String fileName) async {
    try {
      if (fileUrl.isEmpty) {
        throw Exception('File URL is empty - cannot download file');
      }

      // Handle storage permission for Android 10 and below only
      if (Platform.isAndroid) {
        final androidInfo = await DeviceInfoPlugin().androidInfo;
        if (androidInfo.version.sdkInt <= 29) { // Android 10 (API 29) or lower
          debugPrint('Requesting storage permission for legacy Android...');
          final status = await Permission.storage.status;
          if (!status.isGranted) {
            final result = await Permission.storage.request();
            if (!result.isGranted) {
              throw Exception('Storage permission denied');
            }
          }
        } else {
          debugPrint('Skipping storage permission request for Android 11+');
        }
      }

      debugPrint('Downloading file from: $fileUrl');
      final response = await http.get(Uri.parse(fileUrl));

      if (response.statusCode == 200) {
        final bytes = response.bodyBytes;
        final directory = await getApplicationDocumentsDirectory();

        // Create downloads subdirectory
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

  // Future<String?> downloadAndSaveFile(String fileUrl, String fileName) async {
  //   try {
  //     debugPrint('Requesting storage permission...');
  //     var status = await Permission.storage.request();
  //     if (!status.isGranted) {
  //       throw Exception('Storage permission denied');
  //     }
  //
  //     debugPrint('Downloading file from: $fileUrl');
  //     final response = await http.get(Uri.parse(fileUrl));
  //
  //     if (response.statusCode == 200) {
  //       final bytes = response.bodyBytes;
  //       final directory = await getApplicationDocumentsDirectory();
  //
  //       // Create a downloads subdirectory
  //       final downloadsDir = Directory('${directory.path}/downloads');
  //       if (!await downloadsDir.exists()) {
  //         await downloadsDir.create(recursive: true);
  //       }
  //
  //       final filePath = '${downloadsDir.path}/$fileName';
  //       debugPrint('Saving file at: $filePath');
  //
  //       final file = File(filePath);
  //       await file.writeAsBytes(bytes);
  //       debugPrint('File saved successfully at: $filePath');
  //
  //       return filePath; // Return the file path for opening
  //     } else {
  //       throw Exception('Failed to download file: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     debugPrint('Error downloading file: $e');
  //     rethrow;
  //   }
  // }

  // Future<EmailResponse> sendEmail(String invoiceNumber) async {
  //   try {
  //     final useremail = await StorageManager.readData('useremail');
  //
  //     final Uri uri = Uri.parse(
  //         '${ApiConstants.postbaseUrl}/Web_Development_Services_CustomerEmailRegisterOrNot?Company=${ApiConstants.companyName}');
  //     final tokenRepo = TokenRepository();
  //     final bToken = await tokenRepo.getLoginOdataToken();
  //
  //     final response = await http.post(uri,
  //         headers: {
  //           'Content-Type': 'application/json',
  //           'Authorization': 'Bearer $bToken',
  //         },
  //         // body: json.encode({"sINVNo": invoiceNumber}));
  //         body: json.encode({"custEmail":useremail }));
  //
  //     if (response.statusCode == 200) {
  //       final jsonResponse = json.decode(response.body);
  //       return EmailResponse.fromJson(jsonResponse);
  //     } else {
  //       return EmailResponse(
  //           success: false,
  //           message: 'Failed to send email: ${response.reasonPhrase}',
  //           value: 0);
  //     }
  //   } catch (e) {
  //     return EmailResponse(
  //         success: false, message: 'Error sending email: $e', value: 0);
  //   }
  // }

  Future<EmailResponse> sendEmail(String invoiceNumber) async {
    try {
      final useremail = await StorageManager.readData('useremail');
      final tokenRepo = TokenRepository();
      final bToken = await tokenRepo.getLoginOdataToken();

      // First API call to check email registration
      final checkUri = Uri.parse('${ApiConstants.postbaseUrl}/Web_Development_Services_CustomerEmailRegisterOrNot?Company=${ApiConstants.companyName}');
      final checkResponse = await http.post(
        checkUri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $bToken',
        },
        body: json.encode({"custEmail": useremail}),
      );

      if (checkResponse.statusCode == 200) {
        final checkData = json.decode(checkResponse.body);
        if (checkData['value'] == 0) {
          // Second API call to send invoice
          final sendInvoiceUri = Uri.parse(
              '${ApiConstants.postbaseUrl}/Web_Development_Services_SalesInvoiceEmailToCustomer?Company=${ApiConstants.companyName}');
          final invoiceResponse = await http.post(
            sendInvoiceUri,
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $bToken',
            },
            body: json.encode({"sINVNo": invoiceNumber}),
          );

          if (invoiceResponse.statusCode == 200) {
            final invoiceData = json.decode(invoiceResponse.body);
            if (invoiceData['value'] == 0) {
              return EmailResponse(
                success: true,
                message: 'Success',
                value: 0,
              );
            } else {
              return EmailResponse(
                success: false,
                message: 'Failed to send invoice email',
                value: invoiceData['value'],
              );
            }
          } else {
            return EmailResponse(
              success: false,
              message: 'Failed to send invoice: ${invoiceResponse.reasonPhrase}',
              value: invoiceResponse.statusCode,
            );
          }
        } else {
          return EmailResponse(
            success: false,
            message: 'Your email id is not registered please contact HPCSL accounts team.',
            value: 2,
          );
        }
      } else {
        return EmailResponse(
          success: false,
          message: 'Failed to verify email',
          value: checkResponse.statusCode,
        );
      }
    } catch (e) {
      return EmailResponse(
        success: false,
        message: 'Error sending email: $e',
        value: 0,
      );
    }
  }

  String sanitizeFileName(String invoiceNumber) {
    // Replace forward slashes and other potentially problematic characters
    final sanitized = invoiceNumber
        .replaceAll('/', '_')
        .replaceAll('\\', '_')
        .replaceAll(':', '_')
        .replaceAll('*', '_')
        .replaceAll('?', '_')
        .replaceAll('"', '_')
        .replaceAll('<', '_')
        .replaceAll('>', '_')
        .replaceAll('|', '_');

    return 'invoice_${sanitized}.pdf';
  }
}

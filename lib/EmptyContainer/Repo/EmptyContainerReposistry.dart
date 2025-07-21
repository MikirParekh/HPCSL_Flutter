import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:device_info_plus/device_info_plus.dart';
import '../../ALL URL.dart';
import '../../SharedPreference.dart';
import '../../TokenRepo.dart';
import '../Model/EmptyContainer_Model.dart';
import '../UI/EmptyContainer.dart';

class EmptyContainerApi {

  Future<Map<String, String>> _getHeaders() async {
    final tokenRepo = TokenRepository();
    final bToken = await tokenRepo.getLoginOdataToken();
    return {
      'Authorization': 'Bearer $bToken',
      'Prefer': 'odata.include-annotations="*"',
    };
  }

  Future<EmptyContainerModel> fetchEmptyContainerData(BuildContext context) async {
    try {
      final headers = await _getHeaders();
      List<dynamic> allResults = [];

      // Using the exact endpoint structure provided
      final url = "${ApiConstants.baseUrl}/WP_P_LocationTerminal?\$filter=Terminal_Type eq 'Terminal'";

      debugPrint("Request URL: $url");
      final response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['value'] != null) {
          allResults.addAll(data['value']);
          return EmptyContainerModel.fromJson({'value': allResults});
        }
        throw const EmptyContainerException('No data found in response');
      }

      // Parse error message from API response
      final errorData = jsonDecode(response.body);
      if (errorData['error'] != null) {
        throw EmptyContainerException(
            errorData['error']['message'] ?? 'Unknown API error'
        );
      }

      throw EmptyContainerException('API Error: ${response.statusCode}');

    } catch (e) {
      String errorMessage = e is EmptyContainerException
          ? e.message
          : 'Failed to fetch emptycontainer data: ${e.toString()}';

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
          ),
        );
      }
      rethrow;
    }
  }


  Future<void> downloadFile({required String locationCode,}) async {
    try {
      // 1. Get userid from SharedPreferences
      final String? userid = await StorageManager.readData('userid');
      if (userid == null || userid.isEmpty) {
        throw Exception('User ID not found in storage - please login again');
      }

      // 2. Validate location code
      if (locationCode.isEmpty) {
        throw Exception('Location code cannot be empty');
      }

      debugPrint('Starting download for location: $locationCode, user: $userid');

      // 3. Get authentication token
      final tokenRepo = TokenRepository();
      final bToken = await tokenRepo.getLoginOdataToken();
      if (bToken == null || bToken.isEmpty) {
        throw Exception('Bearer token is null or empty - session may have expired');
      }

      final headers = {
        'Authorization': 'Bearer $bToken',
        'Prefer': 'odata.include-annotations="*"',
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };

      final body = json.encode({
        "locationCode": locationCode,  // Dynamic from parameter
        "customerCode": userid        // Dynamic from SharedPreferences
      });

      debugPrint('Request Body: $body');

      final url = Uri.parse('${ApiConstants.postbaseUrl}/Web_Development_Services_InvoiceInventoryDownload?Company=${ApiConstants.companyName}');

      final response = await http.post(url, headers: headers, body: body);
      debugPrint('API Response Status Code: ${response.statusCode}');

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData.containsKey('value')) {
          final fileUrl = responseData['value'];

          // Enhanced empty URL handling
          if (fileUrl == null || fileUrl.toString().trim().isEmpty) {
            debugPrint('Empty file URL received for location: $locationCode');
            throw Exception('No file was found at the specified path');
          }

          debugPrint('File URL retrieved: $fileUrl');

          final filePath = await downloadAndSaveFile(fileUrl.toString(), // Ensure fileUrl is a string
              sanitizeFileName('$locationCode-$userid') // Include userid in filename
          );
          if (filePath != null) {
            await OpenFile.open(filePath);
            debugPrint('File opened successfully at: $filePath');
          } else {
            throw Exception('Failed to save downloaded file');
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

  String sanitizeFileName(String invoiceNumber) {
    // Replace forward slashes and other potentially problematic characters
    final sanitized = invoiceNumber.replaceAll('/', '_')
        .replaceAll('\\', '_')
        .replaceAll(':', '_')
        .replaceAll('*', '_')
        .replaceAll('?', '_')
        .replaceAll('"', '_')
        .replaceAll('<', '_')
        .replaceAll('>', '_')
        .replaceAll('|', '_');

    return 'EmptyContainer_${sanitized}.pdf';
  }
}

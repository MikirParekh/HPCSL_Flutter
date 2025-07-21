// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:hpcsl_1/ALL%20URL.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
// import '../../SharedPreference.dart';
// import '../../TokenRepo.dart';
// import '../Model/Domestic_model.dart';
// import '../UI/Domestic.dart';
//
// class DomesticApi {
//
//
//     Future<Map<String, String>> _getHeaders() async {
//       final tokenRepo = TokenRepository();
//       final bToken = await tokenRepo.getLoginOdataToken();
//       return {
//         'Authorization': 'Bearer $bToken',
//         'Prefer': 'odata.include-annotations="*"',
//       };
//     }
//
//     Future<DomesticModel> fetchDomesticData(BuildContext context, String userId) async {
//       try {
//         print('Fetching domestic data for userId: $userId');
//
//         final headers = await _getHeaders();
//         print('Headers fetched: $headers');
//
//         List<dynamic> allResults = [];
//
//         // Prepare the filter query
//         final filterQuery = "Do_Not_Show eq false";
//         final encodedFilter = Uri.encodeComponent(filterQuery);
//         final url = "${ApiConstants.baseUrl}/WP_P_DomesticTrackingLineList?\$filter=$encodedFilter";
//
//         print('Request URL: $url');
//
//         final response = await http.get(Uri.parse(url), headers: headers);
//
//         print('Response status code: ${response.statusCode}');
//
//         if (response.statusCode == 200) {
//           final data = jsonDecode(response.body);
//           print('Response body decoded successfully.');
//
//           if (data['value'] != null) {
//             print('Original fetched records count: ${data['value'].length}');
//
//             // Filtering results
//             allResults.addAll(data['value'].where((item) =>
//             item['Customer_No'] == userId
//             ));
//
//             print('Filtered records count: ${allResults.length}');
//           } else {
//             print('No "value" field found in response.');
//           }
//         } else {
//           print('Request failed with status: ${response.statusCode}');
//         }
//
//         print('Returning DomesticModel with ${allResults.length} records.');
//         return DomesticModel.fromJson({'value': allResults});
//
//       } catch (e) {
//         print('Error occurred while fetching domestic data: $e');
//         _handleError(context, e);
//         return DomesticModel.fromJson({'value': []});
//       }
//     }
//
//
//
//
//     void _handleError(BuildContext context, dynamic error) {
//
//     }
//
//
//
//     // New method to fetch states with a search term
//   Future<DomesticModel> fetchContainerNoWithSearch(BuildContext context, String searchText) async {
//     final tokenRepo = TokenRepository();
//     final bToken = await tokenRepo.getLoginOdataToken();
//     debugPrint('Bearer Token: $bToken');
//
//     final headers = {
//       'Authorization': 'Bearer $bToken',
//       'Prefer': 'odata.include-annotations="*"',
//     };
//
//     // Updated URL to include the search term using $filter
//     final url =
//         '${ApiConstants.baseUrl}/WP_P_DomesticTrackingLineList?\$filter=contains(Container_Wagon_No,\'$searchText\')';
//
//     debugPrint('URL: $url');
//
//     try {
//       final response = await http.get(Uri.parse(url), headers: headers);
//
//       if (response.statusCode == 200)
//       {
//         final data = jsonDecode(response.body);
//         final DomesticList = DomesticModel.fromJson(data);
//
//         debugPrint('data: $data');
//         if (DomesticList.value != null && DomesticList.value!.isNotEmpty) {
//           return DomesticList; // Return the filtered StateListModel object
//         } else {
//           throw Exception('No Export found matching your search.');
//         }
//       } else {
//         throw Exception('Failed with status code: ${response.statusCode}');
//       }
//     } catch (e) {
//       rethrow; // Re-throw the exception for further handling if needed
//     }
//   }
//   // New method to fetch states with a search term
//   Future<DomesticModel> fetchOrderWithSearch(BuildContext context, String searchText) async {
//     final tokenRepo = TokenRepository();
//     final bToken = await tokenRepo.getLoginOdataToken();
//     debugPrint('Bearer Token: $bToken');
//
//     final headers = {
//       'Authorization': 'Bearer $bToken',
//       'Prefer': 'odata.include-annotations="*"',
//     };
//
//     // Updated URL to include the search term using $filter
//     final url =
//         '${ApiConstants.baseUrl}/WP_P_DomesticTrackingLineList?\$filter=contains(Document_No,\'$searchText\')';
//
//     debugPrint('URL: $url');
//
//     try {
//       final response = await http.get(Uri.parse(url), headers: headers);
//
//       if (response.statusCode == 200)
//       {
//         final data = jsonDecode(response.body);
//         final DomesticList = DomesticModel.fromJson(data);
//
//         debugPrint('data: $data');
//         if (DomesticList.value != null && DomesticList.value!.isNotEmpty) {
//           return DomesticList; // Return the filtered StateListModel object
//         } else {
//           throw Exception('No Export found matching your search.');
//         }
//       } else {
//         throw Exception('Failed with status code: ${response.statusCode}');
//       }
//     } catch (e) {
//       rethrow; // Re-throw the exception for further handling if needed
//     }
//   }
//
//
// }


import 'dart:convert';
import 'package:flutter/cupertino.dart';
import '../../ALL URL.dart';
import '../../SharedPreference.dart';
import '../../TokenRepo.dart';
import 'package:http/http.dart' as http;

import '../Model/Domestic_model.dart';


class DomesticApi {
  Future<Map<String, String>> _getHeaders() async {
    final tokenRepo = TokenRepository();
    final bToken = await tokenRepo.getLoginOdataToken();
    return {
      'Authorization': 'Bearer $bToken',
      'Prefer': 'odata.include-annotations="*"',
    };
  }

  Future<List<DomesticModel1>> _fetchDomesticDataByField(String fieldName, {String? specificValue}) async {
    try {
      final userid = await StorageManager.readData('userid');
      final headers = await _getHeaders();

      // Use specificValue if provided, otherwise use userid
      final valueToFilter = specificValue ?? userid;

      final encodedFilter = Uri.encodeComponent(
          "$fieldName eq '$valueToFilter' and Do_Not_Show eq false");
      final url = "${ApiConstants.baseUrl}/WP_P_DomesticTrackingLineList?"
          "\$filter=$encodedFilter";

      final response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List<dynamic> items = data['value'];
        return items.map((item) => DomesticModel1.fromJson(item)).toList();
      }
      return [];
    } catch (e) {
      debugPrint('Error in _fetchDomesticDataByField: $e');
      return [];
    }
  }

  // Existing method remains the same but will use the updated _fetchDomesticDataByField
  Future<List<DomesticModel1>> fetchDomesticDataImportNo() async {
    return _fetchDomesticDataByField('Customer_No');
  }

  // New method to fetch by specific customer number
  Future<List<DomesticModel1>> fetchDomesticDataByCustomerNo(String customerNo) async {
    return _fetchDomesticDataByField('Customer_No', specificValue: customerNo);
  }

  Future<List<DomesticModel1>> listOfDomesticData({
    String? containerwagonNoSearch,
    String? documentnumber,
    String? customerNo, // Add new optional parameter
  }) async {
    try {
      // If search parameters are provided, use the search endpoints
      if (containerwagonNoSearch != null && containerwagonNoSearch.isNotEmpty) {
        final result = await fetchContainerWagonNo(containerwagonNoSearch);
        return result.value ?? [];
      }

      if (documentnumber != null && documentnumber.isNotEmpty) {
        final result = await fetchDocumentNo(documentnumber);
        return result.value ?? [];
      }

      // If customerNo is provided, use the new method
      if (customerNo != null && customerNo.isNotEmpty) {
        return await fetchDomesticDataByCustomerNo(customerNo);
      }

      // Otherwise, fetch all data as before
      final results = await Future.wait([
        fetchDomesticDataImportNo()
      ]);

      return results.expand((list) => list).toList();
    } catch (e) {
      debugPrint('Error in listOfDomesticData: $e');
      return [];
    }
  }

  // Rest of your existing methods remain the same...
  Future<DomesticModel> fetchContainerWagonNo(String searchText) async {
    return _fetchDomesticDataBySearch('Container_Wagon_No', searchText);
  }

  Future<DomesticModel> fetchDocumentNo(String searchText) async {
    return _fetchDomesticDataBySearch('Document_No', searchText);
  }

  Future<DomesticModel> _fetchDomesticDataBySearch(String field, String searchText) async {
    try {
      final userid = await StorageManager.readData('userid');
      final headers = await _getHeaders();
      final encodedFilter = Uri.encodeComponent(
          "contains($field,'$searchText') and Do_Not_Show eq false and Customer_No eq '$userid'");
      final url = '${ApiConstants.baseUrl}/WP_P_DomesticTrackingLineList?'
          '\$filter=$encodedFilter';

      debugPrint('API URL: $url'); // For debugging

      final response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final importList = DomesticModel.fromJson(data);
        return importList; // Return even if empty
      }
      throw Exception('Failed with status code: ${response.statusCode}');
    } catch (e) {
      debugPrint('Error in _fetchDomesticDataBySearch: $e');
      rethrow;
    }
  }
}


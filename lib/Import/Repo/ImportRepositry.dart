// import 'dart:convert';
// import 'dart:isolate';
// import 'package:flutter/material.dart';
// import 'package:hpcsl_1/ALL%20URL.dart';
// import 'package:hpcsl_1/SharedPreference.dart';
// import 'package:http/http.dart' as http;
// import '../../TokenRepo.dart';
// import '../Model/Import_model.dart';
//
//
// class ImportApi {
//
//
//   Future<Map<String, String>> _getHeaders() async {
//     final tokenRepo = TokenRepository();
//     final bToken = await tokenRepo.getLoginOdataToken();
//     return {
//       'Authorization': 'Bearer $bToken',
//       'Prefer': 'odata.include-annotations="*"',
//     };
//   }
//   //
//   // Future<ImportModel> fetchImportData(BuildContext context, String userId) async {
//   //   try {
//   //     final headers = await _getHeaders();
//   //     List<dynamic> allResults = [];
//   //
//   //     final List<String> fieldsToCheck = [
//   //       "Importer_No",
//   //       "CHA_No",
//   //       "Freight_Forwarder_No",
//   //       "Shipping_Line_No"
//   //     ];
//   //
//   //     for (String field in fieldsToCheck) {
//   //       final filterQuery = "Do_Not_Show eq false and $field eq '$userId'";
//   //       final encodedFilter = Uri.encodeComponent(filterQuery);
//   //
//   //       final url = "${ApiConstants.baseUrl}/WP_P_ImportTrackingLineList?\$filter=$encodedFilter";
//   //       print("Fetching for $field: $url");
//   //
//   //       final response = await http.get(Uri.parse(url), headers: headers);
//   //
//   //       if (response.statusCode == 200) {
//   //         final data = jsonDecode(response.body);
//   //         if (data['value'] != null) {
//   //           allResults.addAll(data['value']);
//   //         }
//   //       } else {
//   //         print("Error for $field: ${response.statusCode}");
//   //       }
//   //     }
//   //
//   //     return ImportModel.fromJson({'value': allResults});
//   //   } catch (e) {
//   //     print("Exception: $e");
//   //     return ImportModel.fromJson({'value': []});
//   //   }
//   // }
//
//   // Future<List<Value>> fetchImportDataImportNo() async {
//   //   var userid = await StorageManager.readData('userid');
//   //   return await Isolate.run(() async {
//   //     try {
//   //       final url = "${ApiConstants.baseUrl}/WP_P_ImportTrackingLineList?\$filter=Importer_No eq '$userid' and Do_Not_Show eq false";
//   //       final response = await http.get(Uri.parse(url)); // Add error checking as needed
//   //
//   //       if (response.statusCode == 200) {
//   //         // return ImportModel.fromJson(json.decode(response.body));
//   //         // var res = ImportModel.fromJson(jsonDecode(response.body));
//   //         var res = Value.fromJson(jsonDecode(response.body));
//   //         return res; // post man ma open kr ne
//   //       } else {
//   //         return [];
//   //       }
//   //     } catch (e) {
//   //       return [];
//   //     }
//   //   });
//   // }
//
//   Future<List<Value>> fetchImportDataImportNo() async {
//     var userid = await StorageManager.readData('userid');
//     return await Isolate.run(() async {
//       try {
//         final url = "${ApiConstants.baseUrl}/WP_P_ImportTrackingLineList?\$filter=Importer_No eq '$userid' and Do_Not_Show eq false";
//         final response = await http.get(Uri.parse(url));
//
//         if (response.statusCode == 200) {
//           final data = jsonDecode(response.body);
//           final List<dynamic> items = data['value'];
//           return items.map((item) => Value.fromJson(item)).toList();
//         } else {
//           return [];
//         }
//       } catch (e) {
//         return [];
//       }
//     });
//   }
//
//   // badi mathod ma aava changes kri deok, me aavu 10 min ma ok
//
//
//
//   // Future<List<Value>> fetchImportDataShippingLineNo() async {
//   //   var userid = await StorageManager.readData('userid');
//   //   return await Isolate.run(() async {
//   //     try {
//   //       final url = "${ApiConstants.baseUrl}/WP_P_ImportTrackingLineList?\$filter=Shipping_Line_No eq '$userid' and Do_Not_Show eq false";
//   //       final response = await http.get(Uri.parse(url)); // Add error checking as needed
//   //
//   //       if (response.statusCode == 200) {
//   //         return data=jsonDecode(response.body);
//   //
//   //       } else {
//   //         return null;
//   //       }
//   //     } catch (e) {
//   //       return null;
//   //     }
//   //   });
//   // }
//
//
//   Future<List<Value>> fetchImportDataShippingLineNo() async {
//     var userid = await StorageManager.readData('userid');
//     return await Isolate.run(() async {
//       try {
//         final url = "${ApiConstants.baseUrl}/WP_P_ImportTrackingLineList?\$filter=Shipping_Line_No eq '$userid' and Do_Not_Show eq false";
//         final response = await http.get(Uri.parse(url));
//
//         if (response.statusCode == 200) {
//           final data = jsonDecode(response.body);
//           final List<dynamic> items = data['value'];
//           return items.map((item) => Value.fromJson(item)).toList();
//         } else {
//           return [];
//         }
//       } catch (e) {
//         return [];
//       }
//     });
//   }
//
//
//   // Future<ImportModel?> fetchImportDataFreightForwarderNO() async {
//   //   var userid = await StorageManager.readData('userid');
//   //   return await Isolate.run(() async {
//   //     try {
//   //       final url = "${ApiConstants.baseUrl}/WP_P_ImportTrackingLineList?\$filter=Freight_Forwarder_No eq '$userid' and Do_Not_Show eq false";
//   //       final response = await http.get(Uri.parse(url)); // Add error checking as needed
//   //
//   //       if (response.statusCode == 200) {
//   //         return ImportModel.fromJson(json.decode(response.body));
//   //       } else {
//   //         return null;
//   //       }
//   //     } catch (e) {
//   //       return null;
//   //     }
//   //   });
//   // }
//
//   Future<List<Value>> fetchImportDataFreightForwarderNO() async {
//     var userid = await StorageManager.readData('userid');
//     return await Isolate.run(() async {
//       try {
//         final url = "${ApiConstants.baseUrl}/WP_P_ImportTrackingLineList?\$filter=Freight_Forwarder_No eq '$userid' and Do_Not_Show eq false";
//         final response = await http.get(Uri.parse(url));
//
//         if (response.statusCode == 200) {
//           final data = jsonDecode(response.body);
//           final List<dynamic> items = data['value'];
//           return items.map((item) => Value.fromJson(item)).toList();
//         } else {
//           return [];
//         }
//       } catch (e) {
//         return [];
//       }
//     });
//   }
//
//   // Future<ImportModel?> fetchImportDataCHANO() async {
//   //   var userid = await StorageManager.readData('userid');
//   //   return await Isolate.run(() async {
//   //     try {
//   //       final url = "${ApiConstants.baseUrl}/WP_P_ImportTrackingLineList?\$filter=CHA_No eq '$userid' and Do_Not_Show eq false";
//   //       final response = await http.get(Uri.parse(url)); // Add error checking as needed
//   //
//   //       if (response.statusCode == 200) {
//   //         return ImportModel.fromJson(json.decode(response.body));
//   //       } else {
//   //         return null;
//   //       }
//   //     } catch (e) {
//   //       return null;
//   //     }
//   //   });
//   // }
//
//   Future<List<Value>> fetchImportDataCHANO() async {
//     var userid = await StorageManager.readData('userid');
//     return await Isolate.run(() async {
//       try {
//         final url = "${ApiConstants.baseUrl}/WP_P_ImportTrackingLineList?\$filter=CHA_No eq '$userid' and Do_Not_Show eq false";
//         final response = await http.get(Uri.parse(url));
//
//         if (response.statusCode == 200) {
//           final data = jsonDecode(response.body);
//           final List<dynamic> items = data['value'];
//           return items.map((item) => Value.fromJson(item)).toList();
//         } else {
//           return [];
//         }
//       } catch (e) {
//         return [];
//       }
//     });
//   }
//
//   Future<List<Value>>? listOfImportData() async{
//     try{
//       List<Value>? list1=await fetchImportDataImportNo();
//       List<Value>? list2=await fetchImportDataCHANO();
//       List<Value>? list3=await fetchImportDataFreightForwarderNO();
//       List<Value>? list4=await fetchImportDataShippingLineNo();
//
//       List<Value>? finalList=[];
//
//       if(list1 != null && list2 != null && list3 != null && list4 != null){
//         finalList = [...list1, ...list2, ...list3, ...list4];
//       }else{
//         finalList = [...list1, ...list2, ...list3, ...list4] ?? [];
//       }
//
//       return finalList;
//     } catch(e){
//       debugPrint('catch error ----->$e');
//       return [];
//     }
//   }
//
//   Future<ImportModel> fetchContainerNo(BuildContext context, String searchText) async {
//     final tokenRepo = TokenRepository();
//     final bToken = await tokenRepo.getLoginOdataToken();
//     debugPrint('Bearer Token: $bToken');
//
//     final headers = {
//       'Authorization': 'Bearer $bToken',
//       'Prefer': 'odata.include-annotations="*"',
//     };
//
//
//     var url = '${ApiConstants.baseUrl}/WP_P_ImportTrackingLineList?\$filter=contains(Container_No,\'$searchText\')';
//
//     debugPrint('URL: $url');
//
//     try {
//       final response = await http.get(Uri.parse(url), headers: headers);
//
//       if (response.statusCode == 200)
//       {
//         final data = jsonDecode(response.body);
//         final ImportList = ImportModel.fromJson(data);
//
//         debugPrint('data: $data');
//         if (ImportList.value != null && ImportList.value!.isNotEmpty) {
//           return ImportList; // Return the filtered StateListModel object
//         } else {
//           throw Exception('No Export found matching your search.');
//         }
//       } else {
//         throw Exception('Failed with status code: ${response.statusCode}');
//       }
//     } catch (e) {
//       rethrow;
//     }
//   }
//
//
//   Future<ImportModel> fetchBLNo(BuildContext context, String searchText) async {
//     final tokenRepo = TokenRepository();
//     final bToken = await tokenRepo.getLoginOdataToken();
//     debugPrint('Bearer Token: $bToken');
//
//     final headers = {
//       'Authorization': 'Bearer $bToken',
//       'Prefer': 'odata.include-annotations="*"',
//     };
//
//     final url =
//         '${ApiConstants.baseUrl}/WP_P_ImportTrackingLineList?\$filter=contains(B_L_No,\'$searchText\')';
//
//     debugPrint('URL: $url');
//
//     try {
//       final response = await http.get(Uri.parse(url), headers: headers);
//
//       if (response.statusCode == 200)
//       {
//         final data = jsonDecode(response.body);
//         final ImportList = ImportModel.fromJson(data);
//
//         debugPrint('data: $data');
//         if (ImportList.value != null && ImportList.value!.isNotEmpty) {
//           return ImportList;
//         } else {
//           throw Exception('No Export found matching your search.');
//         }
//       } else {
//         throw Exception('Failed with status code: ${response.statusCode}');
//       }
//     } catch (e) {
//       rethrow;
//     }
//   }
//
// }
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:hpcsl_1/ALL%20URL.dart';
// import 'package:hpcsl_1/SharedPreference.dart';
// import 'package:http/http.dart' as http;
// import '../../TokenRepo.dart';
// import '../Model/Import_model.dart';
//
// class ImportApi {
//   List<Value>? _cachedUserData; // Stores fetched data for the current user
//   String? _lastUserId; // Tracks the last fetched userId
//
//   // ======================== Core Methods ========================
//
//   /// Fetches headers with auth token
//   Future<Map<String, String>> _getHeaders() async {
//     final tokenRepo = TokenRepository();
//     final bToken = await tokenRepo.getLoginOdataToken();
//     return {
//       'Authorization': 'Bearer $bToken',
//       'Prefer': 'odata.include-annotations="*"',
//     };
//   }
//
//   Future<Map<String, bool>> getUserRoles(String userId) async {
//     final fields = [
//       "Importer_No",
//       "CHA_No",
//       "Freight_Forwarder_No",
//       "Shipping_Line_No"
//     ];
//
//     final results = await Future.wait(fields.map((field) => _checkUserInField(field, userId)));
//
//     return {
//       'isImporter': results[0],
//       'isCHA': results[1],
//       'isFreightForwarder': results[2],
//       'isShippingLine': results[3],
//     };
//   }
//
//   Future<bool> _checkUserInField(String field, String userId) async {
//     try {
//       final url = "${ApiConstants.baseUrl}/WP_P_ImportTrackingLineList?"
//           "\$top=1&\$filter=${Uri.encodeComponent("$field eq '$userId'")}";
//
//       final response = await http.get(
//         Uri.parse(url),
//         headers: await _getHeaders(),
//       ).timeout(const Duration(seconds: 10));
//
//       return response.statusCode == 200 &&
//           jsonDecode(response.body)['value'].isNotEmpty;
//     } catch (e) {
//       debugPrint('Error checking $field: $e');
//       return false;
//     }
//   }
//   /// Fetches all import data for a user (cached after first call)
//   Future<List<Value>> getUserData(String userId) async {
//     if (_cachedUserData != null && _lastUserId == userId) {
//       return _cachedUserData!; // Return cached data if available
//     }
//
//     _cachedUserData = await fetchFilteredImportDataParallel(userId);
//     _lastUserId = userId;
//     return _cachedUserData!;
//   }
//
//   // ======================== Data Fetching ========================
//
//   /// Fetches data where userId appears in any of the 4 fields (parallel requests)
//   Future<List<Value>> fetchFilteredImportDataParallel(String userId) async {
//     final List<String> fieldsToCheck = [
//       "Importer_No",
//       "CHA_No",
//       "Freight_Forwarder_No",
//       "Shipping_Line_No"
//     ];
//
//     final List<Future<List<Value>>> futures = fieldsToCheck.map((field) async {
//       try {
//         final filter = "$field eq '$userId' and Do_Not_Show eq false";
//         final encodedFilter = Uri.encodeComponent(filter);
//         final url = "${ApiConstants.baseUrl}/WP_P_ImportTrackingLineList?\$filter=$encodedFilter";
//
//         final response = await http.get(
//           Uri.parse(url),
//           headers: await _getHeaders(),
//         );
//
//         if (response.statusCode == 200) {
//           final data = jsonDecode(response.body);
//           return (data['value'] as List).map((item) => Value.fromJson(item)).toList();
//         } else {
//           debugPrint("Error fetching $field: ${response.statusCode}");
//           return <Value>[];
//         }
//       } catch (e) {
//         debugPrint("Exception in $field fetch: $e");
//         return <Value>[];
//       }
//     }).toList();
//
//     final results = await Future.wait(futures);
//     return results.expand((list) => list).toList(); // Combine all lists
//   }
//
//   // ======================== Search Methods ========================
//
//   /// Searches by ContainerNo within cached user data
//   Future<List<Value>> fetchContainerNo(String userId, String searchText) async {
//     try {
//       final userData = await getUserData(userId);
//       return userData.where((item) =>
//       item.containerNo?.toLowerCase().contains(searchText.toLowerCase()) ?? false
//       ).toList();
//     } catch (e) {
//       debugPrint('Local container search failed: $e');
//       return [];
//     }
//   }
//
//   /// Searches by BLNo within cached user data
//   Future<List<Value>> fetchBLNo(String userId, String searchText) async {
//     try {
//       final userData = await getUserData(userId);
//       return userData.where((item) =>
//       item.bLNo?.toLowerCase().contains(searchText.toLowerCase()) ?? false
//       ).toList();
//     } catch (e) {
//       debugPrint('Local BL search failed: $e');
//       return [];
//     }
//   }
//
//   // ======================== Smart Search Fallback ========================
//
//   /// Hybrid search: tries local first, falls back to server
//   Future<List<Value>> fetchContainerNoSmart(String userId, String searchText) async {
//     // Try local search first
//     final localResults = await fetchContainerNo(userId, searchText);
//     if (localResults.isNotEmpty) return localResults;
//
//     // Fallback to server API
//     try {
//       final url = '${ApiConstants.baseUrl}/WP_P_ImportTrackingLineList?\$filter='
//           '(Importer_No eq \'$userId\' or '
//           'CHA_No eq \'$userId\' or '
//           'Freight_Forwarder_No eq \'$userId\' or '
//           'Shipping_Line_No eq \'$userId\') and '
//           'Do_Not_Show eq false and '
//           'contains(Container_No,\'$searchText\')';
//       final response = await http.get(
//         Uri.parse(url),
//         headers: await _getHeaders(),
//       );
//
//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         return (data['value'] as List).map((item) => Value.fromJson(item)).toList();
//       }
//       return [];
//     } catch (e) {
//       debugPrint('Server container search failed: $e');
//       return [];
//     }
//   }
//
//   /// Hybrid search for BLNo
//   Future<List<Value>> fetchBLNoSmart(String userId, String searchText) async {
//     // Try local search first
//     final localResults = await fetchBLNo(userId, searchText);
//     if (localResults.isNotEmpty) return localResults;
//
//     // Fallback to server API
//     try {
//       final url = '${ApiConstants.baseUrl}/WP_P_ImportTrackingLineList?\$filter='
//           '(Importer_No eq \'$userId\' or '
//           'CHA_No eq \'$userId\' or '
//           'Freight_Forwarder_No eq \'$userId\' or '
//           'Shipping_Line_No eq \'$userId\') and '
//           'Do_Not_Show eq false and '
//           'contains(B_L_No,\'$searchText\')';
//
//       final response = await http.get(
//         Uri.parse(url),
//         headers: await _getHeaders(),
//       );
//
//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         return (data['value'] as List).map((item) => Value.fromJson(item)).toList();
//       }
//       return [];
//     } catch (e) {
//       debugPrint('Server BL search failed: $e');
//       return [];
//     }
//   }
//
//   // ======================== Helper Methods ========================
//
//   /// Clears cached data (call when user logs out or data needs refresh)
//   void clearCache() {
//     _cachedUserData = null;
//     _lastUserId = null;
//   }
// }
// import 'dart:convert';
// import 'package:flutter/cupertino.dart';
// import '../../ALL URL.dart';
// import '../../SharedPreference.dart';
// import '../../TokenRepo.dart';
// import 'package:http/http.dart' as http;
// import '../Model/Import_model.dart';
//
// class ImportApi {
//   Future<Map<String, String>> _getHeaders() async {
//     final tokenRepo = TokenRepository();
//     final bToken = await tokenRepo.getLoginOdataToken();
//     return {
//       'Authorization': 'Bearer $bToken',
//       'Prefer': 'odata.include-annotations="*"',
//     };
//   }
//
//   Future<List<Value>> _fetchImportDataByField(String fieldName) async {
//     try {
//       final userid = await StorageManager.readData('userid');
//       final headers = await _getHeaders();
//       final url = "${ApiConstants.baseUrl}/WP_P_ImportTrackingLineList?"
//           "\$filter=$fieldName eq '$userid' and Do_Not_Show eq false";
//
//       final response = await http.get(Uri.parse(url), headers: headers);
//
//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         final List<dynamic> items = data['value'];
//         return items.map((item) => Value.fromJson(item)).toList();
//       }
//       return [];
//     } catch (e) {
//       debugPrint('Error in _fetchImportDataByField: $e');
//       return [];
//     }
//   }
//
//   Future<List<Value>> fetchImportDataImportNo() async {
//     return _fetchImportDataByField('Importer_No');
//   }
//
//   Future<List<Value>> fetchImportDataShippingLineNo() async {
//     return _fetchImportDataByField('Shipping_Line_No');
//   }
//
//   Future<List<Value>> fetchImportDataFreightForwarderNO() async {
//     return _fetchImportDataByField('Freight_Forwarder_No');
//   }
//
//   Future<List<Value>> fetchImportDataCHANO() async {
//     return _fetchImportDataByField('CHA_No');
//   }
//
//   Future<List<Value>> listOfImportData({String? containerNoSearch, String? blNoSearch,}) async {
//     try {
//       // If search parameters are provided, use the search endpoints
//       if (containerNoSearch != null && containerNoSearch.isNotEmpty) {
//         final result = await fetchContainerNo(containerNoSearch);
//         return result.value ?? [];
//       }
//
//       if (blNoSearch != null && blNoSearch.isNotEmpty) {
//         final result = await fetchBLNo(blNoSearch);
//         return result.value ?? [];
//       }
//
//       // Otherwise, fetch all data as before
//       final results = await Future.wait([
//         fetchImportDataImportNo(),
//         fetchImportDataCHANO(),
//         fetchImportDataFreightForwarderNO(),
//         fetchImportDataShippingLineNo(),
//       ]);
//
//       return results.expand((list) => list).toList();
//     } catch (e) {
//       debugPrint('Error in listOfImportData: $e');
//       return [];
//     }
//   }
//
//   Future<ImportModel> fetchContainerNo(String searchText) async {
//     return _fetchImportDataBySearch('Container_No', searchText);
//   }
//
//   Future<ImportModel> fetchBLNo(String searchText) async {
//     return _fetchImportDataBySearch('B_L_No', searchText);
//   }
//
//   Future<ImportModel> _fetchImportDataBySearch(String field, String searchText) async {
//
//     try {
//       final userid = await StorageManager.readData('userid');
//       final headers = await _getHeaders();
//       final url = '${ApiConstants.baseUrl}/WP_P_ImportTrackingLineList?'
//           '\$filter=contains($field,\'$searchText\')';
//
//       final response = await http.get(Uri.parse(url), headers: headers);
//
//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         final importList = ImportModel.fromJson(data);
//
//         if (importList.value?.isNotEmpty ?? false) {
//           return importList;
//         }
//         throw Exception('No Import found matching your search.');
//       }
//       throw Exception('Failed with status code: ${response.statusCode}');
//     } catch (e) {
//       debugPrint('Error in _fetchImportDataBySearch: $e');
//       rethrow;
//     }
//   }
// }

// Future<List<Value>> _fetchImportDataBySearch(String field, String searchText,String containerNo,String blNo) async {
//   final List<Value> importLineList = [];
//   final customerNo = await StorageManager.readData('userid');
//   final headers = await _getHeaders();
//
//   final String filterQuery = "?'\$filter=Do_Not_Show eq false";
//
//
//   List<String> filters = [
//     "CHA_No",
//     "Shipping_Line_No",
//     "Importer_No",
//     "Freight_Forwarder_No",
//     "Importer_No_2"
//   ];
//
//   for (String field in filters) {
//     try {
//       if (customerNo.isNotEmpty) {
//         final query = "${ApiConstants
//             .baseUrl}/WP_P_ImportTrackingLineList$filterQuery and $field eq '$customerNo'${_buildExtraFilters(
//             containerNo, blNo)}";
//
//         final response = await http.get(
//             Uri.parse(query),
//             headers: headers
//         );
//
//         if (response.statusCode == 200) {
//           final res = jsonDecode(response.body);
//           final decoded = res["value"];
//           final model = decoded.map((e) => Value.fromJson(e)).toList();
//           if (model.isNotEmpty) {
//             importLineList.add(model);
//           }
//         } else {
//           print("Error: ${response.statusCode} - ${response.body}");
//         }
//       }
//     }catch(e){
//       var d = e;
//     }
//   }
//
//   return importLineList;
// }
//
// String _buildExtraFilters(String containerNo, String blNo) {
//   String filters = '';
//   if (containerNo.isNotEmpty) {
//     filters += " and Container_No eq '$containerNo'";
//   }
//   if (blNo.isNotEmpty) {
//     filters += " and B_L_No eq '$blNo'";
//   }
//   return filters;
// }
// }

// import 'dart:convert';
// import 'package:flutter/cupertino.dart';
// import '../../ALL URL.dart';
// import '../../SharedPreference.dart';
// import '../../TokenRepo.dart';
// import 'package:http/http.dart' as http;
// import '../Model/Import_model.dart';
//
// class ImportApi {
//   Future<Map<String, String>> _getHeaders() async {
//     final tokenRepo = TokenRepository();
//     final bToken = await tokenRepo.getLoginOdataToken();
//     return {
//       'Authorization': 'Bearer $bToken',
//       'Prefer': 'odata.include-annotations="*"',
//     };
//   }
//
//   Future<List<Value>> _fetchImportDataByField(String fieldName) async {
//     try {
//       final userid = await StorageManager.readData('userid');
//       final headers = await _getHeaders();
//       final encodedFilter = Uri.encodeComponent(
//           "$fieldName eq '$userid' and Do_Not_Show eq false");
//       final url = "${ApiConstants.baseUrl}/WP_P_ImportTrackingLineList?"
//           "\$filter=$encodedFilter";
//
//       final response = await http.get(Uri.parse(url), headers: headers);
//
//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         final List<dynamic> items = data['value'];
//         return items.map((item) => Value.fromJson(item)).toList();
//       }
//       return [];
//     } catch (e) {
//       debugPrint('Error in _fetchImportDataByField: $e');
//       return [];
//     }
//   }
//
//   Future<List<Value>> fetchImportDataImportNo() async {
//     return _fetchImportDataByField('Importer_No');
//   }
//
//   Future<List<Value>> fetchImportDataShippingLineNo() async {
//     return _fetchImportDataByField('Shipping_Line_No');
//   }
//
//   Future<List<Value>> fetchImportDataFreightForwarderNO() async {
//     return _fetchImportDataByField('Freight_Forwarder_No');
//   }
//
//   Future<List<Value>> fetchImportDataCHANO() async {
//     return _fetchImportDataByField('CHA_No');
//   }
//
//
//   Future<List<Value>> fetchContainerNo(String searchText) async {
//     return _fetchImportDataBySearch('Container_No', searchText,searchText,"");
//   }
//
//   Future<List<Value>> fetchBLNo(String searchText) async {
//     return _fetchImportDataBySearch('B_L_No', searchText,"",searchText);
//   }
//
//   Future<ImportModel> _fetchImportDataBySearch(String field, String searchText) async {
//     try {
//       final userid = await StorageManager.readData('userid');
//       final headers = await _getHeaders();
//       final encodedFilter = Uri.encodeComponent(
//           "contains($field,'$searchText') ");
//       final url = '${ApiConstants.baseUrl}/WP_P_ImportTrackingLineList?'
//           '\$filter=$encodedFilter';
//
//       debugPrint('API URL: $url'); // For debuggingC00
//
//       final response = await http.get(Uri.parse(url), headers: headers);
//
//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         final importList = ImportModel.fromJson(data);
//         return importList; // Return even if empty
//       }
//       throw Exception('Failed with status code: ${response.statusCode}');
//     } catch (e) {
//       debugPrint('Error in _fetchImportDataBySearch: $e');
//       rethrow;
//     }
//   }

// import 'dart:convert';
// import 'package:flutter/cupertino.dart';
// import '../../ALL URL.dart';
// import '../../SharedPreference.dart';
// import '../../TokenRepo.dart';
// import 'package:http/http.dart' as http;
// import '../Model/Import_model.dart';
//
// class ImportApi {
//   Future<Map<String, String>> _getHeaders() async {
//     final tokenRepo = TokenRepository();
//     final bToken = await tokenRepo.getLoginOdataToken();
//     return {
//       'Authorization': 'Bearer $bToken',
//       'Prefer': 'odata.include-annotations="*"',
//     };
//   }
//
//   Future<List<Value>> _fetchImportDataByField(String fieldName, String userId) async {
//     try {
//       final headers = await _getHeaders();
//       final encodedFilter = Uri.encodeComponent(
//           "$fieldName eq '$userId' and Do_Not_Show eq false");
//       final url = "${ApiConstants.baseUrl}/WP_P_ImportTrackingLineList?"
//           "\$filter=$encodedFilter";
//
//       final response = await http.get(Uri.parse(url), headers: headers);
//
//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         final List<dynamic> items = data['value'];
//         return items.map((item) => Value.fromJson(item)).toList();
//       }
//       return [];
//     } catch (e) {
//       debugPrint('Error in _fetchImportDataByField: $e');
//       return [];
//     }
//   }
//
//   Future<List<Value>> fetchImportDataImportNo() async {
//     final userId = await StorageManager.readData('userid');
//     return _fetchImportDataByField('Importer_No', userId);
//   }
//
//   Future<List<Value>> fetchImportDataShippingLineNo() async {
//     final userId = await StorageManager.readData('userid');
//     return _fetchImportDataByField('Shipping_Line_No', userId);
//   }
//
//   Future<List<Value>> fetchImportDataFreightForwarderNO() async {
//     final userId = await StorageManager.readData('userid');
//     return _fetchImportDataByField('Freight_Forwarder_No', userId);
//   }
//
//   Future<List<Value>> fetchImportDataCHANO() async {
//     final userId = await StorageManager.readData('userid');
//     return _fetchImportDataByField('CHA_No', userId);
//   }
//
//   Future<List<Value>> fetchContainerNo(String searchText) async {
//     final userId = await StorageManager.readData('userid');
//     return _fetchImportDataBySearch('Container_No', searchText, userId);
//   }
//
//   Future<List<Value>> fetchBLNo(String searchText) async {
//     final userId = await StorageManager.readData('userid');
//     return _fetchImportDataBySearch('B_L_No', searchText, userId);
//   }
//
//   Future<List<Value>> _fetchImportDataBySearch(
//       String field,
//       String searchText,
//       String userId,
//       ) async {
//     try {
//       final headers = await _getHeaders();
//       final List<Value> results = [];
//
//       // Check each field separately with the Do_Not_Show condition
//       final fieldsToCheck = [
//         'Importer_No',
//         'Shipping_Line_No',
//         'Freight_Forwarder_No',
//         'CHA_No'
//       ];
//
//       for (var userField in fieldsToCheck) {
//         final encodedFilter = Uri.encodeComponent(
//             "contains($field,'$searchText') and Do_Not_Show eq false and $userField eq '$userId'"
//         );
//
//         final url = '${ApiConstants.baseUrl}/WP_P_ImportTrackingLineList?'
//             '\$filter=$encodedFilter';
//
//         debugPrint('API URL: $url');
//
//         final response = await http.get(Uri.parse(url), headers: headers);
//
//         if (response.statusCode == 200) {
//           final data = jsonDecode(response.body);
//           final List<dynamic> items = data['value'];
//           results.addAll(items.map((item) => Value.fromJson(item)).toList());
//         }
//       }
//
//       // Remove duplicates if any
//       final uniqueResults = results.toSet().toList();
//       return uniqueResults;
//     } catch (e) {
//       debugPrint('Error in _fetchImportDataBySearch: $e');
//       rethrow;
//     }
//   }
// }

import 'dart:convert';
import 'package:flutter/cupertino.dart';
import '../../ALL URL.dart';
import '../../SharedPreference.dart';
import '../../TokenRepo.dart';
import 'package:http/http.dart' as http;
import '../Model/Import_model.dart';

class ImportApi {
  Future<Map<String, String>> _getHeaders() async {
    final tokenRepo = TokenRepository();
    final bToken = await tokenRepo.getLoginOdataToken();
    return {
      'Authorization': 'Bearer $bToken',
      'Prefer': 'odata.include-annotations="*"',
    };
  }

  Future<List<Value>> _fetchImportDataByField(String fieldName, String userId) async {
    try {
      final headers = await _getHeaders();
      final encodedFilter = Uri.encodeComponent(
          "$fieldName eq '$userId' and Do_Not_Show eq false");
      final url = "${ApiConstants.baseUrl}/WP_P_ImportTrackingLineList?"
          "\$filter=$encodedFilter";

      final response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List<dynamic> items = data['value'];
        return items.map((item) => Value.fromJson(item)).toList();
      }
      return [];
    } catch (e) {
      debugPrint('Error in _fetchImportDataByField: $e');
      return [];
    }
  }

  Future<List<Value>> fetchImportDataImportNo() async {
    final userId = await StorageManager.readData('userid');
    return _fetchImportDataByField('Importer_No', userId);
  }

  Future<List<Value>> fetchImportDataShippingLineNo() async {
    final userId = await StorageManager.readData('userid');
    return _fetchImportDataByField('Shipping_Line_No', userId);
  }

  Future<List<Value>> fetchImportDataFreightForwarderNO() async {
    final userId = await StorageManager.readData('userid');
    return _fetchImportDataByField('Freight_Forwarder_No', userId);
  }

  Future<List<Value>> fetchImportDataCHANO() async {
    final userId = await StorageManager.readData('userid');
    return _fetchImportDataByField('CHA_No', userId);
  }

  // Add this new method to handle search parameters and fetch all data
  Future<List<Value>> listOfImportData({
    String? containerNoSearch,
    String? blNoSearch,
  }) async {
    try {
      final userId = await StorageManager.readData('userid');

      if (containerNoSearch != null && containerNoSearch.isNotEmpty) {
        return await _fetchImportDataBySearch('Container_No', containerNoSearch, userId);
      }

      if (blNoSearch != null && blNoSearch.isNotEmpty) {
        return await _fetchImportDataBySearch('B_L_No', blNoSearch, userId);
      }

      // Fetch all data if no search parameters
      final results = await Future.wait([
        fetchImportDataImportNo(),
        fetchImportDataShippingLineNo(),
        fetchImportDataFreightForwarderNO(),
        fetchImportDataCHANO(),
      ]);

      return results.expand((list) => list).toList();
    } catch (e) {
      debugPrint('Error in listOfImportData: $e');
      return [];
    }
  }

  Future<List<Value>> fetchContainerNo(String searchText) async {
    final userId = await StorageManager.readData('userid');
    return _fetchImportDataBySearch('Container_No', searchText, userId);
  }

  Future<List<Value>> fetchBLNo(String searchText) async {
    final userId = await StorageManager.readData('userid');
    return _fetchImportDataBySearch('B_L_No', searchText, userId);
  }

  Future<List<Value>> _fetchImportDataBySearch(
      String field,
      String searchText,
      String userId,
      ) async {
    try {
      final headers = await _getHeaders();
      final List<Value> results = [];

      final fieldsToCheck = [
        'Importer_No',
        'Shipping_Line_No',
        'Freight_Forwarder_No',
        'CHA_No'
      ];

      for (var userField in fieldsToCheck) {
        // Use 'eq' for exact match instead of 'contains'
        final encodedFilter = Uri.encodeComponent(
            "contains($field,'$searchText') and Do_Not_Show eq false and $userField eq '$userId'"
        );

        final url = '${ApiConstants.baseUrl}/WP_P_ImportTrackingLineList?'
            '\$filter=$encodedFilter';

        debugPrint('API URL: $url');

        final response = await http.get(Uri.parse(url), headers: headers);

        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          final List<dynamic> items = data['value'];
          results.addAll(items.map((item) => Value.fromJson(item)).toList());
        }
      }

      final uniqueResults = results.toSet().toList();
      return uniqueResults;
    } catch (e) {
      debugPrint('Error in _fetchImportDataBySearch: $e');
      rethrow;
    }
  }
}


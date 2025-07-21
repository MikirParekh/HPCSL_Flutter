// import 'package:flutter/material.dart';
// import 'package:hpcsl_1/Domestic/Model/Domestic_model.dart';
// import 'package:hpcsl_1/Transport/Model/Transport_Model.dart';
// import 'package:hpcsl_1/colors.dart';
// import 'package:intl/intl.dart';
//
// import '../../Drawer.dart';
// import '../../NoRecordFound.dart';
// import '../../SharedPreference.dart';
// import '../../Sign In/UI/login.dart';
// import '../Repo/TransportReposistry.dart';
//
// class Transport extends StatefulWidget {
//   const Transport ({super.key});
//
//   @override
//   State<Transport > createState() => _Transport ();
// }
//
// class TransportException implements Exception {
//   final String message;
//   const TransportException(this.message);
//
//   @override
//   String toString() => "TransportException: $message";
// }
//
// class _Transport extends State<Transport > {
//   final String title = "AIA ENGINEERING LTD";
//   final String subtitle = "Transport Tracking";
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//
//   // Variable to keep track of the selected item index
//   int selectedIndex = 0;
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); // Added form key
//   late List<TransportModel1> transportDataList; // List to hold the import data
//   String? userid;
//
//   List<TransportModel1> users = [];
//   bool isLoading = false;
//
//   final TextEditingController _controller = TextEditingController();
//   final TextEditingController _shippingBillNo = TextEditingController();
//   List<TransportModel1> filteredUsers = [];
//
//   TransportApi transport=TransportApi();
//
//   @override
//   void initState() {
//     super.initState();
//     _loadUserId(); // Fetch data on screen load
//   }
//
//   @override
//   void dispose() {
//     // Dispose the controller when the widget is disposed
//     _controller.dispose();
//     _shippingBillNo.dispose();
//     super.dispose();
//   }
//
//   Future<void> _loadUserId() async {
//     userid = await StorageManager.readData('userid') as String?;
//     if (userid == null) {
//       // Handle the case where userId is missing
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error: User ID is missing')),
//       );
//     } else {
//       // Proceed with fetching data or other actions
//       fetchTransportData();
//     }
//   }
//
//
//
//   Future<void> fetchTransportData() async {
//     // setState(() => isLoading = true);
//     try {
//       final response = await TransportApi().fetchTransportData(context,userid ?? '');  // Pass only context
//
//       if (mounted) {
//         setState(() {
//           users = response.value ?? [];
//           debugPrint('Fetched Transport data: ${users.length}');
//         });
//       }
//     } catch (e) {
//       if (mounted) {
//         debugPrint('Error in Fetching Transport data: $e');
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Failed to load data: $e')),
//         );
//       }
//     } finally {
//       if (mounted) {
//         setState(() => isLoading = false);
//       }
//     }
//   }
//
//
//   void _handleSearch() async {
//     String input = _controller.text.trim().toUpperCase(); // Convert to uppercase for exact matching
//
//     if (input.isEmpty) {
//       setState(() {
//         filteredUsers = [];
//       });
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Please enter a container number')),
//       );
//       return;
//     }
//
//     setState(() {
//       isLoading = true;  // Show loading indicator
//     });
//
//     try {
//       // Call the API with exact container number
//       final response = await transport.fetchContainerNoWithSearch(context, input);
//
//       if (mounted) {
//         setState(() {
//           if (response.value != null) {
//             // Filter for exact match only
//             filteredUsers = response.value!.where((user) =>
//             (user.containerNo?.toUpperCase() ?? '') == input
//             ).toList();
//
//             if (filteredUsers.isEmpty) {
//               ScaffoldMessenger.of(context).showSnackBar(
//                 const SnackBar(content: Text('No exact match found for this container number')),
//               );
//             }
//           } else {
//             filteredUsers = [];
//             ScaffoldMessenger.of(context).showSnackBar(
//               const SnackBar(content: Text('Error fetching container details')),
//             );
//           }
//         });
//       }
//     } catch (e) {
//       if (mounted) {
//         setState(() {
//           filteredUsers = [];
//         });
//       }
//     } finally {
//       if (mounted) {
//         setState(() {
//           isLoading = false;  // Hide loading indicator
//         });
//       }
//     }
//   }
//
//   void _handleBLSearch() async {
//     String input = _shippingBillNo.text.trim().toUpperCase();
//
//     if (input.isEmpty) {
//       setState(() {
//         filteredUsers = [];
//       });
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Please enter a B/L number')),
//       );
//       return;
//     }
//
//     setState(() {
//       isLoading = true;
//     });
//
//     try {
//       final response = await transport.fetchGRNoWithSearch(context, input);
//
//       if (mounted) {
//         setState(() {
//           if (response.value != null) {
//             filteredUsers = response.value!.where((user) =>
//             (user.gRNo?.toUpperCase() ?? '') == input).toList();
//
//             if (filteredUsers.isEmpty) {
//               ScaffoldMessenger.of(context).showSnackBar(
//                 const SnackBar(
//                     content: Text('No exact match found for this B/L number')),
//               );
//             }
//           } else {
//             filteredUsers = [];
//             ScaffoldMessenger.of(context).showSnackBar(
//               const SnackBar(content: Text('Error fetching B/L details')),
//             );
//           }
//         });
//       }
//     } catch (e) {
//       if (mounted) {
//         setState(() {
//           filteredUsers = [];
//         });
//       }
//     } finally {
//       if (mounted) {
//         setState(() {
//           isLoading = false;
//         });
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: _scaffoldKey,
//       backgroundColor: Colors.white, // Set the background color of the body to white
//       appBar: PreferredSize(
//         preferredSize: const Size.fromHeight(100.0),
//         child: AppBar(
//           backgroundColor: AppColors.colorPrimary,
//           elevation: 0,
//           automaticallyImplyLeading: false,
//           flexibleSpace: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 10.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const SizedBox(height: 40), // Space for app bar content
//                 Text(
//                   title,
//                   style: const TextStyle(
//                     fontSize: 20,
//                     color: AppColors.titlecolor,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//                 Row(
//                   children: [
//                     IconButton(
//                       icon: const Icon(Icons.menu, color: Colors.white),
//                       onPressed: () {
//                         _scaffoldKey.currentState?.openDrawer(); // Open the drawer
//                       },
//                     ),
//                     Text(
//                       subtitle,
//                       style: const TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                       ),
//                     ),
//                     const Spacer(),
//                     GestureDetector(
//                       onTap: () {
//                         showDialog(
//                           context: context,
//                           builder: (BuildContext context) {
//                             return AlertDialog(
//                               backgroundColor: Colors.white, // Set background color to white
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(10), // Optional: Rounded corners
//                               ),
//                               content: SizedBox(
//                                 width: 800, // Increase width of the dialog
//                                 child: const Text('Are You Sure You Want to Exit?',style:TextStyle(fontSize: 16) ,),
//                               ),
//                               actions: [
//                                 TextButton(
//                                   onPressed: () {
//                                     Navigator.of(context).pop(); // Close dialog
//                                   },
//                                   child: const Text('CANCEL',style:TextStyle(color: Colors.blue),),
//                                 ),
//                                 TextButton(
//                                   onPressed: () {
//                                     // Add your logout logic here
//                                     Navigator.of(context).pop(); // Close dialog
//                                     Navigator.of(context).pushAndRemoveUntil(
//                                       MaterialPageRoute(
//                                         builder: (context) => LoginScreen(),
//                                       ),
//                                           (route) => false,
//                                     );
//                                   },
//                                   child: const Text('CONFIRM',style:TextStyle(color: Colors.blue),),
//                                 ),
//                               ],
//                             );
//                           },
//                         );
//                       },
//
//                       child: Image.asset(
//                         'assets/images/sign_out.png',
//                         width: 30,
//                         height: 30,
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//       drawer: SizedBox(
//         width: MediaQuery.of(context).size.width * 0.8,
//         child: CustomDrawer(
//           selectedIndex: selectedIndex,
//           onItemTap: (int index) {
//             setState(() {
//               selectedIndex = index;
//             });
//             _scaffoldKey.currentState?.openEndDrawer(); // Close the drawer on item tap
//           },
//         ),
//       ),
//
//       body:
//       Padding(
//         padding: const EdgeInsets.all(7.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               // Container No. and Shipping Bill No.
//               Row(
//                 children: [
//                   Expanded(
//                     child: TextFormField(
//                       controller: _controller,
//                       decoration: InputDecoration(
//                         labelText: 'Container No.',
//                         hintText: 'Container No.',
//                         fillColor: Colors.white,
//                         filled: true,
//                         labelStyle: const TextStyle(color: Colors.grey,fontSize: 18, fontWeight: FontWeight.normal),
//                         hintStyle: const TextStyle(color: Colors.grey, fontSize: 18, fontWeight: FontWeight.normal),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12.0), // Rounded corners
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12.0),
//                           borderSide: const BorderSide(color: Colors.blue), // Blue border when focused
//                         ),
//                         enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12.0),
//                           borderSide: const BorderSide(color: Colors.blue), // Blue border when enabled
//                         ),
//                         floatingLabelBehavior: FloatingLabelBehavior.never,
//                         contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 18.0),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 4.0), // Add space between the fields
//                   Expanded(
//                     child: TextFormField(
//                       controller:_shippingBillNo,
//                       decoration: InputDecoration(
//                         labelText: 'GR No',
//                         hintText: 'GR No',
//                         fillColor: Colors.white,
//                         filled: true,
//                         labelStyle: const TextStyle(color: Colors.grey),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12.0), // Rounded corners
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12.0),
//                           borderSide: const BorderSide(color: Colors.blue), // Blue border when focused
//                         ),
//                         enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12.0),
//                           borderSide: const BorderSide(color: Colors.blue), // Blue border when enabled
//                         ),
//                         floatingLabelBehavior: FloatingLabelBehavior.never,
//                         contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 18.0),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 6.0),
//
//               // Clear and Search Buttons
//               Row(
//                 children: [
//                   Expanded(
//                     child: ElevatedButton(
//                       onPressed: () {
//                         setState(() {
//                           _controller.clear();
//                           _shippingBillNo.clear();
//                           filteredUsers = []; // Clear filtered results
//                         });
//                       },
//                       style: ElevatedButton.styleFrom(
//                         foregroundColor: Colors.white, backgroundColor: AppColors.colorPrimary, // Text color
//                         padding: const EdgeInsets.symmetric(vertical: 12.0), // Increase the button size
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12.0), // Rounded corners for buttons
//                         ),
//                       ),
//                       child: const Text('Clear', style: TextStyle(fontSize: 18)),
//                     ),
//                   ),
//                   const SizedBox(width: 6.0), // Add space between the buttons
//                   Expanded(
//                     child: ElevatedButton(
//                       onPressed: () {
//                         if (_controller.text.isNotEmpty) {
//                           _handleSearch();
//                         } else if (_shippingBillNo.text.isNotEmpty) {
//                           _handleBLSearch();
//                         } else {
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             const SnackBar(
//                                 content: Text(
//                                     'Please enter value',textAlign: TextAlign.center,)),
//                           );
//                         }
//                       },
//                       style: ElevatedButton.styleFrom(
//                         foregroundColor: Colors.white, backgroundColor: AppColors.colorPrimary, // Text color
//                         padding: const EdgeInsets.symmetric(vertical: 12.0), // Increase the button size
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12.0), // Rounded corners for buttons
//                         ),
//                       ),
//                       child: const Text('Search', style: TextStyle(fontSize: 18)),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 4.0),
//               transportdata(context),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget transportdata(BuildContext context) {
//     final dataToShow =
//     (_controller.text.isNotEmpty || _shippingBillNo.text.isNotEmpty) ? filteredUsers : [];
//     return Expanded(
//       child: isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : _controller.text.isEmpty || _shippingBillNo.text.isEmpty
//           ? const Center( child :Text(''))
//       :dataToShow.isEmpty
//       ?const Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Center(
//               child: ErrorScreen(
//                 errorImage: "assets/images/no_content.png",
//                 titleMsg: "No Record Found",
//                 msg: "",
//               ),
//             ),
//           ],
//         ),
//       )
//           : ListView.separated(
//         itemCount: dataToShow.length,
//         separatorBuilder: (context, index) =>
//         const Divider(
//           color: Colors.grey, // Color of the divider
//           thickness: 1.0, // Thickness of the divider
//           height: 1.0, // Space before and after the divider
//         ),
//         itemBuilder: (context, index) {
//           final user = dataToShow[index];
//           return ListTile(
//             title: _buildInfoRow('GR No', user.gRNo ?? 'N/A'),
//             subtitle: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 _buildInfoRow('GR Date.', formatDate(user.gRDate)),
//                 _buildInfoRow('Container No.', user.containerNo ?? 'N/A'),
//                  _buildInfoRow('Container Size.', user.size ?? 'N/A'),
//                 _buildInfoRow('Consignee', user.consigneeName ?? 'N/A'),
//                 _buildInfoRow('Consignor', user.consignorName ?? 'N/A'),
//                 _buildInfoRow('Shipping Line.', user.shippingLineName ?? 'N/A'),
//                 _buildInfoRow('Transaction Type', user.transactionType ?? 'N/A'),
//                 _buildInfoRow('Document Type', user.documentType ?? 'N/A'),
//                 _buildInfoRow('Terminal', user.terminal ?? 'N/A'),
//                 _buildInfoRow('Cargo Description', user.cargoDescription ?? 'N/A'),
//                 _buildInfoRow('Gross Weight(MT)', user.grossWeight.toString() ?? 'N/A'),
//                 _buildInfoRow('CHA', user.cHAName ?? 'N/A'),
//                 _buildInfoRow('DO Validity Date', formatDate(user.dOValidityDate)),
//                 _buildInfoRow('DO Re-validity Date', formatDate(user.dORevalidityDate)),
//                 _buildInfoRow('POL', user.pOL ?? 'N/A'),
//                 _buildInfoRow('REDT', user.rEDT ?? 'N/A'),
//                 _buildInfoRow('Shipping Bill No.', user.shippingBillNo ?? 'N/A'),
//                 _buildInfoRow('B/L No.', user.bLNo ?? 'N/A'),
//                  _buildInfoRow('Pickup Location', user.emptyPickDropLocation ?? 'N/A'),
//                 _buildInfoRow('Route Name', user.roadRouteName ?? 'N/A'),
//                 _buildInfoRow('Factory Plan Date', formatDate(user.factoryPlanDate)),
//                 _buildInfoRow('Factory Plan Time', formatDate(user.factoryPlanTime)),
//                 _buildInfoRow('Planned Pick Date', formatDate(user.loadingUnloadingPlanDate)),
//                 _buildInfoRow('Vehicle No', user.vehicleNo ?? 'N/A'),
//                  _buildInfoRow('Trip Start Date', formatDate(user.tripStartDateX0026Time)),
//                 _buildInfoRow('Factory/Yard/ICD Arr \n Date Time', formatDate(user.factoryYardArrivalDatetime)),
//                 _buildInfoRow('Factory/Yard/ICD\n Dpt Date Time', user.factoryYardDepDatetime ?? 'N/A'),
//                 _buildInfoRow('Port Gate In Date', formatDate(user.portYardInGatedDate)),
//               ],
//             ),
//             isThreeLine: true,
//             contentPadding: EdgeInsets.zero,
//           );
//         },
//
//
//       ),
//     );
//   }
//
//
//
//   Widget _buildInfoRow(String label, String value) {
//     return Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           SizedBox(
//             width: 150, // Fixed width for the label
//             child: Text(
//               label,
//               style: TextStyle(
//                 color: Colors.blue[700],
//                 fontSize: 16,
//               ),
//             ),
//           ),
//           Expanded(
//             child: Text(
//               value,
//               style:  TextStyle(
//                 color: Colors.grey[700],
//                 fontSize: 16,
//               ),
//               overflow: TextOverflow.visible, // Allow text to display fully
//              // softWrap: true, // Enable text wrapping// Ensure value remains in one line
//             ),
//           ),
//         ],
//       );
//
//   }
//
//
//   String formatDate(String? date) {
//     if (date == null || date.isEmpty) return 'N/A';
//     try {
//       final parsedDate = DateTime.parse(date); // Parse the date string
//       return DateFormat('dd-MM-yyyy').format(parsedDate); // Format the date
//     } catch (e) {
//       return 'Invalid Date'; // Handle invalid date strings
//     }
//   }
//
// }

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hpcsl_1/colors.dart';
import '../../Drawer.dart';
import '../../NoRecordFound.dart';
import '../../SharedPreference.dart';
import '../../Sign In/UI/login.dart';
import 'package:intl/intl.dart';

import '../../TitleManager.dart';
import '../Model/Transport_Model.dart';
import '../Repo/TransportReposistry.dart';

class Transport extends StatefulWidget {
  const Transport ({super.key});

  @override
  State<Transport > createState() => _Transport ();
}

class TransportException implements Exception {
  final String message;
  const TransportException(this.message);

  @override
  String toString() => "TransportException: $message";
}

// class _Transport extends State<Transport> {
//   final String title = "AIA ENGINEERING LTD";
//   final String subtitle = "Transport Tracking";
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//   int selectedIndex = 0;
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//
//   List<TransportModel1> filteredUsers = [];
//   final TextEditingController _controller = TextEditingController();
//   final TextEditingController _grNo = TextEditingController();
//   String? userid;
//   bool hasSearched = false;
//   bool showInitialMessage = true;
//   bool isLoading = false;
//
//
//   final TransportApi transportApi = TransportApi();
//
//   @override
//   void initState() {
//     super.initState();
//     _loadUserId();
//
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     _grNo.dispose();
//     super.dispose();
//   }
//
//   Future<void> _loadUserId() async {
//     try {
//       userid = await StorageManager.readData('userid') as String?;
//       if (userid == null) {
//         if (mounted) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text('Error: User ID is missing')),
//           );
//         }
//       }
//     } catch (e) {
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Error loading user ID: ${e.toString()}')),
//         );
//       }
//     }
//   }
//
//   void _handleGPSTrackingClick(String? grNo) {
//     if (grNo == null || grNo == 'N/A') return;
//
//     // Copy to clipboard
//     Clipboard.setData(ClipboardData(text: grNo));
//
//     // Show confirmation
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text('Copied GPS Tracking No: $grNo')),
//     );
//   }
//
//   void _handleSearch() async {
//     final input = _controller.text.trim();
//     if (input.isEmpty) {
//       _showSnackBar('Please enter a container number');
//       return;
//     }
//
//     try {
//       if (mounted) {
//         setState(() {
//           isLoading = true;
//           hasSearched = true;
//         });
//       }
//
//       final results = await transportApi.fetchContainerNo(input);
//
//       if (mounted) {
//         setState(() {
//           filteredUsers = results ?? [];
//           isLoading = false;
//         });
//         if (filteredUsers.isEmpty) {
//           _showSnackBar('No matching records found');
//         }
//       }
//     } catch (e) {
//       if (mounted) {
//         setState(() {
//           filteredUsers = [];
//           isLoading = false;
//         });
//         _showSnackBar('Search failed: ${e.toString()}');
//       }
//     }
//   }
//
//   void _handleGrNoSearch() async {
//     final input = _grNo.text.trim();
//     if (input.isEmpty) {
//       _showSnackBar('Please enter a GR NO');
//       return;
//     }
//
//     try {
//       if (mounted) {
//         setState(() {
//           isLoading = true;
//           hasSearched = true;
//         });
//       }
//
//       final result = await transportApi.fetchGrNo(input);
//
//       if (mounted) {
//         setState(() {
//           filteredUsers = result ?? [];
//           isLoading = false;
//         });
//         if (filteredUsers.isEmpty) {
//           _showSnackBar('No matching records found');
//         }
//       }
//     } catch (e) {
//       if (mounted) {
//         setState(() {
//           filteredUsers = [];
//           isLoading = false;
//         });
//         _showSnackBar('Search failed: ${e.toString()}');
//       }
//     }
//   }
//
//
//   // void _performSearch(Future<List<Value>> Function() searchFunction) async {
//   //   if (userid == null) {
//   //     _showSnackBar('User ID is not available');
//   //     return;
//   //   }
//   //
//   //   setState(() => hasSearched = true); // Only track search attempt
//   //
//   //   try {
//   //     final results = await searchFunction();
//   //     if (mounted) {
//   //       setState(() => filteredUsers = results);
//   //       if (filteredUsers.isEmpty) {
//   //         _showSnackBar('No matching records found');
//   //       }
//   //     }
//   //   } catch (e) {
//   //     if (mounted) {
//   //       setState(() => filteredUsers = []);
//   //       _showSnackBar('Search failed: ${e.toString()}');
//   //     }
//   //   }
//   // }
//
//   void _showSnackBar(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text(message)),
//     );
//   }
//
//   void _clearSearch() {
//     setState(() {
//       _controller.clear();
//       _grNo.clear();
//       filteredUsers = [];
//       hasSearched = false;
//       showInitialMessage = true;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: _scaffoldKey,
//       backgroundColor: Colors.white,
//       appBar: PreferredSize(
//         preferredSize: const Size.fromHeight(100.0),
//         child: AppBar(
//           backgroundColor: AppColors.colorPrimary,
//           elevation: 0,
//           automaticallyImplyLeading: false,
//           flexibleSpace: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 10.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const SizedBox(height: 40),
//                 Text(
//                   title,
//                   style: const TextStyle(
//                     fontSize: 20,
//                     color: AppColors.titlecolor,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//                 Row(
//                   children: [
//                     IconButton(
//                       icon: const Icon(Icons.menu, color: Colors.white),
//                       onPressed: () {
//                         _scaffoldKey.currentState?.openDrawer();
//                       },
//                     ),
//                     Text(
//                       subtitle,
//                       style: const TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                       ),
//                     ),
//                     const Spacer(),
//                     GestureDetector(
//                       onTap: () => _showLogoutConfirmation(),
//                       child: Image.asset(
//                         'assets/images/sign_out.png',
//                         width: 30,
//                         height: 30,
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//       drawer: SizedBox(
//         width: MediaQuery.of(context).size.width * 0.8,
//         child: CustomDrawer(
//           selectedIndex: selectedIndex,
//           onItemTap: (int index) {
//             setState(() {
//               selectedIndex = index;
//             });
//             _scaffoldKey.currentState?.openEndDrawer();
//           },
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(7.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               Row(
//                 children: [
//                   Expanded(
//                     child: TextFormField(
//                       controller: _controller,
//                       decoration: InputDecoration(
//                         labelText: 'Container No.',
//                         hintText: 'Container No.',
//                         fillColor: Colors.white,
//                         filled: true,
//                         labelStyle: const TextStyle(
//                             color: Colors.grey,
//                             fontSize: 18,
//                             fontWeight: FontWeight.normal),
//                         hintStyle: const TextStyle(
//                             color: Colors.grey,
//                             fontSize: 18,
//                             fontWeight: FontWeight.normal),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12.0),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12.0),
//                           borderSide: const BorderSide(color: Colors.blue),
//                         ),
//                         enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12.0),
//                           borderSide: const BorderSide(color: Colors.blue),
//                         ),
//                         floatingLabelBehavior: FloatingLabelBehavior.never,
//                         contentPadding: const EdgeInsets.symmetric(
//                             vertical: 8.0, horizontal: 18.0),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 4.0),
//                   Expanded(
//                     child: TextFormField(
//                       controller: _grNo,
//                       decoration: InputDecoration(
//                         labelText: 'GR No',
//                         hintText: 'GR No',
//                         fillColor: Colors.white,
//                         filled: true,
//                         labelStyle: const TextStyle(
//                             color: Colors.grey,
//                             fontSize: 18,
//                             fontWeight: FontWeight.normal),
//                         hintStyle: const TextStyle(
//                             color: Colors.grey,
//                             fontSize: 18,
//                             fontWeight: FontWeight.normal),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12.0),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12.0),
//                           borderSide: const BorderSide(color: Colors.blue),
//                         ),
//                         enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12.0),
//                           borderSide: const BorderSide(color: Colors.blue),
//                         ),
//                         floatingLabelBehavior: FloatingLabelBehavior.never,
//                         contentPadding: const EdgeInsets.symmetric(
//                             vertical: 8.0, horizontal: 18.0),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 6.0),
//               Row(
//                 children: [
//                   Expanded(
//                     child: ElevatedButton(
//                       onPressed: isLoading ? null : _clearSearch,
//                       style: ElevatedButton.styleFrom(
//                         foregroundColor: Colors.white,
//                         backgroundColor: AppColors.colorPrimary,
//                         padding: const EdgeInsets.symmetric(vertical: 12.0),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12.0),
//                         ),
//                       ),
//                       child: const Text('Clear', style: TextStyle(fontSize: 18)),
//                     ),
//                   ),
//                   const SizedBox(width: 6.0),
//                   Expanded(
//                     child: ElevatedButton(
//                       onPressed: isLoading ? null : (){
//                         if (_controller.text.isNotEmpty) {
//                           _handleSearch();
//                         } else if (_grNo.text.isNotEmpty) {
//                           _handleGrNoSearch();
//                         } else {
//                           _showSnackBar('Please enter a search term');
//                         }
//                       },
//                       style: ElevatedButton.styleFrom(
//                         foregroundColor: Colors.white,
//                         backgroundColor: AppColors.colorPrimary,
//                         padding: const EdgeInsets.symmetric(vertical: 12.0),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12.0),
//                         ),
//                       ),
//                       child: const Text('Search', style: TextStyle(fontSize: 18)),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 4.0),
//               _buildTransportDataView(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   void _showLogoutConfirmation() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           backgroundColor: Colors.white,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(10),
//           ),
//           content: const SizedBox(
//             width: 800,
//             child: Text('Are You Sure You Want to Exit?',
//                 style: TextStyle(fontSize: 16)),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.of(context).pop(),
//               child: const Text('CANCEL',
//                   style: TextStyle(color: Colors.blue)),
//             ),
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//                 Navigator.of(context).pushAndRemoveUntil(
//                   MaterialPageRoute(
//                     builder: (context) =>  LoginScreen(),
//                   ),
//                       (route) => false,
//                 );
//               },
//               child: const Text('CONFIRM',
//                   style: TextStyle(color: Colors.blue)),
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   Widget _buildTransportDataView() {
//     if (isLoading) {
//       return const Expanded(
//         child: Center(
//           child: CircularProgressIndicator(
//             valueColor: AlwaysStoppedAnimation<Color>(AppColors.colorPrimary),
//           ),
//         ),
//       );
//     }
//
//     if (!hasSearched) {
//       return Expanded(
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const Text(
//                 '',
//               ),
//             ],
//           ),
//         ),
//       );
//     }
//
//     if (filteredUsers.isEmpty) {
//       return const Expanded(
//         child: Center(
//           child: ErrorScreen(
//             errorImage: "assets/images/no_content.png",
//             titleMsg: "No Record Found",
//             msg: "",
//           ),
//         ),
//       );
//     }
//
//     return Expanded(
//       child: ListView.separated(
//         itemCount: filteredUsers.length,
//         separatorBuilder: (context, index) => const Divider(),
//         itemBuilder: (context, index) => _buildResultItem(filteredUsers[index]),
//       ),
//     );
//   }
//
//   Widget _buildResultItem(TransportModel1 user) {
//     return ListTile(
//             title:
//             InkWell(
//               onTap: () => _handleGPSTrackingClick(user.gPSTrackingLink),
//               child:
//               _buildInfoRow('GPS Tracking', user.gPSTrackingLink  ?? 'N/A'),
//             ),
//             subtitle: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 _buildInfoRow('GR No', user.gRNo ?? 'N/A'),
//                 _buildInfoRow('GR Date.', formatDate(user.gRDate)),
//                 _buildInfoRow('Container No.', user.containerNo ?? 'N/A'),
//                  _buildInfoRow('Container Size.', user.size ?? 'N/A'),
//                 _buildInfoRow('Consignee', user.consigneeName ?? 'N/A'),
//                 _buildInfoRow('Consignor', user.consignorName ?? 'N/A'),
//                 _buildInfoRow('Shipping Line.', user.shippingLineName ?? 'N/A'),
//                 _buildInfoRow('Transaction Type', user.transactionType ?? 'N/A'),
//                 _buildInfoRow('Document Type', user.documentType ?? 'N/A'),
//                 _buildInfoRow('Terminal', user.terminal ?? 'N/A'),
//                 _buildInfoRow('Cargo Description', user.cargoDescription ?? 'N/A'),
//                 _buildInfoRow('Gross Weight(MT)', user.grossWeight.toString() ?? 'N/A'),
//                 _buildInfoRow('CHA', user.cHAName ?? 'N/A'),
//                 _buildInfoRow('DO Validity Date', formatDate(user.dOValidityDate)),
//                 _buildInfoRow('DO Re-validity Date', formatDate(user.dORevalidityDate)),
//                 _buildInfoRow('POL', user.pOL ?? 'N/A'),
//                 _buildInfoRow('REDT', user.rEDT ?? 'N/A'),
//                 _buildInfoRow('Shipping Bill No.', user.shippingBillNo ?? 'N/A'),
//                 _buildInfoRow('B/L No.', user.bLNo ?? 'N/A'),
//                  _buildInfoRow('Pickup Location', user.emptyPickDropLocation ?? 'N/A'),
//                 _buildInfoRow('Route Name', user.roadRouteName ?? 'N/A'),
//                 _buildInfoRow('Factory Plan Date', formatDate(user.factoryPlanDate)),
//                 _buildInfoRow('Factory Plan Time', formatDate(user.factoryPlanTime)),
//                 _buildInfoRow('Planned Pick Date', formatDate(user.loadingUnloadingPlanDate)),
//                 _buildInfoRow('Vehicle No', user.vehicleNo ?? 'N/A'),
//                  _buildInfoRow('Trip Start Date', formatDate(user.tripStartDateX0026Time)),
//                 _buildInfoRow('Factory/Yard/ICD Arr \n Date Time', formatDate(user.factoryYardArrivalDatetime)),
//                 _buildInfoRow('Factory/Yard/ICD\n Dpt Date Time', user.factoryYardDepDatetime ?? 'N/A'),
//                 _buildInfoRow('Port Gate In Date', formatDate(user.portYardInGatedDate)),
//               ],
//       ),
//       isThreeLine: true,
//       contentPadding: EdgeInsets.zero,
//     );
//   }
//
//
//   Widget _buildInfoRow(String label, String value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 0.0),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           SizedBox(
//             width: 150,
//             child: Text(
//               label,
//               style: TextStyle(
//                 color: Colors.blue[700],
//                 fontSize: 16,
//               ),
//             ),
//           ),
//           Expanded(
//             child: Text(
//               value,
//               style: TextStyle(
//                 color: Colors.grey[700],
//                 fontSize: 16,
//               ),
//               overflow: TextOverflow.visible,
//               softWrap: true,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   String formatDate(String? date) {
//     if (date == null || date.isEmpty) return 'N/A';
//     try {
//       final parsedDate = DateTime.parse(date);
//       return DateFormat('dd-MM-yyyy').format(parsedDate);
//     } catch (e) {
//       return 'Invalid Date';
//     }
//   }
// }

// class _Transport extends State<Transport> {
//   String title = '';
//   final String subtitle = "Transport Tracking";
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//   int selectedIndex = 0;
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//
//   List<TransportModel1> filteredUsers = [];
//   final TextEditingController _controller = TextEditingController();
//   final TextEditingController _grNo = TextEditingController();
//   String? userid;
//   bool hasSearched = false;
//   bool showInitialMessage = true;
//   bool isLoading = false;
//   bool isInitialLoading = true; // Add this for initial loading state
//
//   final TransportApi transportApi = TransportApi();
//
//   @override
//   void initState() {
//     super.initState();
//     _loadUserId();
//     _loadInitialData();// Add this line to load data on startup
//     _loadDynamicTitle();
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     _grNo.dispose();
//     super.dispose();
//   }
//
//   Future<void> _loadUserId() async {
//     try {
//       userid = await StorageManager.readData('userid') as String?;
//       if (userid == null) {
//         if (mounted) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text('Error: User ID is missing')),
//           );
//         }
//       }
//     } catch (e) {
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Error loading user ID: ${e.toString()}')),
//         );
//       }
//     }
//   }
//
//   void _loadDynamicTitle() async {
//     final fetchedTitle = await TitleManager.getTitle();
//     setState(() {
//       title = fetchedTitle;
//     });
//   }
//
//   // Add this method to load initial data
//   Future<void> _loadInitialData() async {
//     if (userid == null) {
//       await _loadUserId();
//     }
//
//     try {
//       if (mounted) {
//         setState(() {
//           isInitialLoading = true;
//           showInitialMessage = false;
//         });
//       }
//
//       final results = await transportApi.listOfTransportData();
//
//       if (mounted) {
//         setState(() {
//           filteredUsers = results;
//           isInitialLoading = false;
//           hasSearched = true; // Set to true so data is displayed
//         });
//       }
//     } catch (e) {
//       if (mounted) {
//         setState(() {
//           filteredUsers = [];
//           isInitialLoading = false;
//           hasSearched = true;
//         });
//         _showSnackBar('Failed to load data: ${e.toString()}');
//       }
//     }
//   }
//
//   void _handleGPSTrackingClick(String? grNo) {
//     if (grNo == null || grNo == 'N/A') return;
//
//     // Copy to clipboard
//     Clipboard.setData(ClipboardData(text: grNo));
//
//     // Show confirmation
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text('Copied GPS Tracking No: $grNo')),
//     );
//   }
//
//   void _handleSearch() async {
//     final input = _controller.text.trim();
//     if (input.isEmpty) {
//       _showSnackBar('Please enter a container number');
//       return;
//     }
//
//     try {
//       if (mounted) {
//         setState(() {
//           isLoading = true;
//           hasSearched = true;
//         });
//       }
//
//       final results = await transportApi.fetchContainerNo(input);
//
//       if (mounted) {
//         setState(() {
//           filteredUsers = results ?? [];
//           isLoading = false;
//         });
//         if (filteredUsers.isEmpty) {
//           _showSnackBar('No matching records found');
//         }
//       }
//     } catch (e) {
//       if (mounted) {
//         setState(() {
//           filteredUsers = [];
//           isLoading = false;
//         });
//         _showSnackBar('Search failed: ${e.toString()}');
//       }
//     }
//   }
//
//   void _handleGrNoSearch() async {
//     final input = _grNo.text.trim();
//     if (input.isEmpty) {
//       _showSnackBar('Please enter a GR NO');
//       return;
//     }
//
//     try {
//       if (mounted) {
//         setState(() {
//           isLoading = true;
//           hasSearched = true;
//         });
//       }
//
//       final result = await transportApi.fetchGrNo(input);
//
//       if (mounted) {
//         setState(() {
//           filteredUsers = result ?? [];
//           isLoading = false;
//         });
//         if (filteredUsers.isEmpty) {
//           _showSnackBar('No matching records found');
//         }
//       }
//     } catch (e) {
//       if (mounted) {
//         setState(() {
//           filteredUsers = [];
//           isLoading = false;
//         });
//         _showSnackBar('Search failed: ${e.toString()}');
//       }
//     }
//   }
//
//   void _showSnackBar(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text(message)),
//     );
//   }
//
//   void _clearSearch() {
//     setState(() {
//       _controller.clear();
//       _grNo.clear();
//       hasSearched = false;
//       showInitialMessage = false;
//     });
//     // Reload initial data when clearing search
//     _loadInitialData();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: _scaffoldKey,
//       backgroundColor: Colors.white,
//       appBar: PreferredSize(
//         preferredSize: const Size.fromHeight(100.0),
//         child: AppBar(
//           backgroundColor: AppColors.colorPrimary,
//           elevation: 0,
//           automaticallyImplyLeading: false,
//           flexibleSpace: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 10.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const SizedBox(height: 40),
//                 Text(
//                   title,
//                   style: const TextStyle(
//                     fontSize: 20,
//                     color: AppColors.titlecolor,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//                 Row(
//                   children: [
//                     IconButton(
//                       icon: const Icon(Icons.menu, color: Colors.white),
//                       onPressed: () {
//                         _scaffoldKey.currentState?.openDrawer();
//                       },
//                     ),
//                     Text(
//                       subtitle,
//                       style: const TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                       ),
//                     ),
//                     const Spacer(),
//                     GestureDetector(
//                       onTap: () => _showLogoutConfirmation(),
//                       child: Image.asset(
//                         'assets/images/sign_out.png',
//                         width: 30,
//                         height: 30,
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//       drawer: SizedBox(
//         width: MediaQuery.of(context).size.width * 0.8,
//         child: CustomDrawer(
//           showAccounts: false,
//           selectedIndex: selectedIndex,
//           onItemTap: (int index) {
//             setState(() {
//               selectedIndex = index;
//             });
//             _scaffoldKey.currentState?.openEndDrawer();
//           },
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(7.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               Row(
//                 children: [
//                   Expanded(
//                     child: TextFormField(
//                       controller: _controller,
//                       decoration: InputDecoration(
//                         labelText: 'Container No.',
//                         hintText: 'Container No.',
//                         fillColor: Colors.white,
//                         filled: true,
//                         labelStyle: const TextStyle(
//                             color: Colors.grey,
//                             fontSize: 18,
//                             fontWeight: FontWeight.normal),
//                         hintStyle: const TextStyle(
//                             color: Colors.grey,
//                             fontSize: 18,
//                             fontWeight: FontWeight.normal),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12.0),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12.0),
//                           borderSide: const BorderSide(color: Colors.blue),
//                         ),
//                         enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12.0),
//                           borderSide: const BorderSide(color: Colors.blue),
//                         ),
//                         floatingLabelBehavior: FloatingLabelBehavior.never,
//                         contentPadding: const EdgeInsets.symmetric(
//                             vertical: 8.0, horizontal: 18.0),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 4.0),
//                   Expanded(
//                     child: TextFormField(
//                       controller: _grNo,
//                       decoration: InputDecoration(
//                         labelText: 'GR No',
//                         hintText: 'GR No',
//                         fillColor: Colors.white,
//                         filled: true,
//                         labelStyle: const TextStyle(
//                             color: Colors.grey,
//                             fontSize: 18,
//                             fontWeight: FontWeight.normal),
//                         hintStyle: const TextStyle(
//                             color: Colors.grey,
//                             fontSize: 18,
//                             fontWeight: FontWeight.normal),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12.0),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12.0),
//                           borderSide: const BorderSide(color: Colors.blue),
//                         ),
//                         enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12.0),
//                           borderSide: const BorderSide(color: Colors.blue),
//                         ),
//                         floatingLabelBehavior: FloatingLabelBehavior.never,
//                         contentPadding: const EdgeInsets.symmetric(
//                             vertical: 8.0, horizontal: 18.0),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 6.0),
//               Row(
//                 children: [
//                   Expanded(
//                     child: ElevatedButton(
//                       onPressed: isLoading || isInitialLoading ? null : _clearSearch,
//                       style: ElevatedButton.styleFrom(
//                         foregroundColor: Colors.white,
//                         backgroundColor: AppColors.colorPrimary,
//                         padding: const EdgeInsets.symmetric(vertical: 12.0),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12.0),
//                         ),
//                       ),
//                       child: const Text('Clear', style: TextStyle(fontSize: 18)),
//                     ),
//                   ),
//                   const SizedBox(width: 6.0),
//                   Expanded(
//                     child: ElevatedButton(
//                       onPressed: isLoading || isInitialLoading ? null : (){
//                         if (_controller.text.isNotEmpty) {
//                           _handleSearch();
//                         } else if (_grNo.text.isNotEmpty) {
//                           _handleGrNoSearch();
//                         } else {
//                           _showSnackBar('Please enter a search term');
//                         }
//                       },
//                       style: ElevatedButton.styleFrom(
//                         foregroundColor: Colors.white,
//                         backgroundColor: AppColors.colorPrimary,
//                         padding: const EdgeInsets.symmetric(vertical: 12.0),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12.0),
//                         ),
//                       ),
//                       child: const Text('Search', style: TextStyle(fontSize: 18)),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 4.0),
//               _buildTransportDataView(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   void _showLogoutConfirmation() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           backgroundColor: Colors.white,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(10),
//           ),
//           content: const SizedBox(
//             width: 800,
//             child: Text('Are You Sure You Want to Exit?',
//                 style: TextStyle(fontSize: 16)),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.of(context).pop(),
//               child: const Text('CANCEL',
//                   style: TextStyle(color: Colors.blue)),
//             ),
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//                 Navigator.of(context).pushAndRemoveUntil(
//                   MaterialPageRoute(
//                     builder: (context) =>  LoginScreen(),
//                   ),
//                       (route) => false,
//                 );
//               },
//               child: const Text('CONFIRM',
//                   style: TextStyle(color: Colors.blue)),
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   Widget _buildTransportDataView() {
//     // Show initial loading indicator
//     if (isInitialLoading) {
//       return const Expanded(
//         child: Center(
//           child: CircularProgressIndicator(
//             valueColor: AlwaysStoppedAnimation<Color>(AppColors.colorPrimary),
//           ),
//         ),
//       );
//     }
//
//     // Show search loading indicator
//     if (isLoading) {
//       return const Expanded(
//         child: Center(
//           child: CircularProgressIndicator(
//             valueColor: AlwaysStoppedAnimation<Color>(AppColors.colorPrimary),
//           ),
//         ),
//       );
//     }
//
//     // Show empty state only if we have searched but found no results
//     if (hasSearched && filteredUsers.isEmpty) {
//       return const Expanded(
//         child: Center(
//           child: ErrorScreen(
//             errorImage: "assets/images/no_content.png",
//             titleMsg: "No Record Found",
//             msg: "",
//           ),
//         ),
//       );
//     }
//
//     // Show the data list
//     if (filteredUsers.isNotEmpty) {
//       return Expanded(
//         child: ListView.separated(
//           itemCount: filteredUsers.length,
//           separatorBuilder: (context, index) => const Divider(),
//           itemBuilder: (context, index) => _buildResultItem(filteredUsers[index]),
//         ),
//       );
//     }
//
//     // Default state (this shouldn't normally be reached)
//     return const Expanded(
//       child: Center(
//         child: Text('Welcome! Your transport data will appear here.'),
//       ),
//     );
//   }
//
//   Widget _buildResultItem(TransportModel1 user) {
//     return ListTile(
//       title:
//       InkWell(
//         onTap: () => _handleGPSTrackingClick(user.gPSTrackingLink),
//         child:
//         _buildInfoRow('GPS Tracking', user.gPSTrackingLink  ?? 'N/A'),
//       ),
//       subtitle: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           _buildInfoRow('GR No', user.gRNo ?? 'N/A'),
//           _buildInfoRow('GR Date.', formatDate(user.gRDate)),
//           _buildInfoRow('Container No.', user.containerNo ?? 'N/A'),
//           _buildInfoRow('Container Size.', user.size ?? 'N/A'),
//           _buildInfoRow('Consignee', user.consigneeName ?? 'N/A'),
//           _buildInfoRow('Consignor', user.consignorName ?? 'N/A'),
//           _buildInfoRow('Shipping Line.', user.shippingLineName ?? 'N/A'),
//           _buildInfoRow('Transaction Type', user.transactionType ?? 'N/A'),
//           _buildInfoRow('Document Type', user.documentType ?? 'N/A'),
//           _buildInfoRow('Terminal', user.terminal ?? 'N/A'),
//           _buildInfoRow('Cargo Description', user.cargoDescription ?? 'N/A'),
//           _buildInfoRow('Gross Weight(MT)', user.grossWeight.toString() ?? 'N/A'),
//           _buildInfoRow('CHA', user.cHAName ?? 'N/A'),
//           _buildInfoRow('DO Validity Date', formatDate(user.dOValidityDate)),
//           _buildInfoRow('DO Re-validity Date', formatDate(user.dORevalidityDate)),
//           _buildInfoRow('POL', user.pOL ?? 'N/A'),
//           _buildInfoRow('REDT', user.rEDT ?? 'N/A'),
//           _buildInfoRow('Shipping Bill No.', user.shippingBillNo ?? 'N/A'),
//           _buildInfoRow('B/L No.', user.bLNo ?? 'N/A'),
//           _buildInfoRow('Pickup Location', user.emptyPickDropLocation ?? 'N/A'),
//           _buildInfoRow('Route Name', user.roadRouteName ?? 'N/A'),
//           _buildInfoRow('Factory Plan Date', formatDate(user.factoryPlanDate)),
//           _buildInfoRow('Factory Plan Time', formatTime(user.factoryPlanTime)),
//           _buildInfoRow('Planned Pick Date', formatDate(user.loadingUnloadingPlanDate)),
//           _buildInfoRow('Vehicle No', user.vehicleNo ?? 'N/A'),
//           _buildInfoRow('Trip Start Date', formatDate(user.tripStartDateX0026Time)),
//           _buildInfoRow('Factory/Yard/ICD Arr \n Date Time', formatDate(user.factoryYardArrivalDatetime)),
//           _buildInfoRow('Factory/Yard/ICD\n Dpt Date Time', formatDate(user.factoryYardDepDatetime)),
//           _buildInfoRow('Port Gate In Date', formatDate(user.portYardInGatedDate)),
//         ],
//       ),
//       isThreeLine: true,
//       contentPadding: EdgeInsets.zero,
//     );
//   }
//
//   Widget _buildInfoRow(String label, String value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 0.0),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           SizedBox(
//             width: 150,
//             child: Text(
//               label,
//               style: TextStyle(
//                 color: Colors.blue[700],
//                 fontSize: 16,
//               ),
//             ),
//           ),
//           Expanded(
//             child: Text(
//               value,
//               style: TextStyle(
//                 color: Colors.grey[700],
//                 fontSize: 16,
//               ),
//               overflow: TextOverflow.visible,
//               softWrap: true,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//
//   String formatDate(String? date) {
//     if (date == null || date.isEmpty) return 'N/A';
//
//     // Directly check for the unwanted placeholder value
//     if (date == '0001-01-01' || date.startsWith('0001-01-01')) {
//       return '';
//     }
//
//     try {
//       final parsedDate = DateTime.parse(date);
//       return DateFormat('dd-MM-yyyy').format(parsedDate);
//     } catch (e) {
//       return 'Invalid Date';
//     }
//   }
//
//   String formatTime(String? time) {
//     if (time == null || time.isEmpty) return 'N/A';
//
//     if (time == '00:00:00') {
//       return ''; // Show "Not Set" instead of empty string
//     }
//
//     try {
//       final parts = time.split(':');
//       if (parts.length >= 2) {
//         final hour = int.parse(parts[0]);
//         final minute = int.parse(parts[1]);
//         return '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
//       }
//       return time;
//     } catch (e) {
//       return 'Invalid Time';
//     }
//   }
//
// }

class _Transport extends State<Transport> {
  String title = '';
  final String subtitle = "Transport Tracking";
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int selectedIndex = 0;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  List<TransportModel1> filteredUsers = [];
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _grNo = TextEditingController();
  String? userid;
  bool hasSearched = false;
  bool showInitialMessage = true;
  bool isLoading = false;
  // Remove isInitialLoading as we don't need it anymore

  final TransportApi transportApi = TransportApi();

  @override
  void initState() {
    super.initState();
    _loadUserId();
    _loadDynamicTitle();
  }

  @override
  void dispose() {
    _controller.dispose();
    _grNo.dispose();
    super.dispose();
  }

  Future<void> _loadUserId() async {
    try {
      userid = await StorageManager.readData('userid') as String?;
      if (userid == null) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Error: User ID is missing')),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading user ID: ${e.toString()}')),
        );
      }
    }
  }

  void _loadDynamicTitle() async {
    final fetchedTitle = await TitleManager.getTitle();
    setState(() {
      title = fetchedTitle;
    });
  }


  void _handleGPSTrackingClick(String? grNo) {
    if (grNo == null || grNo == 'N/A') return;

    // Copy to clipboard
    Clipboard.setData(ClipboardData(text: grNo));

    // Show confirmation
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Copied GPS Tracking No: $grNo')),
    );
  }

  void _handleSearch() async {
    final input = _controller.text.trim();
    if (input.isEmpty) {
      _showSnackBar('Please enter a container number');
      return;
    }

    try {
      if (mounted) {
        setState(() {
          isLoading = true;
          hasSearched = true;
          showInitialMessage = false; // Hide initial message when searching
        });
      }

      final results = await transportApi.fetchContainerNo(input);

      if (mounted) {
        setState(() {
          filteredUsers = results ?? [];
          isLoading = false;
        });
        if (filteredUsers.isEmpty) {
          _showSnackBar('No matching records found');
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          filteredUsers = [];
          isLoading = false;
        });
        _showSnackBar('Search failed: ${e.toString()}');
      }
    }
  }

  void _handleGrNoSearch() async {
    final input = _grNo.text.trim();
    if (input.isEmpty) {
      _showSnackBar('Please enter a GR NO');
      return;
    }

    try {
      if (mounted) {
        setState(() {
          isLoading = true;
          hasSearched = true;
          showInitialMessage = false; // Hide initial message when searching
        });
      }

      final result = await transportApi.fetchGrNo(input);

      if (mounted) {
        setState(() {
          filteredUsers = result ?? [];
          isLoading = false;
        });
        if (filteredUsers.isEmpty) {
          _showSnackBar('No matching records found');
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          filteredUsers = [];
          isLoading = false;
        });
        _showSnackBar('Search failed: ${e.toString()}');
      }
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void _clearSearch() {
    setState(() {
      _controller.clear();
      _grNo.clear();
      hasSearched = false;
      showInitialMessage = true; // Show initial message again
      filteredUsers = []; // Clear the results
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100.0),
        child: AppBar(
          backgroundColor: AppColors.colorPrimary,
          elevation: 0,
          automaticallyImplyLeading: false,
          flexibleSpace: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    color: AppColors.titlecolor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.menu, color: Colors.white),
                      onPressed: () {
                        _scaffoldKey.currentState?.openDrawer();
                      },
                    ),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () => _showLogoutConfirmation(),
                      child: Image.asset(
                        'assets/images/sign_out.png',
                        width: 30,
                        height: 30,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      drawer: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        child: CustomDrawer(
          selectedIndex: selectedIndex,
          onItemTap: (int index) {
            setState(() {
              selectedIndex = index;
            });
            _scaffoldKey.currentState?.openEndDrawer();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(7.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _controller,
                      decoration: InputDecoration(
                        labelText: 'Container No.',
                        hintText: 'Container No.',
                        fillColor: Colors.white,
                        filled: true,
                        labelStyle: const TextStyle(
                            color: Colors.grey,
                            fontSize: 18,
                            fontWeight: FontWeight.normal),
                        hintStyle: const TextStyle(
                            color: Colors.grey,
                            fontSize: 18,
                            fontWeight: FontWeight.normal),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: const BorderSide(color: Colors.blue),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: const BorderSide(color: Colors.blue),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 18.0),
                      ),
                    ),
                  ),
                  const SizedBox(width: 4.0),
                  Expanded(
                    child: TextFormField(
                      controller: _grNo,
                      decoration: InputDecoration(
                        labelText: 'GR No',
                        hintText: 'GR No',
                        fillColor: Colors.white,
                        filled: true,
                        labelStyle: const TextStyle(
                            color: Colors.grey,
                            fontSize: 18,
                            fontWeight: FontWeight.normal),
                        hintStyle: const TextStyle(
                            color: Colors.grey,
                            fontSize: 18,
                            fontWeight: FontWeight.normal),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: const BorderSide(color: Colors.blue),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: const BorderSide(color: Colors.blue),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 18.0),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6.0),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: isLoading ? null : _clearSearch,
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: AppColors.colorPrimary,
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                      child: const Text('Clear', style: TextStyle(fontSize: 18)),
                    ),
                  ),
                  const SizedBox(width: 6.0),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: isLoading ? null : (){
                        if (_controller.text.isNotEmpty) {
                          _handleSearch();
                        } else if (_grNo.text.isNotEmpty) {
                          _handleGrNoSearch();
                        } else {
                          _showSnackBar('Please enter a search term');
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: AppColors.colorPrimary,
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                      child: const Text('Search', style: TextStyle(fontSize: 18)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4.0),
              _buildTransportDataView(),
            ],
          ),
        ),
      ),
    );
  }

  void _showLogoutConfirmation() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          content: const SizedBox(
            width: 800,
            child: Text('Are You Sure You Want to Exit?',
                style: TextStyle(fontSize: 16)),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('CANCEL',
                  style: TextStyle(color: Colors.blue)),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) =>  LoginScreen(),
                  ),
                      (route) => false,
                );
              },
              child: const Text('CONFIRM',
                  style: TextStyle(color: Colors.blue)),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTransportDataView() {
    if (isLoading) {
      return const Expanded(
        child: Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.colorPrimary),
          ),
        ),
      );
    }

    if (showInitialMessage && !hasSearched) {
      return const Expanded(child: SizedBox()); // Return empty container instead of message
    }

    if (hasSearched && filteredUsers.isEmpty) {
      return const Expanded(
        child: Center(
          child: ErrorScreen(
            errorImage: "assets/images/no_content.png",
            titleMsg: "No Record Found",
            msg: "",
          ),
        ),
      );
    }

    if (filteredUsers.isNotEmpty) {
      return Expanded(
        child: ListView.separated(
          itemCount: filteredUsers.length,
          separatorBuilder: (context, index) => const Divider(),
          itemBuilder: (context, index) =>
              _buildResultItem(filteredUsers[index]),
        ),
      );
    }

    return const Expanded(child: SizedBox()); // Fallback empty widget
  }


  Widget _buildResultItem(TransportModel1 user) {
    return ListTile(
      title:
      InkWell(
        onTap: () => _handleGPSTrackingClick(user.gPSTrackingLink),
        child:
        _buildInfoRow('GPS Tracking', user.gPSTrackingLink  ?? 'N/A'),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfoRow('GR No', user.gRNo ?? 'N/A'),
          _buildInfoRow('GR Date.', formatDate(user.gRDate)),
          _buildInfoRow('Container No.', user.containerNo ?? 'N/A'),
          _buildInfoRow('Container Size.', user.size ?? 'N/A'),
          _buildInfoRow('Consignee', user.consigneeName ?? 'N/A'),
          _buildInfoRow('Consignor', user.consignorName ?? 'N/A'),
          _buildInfoRow('Shipping Line.', user.shippingLineName ?? 'N/A'),
          _buildInfoRow('Transaction Type', user.transactionType ?? 'N/A'),
          _buildInfoRow('Document Type', user.documentType ?? 'N/A'),
          _buildInfoRow('Terminal', user.terminal ?? 'N/A'),
          _buildInfoRow('Cargo Description', user.cargoDescription ?? 'N/A'),
          _buildInfoRow('Gross Weight(MT)', user.grossWeight.toString() ?? 'N/A'),
          _buildInfoRow('CHA', user.cHAName ?? 'N/A'),
          _buildInfoRow('DO Validity Date', formatDate(user.dOValidityDate)),
          _buildInfoRow('DO Re-validity Date', formatDate(user.dORevalidityDate)),
          _buildInfoRow('POL', user.pOL ?? 'N/A'),
          _buildInfoRow('REDT', user.rEDT ?? 'N/A'),
          _buildInfoRow('Shipping Bill No.', user.shippingBillNo ?? 'N/A'),
          _buildInfoRow('B/L No.', user.bLNo ?? 'N/A'),
          _buildInfoRow('Pickup Location', user.emptyPickDropLocation ?? 'N/A'),
          _buildInfoRow('Route Name', user.roadRouteName ?? 'N/A'),
          _buildInfoRow('Factory Plan Date', formatDate(user.factoryPlanDate)),
          _buildInfoRow('Factory Plan Time', formatTime(user.factoryPlanTime)),
          _buildInfoRow('Planned Pick Date', formatDate(user.loadingUnloadingPlanDate)),
          _buildInfoRow('Vehicle No', user.vehicleNo ?? 'N/A'),
          _buildInfoRow('Trip Start Date', formatDate(user.tripStartDateX0026Time)),
          _buildInfoRow('Factory/Yard/ICD Arr \n Date Time', formatDate(user.factoryYardArrivalDatetime)),
          _buildInfoRow('Factory/Yard/ICD\n Dpt Date Time', formatDate(user.factoryYardDepDatetime)),
          _buildInfoRow('Port Gate In Date', formatDate(user.portYardInGatedDate)),
        ],
      ),
      isThreeLine: true,
      contentPadding: EdgeInsets.zero,
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 150,
            child: Text(
              label,
              style: TextStyle(
                color: Colors.blue[700],
                fontSize: 16,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: 16,
              ),
              overflow: TextOverflow.visible,
              softWrap: true,
            ),
          ),
        ],
      ),
    );
  }


  String formatDate(String? date) {
    if (date == null || date.isEmpty) return 'N/A';

    // Directly check for the unwanted placeholder value
    if (date == '0001-01-01' || date.startsWith('0001-01-01')) {
      return '';
    }

    try {
      final parsedDate = DateTime.parse(date);
      return DateFormat('dd-MM-yyyy').format(parsedDate);
    } catch (e) {
      return 'Invalid Date';
    }
  }

  String formatTime(String? time) {
    if (time == null || time.isEmpty) return 'N/A';

    if (time == '00:00:00') {
      return ''; // Show "Not Set" instead of empty string
    }

    try {
      final parts = time.split(':');
      if (parts.length >= 2) {
        final hour = int.parse(parts[0]);
        final minute = int.parse(parts[1]);
        return '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
      }
      return time;
    } catch (e) {
      return 'Invalid Time';
    }
  }

}
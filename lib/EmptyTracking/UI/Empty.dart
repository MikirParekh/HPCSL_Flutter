// import 'package:flutter/material.dart';
// import 'package:hpcsl_1/EmptyTracking/Model/Empty_model.dart';
// import 'package:hpcsl_1/colors.dart';
// import 'package:intl/intl.dart';
//
// import '../../Drawer.dart';
// import '../../NoRecordFound.dart';
// import '../../SharedPreference.dart';
// import '../../Sign In/UI/login.dart';
//
// class Empty extends StatefulWidget {
//   const Empty({super.key});
//
//   @override
//   State<Empty> createState() => _Empty();
// }
//
// class EmptyException implements Exception {
//   final String message;
//   const EmptyException(this.message);
//
//   @override
//   String toString() => "EmptyException: $message";
// }
//
// class _Empty extends State<Empty> {
//   final String title = "AIA ENGINEERING LTD";
//   final String subtitle = "Empty Tracking";
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//   int selectedIndex = 0;
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); // Added form key
//   late List<EmptyTrackingModel1> importDataList;
//
//   List<EmptyTrackingModel1> users = [];
//   bool isLoading = false;
//   final TextEditingController _controller = TextEditingController();
//   final TextEditingController _DoNo = TextEditingController();
//   List<EmptyTrackingModel1> filteredUsers = [];
//   String? userid;
//
//   EmptyTrackingApi  empty = EmptyTrackingApi();
//
//   @override
//   void initState() {
//     super.initState();
//     _loadUserId();
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     _DoNo.dispose();
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
//       fetchEmptyData();
//     }
//   }
//
//   Future<void> fetchEmptyData() async {
//     // setState(() => isLoading = true);
//     try {
//       final response = await EmptyTrackingApi().fetchFilteredEmptyTracking(context,userid ?? '');
//
//       if (mounted) {
//         setState(() {
//           users = response.value ?? [];
//         });
//       }
//     } catch (e) {
//       if (mounted) {
//
//       }
//     } finally {
//       if (mounted) {
//         setState(() => isLoading = false);
//       }
//     }
//   }
//
//   void _handleSearch() async {
//     String input = _controller.text.trim().toUpperCase();
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
//       isLoading = true;
//     });
//
//     try {
//       final response = await empty.fetchContainerNoWithSearch(context, input);
//
//       if (mounted) {
//         setState(() {
//           if (response.value != null) {
//             filteredUsers = response.value!.where((user) =>
//             (user.containerNo?.toUpperCase() ?? '') == input).toList();
//
//             if (filteredUsers.isEmpty) {
//
//             }
//           } else {
//             filteredUsers = [];
//
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
//   void _handleDoNoSearch() async {
//     String input = _DoNo.text.trim().toUpperCase();
//
//     if (input.isEmpty) {
//       setState(() {
//         filteredUsers = [];
//       });
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Please enter a Do No.')),
//       );
//       return;
//     }
//
//     setState(() {
//       isLoading = true;
//     });
//
//     try {
//       final response = await empty.fetchDonoWithSearch(context, input);
//
//       if (mounted) {
//         setState(() {
//           if (response.value != null) {
//             filteredUsers = response.value!.where((user) =>
//             (user.dONo?.toUpperCase() ?? '') == input).toList();
//
//             if (filteredUsers.isEmpty) {
//             }
//           } else {
//             filteredUsers = [];
//             ScaffoldMessenger.of(context).showSnackBar(
//               const SnackBar(content: Text('Error fetching Do No details')),
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
//             _scaffoldKey.currentState?.openEndDrawer();
//           },
//         ),
//       ),
//       body:
//       Padding(
//         padding: const EdgeInsets.all(16.0),
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
//                       controller: _DoNo,
//                       decoration: InputDecoration(
//                         labelText: 'Do No.',
//                         hintText: 'Do No.',
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
//                           _DoNo.clear();
//                           filteredUsers = [];
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
//                         } else if (_DoNo.text.isNotEmpty) {
//                           _handleDoNoSearch();
//                         } else {
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             const SnackBar(
//                                 content: Text(
//                                   'Please enter value',textAlign: TextAlign.center,)),
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
//               Emptydata(context),
//
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//
//   Widget Emptydata(BuildContext context) {
//     final dataToShow =
//     (_controller.text.isNotEmpty || _DoNo.text.isNotEmpty) ? filteredUsers : [];
//     return Expanded(
//       flex: 2,
//       child: isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : _controller.text.isEmpty || _DoNo.text.isEmpty
//           ? const Center(child:Text(''))
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
//         separatorBuilder: (context, index) => const Divider(
//           color: Colors.grey,
//           thickness: 1.0,
//           height: 1.0,
//         ),
//         itemBuilder: (context, index) {
//           final user = dataToShow[index];
//           return ListTile(
//             title: _buildInfoRow('Container No', user.containerNo ?? 'N/A'),
//             subtitle: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 _buildInfoRow('Size', user.size ?? 'N/A'),
//                 _buildInfoRow('Do No ', user.dONo ?? 'N/A'),
//                 _buildInfoRow('Permission No', user.permissionNo ?? 'N/A'),
//                 _buildInfoRow('Booking Date', formatDate(user.dODate)),
//                 _buildInfoRow('Type', user.type ?? 'N/A'),
//                 _buildInfoRow('Shipping Line Name', user.shippingLineName ?? 'N/A'),
//                 _buildInfoRow('Terminal', user.terminal ?? 'N/A'),
//                 _buildInfoRow('Mode', user.mode ?? 'N/A'),
//                 _buildInfoRow('Rake No', formatDate(user.rakeNo)),
//                 _buildInfoRow('Vehicle No', user.vehicleNo ?? 'N/A'),
//                 _buildInfoRow('Booking Type', user.bookingType ?? 'N/A'),
//                 _buildInfoRow('DO Validity Date', formatDate(user.dOValidityDate)),
//                 _buildInfoRow('DO Re-Validity Date', formatDate(user.dOReValidityDate)),
//                 _buildInfoRow('ICD Arrival Date', formatDate(user.arrivalDate)),
//                 _buildInfoRow('ICD Out Date', formatDate(user.outDate)),
//               ],
//             ),
//             isThreeLine: true,
//             contentPadding: EdgeInsets.zero,
//           );
//         },
//       ),
//     );
//   }
//
//   Widget _buildInfoRow(String label, String value) {
//     return Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           SizedBox(
//             width: 150, // Fixed width for the label
//             child: Text(
//               label,
//               style:TextStyle(
//                 color: Colors.blue[700],
//                 fontSize: 16,
//               ),
//             ),
//           ),
//           Expanded(
//             child: Text(
//               value,
//               style:TextStyle(
//                 color: Colors.grey[700],
//                 fontSize: 16,
//               ),
//               overflow: TextOverflow.visible, // Allow text to display fully
//               softWrap: true, // Enable text wrapping// Ensure value remains in one line
//             ),
//           ),
//         ],
//       );
//   }
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
//
//
// }

// import 'package:flutter/material.dart';
// import 'package:hpcsl_1/colors.dart';
// import '../../Drawer.dart';
// import '../../NoRecordFound.dart';
// import '../../SharedPreference.dart';
// import '../../Sign In/UI/login.dart';
// import 'package:intl/intl.dart';
//
// import '../Model/Empty_model.dart';
// import '../Repo/EmptyTrackingRepositry.dart';
//
// class Empty extends StatefulWidget {
//   const Empty({super.key});
//
//   @override
//   State<Empty> createState() => _Empty();
// }
//
// class EmptyException implements Exception {
//   final String message;
//   const EmptyException(this.message);
//
//   @override
//   String toString() => "Empty Exception: $message";
// }
//
// class _Empty extends State<Empty> {
//   final String title = "AIA ENGINEERING LTD";
//   final String subtitle = "Empty Tracking";
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//   int selectedIndex = 0;
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//
//   List<EmptyTrackingModel1> filteredUsers = [];
//   final TextEditingController _controller = TextEditingController();
//   final TextEditingController _doNo = TextEditingController();
//   String? userid;
//   bool hasSearched = false;
//   bool showInitialMessage = true;
//   bool isLoading = false;
//
//
//   final EmptyTrackingApi emptyApi = EmptyTrackingApi();
//
//   @override
//   void initState() {
//     super.initState();
//     _loadUserId();
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     _doNo.dispose();
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
//       final results = await emptyApi.fetchContainerNo(input);
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
//   void _handleDoNoSearch() async {
//     final input = _doNo.text.trim();
//     if (input.isEmpty) {
//       _showSnackBar('Please enter a Do No number');
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
//       final results = await emptyApi.fetchDoNo(input);
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
//       _doNo.clear();
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
//                       controller: _doNo,
//                       decoration: InputDecoration(
//                         labelText: 'Do No.',
//                         hintText: 'Do No.',
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
//                       onPressed: isLoading ? null : () {
//                         if (_controller.text.isNotEmpty) {
//                           _handleSearch();
//                         } else if (_doNo.text.isNotEmpty) {
//                           _handleDoNoSearch();
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
//               _buildEmptyDataView(),
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
//   Widget _buildEmptyDataView() {
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
//   Widget _buildResultItem(EmptyTrackingModel1 user) {
//     return ListTile(
//             title: _buildInfoRow('Container No', user.containerNo ?? 'N/A'),
//             subtitle: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 _buildInfoRow('Size', user.size ?? 'N/A'),
//                 _buildInfoRow('Do No ', user.dONo ?? 'N/A'),
//                 _buildInfoRow('Permission No', user.permissionNo ?? 'N/A'),
//                 _buildInfoRow('Booking Date', formatDate(user.dODate)),
//                 _buildInfoRow('Type', user.type ?? 'N/A'),
//                 _buildInfoRow('Shipping Line Name', user.shippingLineName ?? 'N/A'),
//                 _buildInfoRow('Terminal', user.terminal ?? 'N/A'),
//                 _buildInfoRow('Mode', user.mode ?? 'N/A'),
//                 _buildInfoRow('Rake No', formatDate(user.rakeNo)),
//                 _buildInfoRow('Vehicle No', user.vehicleNo ?? 'N/A'),
//                 _buildInfoRow('Booking Type', user.bookingType ?? 'N/A'),
//                 _buildInfoRow('DO Validity Date', formatDate(user.dOValidityDate)),
//                 _buildInfoRow('DO Re-Validity Date', formatDate(user.dOReValidityDate)),
//                 _buildInfoRow('ICD Arrival Date', formatDate(user.arrivalDate)),
//                 _buildInfoRow('ICD Out Date', formatDate(user.outDate)),
//               ],
//             ),
//             isThreeLine: true,
//             contentPadding: EdgeInsets.zero,
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

// import 'package:flutter/material.dart';
// import 'package:hpcsl_1/colors.dart';
// import '../../Drawer.dart';
// import '../../NoRecordFound.dart';
// import '../../SharedPreference.dart';
// import '../../Sign In/UI/login.dart';
// import 'package:intl/intl.dart';
//
// import '../../TitleManager.dart';
// import '../Model/Empty_model.dart';
// import '../Repo/EmptyTrackingRepositry.dart';
//
// class Empty extends StatefulWidget {
//   const Empty({super.key});
//
//   @override
//   State<Empty> createState() => _Empty();
// }
//
// class EmptyException implements Exception {
//   final String message;
//   const EmptyException(this.message);
//
//   @override
//   String toString() => "Empty Exception: $message";
// }
//
// class _Empty extends State<Empty> {
//   String title = '';
//   final String subtitle = "Empty Tracking";
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//   int selectedIndex = 0;
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//
//   List<EmptyTrackingModel1> filteredUsers = [];
//   List<EmptyTrackingModel1> allUsers = []; // Store all data
//   final TextEditingController _controller = TextEditingController();
//   final TextEditingController _doNo = TextEditingController();
//   String? userid;
//   bool hasSearched = false;
//   bool showInitialMessage = true;
//   bool isLoading = false;
//
//   final EmptyTrackingApi emptyApi = EmptyTrackingApi();
//
//   @override
//   void initState() {
//     super.initState();
//     _loadDynamicTitle();
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     _doNo.dispose();
//     super.dispose();
//   }
//
//   // Initialize user ID first, then load data
//   Future<void> _initializeData() async {
//     await _loadUserId(); // Wait for user ID to be loaded
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
//   // Load initial data when screen opens
//   Future<void> _loadInitialData() async {
//     if (userid == null) {
//       print('User ID is null, cannot load data');
//       return;
//     }
//
//     try {
//       if (mounted) {
//         setState(() {
//           isLoading = true;
//           showInitialMessage = false;
//         });
//       }
//
//       print('Loading initial data for user: $userid');
//
//       // Use existing method to fetch all records for the user
//       final results = await emptyApi.fetchTransportDataShippingLineNo();
//
//       print('API returned ${results.length} records');
//
//       if (mounted) {
//         setState(() {
//           allUsers = results;
//           filteredUsers = allUsers; // Show all data initially
//           isLoading = false;
//         });
//       }
//     } catch (e) {
//       print('Error loading initial data: ${e.toString()}');
//       if (mounted) {
//         setState(() {
//           allUsers = [];
//           isLoading = false;
//         });
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Error loading data: ${e.toString()}')),
//         );
//       }
//     }
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
//       final results = await emptyApi.fetchContainerNo(input);
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
//   void _handleDoNoSearch() async {
//     final input = _doNo.text.trim();
//     if (input.isEmpty) {
//       _showSnackBar('Please enter a Do No number');
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
//       final results = await emptyApi.fetchDoNo(input);
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
//   void _loadDynamicTitle() async {
//     final fetchedTitle = await TitleManager.getTitle();
//     setState(() {
//       title = fetchedTitle;
//     });
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
//       _doNo.clear();
//       filteredUsers = allUsers; // Reset to show all data
//       hasSearched = false;
//       showInitialMessage = false; // Keep showing data
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
//                       controller: _doNo,
//                       decoration: InputDecoration(
//                         labelText: 'Do No.',
//                         hintText: 'Do No.',
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
//                       onPressed: isLoading ? null : () {
//                         if (_controller.text.isNotEmpty) {
//                           _handleSearch();
//                         } else if (_doNo.text.isNotEmpty) {
//                           _handleDoNoSearch();
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
//               _buildEmptyDataView(),
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
//   Widget _buildEmptyDataView() {
//     // Show loading indicator
//     if (isLoading) {
//       return const Expanded(
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               CircularProgressIndicator(),
//               SizedBox(height: 16),
//               Text('Loading data...', style: TextStyle(fontSize: 16)),
//             ],
//           ),
//         ),
//       );
//     }
//
//     // Show no records found
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
//     // Show the data
//     return Expanded(
//       child: Column(
//         children: [
//           // Show count of records
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Text(
//               'Found ${filteredUsers.length} records',
//               style: const TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.w500,
//                 color: Colors.grey,
//               ),
//             ),
//           ),
//           Expanded(
//             child: ListView.separated(
//               itemCount: filteredUsers.length,
//               separatorBuilder: (context, index) => const Divider(),
//               itemBuilder: (context, index) => _buildResultItem(filteredUsers[index]),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildResultItem(EmptyTrackingModel1 user) {
//     return ListTile(
//       title: _buildInfoRow('Container No', user.containerNo ?? 'N/A'),
//       subtitle: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           _buildInfoRow('Size', user.size ?? 'N/A'),
//           _buildInfoRow('Do No ', user.dONo ?? 'N/A'),
//           _buildInfoRow('Permission No', user.permissionNo ?? 'N/A'),
//           _buildInfoRow('Booking Date', formatDate(user.dODate)),
//           _buildInfoRow('Type', user.type ?? 'N/A'),
//           _buildInfoRow('Shipping Line Name', user.shippingLineName ?? 'N/A'),
//           _buildInfoRow('Terminal', user.terminal ?? 'N/A'),
//           _buildInfoRow('Mode', user.mode ?? 'N/A'),
//           _buildInfoRow('Rake No', formatDate(user.rakeNo)),
//           _buildInfoRow('Vehicle No', user.vehicleNo ?? 'N/A'),
//           _buildInfoRow('Booking Type', user.bookingType ?? 'N/A'),
//           _buildInfoRow('DO Validity Date', formatDate(user.dOValidityDate)),
//           _buildInfoRow('DO Re-Validity Date', formatDate(user.dOReValidityDate)),
//           _buildInfoRow('ICD Arrival Date', formatDate(user.arrivalDate)),
//           _buildInfoRow('ICD Out Date', formatDate(user.outDate)),
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

// Keep all your imports same
import 'package:flutter/material.dart';
import 'package:hpcsl_1/colors.dart';
import '../../Drawer.dart';
import '../../NoRecordFound.dart';
import '../../SharedPreference.dart';
import '../../Sign In/UI/login.dart';
import 'package:intl/intl.dart';

import '../../TitleManager.dart';
import '../Model/Empty_model.dart';
import '../Repo/EmptyTrackingRepositry.dart';

class Empty extends StatefulWidget {
  const Empty({super.key});

  @override
  State<Empty> createState() => _Empty();
}

class _Empty extends State<Empty> {
  String title = '';
  final String subtitle = "Empty Tracking";
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int selectedIndex = 0;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  List<EmptyTrackingModel1> filteredUsers = [];
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _doNo = TextEditingController();
  String? userid;
  bool hasSearched = false;
  bool isLoading = false;

  final EmptyTrackingApi emptyApi = EmptyTrackingApi();

  @override
  void initState() {
    super.initState();
    _loadUserId(); // Only load userid on start
    _loadDynamicTitle();
  }

  @override
  void dispose() {
    _controller.dispose();
    _doNo.dispose();
    super.dispose();
  }

  Future<void> _loadUserId() async {
    try {
      userid = await StorageManager.readData('userid') as String?;
      if (userid == null && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error: User ID is missing')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading user ID: ${e.toString()}')),
        );
      }
    }
  }

  void _handleSearch() async {
    final input = _controller.text.trim();
    if (input.isEmpty) {
      _showSnackBar('Please enter a container number');
      return;
    }

    try {
      setState(() {
        isLoading = true;
        hasSearched = true;
      });

      final results = await emptyApi.fetchContainerNo(input);
      setState(() {
        filteredUsers = results ?? [];
        isLoading = false;
      });

      if (filteredUsers.isEmpty) {
        _showSnackBar('No matching records found');
      }
    } catch (e) {
      setState(() {
        filteredUsers = [];
        isLoading = false;
      });
      _showSnackBar('Search failed: ${e.toString()}');
    }
  }

  void _handleDoNoSearch() async {
    final input = _doNo.text.trim();
    if (input.isEmpty) {
      _showSnackBar('Please enter a Do No number');
      return;
    }

    try {
      setState(() {
        isLoading = true;
        hasSearched = true;
      });

      final results = await emptyApi.fetchDoNo(input);
      setState(() {
        filteredUsers = results ?? [];
        isLoading = false;
      });

      if (filteredUsers.isEmpty) {
        _showSnackBar('No matching records found');
      }
    } catch (e) {
      setState(() {
        filteredUsers = [];
        isLoading = false;
      });
      _showSnackBar('Search failed: ${e.toString()}');
    }
  }

  void _clearSearch() {
    setState(() {
      _controller.clear();
      _doNo.clear();
      filteredUsers = [];
      hasSearched = false;
    });
  }

  void _loadDynamicTitle() async {
    final fetchedTitle = await TitleManager.getTitle();
    setState(() {
      title = fetchedTitle;
    });
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
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
                      decoration: _inputDecoration('Container No.'),
                    ),
                  ),
                  const SizedBox(width: 4.0),
                  Expanded(
                    child: TextFormField(
                      controller: _doNo,
                      decoration: _inputDecoration('Do No.'),
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
                      style: _buttonStyle(),
                      child: const Text('Clear', style: TextStyle(fontSize: 18)),
                    ),
                  ),
                  const SizedBox(width: 6.0),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: isLoading
                          ? null
                          : () {
                        if (_controller.text.isNotEmpty) {
                          _handleSearch();
                        } else if (_doNo.text.isNotEmpty) {
                          _handleDoNoSearch();
                        } else {
                          _showSnackBar('Please enter a search term');
                        }
                      },
                      style: _buttonStyle(),
                      child: const Text('Search', style: TextStyle(fontSize: 18)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4.0),
              _buildEmptyDataView(),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      hintText: label,
      fillColor: Colors.white,
      filled: true,
      labelStyle: const TextStyle(color: Colors.grey, fontSize: 18),
      hintStyle: const TextStyle(color: Colors.grey, fontSize: 18),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(color: Colors.blue),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(color: Colors.blue),
      ),
      floatingLabelBehavior: FloatingLabelBehavior.never,
      contentPadding:
      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 18.0),
    );
  }

  ButtonStyle _buttonStyle() {
    return ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: AppColors.colorPrimary,
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
    );
  }

  Widget _buildEmptyDataView() {
    // Show nothing before searching
    if (!hasSearched) {
      return const SizedBox(); // or Expanded(child: SizedBox()) if you want spacing
    }

    // Show loader while fetching
    if (isLoading) {
      return const Expanded(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text('Loading data...', style: TextStyle(fontSize: 16)),
            ],
          ),
        ),
      );
    }

    // Show "No Data Found" only after search
    if (filteredUsers.isEmpty) {
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

    // Show result list
    return Expanded(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Found ${filteredUsers.length} records',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: filteredUsers.length,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) =>
                  _buildResultItem(filteredUsers[index]),
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildResultItem(EmptyTrackingModel1 user) {
    return ListTile(
      title: _buildInfoRow('Container No', user.containerNo ?? 'N/A'),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfoRow('Size', user.size ?? 'N/A'),
          _buildInfoRow('Do No ', user.dONo ?? 'N/A'),
          _buildInfoRow('Permission No', user.permissionNo ?? 'N/A'),
          _buildInfoRow('Booking Date', formatDate(user.dODate)),
          _buildInfoRow('Type', user.type ?? 'N/A'),
          _buildInfoRow('Shipping Line Name', user.shippingLineName ?? 'N/A'),
          _buildInfoRow('Terminal', user.terminal ?? 'N/A'),
          _buildInfoRow('Mode', user.mode ?? 'N/A'),
          _buildInfoRow('Rake No', formatDate(user.rakeNo)),
          _buildInfoRow('Vehicle No', user.vehicleNo ?? 'N/A'),
          _buildInfoRow('Booking Type', user.bookingType ?? 'N/A'),
          _buildInfoRow('DO Validity Date', formatDate(user.dOValidityDate)),
          _buildInfoRow('DO Re-Validity Date', formatDate(user.dOReValidityDate)),
          _buildInfoRow('ICD Arrival Date', formatDate(user.arrivalDate)),
          _buildInfoRow('ICD Out Date', formatDate(user.outDate)),
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
              style: TextStyle(color: Colors.blue[700], fontSize: 16),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(color: Colors.grey[700], fontSize: 16),
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
              child:
              const Text('CANCEL', style: TextStyle(color: Colors.blue)),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                      (route) => false,
                );
              },
              child:
              const Text('CONFIRM', style: TextStyle(color: Colors.blue)),
            ),
          ],
        );
      },
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:hpcsl_1/colors.dart';
// import 'package:intl/intl.dart';
//
// import '../../Drawer.dart';
// import '../../NoRecordFound.dart';
// import '../../SharedPreference.dart';
// import '../../Sign In/UI/login.dart';
// import '../../TokenRepo.dart';
// import '../Model/Invoice_Model.dart';
// import '../Repo/InvoiceRepositry.dart';
// import 'EmailViewModel.dart';
//
//
// class Invoice extends StatefulWidget {
//   const Invoice({super.key});
//
//   @override
//   State<Invoice> createState() => _Invoice();
// }
//
// class InvoiceException implements Exception {
//   final String message;
//   const InvoiceException(this.message);
//
//   @override
//   String toString() => "DomesticException: $message";
// }
//
// class _Invoice extends State<Invoice> {
//   final String title = "AIA ENGINEERING LTD";
//   final String subtitle = "Invoice Tracking";
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//   int selectedIndex = 0;
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   late List<InvoiceModel1> importDataList;
//   String? userid;
//
//   List<InvoiceModel1> users = [];
//   bool isLoading = false;
//   final TextEditingController _invoiceno = TextEditingController();
//   final TextEditingController _shippingbillno = TextEditingController();
//   final TextEditingController _fromdate = TextEditingController();
//   final TextEditingController _todate = TextEditingController();
//   final TextEditingController _blno= TextEditingController();
//
//   late EmailViewModel emailViewModel;
//
//   InvoiceApi download=InvoiceApi();
//
//
//   List<InvoiceModel1> filteredUsers = [];
//   bool hasSearched = false;
//
//   InvoiceApi invoice = InvoiceApi();
//
//   @override
//   void initState() {
//     super.initState();
//     final emailRepo =InvoiceApi();
//     emailViewModel = EmailViewModel(emailRepo);
//     _loadUserId();
//   }
//
//   @override
//   void dispose() {
//     _invoiceno.dispose();
//     _shippingbillno .dispose();
//     _fromdate.dispose();
//     _todate.dispose();
//     _blno.dispose();
//     emailViewModel.dispose();
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
//   void _handleInvoiceNo() async {
//     final input = _invoiceno.text.trim();
//     if (input.isEmpty) {
//       _showSnackBar('Please enter a Invoice number');
//       return;
//     }
//
//     try {
//       final result = await invoice.fetchInvoiceByNo(input);
//       if (mounted) {
//         setState(() {
//           filteredUsers = result ?? [];
//           hasSearched = true;
//         });
//         if (filteredUsers.isEmpty) {
//           _showSnackBar('No matching records found');
//         }
//       }
//     } catch (e) {
//       if (mounted) {
//         setState(() => filteredUsers = []);
//         _showSnackBar('Search failed: ${e.toString()}');
//       }
//     }
//   }
//
//   void _handleShippingBLSearch() async {
//     final input = _shippingbillno.text.trim();
//     if (input.isEmpty) {
//       _showSnackBar('Please enter a Shipping Bill number');
//       return;
//     }
//
//     try {
//       final result = await invoice.fetchInvoiceByShippingBillNo(input);
//       if (mounted) {
//         setState(() {
//           filteredUsers = result ?? [];
//           hasSearched = true;
//         });
//         if (filteredUsers.isEmpty) {
//           _showSnackBar('No matching records found');
//         }
//       }
//     } catch (e) {
//       if (mounted) {
//         setState(() => filteredUsers = []);
//         _showSnackBar('Search failed: ${e.toString()}');
//       }
//     }
//   }
//
//   // void _handlefromdate() async {
//   //   final input = _fromdate.text.trim();
//   //   if (input.isEmpty) {
//   //     _showSnackBar('Please enter a date');
//   //     return;
//   //   }
//   //
//   //   try {
//   //     final result = await invoice.fetchPostingDate(input);
//   //     if (mounted) {
//   //       setState(() {
//   //         filteredUsers = result ?? [];
//   //         hasSearched = true;
//   //       });
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
//   //
//   // void _handletodate() async {
//   //   final input = _todate.text.trim();
//   //   if (input.isEmpty) {
//   //     _showSnackBar('Please enter a date');
//   //     return;
//   //   }
//   //
//   //   try {
//   //     final result = await invoice.fetchPostingDate(input);
//   //     if (mounted) {
//   //       setState(() {
//   //         filteredUsers = result ?? [];
//   //         hasSearched = true;
//   //       });
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
//   void _handleDateRangeSearch() async{
//     final fromDate=_fromdate.text.trim();
//     final toDate=_todate.text.trim();
//
//     if(fromDate.isEmpty || toDate.isEmpty){
//       _showSnackBar('Please select both From Date and To Date');
//       return;
//     }
//     try {
//       final result = await invoice.fetchInvoiceByDateRange(fromDate, toDate);
//       if (mounted) {
//         setState(() {
//           filteredUsers = result ?? [];
//           hasSearched = true;
//         });
//         if (filteredUsers.isEmpty) {
//           _showSnackBar('No records found for the selected date range');
//         }
//       }
//     } catch (e) {
//       if (mounted) {
//         setState(() => filteredUsers = []);
//         _showSnackBar('Search failed: ${e.toString()}');
//       }
//     }
//   }
//
//   void _handleBLSearch() async {
//     final input = _blno.text.trim();
//     if (input.isEmpty) {
//       _showSnackBar('Please enter a Bill Numbers');
//       return;
//     }
//
//     try {
//       final result = await invoice.fetchInvoiceByBLNo(input);
//       if (mounted) {
//         setState(() {
//           filteredUsers = result ?? [];
//           hasSearched = true;
//         });
//         if (filteredUsers.isEmpty) {
//           _showSnackBar('No matching records found');
//         }
//       }
//     } catch (e) {
//       if (mounted) {
//         setState(() => filteredUsers = []);
//         _showSnackBar('Search failed: ${e.toString()}');
//       }
//     }
//   }
//
//
//
//   void _showSnackBar(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text(message)),
//     );
//   }
//
//   void _handleEmailSend(String invoiceNo) async {
//     final emailRepo = InvoiceApi();
//     final emailViewModel = EmailViewModel(emailRepo);
//
//     // Show loading indicator
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(
//         content: Row(
//           children: [
//             SizedBox(width: 16),
//             Text('Sending email...'),
//           ],
//         ),
//         duration: Duration(seconds: 30),
//       ),
//     );
//
//     try {
//       await emailViewModel.sendEmail(invoiceNo);
//
//       // Dismiss loading snackbar
//       ScaffoldMessenger.of(context).hideCurrentSnackBar();
//
//       if (emailViewModel.success) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Row(
//               children: [
//                 Icon(Icons.check_circle, color: Colors.white),
//                 SizedBox(width: 16),
//                 Text('Email sent successfully!'),
//               ],
//             ),
//             backgroundColor: Colors.green,
//             duration: Duration(seconds: 3),
//           ),
//         );
//       } else {
//         throw Exception(emailViewModel.error ?? 'Failed to send email');
//       }
//     } catch (e) {
//       // Dismiss loading snackbar
//       ScaffoldMessenger.of(context).hideCurrentSnackBar();
//
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Row(
//             children: [
//               const Icon(Icons.error, color: Colors.white),
//               const SizedBox(width: 16),
//               Expanded(
//                 child: Text(
//                   'Email failed: ${e.toString().replaceAll('Exception:', '').trim()}',
//                   maxLines: 2,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//               ),
//             ],
//           ),
//           backgroundColor: Colors.red,
//           duration: const Duration(seconds: 5),
//         ),
//       );
//     }
//   }
//
//
//
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
//       body: Padding(
//         padding: const EdgeInsets.all(7.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               Row(
//                 children: [
//                   Expanded(
//                     flex: 2,
//                     child: TextFormField(
//                       controller: _invoiceno,
//                       decoration: InputDecoration(
//                         labelText: 'Invoice No.',
//                         hintText: 'Invoice No.',
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
//                   const SizedBox(width: 5.0), // Add space between the fields
//
//                   Expanded(
//                     child: TextFormField(
//                       controller:_fromdate,
//                       decoration: InputDecoration(
//                         labelText: 'From Date',
//                         hintText: 'From Date',
//                         fillColor: Colors.white,
//                         filled: true,
//                         labelStyle: const TextStyle(color: Colors.grey,fontSize: 9, fontWeight: FontWeight.normal),
//                         hintStyle: const TextStyle(color: Colors.grey, fontSize: 10, fontWeight: FontWeight.normal),
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
//                       onTap: ()async{
//                         DateTime? pickedDate = await showDatePicker(
//                           context: context,
//                           initialDate: DateTime.now(),
//                           firstDate: DateTime(2000),
//                           lastDate: DateTime(2101),
//                         );
//                         if (pickedDate != null) {
//                           String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
//                           _fromdate.text = formattedDate;
//                         }
//                       },
//                         readOnly:true,
//                     ),
//                   ),
//                   const SizedBox(width: 4.0), // Add space between the fields
//                   Expanded(
//                     child: TextFormField(
//                       controller: _todate,
//                       decoration: InputDecoration(
//                         labelText: 'To Date',
//                         hintText: 'To Date',
//                         fillColor: Colors.white,
//                         filled: true,
//                         labelStyle: const TextStyle(color: Colors.grey,fontSize: 13, fontWeight: FontWeight.normal),
//                         hintStyle: const TextStyle(color: Colors.grey, fontSize: 13, fontWeight: FontWeight.normal),
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
//                       onTap: ()async{
//                         DateTime? pickedDate = await showDatePicker(
//                           context: context,
//                           initialDate: DateTime.now(),
//                           firstDate: DateTime(2000),
//                           lastDate: DateTime(2101),
//                         );
//                         if (pickedDate != null) {
//                           String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
//                           _todate.text = formattedDate;
//                         }
//                       },
//                       readOnly: true,
//
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 6.0),
//
//               // Container No. and Shipping Bill No.
//               Row(
//                 children: [
//                   Expanded(
//                     child: TextFormField(
//                       controller: _shippingbillno,
//                       decoration: InputDecoration(
//                         labelText: 'Shipping Bill No.',
//                         hintText: 'Shipping Bill No.',
//                         fillColor: Colors.white,
//                         filled: true,
//                         labelStyle: const TextStyle(color: Colors.grey,fontSize: 16, fontWeight: FontWeight.normal),
//                         hintStyle: const TextStyle(color: Colors.grey, fontSize: 16, fontWeight: FontWeight.normal),
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
//                       controller: _blno,
//                       decoration: InputDecoration(
//                         labelText: 'B/L No.',
//                         hintText: 'B/L No.',
//                         fillColor: Colors.white,
//                         filled: true,
//                         labelStyle: const TextStyle(color: Colors.grey,fontSize: 13, fontWeight: FontWeight.normal),
//                         hintStyle: const TextStyle(color: Colors.grey, fontSize: 13, fontWeight: FontWeight.normal),
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
//                           _invoiceno.clear();
//                           _shippingbillno.clear();
//                           _fromdate.clear();
//                           _todate.clear();
//                           _blno.clear();
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
//                         if (_invoiceno.text.isNotEmpty) {
//                           _handleInvoiceNo();
//                         } else if (_shippingbillno.text.isNotEmpty) {
//                           _handleShippingBLSearch();
//                         }
//                         else if (_fromdate.text.isNotEmpty || _todate.text.isNotEmpty) {
//                           if (_fromdate.text.isEmpty) {
//                             _showSnackBar('Please select From Date');
//                           } else if (_todate.text.isEmpty) {
//                             _showSnackBar('Please select To Date');
//                           } else {
//                             _handleDateRangeSearch();
//                           }
//                         }
//                         else if (_blno.text.isNotEmpty) {
//                           _handleBLSearch();
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
//               const SizedBox(height: 32.0),
//
//               // const SizedBox(height: 52.0),
//               Importdata(context),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget Importdata(BuildContext context) {
//     final dataToShow =
//     (_invoiceno.text.isNotEmpty || _shippingbillno.text.isNotEmpty || _fromdate.text.isNotEmpty || _todate.text.isNotEmpty || _blno.text.isNotEmpty)
//         ? filteredUsers
//         : [];
//     return Expanded(
//       child: isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : (_invoiceno.text.isEmpty && _shippingbillno.text.isEmpty && _fromdate.text.isEmpty && _todate.text.isEmpty && _blno.text.isEmpty)
//           ? const Center( child:Text(''))
//       :dataToShow.isEmpty
//       ? const Center(
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
//           var viewModel;
//           return ListTile(
//             title: _buildInfoRow('Invoice No', user.no ?? 'N/A'),
//             subtitle: Column(crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 _buildInfoRow('Invoice Date', formatDate(user.bLDate)),
//                 _buildInfoRow('Shipping Bill No', user.shippingBillNo ?? 'N/A'),
//                 _buildInfoRow('B/L No.', user.bLNo ?? 'N/A'),
//                 _buildInfoRow('Total Invoice', user.amount.toString() ?? 'N/A'),
//                 _buildInfoRow('Amount',' '),
//
//                 Row(
//                 children: [
//                   Expanded(
//                     child: ElevatedButton.icon(
//                       onPressed: () async {
//                         debugPrint('Download button pressed');
//
//                         // Show loading indicator
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           const SnackBar(
//                             content: Row(
//                               children: [
//                                 CircularProgressIndicator(
//                                   valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
//                                 ),
//                                 SizedBox(width: 16),
//                                 Text('Downloading invoice...'),
//                               ],
//                             ),
//                             duration: Duration(seconds: 30), // Long duration as we'll dismiss it manually
//                           ),
//                         );
//
//                         try {
//                           debugPrint('Attempting to download file for invoice');
//
//                           // Call the download method with the desired invoice number
//                           await download.downloadFile(user.no ?? '');
//                           debugPrint('File downloaded successfully');
//
//                           // Dismiss the loading snackbar
//                           ScaffoldMessenger.of(context).hideCurrentSnackBar();
//
//                           // Show success message
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             const SnackBar(
//                               content: Row(
//                                 children: [
//                                   Icon(Icons.check_circle, color: Colors.white),
//                                   SizedBox(width: 16),
//                                   Text('File downloaded and opened successfully!'),
//                                 ],
//                               ),
//                               backgroundColor: Colors.green,
//                               duration: Duration(seconds: 3),
//                             ),
//                           );
//                         } catch (e) {
//                           debugPrint('Error downloading file: $e');
//
//                           // Dismiss the loading snackbar
//                           ScaffoldMessenger.of(context).hideCurrentSnackBar();
//                           final errorMessage = e.toString().replaceAll('Exception:', '').trim();
//
//                           // Show error message with specific details
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             SnackBar(
//                               content: Row(
//                                 children: [
//                                   const Icon(Icons.error, color: Colors.white),
//                                   const SizedBox(width: 16),
//                                   Expanded(
//                                     child: Text(
//                                       errorMessage == 'No file present for this invoice'
//                                           ? 'No file available for this invoice'
//                                           : 'Download failed: $errorMessage',
//                                       maxLines: 2,
//                                       overflow: TextOverflow.ellipsis,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               backgroundColor: Colors.red,
//                               duration: const Duration(seconds: 5),
//                             ),
//                           );
//                         }
//                       },
//
//
//                       style: ElevatedButton.styleFrom(
//                         foregroundColor: Colors.white,
//                         backgroundColor: AppColors.colorPrimary, // Text color
//                         padding: const EdgeInsets.symmetric(vertical: 12.0), // Increase the button size
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12.0), // Rounded corners for buttons
//                         ),
//                       ),
//
//                       icon: Image.asset(
//                         'assets/images/download.png',
//                         width: 22,
//                         height: 22,
//                       ),
//                       label: const Text('Download', style: TextStyle(fontSize: 18)),
//                     ),
//                   ),
//                   const SizedBox(width: 6.0), // Add space between the buttons
//
//                   Expanded(
//                     child: ElevatedButton.icon(
//                       onPressed: () async {
//                         try {
//                           // Show loading indicator
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             const SnackBar(
//                               content: Row(
//                                 children: [
//                                   CircularProgressIndicator(
//                                     valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
//                                   ),
//                                   SizedBox(width: 16),
//                                   Text('Sending email...'),
//                                 ],
//                               ),
//                               duration: Duration(seconds: 30),
//                             ),
//                           );
//
//                           await emailViewModel.sendEmail( user.no ?? '');
//
//                           // Dismiss the loading snackbar
//                           ScaffoldMessenger.of(context).hideCurrentSnackBar();
//
//                           if (emailViewModel.success) {
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               const SnackBar(
//                                 content: Row(
//                                   children: [
//                                     Icon(Icons.check_circle, color: Colors.white),
//                                     SizedBox(width: 16),
//                                     Text('Email sent successfully!'),
//                                   ],
//                                 ),
//                                 backgroundColor: Colors.green,
//                                 duration: Duration(seconds: 3),
//                               ),
//                             );
//                           } else {
//                             throw Exception(emailViewModel.error ?? 'Failed to send email');
//                           }
//                         } catch (e) {
//                           // Dismiss the loading snackbar
//                           ScaffoldMessenger.of(context).hideCurrentSnackBar();
//
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             SnackBar(
//                               content: Row(
//                                 children: [
//                                   const Icon(Icons.error, color: Colors.white),
//                                   const SizedBox(width: 16),
//                                   Expanded(
//                                     child: Text(
//                                       'Email failed: ${e.toString().replaceAll('Exception:', '').trim()}',
//                                       maxLines: 2,
//                                       overflow: TextOverflow.ellipsis,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               backgroundColor: Colors.red,
//                               duration: const Duration(seconds: 5),
//                             ),
//                           );
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
//                       icon: Image.asset(
//                         'assets/images/mail.png',
//                         width: 22,
//                         height: 22,
//                       ),
//                       label: const Text('Mail', style: TextStyle(fontSize: 18)),
//                     ),
//                   ),
//                   const SizedBox(width: 6.0),
//                 ],
//               ),
//                ],
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
//   Widget _buildInfoRow(String title, String value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 0.0),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           SizedBox(
//             width: 130, // Set a fixed width for the title
//             child: Text(
//               title,
//               style: const TextStyle(
//                 color: Colors.blue,
//                 fontSize: 16,
//               ),
//             ),
//           ),
//           Expanded(
//             child: Text(
//               value,
//               style: const TextStyle(
//                 color: Colors.grey,
//                 fontSize: 16, // Set value text color to grey
//               ),
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
//       final parsedDate = DateTime.parse(date); // Parse the date string
//       return DateFormat('dd-MM-yyyy').format(parsedDate); // Format the date
//     } catch (e) {
//       return 'Invalid Date'; // Handle invalid date strings
//     }
//   }
//
// }

import 'package:flutter/material.dart';
import 'package:hpcsl_1/colors.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Drawer.dart';
import '../../NoRecordFound.dart';
import '../../SharedPreference.dart';
import '../../Sign In/UI/login.dart';
import '../../TitleManager.dart';
import '../../TokenRepo.dart';
import '../Model/Invoice_Model.dart';
import '../Repo/InvoiceRepositry.dart';
import 'EmailViewModel.dart';

class Invoice extends StatefulWidget {
  const Invoice({super.key});

  @override
  State<Invoice> createState() => _Invoice();
}

class InvoiceException implements Exception {
  final String message;
  const InvoiceException(this.message);

  @override
  String toString() => "DomesticException: $message";
}

class _Invoice extends State<Invoice> {
  String title = '';
  final String subtitle = "Invoice Tracking";
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int selectedIndex = 0;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late List<InvoiceModel1> importDataList;
  String? userid;

  List<InvoiceModel1> users = [];
  bool isLoading = false;
  final TextEditingController _invoiceno = TextEditingController();
  final TextEditingController _shippingbillno = TextEditingController();
  final TextEditingController _fromdate = TextEditingController();
  final TextEditingController _todate = TextEditingController();
  final TextEditingController _blno = TextEditingController();

  late EmailViewModel emailViewModel;

  InvoiceApi download = InvoiceApi();

  List<InvoiceModel1> filteredUsers = [];
  bool hasSearched = false;

  InvoiceApi invoice = InvoiceApi();
  DateTime? selectedFromDate;
  DateTime? selectedToDate;

  @override
  void initState() {
    super.initState();
    final emailRepo = InvoiceApi();
    emailViewModel = EmailViewModel(emailRepo);
    _loadUserId();
    _loadDynamicTitle();
  }

  @override
  void dispose() {
    _invoiceno.dispose();
    _shippingbillno.dispose();
    _fromdate.dispose();
    _todate.dispose();
    _blno.dispose();
    emailViewModel.dispose();
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

  void _handleInvoiceNo() async {
    final input = _invoiceno.text.trim();
    if (input.isEmpty) {
      _showSnackBar('Please enter a Invoice number');
      return;
    }

    try {
      if (mounted) {
        setState(() {
          isLoading = true;
          hasSearched = true;
        });
      }

      final result = await invoice.fetchInvoiceByNo(input);
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

  void _handleShippingBLSearch() async {
    final input = _shippingbillno.text.trim();
    if (input.isEmpty) {
      _showSnackBar('Please enter a Shipping Bill number');
      return;
    }

    try {
      if (mounted) {
        setState(() {
          isLoading = true;
          hasSearched = true;
        });
      }

      final result = await invoice.fetchInvoiceByShippingBillNo(input);
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

  void _handleFromDatePicker() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedFromDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      setState(() {
        selectedFromDate = pickedDate;
        _fromdate.text = DateFormat('dd-MM-yyyy').format(pickedDate);
      });
    }
  }

  void _handleToDatePicker() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedToDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      setState(() {
        selectedToDate = pickedDate;
        _todate.text = DateFormat('dd-MM-yyyy').format(pickedDate);
      });
    }
  }

  void _handleDateRangeSearch() async {
    if (selectedFromDate == null || selectedToDate == null) {
      _showSnackBar('Please select both From Date and To Date');
      return;
    }
    final fromDate = DateFormat('yyyy-MM-dd').format(selectedFromDate!);
    final toDate = DateFormat('yyyy-MM-dd').format(selectedToDate!);

    try {
      if (mounted) {
        setState(() {
          isLoading = true;
          hasSearched = true;
        });
      }

      final result = await invoice.fetchInvoiceByDateRange(fromDate, toDate);
      if (mounted) {
        setState(() {
          filteredUsers = result ?? [];
          isLoading = false;
        });
        if (filteredUsers.isEmpty) {
          _showSnackBar('No records found for the selected date range');
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

  void _handleBLSearch() async {
    final input = _blno.text.trim();
    if (input.isEmpty) {
      _showSnackBar('Please enter a Bill Numbers');
      return;
    }

    try {
      if (mounted) {
        setState(() {
          isLoading = true;
          hasSearched = true;
        });
      }

      final result = await invoice.fetchInvoiceByBLNo(input);
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
      _invoiceno.clear();
      _shippingbillno.clear();
      _fromdate.clear();
      _todate.clear();
      _blno.clear();
      filteredUsers = [];
      hasSearched = false;
      isLoading = false;
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
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              content: SizedBox(
                                width: 800,
                                child: const Text('Are You Sure You Want to Exit?', style: TextStyle(fontSize: 16)),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('CANCEL', style: TextStyle(color: Colors.blue)),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                        builder: (context) => LoginScreen(),
                                      ),
                                          (route) => false,
                                    );
                                  },
                                  child: const Text('CONFIRM', style: TextStyle(color: Colors.blue)),
                                ),
                              ],
                            );
                          },
                        );
                      },
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
                    flex: 2,
                    child: TextFormField(
                      controller: _invoiceno,
                      decoration: InputDecoration(
                        labelText: 'Invoice No.',
                        hintText: 'Invoice No.',
                        fillColor: Colors.white,
                        filled: true,
                        labelStyle: const TextStyle(color: Colors.grey, fontSize: 18, fontWeight: FontWeight.normal),
                        hintStyle: const TextStyle(color: Colors.grey, fontSize: 18, fontWeight: FontWeight.normal),
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
                        contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 18.0),
                      ),
                    ),
                  ),
                  const SizedBox(width: 5.0),
                  Expanded(
                    child: TextFormField(
                      controller: _fromdate,
                      onTap: _handleFromDatePicker,
                      decoration: InputDecoration(
                        labelText: 'From Date',
                        hintText: 'From Date',
                        fillColor: Colors.white,
                        filled: true,
                        labelStyle: const TextStyle(color: Colors.grey, fontSize: 9, fontWeight: FontWeight.normal),
                        hintStyle: const TextStyle(color: Colors.grey, fontSize: 10, fontWeight: FontWeight.normal),
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
                        contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 18.0),
                      ),
                      readOnly: true,
                    ),
                  ),
                  const SizedBox(width: 4.0),
                  Expanded(
                    child: TextFormField(
                      controller: _todate,
                      onTap: _handleToDatePicker,
                      decoration: InputDecoration(
                        labelText: 'To Date',
                        hintText: 'To Date',
                        fillColor: Colors.white,
                        filled: true,
                        labelStyle: const TextStyle(color: Colors.grey, fontSize: 13, fontWeight: FontWeight.normal),
                        hintStyle: const TextStyle(color: Colors.grey, fontSize: 13, fontWeight: FontWeight.normal),
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
                        contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 18.0),
                      ),
                      readOnly: true,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6.0),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _shippingbillno,
                      decoration: InputDecoration(
                        labelText: 'Shipping Bill No.',
                        hintText: 'Shipping Bill No.',
                        fillColor: Colors.white,
                        filled: true,
                        labelStyle: const TextStyle(color: Colors.grey, fontSize: 16, fontWeight: FontWeight.normal),
                        hintStyle: const TextStyle(color: Colors.grey, fontSize: 16, fontWeight: FontWeight.normal),
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
                        contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 18.0),
                      ),
                    ),
                  ),
                  const SizedBox(width: 4.0),
                  Expanded(
                    child: TextFormField(
                      controller: _blno,
                      decoration: InputDecoration(
                        labelText: 'B/L No.',
                        hintText: 'B/L No.',
                        fillColor: Colors.white,
                        filled: true,
                        labelStyle: const TextStyle(color: Colors.grey, fontSize: 13, fontWeight: FontWeight.normal),
                        hintStyle: const TextStyle(color: Colors.grey, fontSize: 13, fontWeight: FontWeight.normal),
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
                        contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 18.0),
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
                      onPressed: isLoading
                          ? null
                          : () {
                        if (_invoiceno.text.isNotEmpty) {
                          _handleInvoiceNo();
                        } else if (_shippingbillno.text.isNotEmpty) {
                          _handleShippingBLSearch();
                        } else if (_fromdate.text.isNotEmpty || _todate.text.isNotEmpty) {
                          if (_fromdate.text.isEmpty) {
                            _showSnackBar('Please select From Date');
                          } else if (_todate.text.isEmpty) {
                            _showSnackBar('Please select To Date');
                          } else {
                            _handleDateRangeSearch();
                          }
                        } else if (_blno.text.isNotEmpty) {
                          _handleBLSearch();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text(
                                  'Please enter value',
                                  textAlign: TextAlign.center,
                                )),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: isLoading ? Colors.grey : AppColors.colorPrimary,
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                      child: isLoading
                          ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                          : const Text('Search', style: TextStyle(fontSize: 18)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32.0),
              Importdata(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget Importdata(BuildContext context) {
    final dataToShow = (_invoiceno.text.isNotEmpty ||
        _shippingbillno.text.isNotEmpty ||
        _fromdate.text.isNotEmpty ||
        _todate.text.isNotEmpty ||
        _blno.text.isNotEmpty)
        ? filteredUsers
        : [];

    if (isLoading) {
      return const Expanded(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (!hasSearched) {
      return Expanded(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(''),
            ],
          ),
        ),
      );
    }

    if (dataToShow.isEmpty) {
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

    return Expanded(
      child: ListView.separated(
        itemCount: dataToShow.length,
        separatorBuilder: (context, index) => const Divider(
          color: Colors.grey,
          thickness: 1.0,
          height: 1.0,
        ),
        itemBuilder: (context, index) {
          final user = dataToShow[index];
          var viewModel;
          return ListTile(
            title: _buildInfoRow('Invoice No', user.no ?? 'N/A'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInfoRow('Invoice Date', formatDate(user.documentDate)),
                _buildInfoRow('Shipping Bill No', user.shippingBillNo ?? 'N/A'),
                _buildInfoRow('B/L No.', user.bLNo ?? 'N/A'),
                _buildInfoRow('Total Invoice', user.amount.toString() ?? 'N/A'),
                _buildInfoRow(
                  'GST Amount',
                  user.gstAmount != null ? user.gstAmount!.toStringAsFixed(2) : 'N/A',
                ),
                _buildInfoRow(
                  'Total Amount',
                  user.amounttocustomer != null
                      ? user.amounttocustomer!.toStringAsFixed(0)
                      : 'N/A',
                ),

                _buildInfoRow('Amount', ' '),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () async {
                          debugPrint('Download button pressed');

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Row(
                                children: [
                                  CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                  ),
                                  SizedBox(width: 16),
                                  Text('Downloading invoice...'),
                                ],
                              ),
                              duration: Duration(seconds: 30),
                            ),
                          );

                          try {
                            debugPrint('Attempting to download file for invoice');
                            await download.downloadFile(user.no ?? '');
                            debugPrint('File downloaded successfully');
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Row(
                                  children: [
                                    Icon(Icons.check_circle, color: Colors.white),
                                    SizedBox(width: 16),
                                    Text('File downloaded and opened successfully!'),
                                  ],
                                ),
                                backgroundColor: Colors.green,
                                duration: Duration(seconds: 3),
                              ),
                            );
                          } catch (e) {
                            debugPrint('Error downloading file: $e');
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                            final errorMessage = e.toString().replaceAll('Exception:', '').trim();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Row(
                                  children: [
                                    const Icon(Icons.error, color: Colors.white),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: Text(
                                        errorMessage == 'No file present for this invoice'
                                            ? 'No file available for this invoice'
                                            : 'Download failed: $errorMessage',
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                                backgroundColor: Colors.red,
                                duration: const Duration(seconds: 5),
                              ),
                            );
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
                        icon: Image.asset(
                          'assets/images/download.png',
                          width: 22,
                          height: 22,
                        ),
                        label: const Text('Download', style: TextStyle(fontSize: 18)),
                      ),
                    ),
                    const SizedBox(width: 6.0),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () async {
                          try {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Row(
                                  children: [
                                    CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                    ),
                                    SizedBox(width: 16),
                                    Text('Sending email...'),
                                  ],
                                ),
                                duration: Duration(seconds: 30),
                              ),
                            );

                            await emailViewModel.sendEmail(user.no ?? '');
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();

                            if (emailViewModel.success) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Row(
                                    children: [
                                      Icon(Icons.check_circle, color: Colors.white),
                                      SizedBox(width: 16),
                                      Text('Email sent successfully!'),
                                    ],
                                  ),
                                  backgroundColor: Colors.green,
                                  duration: Duration(seconds: 3),
                                ),
                              );
                            } else {
                              throw Exception(emailViewModel.error ?? 'Failed to send email');
                            }
                          } catch (e) {
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Row(
                                  children: [
                                    const Icon(Icons.error, color: Colors.white),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: Text(
                                        'Email failed: ${e.toString().replaceAll('Exception:', '').trim()}',
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                                backgroundColor: Colors.red,
                                duration: const Duration(seconds: 5),
                              ),
                            );
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
                        icon: Image.asset(
                          'assets/images/mail.png',
                          width: 22,
                          height: 22,
                        ),
                        label: const Text('Mail', style: TextStyle(fontSize: 18)),
                      ),
                    ),
                    const SizedBox(width: 6.0),
                  ],
                ),
              ],
            ),
            isThreeLine: true,
            contentPadding: EdgeInsets.zero,
          );
        },
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    // Special handling for GPS Tracking link
    if (label == 'GPS Tracking') {
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
              child: InkWell(
                onTap: () {
                  if (value != 'N/A' && value.isNotEmpty) {
                    _launchUrl(value);
                  }
                },
                child: Text(
                  value,
                  style: TextStyle(
                    color: value != 'N/A' ? Colors.blue : Colors.grey[700],
                    fontSize: 16,
                    decoration: value != 'N/A' ? TextDecoration.underline : null,
                  ),
                  overflow: TextOverflow.visible,
                  softWrap: true,
                ),
              ),
            ),
          ],
        ),
      );
    }

    // Regular info row for non-clickable fields
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

  void _launchUrl(String url) async {
    // Make sure the URL starts with http:// or https://
    if (!url.startsWith('http://') && !url.startsWith('https://')) {
      url = 'https://$url';
    }

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      _showSnackBar('Could not launch $url');
    }
  }

  // String formatDate(String? date) {
  //   if (date == null || date.isEmpty) return 'N/A';
  //   try {
  //     final parsedDate = DateTime.parse(date);
  //     return DateFormat('dd-MM-yyyy').format(parsedDate);
  //   } catch (e) {
  //     return 'Invalid Date';
  //   }
  // }

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
}
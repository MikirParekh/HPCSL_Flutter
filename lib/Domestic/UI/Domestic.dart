// import 'package:flutter/material.dart';
// import 'package:hpcsl_1/Domestic/Model/Domestic_model.dart';
// import 'package:hpcsl_1/colors.dart';
// import 'package:intl/intl.dart';
//
// import '../../Drawer.dart';
// import '../../NoRecordFound.dart';
// import '../../SharedPreference.dart';
// import '../../Sign In/UI/login.dart';
// import '../Repo/DomesticRepositry.dart';
//
// class Domestic extends StatefulWidget {
//   const Domestic({super.key});
//
//   @override
//   State<Domestic> createState() => _Domestic();
// }
//
// class DomesticException implements Exception {
//   final String message;
//   const DomesticException(this.message);
//
//   @override
//   String toString() => "DomesticException: $message";
// }
//
// class _Domestic extends State<Domestic> {
//   final String title = "AIA ENGINEERING LTD";
//   final String subtitle = "Domestic Tracking";
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//   // Variable to keep track of the selected item index
//   int selectedIndex = 0;
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); // Added form key
//   late List<DomesticModel1> domesticDataList; // List to hold the import data
//   List<DomesticModel1> users = [];
//   bool isLoading = false;
//   final TextEditingController _controller = TextEditingController();
//   final TextEditingController _Orderno = TextEditingController();
//   List<DomesticModel1> filteredUsers = [];
//   String? userid;
//
//   DomesticApi domestic=DomesticApi();
//
//   @override
//   void initState() {
//     super.initState();
//     _loadUserId(); // Fetch data on screen load
//   }
//   @override
//   void dispose() {
//     // Dispose the controller when the widget is disposed
//     _controller.dispose();
//     _Orderno.dispose();
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
//       fetchDomesticData();
//     }
//   }
//
//   Future<void> fetchDomesticData() async {
//     // setState(() => isLoading = true);
//     try {
//       final response = await DomesticApi().fetchDomesticData(context, userid ?? '');  // Pass only context
// // Fetch Postcode data
//       if (mounted) {
//         setState(() {
//           users = response.value ?? [];
//           debugPrint('Fetched Import data: ${users.length}');
//         });
//       }
//     } catch (e) {
//       if (mounted) {
//         debugPrint('Error in Fetching Domestic data: $e');
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
//       final response = await domestic.fetchContainerNoWithSearch(context, input);
//
//       if (mounted) {
//         setState(() {
//           if (response.value != null) {
//             // Filter for exact match only
//             filteredUsers = response.value!.where((user) =>
//             (user.containerWagonNo?.toUpperCase() ?? '') == input
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
//   void _handleBLSearch() async {
//     String input = _Orderno.text.trim().toUpperCase();
//
//     if (input.isEmpty) {
//       setState(() {
//         filteredUsers = [];
//       });
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Please enter a order number')),
//       );
//       return;
//     }
//
//     setState(() {
//       isLoading = true;
//     });
//
//     try {
//       final response = await domestic.fetchOrderWithSearch(context, input);
//
//       if (mounted) {
//         setState(() {
//           if (response.value != null) {
//             filteredUsers = response.value!.where((user) =>
//             (user.documentNo?.toUpperCase() ?? '') == input).toList();
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
//                       controller:_Orderno,
//                       decoration: InputDecoration(
//                         labelText: 'Order No',
//                         hintText: 'Order No',
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
//                           _Orderno.clear();
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
//                         } else if (_Orderno.text.isNotEmpty) {
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
//               domesticdata(context),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget domesticdata(BuildContext context) {
//     final dataToShow =
//     (_controller.text.isNotEmpty || _Orderno.text.isNotEmpty) ? filteredUsers : [];
//     return Expanded(
//       child: isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : (_controller.text.isEmpty && _Orderno.text.isEmpty)
//           ? const Center( child:Text(''))
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
//             title: _buildInfoRow('Order No', user.documentNo ?? 'N/A'),
//             subtitle: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 _buildInfoRow('Order Date', formatDate(user.bookingDate)),
//                 _buildInfoRow('Container/WagonNo', user.containerWagonNo ?? 'N/A'),
//                 _buildInfoRow('Size', user.size ?? 'N/A'),
//                 _buildInfoRow('Customer Name', user.customerName ?? 'N/A'),
//                 _buildInfoRow('Terminal', user.terminal ?? 'N/A'),
//                 _buildInfoRow('No of Packages', user.noOfPackages.toString() ?? 'N/A'),
//                 _buildInfoRow('Comodity Category', user.comodityCategory ?? 'N/A'),
//                 _buildInfoRow('From Location', formatDate(user.fromLocationCode)),
//                 _buildInfoRow('To Location', formatDate(user.toLocationCode)),
//                 _buildInfoRow('Source Out Mode', user.sourceOutMode ?? 'N/A'),
//                 _buildInfoRow('ICD Arrival Date', formatDate(user.arrivalDate)),
//                 _buildInfoRow('Booking Type', user.bookingType ?? 'N/A'),
//                 _buildInfoRow('ICD Gate Out Date', formatDate(user.sourceOutMode)),
//                 _buildInfoRow('Destination Gate In Date', formatDate(user.destinationGateInDate)),
//
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
//   Widget _buildInfoRow(String label, String value) {
//     return  Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           SizedBox(
//             width: 159, // Fixed width for the label
//             child: Text(
//               label,
//               style:  TextStyle(
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
// }

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../Drawer.dart';
import '../../NoRecordFound.dart';
import '../../SharedPreference.dart';
import '../../Sign In/UI/login.dart';
import '../../TitleManager.dart';
import '../../colors.dart';
import '../Model/Domestic_model.dart';
import '../Repo/DomesticRepositry.dart';

class Domestic extends StatefulWidget {
  const Domestic({super.key});

  @override
  State<Domestic> createState() => _Domestic();
}

class DomesticException implements Exception {
  final String message;
  const DomesticException(this.message);

  @override
  String toString() => "DomesticException: $message";
}

class _Domestic extends State<Domestic> {
  String title = '';
  final String subtitle = "Domestic Tracking";
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int selectedIndex = 0;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  List<DomesticModel1> filteredUsers = [];
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _Orderno = TextEditingController();
  String? userid;
  bool hasSearched = false;
  bool showInitialMessage = true;
  bool isLoading = false; // Add this with your other state variables


  final DomesticApi domesticApi = DomesticApi();

  @override
  void initState() {
    super.initState();
    _loadDynamicTitle();
    _loadUserId();
  }

  @override
  void dispose() {
    _controller.dispose();
    _Orderno.dispose();
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
        });
      }

      final result = await domesticApi.fetchContainerWagonNo(input);

      if (mounted) {
        setState(() {
          filteredUsers = result.value ?? [];
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

  void _handleOrderNoSearch() async {
    final input = _Orderno.text.trim();
    if (input.isEmpty) {
      _showSnackBar('Please enter an Order Number');
      return;
    }

    try {
      if (mounted) {
        setState(() {
          isLoading = true;
          hasSearched = true;
        });
      }

      final result = await domesticApi.fetchDocumentNo(input);

      if (mounted) {
        setState(() {
          filteredUsers = result.value ?? [];
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

  // void _performSearch(Future<List<Value>> Function() searchFunction) async {
  //   if (userid == null) {
  //     _showSnackBar('User ID is not available');
  //     return;
  //   }
  //
  //   setState(() => hasSearched = true); // Only track search attempt
  //
  //   try {
  //     final results = await searchFunction();
  //     if (mounted) {
  //       setState(() => filteredUsers = results);
  //       if (filteredUsers.isEmpty) {
  //         _showSnackBar('No matching records found');
  //       }
  //     }
  //   } catch (e) {
  //     if (mounted) {
  //       setState(() => filteredUsers = []);
  //       _showSnackBar('Search failed: ${e.toString()}');
  //     }
  //   }
  // }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void _clearSearch() {
    setState(() {
      _controller.clear();
      _Orderno.clear();
      filteredUsers = [];
      hasSearched = false;
      showInitialMessage = true;
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
                      controller: _Orderno,
                      decoration: InputDecoration(
                        labelText: 'Order No.',
                        hintText: 'Order No.',
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
                      onPressed: isLoading ? null : () {
                        if (_controller.text.isNotEmpty) {
                          _handleSearch();
                        } else if (_Orderno.text.isNotEmpty) {
                          _handleOrderNoSearch();
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
              _buildDomesticDataView(),
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

  Widget _buildDomesticDataView() {
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
            children: [
              const Text(
                '',
              ),
            ],
          ),
        ),
      );
    }

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

    return Expanded(
      child: ListView.separated(
        itemCount: filteredUsers.length,
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (context, index) => _buildResultItem(filteredUsers[index]),
      ),
    );
  }

  Widget _buildResultItem(DomesticModel1 user) {
    return ListTile(
      title: _buildInfoRow('Order No', user.documentNo ?? 'N/A'),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfoRow('Order Date', formatDate(user.bookingDate)),
                _buildInfoRow('Container/WagonNo', user.containerWagonNo ?? 'N/A'),
                _buildInfoRow('Size', user.size ?? 'N/A'),
                _buildInfoRow('Customer Name', user.customerName ?? 'N/A'),
                _buildInfoRow('Terminal', user.terminal ?? 'N/A'),
                _buildInfoRow('No of Packages', user.noOfPackages.toString() ?? 'N/A'),
                _buildInfoRow('Comodity Category', user.comodityCategory ?? 'N/A'),
                _buildInfoRow('From Location', user.fromLocationCode ?? 'N/A'),
                _buildInfoRow('To Location', user.toLocationCode ?? 'N/A'),
                _buildInfoRow('Source Out Mode', user.sourceOutMode ?? 'N/A'),
                _buildInfoRow('ICD Arrival Date', formatDate(user.arrivalDate)),
                _buildInfoRow('Booking Type', user.bookingType ?? 'N/A'),
                _buildInfoRow('ICD Gate Out Date', user.sourceOutMode ?? 'N/A'),
                _buildInfoRow('Destination Gate In Date', formatDate(user.destinationGateInDate)),

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

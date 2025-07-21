// import 'dart:async'
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:hpcsl_1/AccountStatement/UI/Accounts.dart';
// import 'package:hpcsl_1/ChangePassword/UI/ChangePassword.dart';
// import 'package:hpcsl_1/Domestic/UI/Domestic.dart';
// import 'package:hpcsl_1/Import/UI/Import.dart';
// import 'package:hpcsl_1/colors.dart';
// import '../../Drawer.dart';
// import '../../SharedPreference.dart';
// import '../../Sign In/UI/login.dart';
// import '../../TitleManager.dart';
// import '../../ViewProfile/UI/Edit.dart';
// import '../../EmptyTracking/UI/Empty.dart';
// import '../../EmptyContainer/UI/EmptyContainer.dart';
// import '../../Export/UI/Export.dart';
// import '../../Invoice/UI/Invoice.dart';
// import '../../Transport/UI/Transport.dart';
// import '../../Warehouse/UI/Warehouse.dart';
// import '../Repo/HomeScreenRepositry.dart';
//
//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   String title = '';
//   final String subtitle = "Home";
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//
//   // Variable to keep track of the selected item index
//   int selectedIndex = 0;
//   bool showAccounts = false;
//   List<String> _imageUrls = [];
//   bool _isLoadingImages = true;
//   final PageController _pageController = PageController();
//   int _currentPage = 0;
//   Timer? _autoScrollTimer;
//
//
//   final HomeScreenRepository _repository = HomeScreenRepository();
//
//
//   @override
//   void initState() {
//     super.initState();
//     _loadImagesFromRepo();
//     _loadUserInvoiceStatus();
//     _loadDynamicTitle();
//
//
//     _autoScrollTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
//       if (_imageUrls.isNotEmpty && _pageController.hasClients) {
//         _currentPage = (_currentPage + 1) % _imageUrls.length;
//         _pageController.animateToPage(
//           _currentPage,
//           duration: const Duration(milliseconds: 400),
//           curve: Curves.easeInOut,
//         );
//       }
//     });
//   }
//
//   @override
//   void dispose() {
//     _autoScrollTimer?.cancel();
//     _pageController.dispose();
//     super.dispose();
//   }
//
//
//
//
//   void _loadUserInvoiceStatus() async {
//     final userInvoice = await StorageManager.readData('userInvoice');
//     setState(() {
//       showAccounts = userInvoice == true;
//     });
//   }
//
//
//   void _loadDynamicTitle() async {
//     final fetchedTitle = await TitleManager.getTitle();
//     setState(() {
//       title = fetchedTitle;
//     });
//   }
//   Future<void> _loadImagesFromRepo() async {
//     List<String> images = await _repository.fetchImageUrls();
//     setState(() {
//       _imageUrls = images;
//       _isLoadingImages = false;
//     });
//   }
//
//
//
//   Future<bool> _onWillPop() async {
//     return await showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         backgroundColor: Colors.white, // Set background color to white
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(10), // Optional: Rounded corners
//         ),
//         content: SizedBox(
//           width: 800, // Increase width of the dialog
//           child: const Text('Are You Sure You Want to Exit?',style:TextStyle(fontSize: 16) ,),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Navigator.of(context).pop(); // Close dialog
//             },
//             child: const Text('CANCEL',style:TextStyle(color: Colors.blue),),
//           ),
//           TextButton(
//             onPressed: () {
//               // Add your logout logic here
//               Navigator.of(context).pop(); // Close dialog
//               Navigator.of(context).pushAndRemoveUntil(
//                 MaterialPageRoute(
//                   builder: (context) => LoginScreen(),
//                 ),
//                     (route) => false,
//               );
//             },
//             child: const Text('CONFIRM',style:TextStyle(color: Colors.blue),),
//           ),
//         ],
//       ),
//     ) ?? false; // If dialog is dismissed by tapping outside, default to false
//   }
//
//   @override
//   Widget build(BuildContext context) {
//
//     return WillPopScope(
//       onWillPop: _onWillPop,
//       child: Scaffold(
//         key: _scaffoldKey,
//         backgroundColor: AppColors.darkGrey1, // Set the background color of the body to white
//         appBar: PreferredSize(
//           preferredSize: const Size.fromHeight(100.0),
//           child: AppBar(
//             backgroundColor: AppColors.colorPrimary,
//             elevation: 0,
//             automaticallyImplyLeading: false,
//             flexibleSpace: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 10.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const SizedBox(height: 40), // Space for app bar content
//                   Text(
//                     title,
//                     style: const TextStyle(
//                       fontSize: 20,
//                       color: AppColors.titlecolor,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                   Row(
//                     children: [
//                       IconButton(
//                         icon: const Icon(Icons.menu, color: Colors.white),
//                         onPressed: () {
//                           _scaffoldKey.currentState?.openDrawer(); // Open the drawer
//                         },
//                       ),
//                       Text(
//                         subtitle,
//                         style: const TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white,
//                         ),
//                       ),
//                       const Spacer(),
//                       GestureDetector(
//                         onTap: () {
//                           showDialog(
//                             context: context,
//                             builder: (BuildContext context) {
//                               return AlertDialog(
//                                 content: const Text('Are you sure you want to exit?'),
//                                 actions: [
//                                   TextButton(
//                                     onPressed: () {
//                                       Navigator.of(context).pop(); // Close dialog
//                                     },
//                                     child: const Text('CANCEL',style:TextStyle(color: Colors.blue) ,),
//                                   ),
//                                   TextButton(
//                                     onPressed: () {
//                                       // Add your logout logic here
//                                       // For example:
//                                       // AuthService.logout();
//                                       Navigator.of(context).pop(); // Close dialog
//                                       SystemNavigator.pop(); // Close the app
//                                     },
//                                     child: const Text('CONFIRM',style:TextStyle(color: Colors.blue),),
//                                   ),
//                                 ],
//                               );
//                             },
//                           );
//                         },
//                         child: Image.asset(
//                           'assets/images/sign_out.png',
//                           width: 30,
//                           height: 30,
//                         ),
//                       ),
//
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//         drawer: SizedBox(
//           width: MediaQuery.of(context).size.width * 0.8,
//           child: CustomDrawer(
//             selectedIndex: selectedIndex,
//             onItemTap: (int index) {
//               setState(() {
//                 selectedIndex = index;
//               });
//             },
//           ),
//         ),
//
//         body: Padding(
//           padding: const EdgeInsets.fromLTRB(22, 0, 22, 0),
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 const SizedBox(height: 16),
//
//     _isLoadingImages
//     ? const Center(child: CircularProgressIndicator())
//         : _imageUrls.isEmpty
//     ? const Text("No images available")
//         : SizedBox(
//     height: 180,
//     child: PageView.builder(
//     controller: _pageController,
//     itemCount: _imageUrls.length,
//     itemBuilder: (context, index) {
//     final imageUrl = _imageUrls[index];
//     return Padding(
//     padding: const EdgeInsets.symmetric(horizontal: 6.0),
//     child: ClipRRect(
//     borderRadius: BorderRadius.circular(12),
//     child: Image.network(
//     imageUrl,
//     fit: BoxFit.cover,
//     width: double.infinity,
//     errorBuilder: (context, error, stackTrace) =>
//     const Icon(Icons.broken_image, size: 50),
//     loadingBuilder: (context, child, progress) =>
//     progress == null
//     ? child
//         : const Center(
//     child: CircularProgressIndicator()),
//                             ),
//                           );
//                         },
//                       );
//                     }).toList(),
//                   ),
//                 ),
//
//                 const SizedBox(height: 20),
//
//                 // ✅ Now your GridView starts here
//                 GridView.count(
//
//                 crossAxisCount: 2,
//                   mainAxisSpacing: 0,
//                   crossAxisSpacing: 10,
//                   shrinkWrap: true, // Let GridView taknoe only the required space
//                   physics: const NeverScrollableScrollPhysics(), // Disable GridView scrolling
//                   children: [
//                     _buildImageContainer(
//                         'assets/images/export.png',
//                         'Export Tracking',
//                             () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => const Export(),
//                             ),
//                           );
//                         }
//                     ),
//
//                     _buildImageContainer('assets/images/import_report.png', "Import Tracking", () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => const Import(),
//                         ),
//                       );
//                     }),
//                     _buildImageContainer('assets/images/domestic.png', "Domestic \n Tracking", () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => const Domestic(),
//                         ),
//                       );
//                     }),
//                     _buildImageContainer('assets/images/empty.png', "Empty Tracking", () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => const Empty(),
//                         ),
//                       );
//                     }),
//                     _buildImageContainer('assets/images/transit.png', "Transport \n Tracking", () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => const Transport(),
//                         ),
//                       );
//                     }),
//                     _buildImageContainer(
//                       'assets/images/outstanding.png',
//                       "Accounts \n Statement",
//                           () {
//                         if (showAccounts) {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(builder: (context) => const Accounts()),
//                           );
//                         } else {
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             const SnackBar(
//                               content: Text(
//                                 "You do not have access to Accounts Statement.",
//                                 style: TextStyle(color: Colors.white),
//                               ),
//                               backgroundColor: Colors.black,
//                               duration: Duration(seconds: 3),
//                             ),
//                           );
//                         }
//                       },
//                     ),
//
//
//
//                     _buildImageContainer('assets/images/invoice.png', "Invoice", () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => const Invoice(),
//                         ),
//                       );
//                     }),
//                     _buildImageContainer('assets/images/container.png', "Empty Container \n     Inventory", () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => const EmptyContainer(),
//                         ),
//                       );
//                     }),
//                     _buildImageContainer('assets/images/warehouse.png', "Warehouse \n Inventory", () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => const Warehouse(),
//                         ),
//                       );
//                     }),
//                     _buildImageContainer('assets/images/edit.png', "View Profile", () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => const Edit(),
//                         ),
//                       );
//                     }),
//
//                   ],
//                 ),
//                 InkWell(
//                   onTap: (){
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) =>  ChangePassword (),
//                       ),
//                     );
//                   },
//                   child: Container(
//                     padding: const EdgeInsets.symmetric(vertical: 40),
//                     margin: const EdgeInsets.symmetric(vertical: 20),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(20),
//                       color: Colors.white,
//                     ),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//
//                         ColorFiltered(
//                           colorFilter: const ColorFilter.mode(
//                               Color(0xFF0097DD), BlendMode.modulate), // Apply blue color
//                           child: Image.asset(
//                             'assets/images/ic_change_password_lock.png',
//                             width: double.infinity,
//                             height: 50,
//                           ),
//                         ),
//                         const SizedBox(height: 10),
//                         const Text(
//                           'Change Password/mpin',
//                           style: TextStyle(color: Colors.black, fontSize: 16),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildImageContainer(String imagePath, String label, VoidCallback onTap) {
//     return GestureDetector(
//       onTap: onTap, // Trigger the provided callback
//       child: Container(
//         margin: const EdgeInsets.fromLTRB(0,16,0,0),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(12),
//           color: Colors.white,
//         ),
//         height: 100, // Reduce height of the container
//         width: 100,
//         child: Padding(
//           padding: const EdgeInsets.all(10),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               ColorFiltered(
//                 colorFilter: const ColorFilter.mode(
//                     Color(0xFF0097DD), BlendMode.modulate), // Apply blue color
//                 child: Image.asset(
//                   imagePath,
//                   width: 40, // Image width
//                   height: 40, // Image height
//                 ),
//               ),
//               const SizedBox(height: 16), // Reduce space between image and label
//               Text(
//                 label,
//                 textAlign: TextAlign.center,
//                 style: const TextStyle(color: Colors.black, fontSize: 14),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
// }
//
//

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hpcsl_1/AccountStatement/UI/Accounts.dart';
import 'package:hpcsl_1/ChangePassword/UI/ChangePassword.dart';
import 'package:hpcsl_1/Domestic/UI/Domestic.dart';
import 'package:hpcsl_1/Import/UI/Import.dart';
import 'package:hpcsl_1/colors.dart';
import '../../Drawer.dart';
import '../../SharedPreference.dart';
import '../../Sign In/UI/login.dart';
import '../../TitleManager.dart';
import '../../ViewProfile/UI/Edit.dart';
import '../../EmptyTracking/UI/Empty.dart';
import '../../EmptyContainer/UI/EmptyContainer.dart';
import '../../Export/UI/Export.dart';
import '../../Invoice/UI/Invoice.dart';
import '../../Transport/UI/Transport.dart';
import '../../Warehouse/UI/Warehouse.dart';
import '../Repo/HomeScreenRepositry.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String title = '';
  final String subtitle = "Home";
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  int selectedIndex = 0;
  bool showAccounts = false;
  List<String> _imageUrls = [];
  bool _isLoadingImages = true;
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _autoScrollTimer;

  final HomeScreenRepository _repository = HomeScreenRepository();

  @override
  void initState() {
    super.initState();
    _loadImagesFromRepo();
    _loadUserInvoiceStatus();
    _loadDynamicTitle();

    _autoScrollTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (_imageUrls.isNotEmpty && _pageController.hasClients) {
        _currentPage = (_currentPage + 1) % _imageUrls.length;
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _autoScrollTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _loadUserInvoiceStatus() async {
    final userInvoice = await StorageManager.readData('userInvoice');
    setState(() {
      showAccounts = userInvoice == true;
    });
  }

  void _loadDynamicTitle() async {
    final fetchedTitle = await TitleManager.getTitle();
    setState(() {
      title = fetchedTitle;
    });
  }

  Future<void> _loadImagesFromRepo() async {
    List<String> images = await _repository.fetchImageUrls();
    setState(() {
      _imageUrls = images;
      _isLoadingImages = false;
    });
  }

  Future<bool> _onWillPop() async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        content: const SizedBox(
          width: 800,
          child: Text('Are You Sure You Want to Exit?', style: TextStyle(fontSize: 16)),
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
                MaterialPageRoute(builder: (context) => LoginScreen()),
                    (route) => false,
              );
            },
            child: const Text('CONFIRM', style: TextStyle(color: Colors.blue)),
          ),
        ],
      ),
    ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: AppColors.darkGrey1,
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
                                content: const Text('Are you sure you want to exit?'),
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
                                      SystemNavigator.pop();
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
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(22, 0, 22, 0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 16),
                _isLoadingImages
                    ? const Center(child: CircularProgressIndicator())
                    : _imageUrls.isEmpty
                    ? const Text("No images available")
                    : SizedBox(
                  height: 180,
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: _imageUrls.length,
                    itemBuilder: (context, index) {
                      final imageUrl = _imageUrls[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            imageUrl,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.broken_image, size: 50),
                            loadingBuilder: (context, child, progress) =>
                            progress == null
                                ? child
                                : const Center(child: CircularProgressIndicator()),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),
                GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 0,
                  crossAxisSpacing: 10,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    _buildImageContainer('assets/images/export.png', 'Export Tracking', () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const Export()));
                    }),
                    _buildImageContainer('assets/images/import_report.png', "Import Tracking", () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const Import()));
                    }),
                    _buildImageContainer('assets/images/domestic.png', "Domestic \n Tracking", () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const Domestic()));
                    }),
                    _buildImageContainer('assets/images/empty.png', "Empty Tracking", () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const Empty()));
                    }),
                    _buildImageContainer('assets/images/transit.png', "Transport \n Tracking", () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const Transport()));
                    }),
                    _buildImageContainer('assets/images/outstanding.png', "Accounts \n Statement", () {
                      if (showAccounts) {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => const Accounts()));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              "You do not have access to Accounts Statement.",
                              style: TextStyle(color: Colors.white),
                            ),
                            backgroundColor: Colors.black,
                            duration: Duration(seconds: 3),
                          ),
                        );
                      }
                    }),
                    _buildImageContainer('assets/images/invoice.png', "Invoice", () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const Invoice()));
                    }),
                    _buildImageContainer(
                        'assets/images/container.png', "Empty Container \n     Inventory", () {
                      Navigator.push(
                          context, MaterialPageRoute(builder: (context) => const EmptyContainer()));
                    }),
                    _buildImageContainer('assets/images/warehouse.png', "Warehouse \n Inventory", () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const Warehouse()));
                    }),
                    _buildImageContainer('assets/images/edit.png', "View Profile", () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const Edit()));
                    }),
                  ],
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const ChangePassword()));
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 40),
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ColorFiltered(
                          colorFilter: const ColorFilter.mode(
                              Color(0xFF0097DD), BlendMode.modulate),
                          child: Image.asset(
                            'assets/images/ic_change_password_lock.png',
                            width: double.infinity,
                            height: 50,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Change Password/mpin',
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImageContainer(String imagePath, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.fromLTRB(0, 16, 0, 0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
        ),
        height: 100,
        width: 100,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ColorFiltered(
                colorFilter:
                const ColorFilter.mode(Color(0xFF0097DD), BlendMode.modulate),
                child: Image.asset(
                  imagePath,
                  width: 40,
                  height: 40,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.black, fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


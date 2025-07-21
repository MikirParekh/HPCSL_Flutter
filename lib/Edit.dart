import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';  // Import File class to work with files

import 'TitleManager.dart';
import 'colors.dart';

class Edit extends StatefulWidget {
  const Edit({super.key});

  @override
  State<Edit> createState() => _Edit();
}

class _Edit extends State<Edit> {
  final _formKey = GlobalKey<FormState>();
  String? companyName,
      companyAddress,
      selectedPinCode,
      selectedCity,
      selectedState,
      mobileNumber,
      email,
      contactPersonName;
  String? panFilePath, gstFilePath;
  String title = '';
  final String subtitle = "View Profile";// Variables to store file paths

  @override
  void initState() {
    super.initState();
    _loadTitle();
  }

  // Checkboxes for customer types
  final List<Map<String, dynamic>> customerTypes = [
    {"label": "Exporter", "value": true},
    {"label": "Importer", "value": false},
    {"label": "CHA", "value": false},
    {"label": "Forwarder", "value": false},
    {"label": "Consignee", "value": false},
    {"label": "Consignor", "value": false},
    {"label": "Shipping Line", "value": false},
    {"label": "Domestic", "value": true},
    {"label": "Consolidator", "value": false},
  ];

  void _loadTitle() async {
    final fetchedTitle = await TitleManager.getTitle();
    setState(() {
      title = fetchedTitle;
    });
  }


  // Method to pick file for PAN/GST Upload
  Future<void> _pickFile(String type) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      // If a file is picked, we can retrieve the file path
      File file = File(result.files.single.path!);

      setState(() {
        if (type == "PAN") {
          panFilePath = file.path; // Save PAN file path
        } else if (type == "GST") {
          gstFilePath = file.path; // Save GST file path
        }
      });

      // Optionally, print the file path for debugging
      print('Picked file for $type: ${file.path}');
    } else {
      // If the user cancels the file picker
      print('No file selected for $type');
    }
  }

  void _loadDynamicTitle() async {
    final fetchedTitle = await TitleManager.getTitle();
    setState(() {
      title = fetchedTitle;
    });
  }

  int selectedIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                const SizedBox(height: 40), // Space for app bar content
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
                        _scaffoldKey.currentState?.openDrawer(); // Open the drawer
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
                    Image.asset(
                      'assets/images/sign_out.png',
                      width: 30,
                      height: 30,
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
        child: Drawer(
          backgroundColor: Colors.white,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              SizedBox(
                height: 120, // Set the height of the drawer header
                child: DrawerHeader(
                  decoration: const BoxDecoration(
                    color: Colors.blue, // Set the background color of the header
                  ),
                  padding: const EdgeInsets.only(top: -28.0),
                  child: Stack(
                    children: [
                      // Background image (optional)
                      Center(
                        child: Image.asset(
                          'assets/images/logo.png', // Logo image
                          width: 120,
                          height: 100,
                        ),
                      ),
                    ],
                  ),
                ),
              ),



              // Home Icon and Text
              ListTile(
                leading: ColorFiltered(
                  colorFilter: const ColorFilter.mode(
                    Colors.blue, // Change to your desired dark color
                    BlendMode.srcIn,
                  ),
                  child: Image.asset(
                    'assets/images/home.png', // Image for Export Tracking
                    width: 24,
                    height: 30,
                  ),
                ),
                title: Text(
                  'Home',
                  style: TextStyle(color: AppColors.colorPrimary,fontWeight: FontWeight.bold),
                ),
                selected: selectedIndex == 0, // Mark as selected
                selectedTileColor: Colors.grey.withOpacity(0.3),
                onTap: () {
                  setState(() {
                    selectedIndex = 0; // Update selected index
                  });
                  Navigator.pop(context); // Close the drawer
                },
              ),

              const Divider(),
              const ListTile(
                title: Text('Tracking'),
                textColor: AppColors.darkGrey,

              ),
              // Tracking section in the drawer
              ListTile(
                leading: ColorFiltered(
                  colorFilter: const ColorFilter.mode(
                    Colors.blue, // Change to your desired dark color
                    BlendMode.srcIn,
                  ),
                  child: Image.asset(
                    'assets/images/export.png', // Image for Export Tracking
                    width: 24,
                    height: 30,
                  ),
                ),
                title: Text('Export Tracking', style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w500,)),
                selected: selectedIndex == 1, // Mark as selected
                selectedTileColor: Colors.grey.withOpacity(0.3),
                onTap: () {
                  setState(() {
                    selectedIndex = 0; // Update selected index
                  });
                  // Handle Export Tracking tap
                  Navigator.pop(context); // Close the drawer
                  // Navigate to the Export Tracking screen or perform related action
                },
              ),
              ListTile(
                leading: ColorFiltered(
                  colorFilter: const ColorFilter.mode(
                    Colors.blue, // Change to your desired dark color
                    BlendMode.srcIn,
                  ),
                  child: Image.asset(
                    'assets/images/import_report.png', // Image for Import Tracking
                    width: 24,
                    height: 30,
                  ),
                ),
                title: Text('Import Tracking', style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 14)),
                selected: selectedIndex == 1, // Mark as selected
                selectedTileColor: Colors.grey.withOpacity(0.3),
                onTap: () {
                  setState(() {
                    selectedIndex = 0; // Update selected index
                  });
                  // Handle Import Tracking tap
                  Navigator.pop(context); // Close the drawer
                  // Navigate to the Import Tracking screen or perform related action
                },
              ),
              ListTile(
                leading: ColorFiltered(
                  colorFilter: const ColorFilter.mode(
                    Colors.blue, // Change to your desired dark color
                    BlendMode.srcIn,
                  ),
                  child: Image.asset(
                    'assets/images/domestic.png', // Image for Domestic Tracking
                    width: 24,
                    height: 30,
                  ),
                ),
                title: Text('Domestic Tracking', style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 14)),
                selected: selectedIndex == 1, // Mark as selected
                selectedTileColor: Colors.grey.withOpacity(0.3),
                onTap: () {
                  setState(() {
                    selectedIndex = 0; // Update selected index
                  });
                  // Handle Domestic Tracking tap
                  Navigator.pop(context); // Close the drawer
                  // Navigate to the Domestic Tracking screen or perform related action
                },
              ),
              ListTile(
                leading: ColorFiltered(
                  colorFilter: const ColorFilter.mode(
                    Colors.blue, // Change to your desired dark color
                    BlendMode.srcIn,
                  ),
                  child: Image.asset(
                    'assets/images/empty.png', // Image for Empty Tracking
                    width: 24,
                    height: 30,
                  ),
                ),
                title: Text('Empty Tracking', style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500, fontSize: 14)),
                selected: selectedIndex == 1, // Mark as selected
                selectedTileColor: Colors.grey.withOpacity(0.3),
                onTap: () {
                  setState(() {
                    selectedIndex = 0; // Update selected index
                  });
                  // Handle Empty Tracking tap
                  Navigator.pop(context); // Close the drawer
                  // Navigate to the Empty Tracking screen or perform related action
                },
              ),
              ListTile(
                leading: ColorFiltered(
                  colorFilter: const ColorFilter.mode(
                    Colors.blue, // Change to your desired dark color
                    BlendMode.srcIn,
                  ),
                  child: Image.asset(
                    'assets/images/transit.png', // Image for Transport Tracking
                    width: 24,
                    height: 30,
                  ),
                ),
                title: Text('Transport Tracking', style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500, fontSize: 14)),
                selected: selectedIndex == 1, // Mark as selected
                selectedTileColor: Colors.grey.withOpacity(0.3),
                onTap: () {
                  setState(() {
                    selectedIndex = 0; // Update selected index
                  });
                  // Handle Transport Tracking tap
                  Navigator.pop(context); // Close the drawer
                  // Navigate to the Transport Tracking screen or perform related action
                },
              ),

              const Divider(),
              const ListTile(
                title: Text('Account'),
                textColor: AppColors.darkGrey,
              ),
              ListTile(
                leading: ColorFiltered(
                  colorFilter: const ColorFilter.mode(
                    Colors.blue, // Change to your desired dark color
                    BlendMode.srcIn,
                  ),
                  child: Image.asset(
                    'assets/images/outstanding.png', // Image for Transport Tracking
                    width: 24,
                    height: 30,
                  ),
                ),
                title: Text('Account Statement', style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500, fontSize: 14)),
                selected: selectedIndex == 1, // Mark as selected
                selectedTileColor: Colors.grey.withOpacity(0.3),
                onTap: () {
                  setState(() {
                    selectedIndex = 0; // Update selected index
                  });
                  // Handle Transport Tracking tap
                  Navigator.pop(context); // Close the drawer
                  // Navigate to the Transport Tracking screen or perform related action
                },
              ),
              ListTile(
                leading: ColorFiltered(
                  colorFilter: const ColorFilter.mode(
                    Colors.blue, // Change to your desired dark color
                    BlendMode.srcIn,
                  ),
                  child: Image.asset(
                    'assets/images/invoice.png', // Image for Transport Tracking
                    width: 24,
                    height: 30,
                  ),
                ),
                title: Text('Invoice', style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 14)),
                selected: selectedIndex == 1, // Mark as selected
                selectedTileColor: Colors.grey.withOpacity(0.3),
                onTap: () {
                  setState(() {
                    selectedIndex = 0; // Update selected index
                  });
                  // Handle Transport Tracking tap
                  Navigator.pop(context); // Close the drawer
                  // Navigate to the Transport Tracking screen or perform related action
                },
              ),

              const Divider(),
              const ListTile(
                title: Text('Inventory'),
                textColor: AppColors.darkGrey,
              ),
              ListTile(
                leading: ColorFiltered(
                  colorFilter: const ColorFilter.mode(
                    Colors.blue, // Change to your desired dark color
                    BlendMode.srcIn,
                  ),
                  child: Image.asset(
                    'assets/images/warehouse.png', // Image for Transport Tracking
                    width: 24,
                    height: 30,
                  ),
                ),
                title: Text('Warehouse Inventory', style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 14)),
                selected: selectedIndex == 1, // Mark as selected
                selectedTileColor: Colors.grey.withOpacity(0.3),
                onTap: () {
                  setState(() {
                    selectedIndex = 0; // Update selected index
                  });
                  // Handle Transport Tracking tap
                  Navigator.pop(context); // Close the drawer
                  // Navigate to the Transport Tracking screen or perform related action
                },
              ),
              ListTile(
                leading: ColorFiltered(
                  colorFilter: const ColorFilter.mode(
                    Colors.blue, // Change to your desired dark color
                    BlendMode.srcIn,
                  ),
                  child: Image.asset(
                    'assets/images/empty.png', // Image for Transport Tracking
                    width: 24,
                    height: 30,
                  ),
                ),
                title: Text('Empty Container Inventory', style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 14)),
                selected: selectedIndex == 1, // Mark as selected
                selectedTileColor: Colors.grey.withOpacity(0.3),
                onTap: () {
                  setState(() {
                    selectedIndex = 0; // Update selected index
                  });
                  // Handle Transport Tracking tap
                  Navigator.pop(context); // Close the drawer
                  // Navigate to the Transport Tracking screen or perform related action
                },
              ),

              const Divider(),
              const ListTile(
                title: Text('Settings'),
                textColor: AppColors.darkGrey,
              ),
              ListTile(
                leading: ColorFiltered(
                  colorFilter: const ColorFilter.mode(
                    Colors.blue, // Change to your desired dark color
                    BlendMode.srcIn,
                  ),
                  child: Image.asset(
                    'assets/images/edit.png', // Image for Transport Tracking
                    width: 24,
                    height: 30,
                  ),
                ),
                title: Text('View Profile', style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 14)),
                selected: selectedIndex == 1, // Mark as selected
                selectedTileColor: Colors.grey.withOpacity(0.3),
                onTap: () {
                  setState(() {
                    selectedIndex = 0; // Update selected index
                  });
                  // Handle Transport Tracking tap
                  Navigator.pop(context); // Close the drawer
                  // Navigate to the Transport Tracking screen or perform related action
                },
              ),
              ListTile(
                leading: ColorFiltered(
                  colorFilter: const ColorFilter.mode(
                    Colors.blue, // Change to your desired dark color
                    BlendMode.srcIn,
                  ),
                  child: Image.asset(
                    'assets/images/ic_change_password_lock.png', // Image for Transport Tracking
                    width: 24,
                    height: 30,
                  ),
                ),
                title: Text('Change Password/mpin', style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 14)),
                selected: selectedIndex == 1, // Mark as selected
                selectedTileColor: Colors.grey.withOpacity(0.3),
                onTap: () {
                  setState(() {
                    selectedIndex = 0; // Update selected index
                  });
                  // Handle Transport Tracking tap
                  Navigator.pop(context); // Close the drawer
                  // Navigate to the Transport Tracking screen or perform related action
                },
              ),
              ListTile(
                leading: ColorFiltered(
                  colorFilter: const ColorFilter.mode(
                    Colors.blue, // Change to your desired dark color
                    BlendMode.srcIn,
                  ),
                  child: Image.asset(
                    'assets/images/logout.png', // Image for Transport Tracking
                    width: 24,
                    height: 30,
                  ),
                ),
                title: Text('Logout', style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 14)),
                selected: selectedIndex == 1, // Mark as selected
                selectedTileColor: Colors.grey.withOpacity(0.3),
                onTap: () {
                  setState(() {
                    selectedIndex = 0; // Update selected index
                  });
                  // Handle Transport Tracking tap
                  Navigator.pop(context); // Close the drawer
                  // Navigate to the Transport Tracking screen or perform related action
                },
              ),
              // Other options
              // const ListTile(
              //   title: Text('Tracking'),
              //   textColor: Colors.grey,
              // ),
            ],
          ),

        ),
      ),

      body: ListView(
        children: [
          // Stack widget to overlay logo on the image

          // Form for company details
          Container(
            decoration: BoxDecoration(color: Colors.white),
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    // Company Name
                    _buildTextFormField('Company Name', 'assets/images/company.png', (value) => companyName = value, initialValue: "ABC Corp",isEditable: false,),

                    SizedBox(height: 10),

                    // Company Address
                    _buildTextFormField('Company Address', 'assets/images/address.png', (value) => companyAddress = value, initialValue: "123, Sample Street",isEditable: false,),

                    SizedBox(height: 10),

                    // Row for Postcode and City
                    Row(
                      children: [
                        // Pin Code (Text Field)
                        Expanded(
                          child: _buildTextFormField('Select Postcode', 'assets/images/postcode.png', (value) => selectedPinCode = value, fontSize: 11.0, initialValue: "123456",isEditable: false,),
                        ),
                        SizedBox(width: 10),
                        // City (Text Field)
                        Expanded(
                          child: _buildTextFormField('City', 'assets/images/city.png', (value) => selectedCity = value, initialValue: "Sample City",isEditable: false,),
                        ),
                      ],
                    ),

                    SizedBox(height: 10),

                    // Row for State and Mobile Number
                    Row(
                      children: [
                        // State (Text Field)
                        Expanded(
                          child: _buildTextFormField('Select State', 'assets/images/state.png', (value) => selectedState = value, fontSize: 12.0, iconSize: 12, initialValue: "Sample State",isEditable: false,),
                        ),
                        SizedBox(width: 10),
                        // Mobile Number
                        Expanded(
                          child: _buildTextFormField('Mobile No', 'assets/images/mobile.png', (value) => mobileNumber = value, iconSize: 8, initialValue: "9876543210",isEditable: false,),
                        ),
                      ],
                    ),

                    SizedBox(height: 10),

                    // Customer Type Section
                    const Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Customer Type',
                        style: TextStyle(fontSize: 14, color: Colors.black),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    SizedBox(height: 3),

                    // Grid of checkboxes
                    GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 4,
                        crossAxisSpacing: 4,
                        childAspectRatio: 4,
                      ),
                      itemCount: customerTypes.length,
                      itemBuilder: (context, index) {
                        final customerType = customerTypes[index];
                        return Row(
                          mainAxisSize: MainAxisSize.min, // Makes the row take up only the space it needs
                          crossAxisAlignment: CrossAxisAlignment.center, // Vertically align checkbox and text to the center
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Transform.scale(
                              scale: 1.0,
                              child: SizedBox(
                                width: 24.0,
                                height: 24.0,
                                // You can reduce this further to shrink the checkbox
                                child: Checkbox(
                                  value: customerType["value"],
                                  onChanged: (value) {
                                    setState(() {
                                      customerType["value"] = value!;
                                    });
                                  },
                                  side: BorderSide(color: Colors.blue, width: 2),
                                  checkColor: Colors.white,
                                ),
                              ),
                            ),
                            // Reduce left padding between the checkbox and the text
                            Padding(
                              padding: const EdgeInsets.all(0.0), // Reduced padding here
                              child: Transform.translate(
                                offset: const Offset(0, 0),
                                child: Text(
                                  customerType["label"],
                                  style: TextStyle(fontSize: 13, color: Colors.grey),
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),

                    SizedBox(height: 24),

                    // PAN No and GST No in the same row
                    Row(
                      children: [
                        // PAN No
                        Expanded(
                          child: _buildTextFormField('PAN No', 'assets/images/pan.png', (value) => contactPersonName = value, initialValue: "ABCDE1234F",isEditable: false,),
                        ),
                        SizedBox(width: 10),
                        // GST No.
                        Expanded(
                          child: _buildTextFormField('GST No.', 'assets/images/gst.png', (value) => contactPersonName = value, initialValue: "22ABCDE1234G1Z2",isEditable: false,),
                        ),
                      ],
                    ),

                    SizedBox(height: 10),

                    // Contact Person Name field
                    _buildTextFormField('Contact Person Name', 'assets/images/conperson.png', (value) => contactPersonName = value, initialValue: "John Doe",isEditable: false,),


                    SizedBox(height: 10),

                    // Email field
                    _buildTextFormField('Email', 'assets/images/emailid.png', (value) => email = value, initialValue: "johndoe@example.com",isEditable: false,),

                    SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to build a text form field
  Widget _buildTextFormField(
      String label,
      String iconPath,
      Function(String?) onSaved, {
        double fontSize = 14.0,
        double iconSize = 8.0,
        String? initialValue,
        bool isEditable = true, // Added a parameter to toggle editability
      }) {
    return TextFormField(
      initialValue: initialValue,
      style: TextStyle(fontSize: 12),
      enabled: isEditable, // Control editability here
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.grey, fontSize: fontSize),
        prefixIcon: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: Image.asset(
              iconPath,
              height: 8,
              width: 8,
              color: AppColors.colorPrimary,
            ),
          ),
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.colorPrimary),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.colorPrimary, width: 2),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.colorPrimary, width: 1),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      ),
      onSaved: isEditable ? onSaved : null, // Prevent saving if not editable
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $label';
        }
        return null;
      },
    );
  }

}

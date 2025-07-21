// edit_profile_screen.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Drawer.dart';
import '../../Sign In/UI/login.dart';
import '../../TitleManager.dart';
import '../../colors.dart';
import '../Repo/ViewProfileReposistry.dart';

class Edit extends StatefulWidget {
  const Edit({super.key});

  @override
  State<Edit> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<Edit> {
  String title = '';
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final ViewProfileApi _userRepository = ViewProfileApi();
  final _formKey = GlobalKey<FormState>();
  int selectedIndex = 0;
  bool isLoading = true;


  // Controllers
  final Map<String, TextEditingController> _controllers = {
    'companyName': TextEditingController(),
    'companyAddress': TextEditingController(),
    'postcode': TextEditingController(),
    'city': TextEditingController(),
    'state': TextEditingController(),
    'mobileNo': TextEditingController(),
    'panNo': TextEditingController(),
    'gstNo': TextEditingController(),
    'personName': TextEditingController(),
    'email': TextEditingController(),
  };

  final List<Map<String, dynamic>> customerTypes = [
    {"label": "Exporter", "value": false},
    {"label": "Importer", "value": false},
    {"label": "CHA", "value": false},
    {"label": "Forwarder", "value": false},
    {"label": "Consignee", "value": false},
    {"label": "Consignor", "value": false},
    {"label": "Shipping Line", "value": false},
    {"label": "Domestic", "value": false},
    {"label": "Consolidator", "value": false},
  ];

  @override
  void initState() {
    super.initState();
    _loadDynamicTitle();
    _loadUserData();
  }

  @override
  void dispose() {
    _controllers.forEach((_, controller) => controller.dispose());
    super.dispose();
  }

  Future<void> _loadUserData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getString('userid') ?? '';

      final user = await _userRepository.fetchViewProfile(userId);

      if (user.value != null && user.value!.isNotEmpty) {
        final userData = user.value!.first;
        setState(() {
          _controllers['companyName']?.text = userData.name ?? '';
          _controllers['companyAddress']?.text = userData.address ?? '';
          _controllers['postcode']?.text = userData.postCode ?? '';
          _controllers['city']?.text = userData.city ?? '';
          _controllers['state']?.text = userData.stateCode ?? '';
          _controllers['mobileNo']?.text = userData.phoneNo ?? '';
          _controllers['panNo']?.text = userData.pANNo ?? '';
          _controllers['gstNo']?.text = userData.gSTRegistrationNo ?? '';
          _controllers['personName']?.text = userData.name ?? '';
          _controllers['email']?.text = userData.eMail ?? '';

          // Update customer types based on API response
          for (var type in customerTypes) {
            switch (type["label"]) {
              case "Exporter":
                type["value"] = userData.exporter ?? false;
                break;
              case "Importer":
                type["value"] = userData.importera ?? false;
                break;
              case "CHA":
                type["value"] = userData.cHA ?? false;
                break;
              case "Forwarder":
                type["value"] = userData.freightForwarder ?? false;
                break;
              case "Consignee":
                type["value"] = userData.consignee ?? false;
                break;
              case "Consignor":
                type["value"] = userData.consignor ?? false;
                break;
              case "Shipping Line":
                type["value"] = userData.shippingLine ?? false;
                break;
              case "Domestic":
                type["value"] = userData.domestic ?? false;
                break;
              case "Consolidator":
                type["value"] = userData.consolidator ?? false;
                break;
            }
          }
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      if (mounted) {

      }
    }
  }

  void _loadDynamicTitle() async {
    final fetchedTitle = await TitleManager.getTitle();
    setState(() {
      title = fetchedTitle;
    });
  }

  Widget _buildTextFormField(
    String label,
    String iconPath,
    TextEditingController controller, {
    bool isEditable = false,
  }) {
    return TextFormField(
      controller: controller,
      enabled: isEditable,
      style: const TextStyle(fontSize: 14,color: Colors.black,),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.black, fontSize: 14),
        prefixIcon: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            iconPath,
            height: 24,
            width: 24,
            color: AppColors.colorPrimary,
          ),
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.colorPrimary),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.colorPrimary, width: 2),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.colorPrimary),
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        floatingLabelBehavior: FloatingLabelBehavior.never,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $label';
        }
        return null;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      key: _scaffoldKey,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100.0),
        child: AppBar(
          backgroundColor: AppColors.colorPrimary,
          elevation: 0,
          automaticallyImplyLeading: false,
          flexibleSpace: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 20,
                    color: AppColors.titlecolor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.menu, color: Colors.white),
                      onPressed: () => _scaffoldKey.currentState?.openDrawer(),
                    ),
                    const Text(
                      "View Profile",
                      style: TextStyle(
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
                              backgroundColor: Colors.white, // Set background color to white
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10), // Optional: Rounded corners
                              ),
                              content: SizedBox(
                                width: 800, // Increase width of the dialog
                                child: const Text('Are You Sure You Want to Exit?',style:TextStyle(fontSize: 16) ,),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(); // Close dialog
                                  },
                                  child: const Text('CANCEL',style:TextStyle(color: Colors.blue),),
                                ),
                                TextButton(
                                  onPressed: () {
                                    // Add your logout logic here
                                    Navigator.of(context).pop(); // Close dialog
                                    Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                        builder: (context) => LoginScreen(),
                                      ),
                                          (route) => false,
                                    );
                                  },
                                  child: const Text('CONFIRM',style:TextStyle(color: Colors.blue),),
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
          onItemTap: (index) {
            setState(() => selectedIndex = index);
            _scaffoldKey.currentState?.closeDrawer();
          },
        ),
      ),
      body: ListView(
        children: [
          Container(
            color: Colors.white,
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTextFormField(
                      'Company Name',
                      'assets/images/company.png',
                      _controllers['companyName']!,
                    ),
                    const SizedBox(height: 10),
                    _buildTextFormField(
                      'Company Address',
                      'assets/images/address.png',
                      _controllers['companyAddress']!,
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: _buildTextFormField(
                            'Select Postcode',
                            'assets/images/postcode.png',
                            _controllers['postcode']!,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _buildTextFormField(
                            'City',
                            'assets/images/city.png',
                            _controllers['city']!,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: _buildTextFormField(
                            'Select State',
                            'assets/images/state.png',
                            _controllers['state']!,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _buildTextFormField(
                            'Mobile No',
                            'assets/images/mobile.png',
                            _controllers['mobileNo']!,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Customer Type',
                      style: TextStyle(fontSize: 14, color: Colors.black),
                    ),
                    const SizedBox(height: 8),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 4,
                        crossAxisSpacing: 4,
                        childAspectRatio: 4,
                      ),
                      itemCount: customerTypes.length,
                      itemBuilder: (context, index) {
                        final type = customerTypes[index];
                        return Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              width: 24,
                              height: 24,
                              child: Checkbox(
                                value: type["value"],
                                  onChanged: (bool? newValue) {
                                    setState(() {
                                      type["value"] = newValue!;
                                    });
                                  },
                                // Disables editing
                                side: const BorderSide(
                                    color: Colors.blue, width: 2),
                                // Blue border
                                checkColor: Colors.white,
                                // Blue checkmark
                                fillColor:
                                    MaterialStateProperty.resolveWith<Color>(
                                  (Set<MaterialState> states) {
                                    if (type["value"] == true) {
                                      return Colors.blue; // Keeps background white when disabled
                                    }
                                    return Colors
                                        .white; // Keeps background white
                                  },
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                type["label"],
                                style: const TextStyle(
                                    fontSize: 13, color: Colors.grey),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: _buildTextFormField(
                            'PAN No',
                            'assets/images/pan.png',
                            _controllers['panNo']!,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _buildTextFormField(
                            'GST No.',
                            'assets/images/gst.png',
                            _controllers['gstNo']!,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    _buildTextFormField(
                      'Contact Person Name',
                      'assets/images/conperson.png',
                      _controllers['personName']!,
                    ),
                    const SizedBox(height: 10),
                    _buildTextFormField(
                      'Email',
                      'assets/images/emailid.png',
                      _controllers['email']!,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

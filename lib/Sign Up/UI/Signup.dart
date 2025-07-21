import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:hpcsl_1/Sign%20Up/UI/showPostcodePicker.dart';
import 'package:hpcsl_1/Sign%20Up/UI/showStatelistPicker.dart';
import 'dart:io';
import '../Model/SignUp_Model.dart';
import '../Repo/PostCodeListReposistry.dart';
import '../../colors.dart';
import '../Repo/SignupReposistry.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {

  final String baseUrl =
      "https://api.businesscentral.dynamics.com/v2.0/efa11a81-6cb7-49b9-bbe4-bedfeef97f2d/SandBox16Dec2024/ODataV4/Company('CRONUS%20IN')/";


  TextEditingController _textController = TextEditingController();
  TextEditingController postcodeController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController signupController = TextEditingController();
  TextEditingController companyName = TextEditingController();
  TextEditingController companyAddress = TextEditingController();
  TextEditingController selectedCity = TextEditingController();
  TextEditingController selectedState = TextEditingController();
  TextEditingController mobileNumber = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController contactPersonName = TextEditingController();
  TextEditingController PanNo = TextEditingController();
  TextEditingController GstNo = TextEditingController();

  // Pass baseUrl when initializing SignUpApi
  SignUpApi signup = SignUpApi();
  final _formKey = GlobalKey<FormState>();
  String? panFilePath, gstFilePath, selectedPinCode;

  @override
  void dispose() {
    _textController.dispose();
    postcodeController.dispose();
    stateController.dispose();
    signupController.dispose();
    companyName.dispose();
    companyAddress.dispose();
    selectedCity.dispose();
    selectedState.dispose();
    mobileNumber.dispose();
    email.dispose();
    contactPersonName.dispose();
    PanNo.dispose();
    GstNo.dispose();
    super.dispose();
  }

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

  Future<void> _pickFile(String type) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      File file = File(result.files.single.path!);
      setState(() {
        if (type == "PAN") {
          panFilePath = file.path;
        } else if (type == "GST") {
          gstFilePath = file.path;
        }
      });
      print('Picked file for $type: ${file.path}');
    } else {
      print('No file selected for $type');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: AppColors.colorPrimary,
      ),
      body: Stack(
        children: [
          ListView(
            children: [
              Container(
                height: 273,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/blue_bg.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Center(
                  child: Image.asset(
                    'assets/images/logo.png',
                    height: 130,
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(color: Colors.white),
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        _buildTextFormField(
                          'Company Name',
                          'assets/images/company.png',
                          (value) {
                            companyName.text = value ?? '';
                          },
                          controller: companyName,
                        ),
                        SizedBox(height: 10),
                        _buildTextFormField(
                          'Company Address',
                          'assets/images/address.png',
                          (value) {
                            companyAddress.text = value ?? '';
                          },
                          maxLines: 4,
                          minLines: 2,
                          fieldHeight: 70.0,
                          keyboardType: TextInputType.multiline,
                          controller: companyAddress,
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: _buildTextFormField(
                                selectedPinCode ?? 'Select Postcode',
                                'assets/images/postcode.png',
                                (value) {
                                  setState(() {
                                    selectedPinCode = value;
                                  });
                                },
                                fontSize: 14.0,
                                readOnly: true,
                                defaultTextColor: Colors.grey,
                                controller: postcodeController,
                                onTap: () async {
                                  final result =
                                      await showDialog<Map<String, String>>(
                                    context: context,
                                    builder: (context) => Dialog(
                                      backgroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.zero,
                                      ),
                                      child: SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.9,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.9,
                                        child: const PostcodeList(),
                                      ),
                                    ),
                                  );

                                  if (result != null) {
                                    setState(() {
                                      selectedPinCode = result['postcode'];
                                      selectedCity.text = result['city'] ?? '';
                                    });
                                    postcodeController.text =
                                        selectedPinCode ?? '';
                                  }
                                },
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: _buildTextFormField(
                                'City',
                                'assets/images/city.png',
                                (value) {
                                  selectedCity.text = value ?? '';
                                },
                                fontSize: 14.0,
                                readOnly: true,
                                controller: selectedCity,
                                defaultTextColor: selectedCity.text.isNotEmpty
                                    ? Colors.black
                                    : Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: _buildTextFormField(
                                'State',
                                'assets/images/state.png',
                                (value) {
                                  selectedState.text = value ?? '';
                                },
                                fontSize: 14.0,
                                iconSize: 12,
                                readOnly: true,
                                controller: stateController,
                                onTap: () async {
                                  final state = await showDialog<String>(
                                    context: context,
                                    builder: (context) => Dialog(
                                      backgroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.zero,
                                      ),
                                      child: SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.9,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.9,
                                        child: const StateList(),
                                      ),
                                    ),
                                  );
                                  print('Statelocal $state');
                                  if (state != null && state.isNotEmpty) {
                                    setState(() {
                                      stateController.text = state;
                                    });
                                  }
                                },
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: _buildTextFormField(
                                'Mobile No',
                                'assets/images/mobile.png',
                                (value) {
                                  mobileNumber.text = value ?? '';
                                },
                                controller: mobileNumber,
                                iconSize: 8,
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 10),
                        const Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Customer Type',
                            style: TextStyle(fontSize: 14, color: Colors.black),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        SizedBox(height: 3),
                        GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 4,
                            crossAxisSpacing: 4,
                            childAspectRatio: 4,
                          ),
                          itemCount: customerTypes.length,
                          itemBuilder: (context, index) {
                            final customerType = customerTypes[index];
                            return Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Transform.scale(
                                  scale: 1.0,
                                  child: SizedBox(
                                    width: 24.0,
                                    height: 24.0,
                                    child: Checkbox(
                                      value: customerType["value"],
                                      onChanged: (value) {
                                        setState(() {
                                          customerType["value"] = value!;
                                        });
                                      },
                                      side: BorderSide(
                                          color: Colors.blue, width: 2),
                                      checkColor: Colors.white,
                                      activeColor: Colors.blue,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(0.0),
                                  child: Text(
                                    customerType["label"],
                                    style: TextStyle(
                                        fontSize: 13, color: Colors.grey),
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                        SizedBox(height: 24),
                        Row(
                          children: [
                            Expanded(
                              child: _buildTextFormField(
                                'PAN No',
                                'assets/images/pan.png',
                                (value) {
                                  PanNo.text = value ?? '';
                                },
                                controller: PanNo,
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: _buildTextFormField(
                                'GST No.',
                                'assets/images/gst.png',
                                (value) {
                                  GstNo.text = value ?? '';
                                },
                                controller: GstNo,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        _buildTextFormField(
                          'Contact Person Name',
                          'assets/images/conperson.png',
                          (value) {
                            contactPersonName.text = value ?? '';
                          },
                          controller: contactPersonName,
                        ),
                        SizedBox(height: 10),
                        _buildTextFormField(
                          'Email',
                          'assets/images/emailid.png',
                          (value) {
                            email.text = value ?? '';
                          },
                          controller: email,
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: TextButton(
                                onPressed: () => _pickFile("PAN"),
                                style: TextButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 16.0),
                                  side: BorderSide(
                                      color: AppColors.colorPrimary, width: 1),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/images/upload.png',
                                      height: 24,
                                      width: 24,
                                      color: AppColors.colorPrimary,
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      panFilePath == null
                                          ? "Upload PAN"
                                          : "PAN Selected",
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: TextButton(
                                onPressed: () => _pickFile("GST"),
                                style: TextButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 16.0),
                                  side: BorderSide(
                                      color: AppColors.colorPrimary, width: 1),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/images/upload.png',
                                      height: 24,
                                      width: 24,
                                      color: AppColors.colorPrimary,
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      gstFilePath == null
                                          ? "Upload GST"
                                          : "GST Selected",
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                minimumSize: Size(double.infinity, 40),
                              ),

                              // In your _SignupState class, modify the onPressed of the signup button
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();

                                  // Show loading indicator
                                  showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (BuildContext context) {
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    },
                                  );

                                  String? stateCode = await SetStateCode.getStateCode();
                                  // Create the signup model from the form data
                                  SignUpModel signupModel = SignUpModel(
                                    companyName: companyName.text,
                                    companyAddress: companyAddress.text,
                                    postCode: postcodeController.text,
                                    city: selectedCity.text,
                                    state: stateCode ?? '',
                                    mobileNo: mobileNumber.text,
                                    pANNo: PanNo.text,
                                    gSTNo: GstNo.text,
                                    contactPersonName: contactPersonName.text,
                                    emailID: email.text,
                                    uploadPAN: panFilePath,
                                    uploadGST: gstFilePath,
                                    exporter: customerTypes[0]["value"],
                                    importer: customerTypes[1]["value"],
                                    cHA: customerTypes[2]["value"],
                                    forwarder: customerTypes[3]["value"],
                                    consignee: customerTypes[4]["value"],
                                    consignor: customerTypes[5]["value"],
                                    shippingLine: customerTypes[6]["value"],
                                    domestic: customerTypes[7]["value"],
                                    consolidator: customerTypes[8]["value"],
                                  );

                                  // debugPrint(signupModel as String?);
                                  print(signupModel.toJson()); // If you have a toJson() method in your model

                                  // Pass the model to your API method
                                  try {
                                    await signup.registration(signupModel);  // Pass baseUrl here
                                    Navigator.pop(context); // Hide loading indicator
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Registration Successful!')),
                                    );
                                    Navigator.of(context).pop(); // Return to previous screen
                                  } catch (error) {
                                    Navigator.pop(context); // Hide loading indicator
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('Registration Failed: $error')),
                                    );
                                  }
                                } else {
                                  // If validation fails, show a message
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Please fill all required fields correctly.')),
                                  );
                                }
                              },

                              child: Text(
                                'Sign Up',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTextFormField(
    String label,
    String iconPath,
    Function(String?) onSaved, {
    double fontSize = 14.0,
    double iconSize = 8.0,
    VoidCallback? onTap,
    bool readOnly = false,
    TextEditingController? controller,
    Color? defaultTextColor = Colors.grey,
    String? initialValue,
    int? maxLines,
    int? minLines,
    TextInputType? keyboardType,
    double? fieldHeight,
  }) {
    return TextFormField(
      readOnly: readOnly,
      controller: controller,
      initialValue: initialValue,
      maxLines: maxLines ?? 1,
      minLines: minLines ?? 1,
      keyboardType: keyboardType,
      style: TextStyle(
        fontSize: fontSize,
        color: Colors.black,
      ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.grey, fontSize: fontSize),
        hintStyle: TextStyle(color: Colors.grey),
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
        floatingLabelBehavior: FloatingLabelBehavior.never,
        alignLabelWithHint: true,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.colorPrimary),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.colorPrimary, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.colorPrimary, width: 1),
        ),
        contentPadding: EdgeInsets.symmetric(
          vertical: fieldHeight != null ? (fieldHeight - fontSize) / 2 : 12.0,
          horizontal: 12.0,
        ),
      ),
      onTap: onTap,
      onSaved: onSaved,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $label';
        }
        // Add email validation
        if (label == 'Email' && !_isValidEmail(value)) {
          return 'Please enter a valid email address';
        }
        // Add mobile number validation
        if (label == 'Mobile No' && !_isValidMobile(value)) {
          return 'Please enter a valid 10-digit mobile number';
        }
        // Add PAN validation
        if (label == 'PAN No' && !_isValidPAN(value)) {
          //return 'Please enter a valid PAN number';
        }
        // Add GST validation
        if (label == 'GST No.' && !_isValidGST(value)) {
          // return 'Please enter a valid GST number';
        }
        return null;
      },
    );
  }

  // Validation methods
  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  bool _isValidMobile(String mobile) {
    return RegExp(r'^[0-9]{10}$').hasMatch(mobile);
  }

  bool _isValidPAN(String pan) {
    return RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]{1}$').hasMatch(pan);
  }

  bool _isValidGST(String gst) {
    return RegExp(r'^[0-9]{2}[A-Z]{5}[0-9]{4}[A-Z]{1}[1-9A-Z]{1}Z[0-9A-Z]{1}$')
        .hasMatch(gst);
  }
}

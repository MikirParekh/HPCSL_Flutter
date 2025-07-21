import 'package:flutter/material.dart';
import 'package:hpcsl_1/ChangePassword/Repo/ChangePassRepositry.dart';
import 'package:hpcsl_1/colors.dart';

import '../../Drawer.dart';
import '../../Sign In/UI/login.dart';
import '../../TitleManager.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePassword();
}

class _ChangePassword extends State<ChangePassword> {
  String title = '';
  final String subtitle = "Change Password/mpin";
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int selectedIndex = 0;
  final GlobalKey<FormState> _passwordFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _mpinFormKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _mpinController = TextEditingController();
  final TextEditingController _confirmMpinController = TextEditingController();
  final TextEditingController _noController = TextEditingController();
  final TextEditingController _tokenController = TextEditingController();

  ChangePasswordApi password = ChangePasswordApi();

  @override
  void initState() {
    super.initState();
    _loadDynamicTitle();
  }

  void _loadDynamicTitle() async {
    final fetchedTitle = await TitleManager.getTitle();
    setState(() {
      title = fetchedTitle;
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
        child: SingleChildScrollView(
          child: Form(
            key: _passwordFormKey,
            child: Column(
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Change Password',
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ),
                const SizedBox(height: 12.7),
                _buildInputField(
                  context,
                  controller: _passwordController,
                  iconPath: 'assets/images/pass.png',
                  hintText: 'Password',
                  inputType: TextInputType.visiblePassword,
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12.7),
                _buildInputField(
                  context,
                  controller: _confirmPasswordController,
                  iconPath: 'assets/images/pass.png',
                  hintText: 'Confirm Password',
                  inputType: TextInputType.visiblePassword,
                  obscureText: true,
                  validator: (value) {
                    if (value != _passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 6.0),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          if ( _passwordFormKey.currentState!.validate()) {
                            print("Password: ${_passwordController.text}"); // Debug print
                            print("Confirm Password: ${_confirmPasswordController.text}"); // Debug print
                            print("Mobile Number: ${_noController.text}"); // Debug print
                            print("Token: ${_tokenController.text}"); // Debug print

                            // Call the changePassword method for password
                            await password.updateLoginData(
                              _noController.text,          // Same for mobile number
                              _passwordController.text,
                              _confirmPasswordController.text,
                              _tokenController.text,       // Same for token
                            );

                            // Show success message
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Password updated successfully')),
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
                        child: const Text('Update Password', style: TextStyle(fontSize: 18)),
                      ),
                    ),
                    const SizedBox(width: 6.0),
                  ],
                ),
                const SizedBox(height: 16.0),

               Form(
               key: _mpinFormKey,
                 child: Column(
                    children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Change MPIN',
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ),
                const SizedBox(height: 12.7),
                _buildInputField(
                  context,
                  controller: _mpinController,
                  iconPath: 'assets/images/pass.png',
                  hintText: 'Mpin',
                  inputType: TextInputType.visiblePassword,
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an MPIN';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12.7),
                _buildInputField(
                  context,
                  controller: _confirmMpinController,
                  iconPath: 'assets/images/pass.png',
                  hintText: 'Confirm Mpin',
                  inputType: TextInputType.visiblePassword,
                  obscureText: true,
                  validator: (value) {
                    if (value != _mpinController.text) {
                      return 'MPINs do not match';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 6.0),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_mpinFormKey.currentState!.validate()) {
                            print("MPIN: ${_mpinController.text}"); // Debug print
                            print("Confirm MPIN: ${_confirmMpinController.text}"); // Debug print

                            // Call the changePassword method for MPIN
                            await password.updateLoginData(
                              _noController.text,          // Same for mobile number
                              _mpinController.text,
                              _confirmMpinController.text,
                              _tokenController.text,       // Same for token
                            );

                            // Show success message
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('MPIN updated successfully')),
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
                        child: const Text('Update Mpin', style: TextStyle(fontSize: 18)),
                      ),
                    ),
                    const SizedBox(width: 6.0),
                  ],
                ),
                const SizedBox(height: 16.0),
              ],
            ),
          ),
        ],
    ),
      ),
    ),
    )
    );
  }

  Widget _buildInputField(BuildContext context, {
    required String iconPath,
    required String hintText,
    required TextInputType inputType,
    bool obscureText = false,
    required TextEditingController controller,
    String? Function(String?)? validator,
    int? maxLength}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Container(
        height: 56.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.blue),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                iconPath,
                width: 20,
                height: 20,
              ),
            ),
            Expanded(
              child: TextFormField(
                controller: controller,
                keyboardType: inputType,
                obscureText: obscureText,
                maxLength: maxLength,
                validator: validator,
                decoration: InputDecoration(
                  hintText: hintText,
                  counterText: '',
                  border: InputBorder.none,
                  hintStyle: const TextStyle(color: Colors.grey),
                ),
                style: const TextStyle(fontSize: 15.0, color: Colors.black),
              ),
            )
          ],
        ),
      ),
    );
  }
}

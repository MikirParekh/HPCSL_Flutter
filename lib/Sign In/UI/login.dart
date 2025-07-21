import 'package:flutter/material.dart';
import 'package:hpcsl_1/ForgetUserId/UI/ForgetUserId.dart';
import 'package:hpcsl_1/Sign%20In/Repo/SiginReposistry.dart';
import '../../ForgetMpin/UI/ForgetMpin.dart';
import '../../ForgetPassword/UI/ForgetPassword.dart';
import '../../Sign Up/UI/Signup.dart';
import '../../TokenRepo.dart';
import '../../colors.dart';

class LoginScreen extends StatelessWidget {

  SignInRepo singinRepo = SignInRepo();
  final TextEditingController userIdController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController mpinController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white, // Set the background color for the entire screen
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(height: 40,color: AppColors.colorPrimary,),
              Container(
                height: 273,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/blue_bg.png'), // Replace with your drawable resource
                    fit: BoxFit.cover,
                  ),
                ),
                child: Center(
                  child: Image.asset(
                    'assets/images/logo.png', // Replace with your logo resource
                    height: 130,
                  ),
                ),
              ),
              const SizedBox(height: 14),
              _buildInputField(
                context,
                iconPath: 'assets/images/user.png', // Custom image for User ID
                hintText: 'User ID',
                inputType: TextInputType.emailAddress,
                controller: userIdController,
              ),
              const SizedBox(height: 12.7),
              _buildInputField(
                context,
                iconPath: 'assets/images/pass.png', // Custom image for Password
                hintText: 'Password',
                inputType: TextInputType.visiblePassword,
                obscureText: true,
                controller: passwordController,
              ),
              const SizedBox(height: 12.7),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Row(
                  children: [
                    Expanded(child: Divider(color: AppColors.colorPrimary)),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40.0),
                      child: Text(
                        "OR",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    Expanded(child: Divider(color: Theme.of(context).primaryColor)),
                  ],
                ),
              ),
              const SizedBox(height: 12.7),
              _buildInputField(
                context,
                iconPath: 'assets/images/pan.png', // Custom image for MPIN
                hintText: 'MPIN',
                inputType: TextInputType.emailAddress,
                obscureText: true,
                maxLength: 10,
                controller: mpinController
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ForgetUserId ()),
                        );
                      },
                      child: const Text(
                        'Forgot User ID?',
                        style: TextStyle(
                          color: AppColors.colorPrimary,
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>  ForgetPassword()),
                        );
                      }, // Add your navigation here
                      child: const Text(
                        'Forgot Password?',
                        style: TextStyle(
                          color: AppColors.colorPrimary,
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ForgetMPIN()),
                    );
                  }, // Add your navigation here
                  child: const Text(
                    'Forgot MPIN?',
                    style: TextStyle(
                      color: AppColors.colorPrimary,
                      fontSize: 17,
                       fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 18.7),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 26.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue, // Replace with your blue fill rounded color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 5),
                  ),
                  // onPressed: () async {
                  //   if (userIdController.text.toString().trim().isNotEmpty) {
                  //     if (passwordController.text.toString().trim().isNotEmpty) {
                  //       await singinRepo.login(context, userIdController.text, passwordController.text);
                  //
                  //    }
                  //     else {
                  //       print('Error1');
                  //     }
                  //   } else {
                  //     print('Error1');
                  //   }
                  // },
                  onPressed: () async {
                    final userId = userIdController.text.trim();
                    final password = passwordController.text.trim();
                    final mpin = mpinController.text.trim();

                    if (mpin.isNotEmpty) {

                      userIdController.clear();
                      passwordController.clear();

                      try {
                        await singinRepo.login(context, '', '', mpin);
                      } catch (e) {
                        print('MPIN Login Error: $e');
                      }
                    }
                    else if (userId.isNotEmpty && password.isNotEmpty) {
                      mpinController.clear();

                      try {
                        await singinRepo.login(context, userId, password, '');
                      } catch (e) {
                        // Error handling is done in the repository
                        print('User ID + Password Login Error: $e');
                      }
                    }
                    else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please enter either MPIN OR both User ID and Password'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },

                  child: const Text(
                    'Login',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'New User?',
                      style: TextStyle(fontSize: 20),
                    ),
                    const SizedBox(width: 5),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Signup()),
                        );
                      }, // Add your sign-up navigation here
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(
                          color: AppColors.colorPrimary,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(BuildContext context,
      {required String iconPath, // Change to accept image path
        required String hintText,
        required TextInputType inputType,
        bool obscureText = false,
        int? maxLength,
        TextEditingController? controller}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Container(
        height: 56.0, // Adjusted to match your Android layout height
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.blue), // Border color
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                iconPath, // Use the custom image here
                width: 20, // Adjust width as needed
                height: 20, // Adjust height as needed
              ),
            ),
            Expanded(
              child: TextField(
                controller: controller,
                keyboardType: inputType,
                obscureText: obscureText,
                maxLength: maxLength,
                decoration: InputDecoration(
                  hintText: hintText,
                  counterText: '',
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.grey)
                ),
                style: TextStyle(fontSize: 15.0,color: Colors.black),
            ),
            )],
        ),
      ),
    );
  }
}

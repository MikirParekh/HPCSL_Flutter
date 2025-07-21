import 'package:flutter/material.dart';

class ForgetUserID extends StatefulWidget {
  const ForgetUserID({super.key});

  @override
  State<ForgetUserID> createState() => _ForgetUserIDState();
}

class _ForgetUserIDState extends State<ForgetUserID> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Stack widget to overlay logo on the image
          Container(
            margin: const EdgeInsets.all(0),
            height: 300,
            width: double.infinity,
            child: Stack(
              children: [
                // Header Image
                Positioned.fill(
                  child: Image.asset(
                    'assets/images/blue_bg.png', // Replace with your image asset
                    fit: BoxFit.fill,
                  ),
                ),
                // Logo centered on top of the image
                Center(
                  child: Image.asset(
                    'assets/images/logo.png', // Replace with your logo asset
                    height: 200,
                    width: 200,
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
          ),

          // Text Field for Mobile Number or Email ID
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Mobile Number or email id',
                hintStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person,color: Colors.blue), // or use Icons.phone for phone number
              ),
              keyboardType: TextInputType.emailAddress, // Change to number for mobile
            ),
          ),

          // Send Button (Full width, white text, blue background)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
            child: ElevatedButton(
              onPressed: () {
                // Handle the Send button click
                String input = _controller.text;
                print('Entered: $input');
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50), // Full width
                backgroundColor: Colors.blue, // Blue background
              ),
              child: Text(
                'Send',
                style: TextStyle(color: Colors.white), // White text color
              ),
            ),
          ),

          // Note Text
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Note: Please enter your registered mobile number or email ID',
              style: TextStyle(fontSize: 16, color: Colors.blue,fontWeight: FontWeight.bold),

            ),
          ),
        ],
      ),
    );
  }
}

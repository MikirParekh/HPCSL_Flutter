import 'package:flutter/material.dart';
import '../Repo/ForgetMpinRepositry.dart';

class ForgetMPIN extends StatefulWidget {
  const ForgetMPIN({super.key});

  @override
  State<ForgetMPIN> createState() => _ForgetUserIDState();
}

class _ForgetUserIDState extends State<ForgetMPIN> {
  final TextEditingController _controller = TextEditingController(); // Corrected variable name
  bool _loading = false;
  String _message = '';
  final ForgotMPINRepository _repository = ForgotMPINRepository();



  bool _validateInput(String input, bool isEmail) {
    if (isEmail) {
      return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(input);
    } else {
      return input.length == 10 && RegExp(r'^[0-9]{10}$').hasMatch(input);
    }
  }

void _submit() async {
  if (_controller.text.isEmpty) {
    setState(() {
      _message = 'Please enter your mobile number or email address';
    });
    return;
  }

  setState(() {
    _loading = true;
    _message = '';
  });

  try {
    final isEmail = _controller.text.contains('@');

    if (!_validateInput(_controller.text, isEmail)) {
      setState(() {
        _message = isEmail
            ? 'Please enter a valid email address'
            : 'Please enter a valid 10-digit mobile number';
        _loading = false;
      });
      return;
    }

    final textLink = "http://52.172.139.203:8090/Login/resetMPIN?id=${_controller.text}";

    final response = await _repository.forgotMPIN(
      _controller.text,
      textLink,
      isEmail: isEmail,
    );

    setState(() {
      _message = response[1];
      if (response[0] == 'success') {
        _controller.clear();
      }
    });
  } catch (e) {
    setState(() {
      _message = 'Error: ${e.toString()}';
    });
  } finally {
    setState(() {
      _loading = false;
    });
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
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
                controller: _controller, // Corrected variable name
                decoration: InputDecoration(
                  labelText: 'Mobile Number or Email ID',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person, color: Colors.blue), // or use Icons.phone for phone number
                ),
                keyboardType: TextInputType.phone, // Updated to phone for mobile number
              ),
            ),

            // Send Button (Full width, white text, blue background)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
              child: ElevatedButton(
                onPressed: _loading ? null : _submit, // Corrected onPressed callback
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50), // Full width
                  backgroundColor: Colors.blue, // Blue background
                ),
                child: _loading
                    ? CircularProgressIndicator(color: Colors.white)
                    : Text(
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
                style: TextStyle(fontSize: 16, color: Colors.blue, fontWeight: FontWeight.bold),
              ),
            ),

            // Display message
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                _message,
                style: TextStyle(fontSize: 16, color: Colors.red, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

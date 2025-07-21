// lib/screens/forget_user_id_screen.dart
import 'package:flutter/material.dart';
import '../Repo/ForgetUserIdReposistry.dart';


class ForgetUserId extends StatefulWidget {
  const ForgetUserId({super.key});

  @override
  State<ForgetUserId> createState() => _ForgetUserIdState();
}

class _ForgetUserIdState extends State<ForgetUserId> {
  final TextEditingController _controller = TextEditingController();
  final ForgotUserIdRepository _repository = ForgotUserIdRepository();
  bool _loading = false;
  String _message = '';

  void _submit() async {
    if (_controller.text.isEmpty) {
      setState(() =>
      _message = 'Please enter your mobile number or email address');
      return;
    }

    final isEmail = _controller.text.contains('@');

    if (!_validateInput(_controller.text, isEmail)) {
      setState(() {
        _message = isEmail
            ? 'Please enter a valid email address'
            : 'Please enter a valid 10-digit mobile number';
      });
      return;
    }

    setState(() {
      _loading = true;
      _message = '';
    });

    try {
      final response = await _repository.forgotUserId(
          _controller.text, isEmail: isEmail);
      setState(() {
        _message = response[1];
        if (response[0] == 'success') _controller.clear();
      });
    } catch (e) {
      setState(() => _message = 'Error: ${e.toString()}');
    } finally {
      setState(() => _loading = false);
    }
  }

  bool _validateInput(String input, bool isEmail) {
    if (isEmail) {
      return RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
          .hasMatch(input);
    } else {
      return RegExp(r"^[0-9]{10}$").hasMatch(input);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header with background and logo
            Container(
              height: 300,
              width: double.infinity,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.asset(
                      'assets/images/blue_bg.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                  Center(
                    child: Image.asset(
                      'assets/images/logo.png',
                      height: 200,
                      width: 200,
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
            ),

            // Input field
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  labelText: 'Mobile Number or Email ID',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person, color: Colors.blue),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
                keyboardType: TextInputType.text,
              ),
            ),

            // Submit button
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 20.0,
                horizontal: 16.0,
              ),
              child: ElevatedButton(
                onPressed: _loading ? null : _submit,
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: _loading
                    ? CircularProgressIndicator(color: Colors.white)
                    : Text(
                  'Send',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            // Note text
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Note: Please enter your registered mobile number or email ID',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            // Error/Success message
            if (_message.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  _message,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

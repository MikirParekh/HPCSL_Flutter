import 'package:flutter/material.dart';
import '../Repo/ForgetPasswordRepositry.dart';


class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final TextEditingController controller = TextEditingController();
  bool loading = false;
  String message = '';
  final ForgotPasswordRepository repository = ForgotPasswordRepository();

  bool _validateInput(String input, bool isEmail) {
    if (isEmail) {
      return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(input);
    } else {
      return input.length == 10 && RegExp(r'^[0-9]{10}$').hasMatch(input);
    }
  }

  void _submit() async {
    final input = controller.text.trim();

    if (input.isEmpty) {
      setState(() {
        message = 'Please enter your mobile number or email address';
      });
      return;
    }

    setState(() {
      loading = true;
      message = '';
    });

    try {
      final isEmail = input.contains('@');

      if (!_validateInput(input, isEmail)) {
        setState(() {
          message = isEmail
              ? 'Please enter a valid email address'
              : 'Please enter a valid 10-digit mobile number';
          loading = false;
        });
        return;
      }

      final textLink = "http://52.172.139.203:8090/Login/resetpassword?id=$input";

      final response = await repository.forgotPASSWORD(
        input,
        textLink,
        isEmail: isEmail,
      );

      setState(() {
        message = response[1];
        if (response[0] == 'success') {
          controller.clear();
        }
      });
    } catch (e) {
      setState(() {
        message = 'Error: ${e.toString()}';
      });
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(0),
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  labelText: 'Mobile Number or Email ID',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person, color: Colors.blue),
                ),
                keyboardType: TextInputType.text,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
              child: ElevatedButton(
                onPressed: loading ? null : _submit,
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  backgroundColor: Colors.blue,
                ),
                child: loading
                    ? CircularProgressIndicator(color: Colors.white)
                    : Text(
                  'Send',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Note: Please enter your registered mobile number or email ID',
                style: TextStyle(fontSize: 16, color: Colors.blue, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                message,
                style: TextStyle(fontSize: 16, color: Colors.red, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
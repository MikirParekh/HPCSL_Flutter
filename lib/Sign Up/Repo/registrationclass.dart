// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// import 'SignupReposistry.dart';
//
// class Registration {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   late String companyName, companyAddress, selectedCity, selectedState, mobileNumber, email, contactPersonName, selectedPinCode;
//
//   Future<void> submitSignup(BuildContext context) async {
//     if (_formKey.currentState?.validate() ?? false) {
//       // Construct data to be sent in the request body
//       var data = {
//         "companyName": companyName,
//         "companyAddress": companyAddress,
//         "selectedCity": selectedCity,
//         "selectedState": selectedState,
//         "mobileNumber": mobileNumber,
//         "email": email,
//         "contactPersonName": contactPersonName,
//         "selectedPinCode": selectedPinCode,
//         // Add PAN and GST file paths if needed
//       };
//
//       try {
//         // Call the registration API repository here
//         var registrationRepo = SignUpRepo();
//         var signupResponse = await registrationRepo.registration(context, data);
//
//         // Handle the success or further processing
//         if (signupResponse != null) {
//           // Do something after successful registration, e.g., show a message
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text('Registration successful!')),
//           );
//         }
//       } catch (e) {
//         // Handle errors (e.g., show an error message)
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Registration failed: ${e.toString()}')),
//         );
//       }
//     }
//   }
// }

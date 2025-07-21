import 'package:hpcsl_1/Domestic/Model/Domestic_model.dart';
import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  final String errorImage;
  final String titleMsg;
  final String msg;
  const ErrorScreen({super.key,required this.errorImage,required this.titleMsg,required this.msg});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      child: Column(
        children: [
          Image.asset(errorImage,height: 197,width: 300,),
          Text(titleMsg,style: Theme.of(context).textTheme.labelLarge?.copyWith(
            color: Colors.blue,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            // Set your desired color here
          ),),
          Text(msg,style: Theme.of(context).textTheme.labelSmall,),
        ],
      ),
    );
  }
}


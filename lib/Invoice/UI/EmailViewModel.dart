// view_models/email_view_model.dart
import 'package:flutter/material.dart';
import 'package:hpcsl_1/Invoice/Repo/InvoiceRepositry.dart';

class EmailViewModel extends ChangeNotifier {
  final InvoiceApi repository;
  bool isLoading = false;
  String? error;
  bool success = false;

  EmailViewModel(this.repository);

  Future<void> sendEmail(String invoiceNumber) async {
    isLoading = true;
    error = null;
    success = false;
    notifyListeners();

    try {
      final response = await repository.sendEmail(invoiceNumber);
      success = response.success;
      if (!response.success) {
        error = response.message;
      }
    } catch (e) {
      error = e.toString();
      success = false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
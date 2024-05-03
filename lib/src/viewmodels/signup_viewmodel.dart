import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/database/database_service.dart';

class SignupViewModel extends ChangeNotifier {
  final DatabaseService databaseService;

  SignupViewModel(this.databaseService);

  Future<void> signUpWithEmailAndPassword(
      String email, String password, String name) async {
    // Implement sign-up logic here
    // Call databaseService methods to save user information
  }

  bool validateEmail(String email) {
    // Implement email validation logic
    return true;
  }

  // Add more methods as needed
}

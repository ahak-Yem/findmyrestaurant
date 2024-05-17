import 'package:findmyrestaurant/src/services/dotenv_service.dart';
import 'dart:math';
import 'package:flutter/services.dart';

class EmailService {
  // Singleton Section
  EmailService._();
  static final EmailService _instance = EmailService._();
  factory EmailService() => _instance;
  static EmailService get instance => _instance;

  final DotenvService _dotenvService = DotenvService.instance; 
  
  String? _htmlText; 

  Future<void> initialize() async{
    _htmlText = await _fetchLocalEmailTemplate();
  }

  Future<String> _fetchLocalEmailTemplate() async{
    const String htmlFilePath = "assets/html pages/confirm_email.html";
    String templateText = _injectConfirmationCodeInHtml(await rootBundle.loadString(htmlFilePath));
    return templateText;
  }

  String _injectConfirmationCodeInHtml(String htmlString, {final int codeLength = 6}) {
    const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
    String confirmationCode = List.generate(codeLength, (index) => chars[Random().nextInt(chars.length)]).join();
    final RegExp regex = RegExp(r'<p id="confirmationCode" class="default-button"></p>');
    String htmlContent = htmlString.replaceAllMapped(regex, (match) {
      return '<p id="confirmationCode" class="default-button">$confirmationCode</p>';
    });
    return htmlContent;
  }
  
  Future<bool> sendOTP(String userEmail) async {
    bool isSent = false;
    return isSent;
  }

  bool verifyOTP(String enteredOTP) {
    bool result = false;
    return result;
  }
}

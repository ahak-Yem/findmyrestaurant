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
  
  String _confirmationCode = "";
  String get confirmationCode => _confirmationCode;
  bool isEmailReady = false;

  Future<void> initialize() async{
    _htmlText = await _setConfirmEmailTemplate();
  }

  Future<String> _setConfirmEmailTemplate() async{
    const String htmlFilePath = "assets/html pages/confirm_email.html";
    String templateText = "";
    try{
      String htmlOrig = await rootBundle.loadString(htmlFilePath);
      templateText = _injectConfirmationCodeInHtml(htmlOrig);
      isEmailReady = true;
    }
    catch(e){
      isEmailReady = false;
    }
    return templateText;
  }

  String _injectConfirmationCodeInHtml(String htmlString,) {
    _setConfiramtionCode();
    final RegExp regex = RegExp(r'<p id="confirmationCode" class="default-button"></p>');
    String htmlContent = htmlString.replaceAllMapped(regex, (match) {
      return '<p id="confirmationCode" class="default-button">$confirmationCode</p>';
    });
    return htmlContent;
  }
  
  void _setConfiramtionCode({final int codeLength = 6}){
    const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
    _confirmationCode = List.generate(codeLength, (index) => chars[Random().nextInt(chars.length)]).join();
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
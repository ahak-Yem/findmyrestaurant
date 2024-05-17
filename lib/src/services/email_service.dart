import 'package:findmyrestaurant/src/enums/dotenv_keys_enum.dart';
import 'package:findmyrestaurant/src/services/confirmation_code_service.dart';
import 'package:findmyrestaurant/src/services/dotenv_service.dart';
import 'package:flutter/services.dart';

class EmailService {
  // Singleton Section
  EmailService._();
  static final EmailService _instance = EmailService._();
  factory EmailService() => _instance;
  static EmailService get instance => _instance;

  final DotenvService _dotenvService = DotenvService.instance;
  
  String? _confirmationEmailHtml; 
  
  String _confirmationCode = "";
  ConfirmationCodeService confirmationCodeService = ConfirmationCodeService();

  bool isEmailReady = false;

  final String _brevoApiEndpoint = "https://api.brevo.com/v3/";
  String? _brevoApiKey;

  Future<void> initialize() async{
    _confirmationEmailHtml = await _setConfirmEmailTemplate();
    _brevoApiKey = await _dotenvService.getEnvValue(DotenvKeys.brevoApi);
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
      return '<p id="confirmationCode" class="default-button">$_confirmationCode</p>';
    });
    return htmlContent;
  }
  
  void _setConfiramtionCode() {
    _confirmationCode = confirmationCodeService.generateCode();
  }
  
  Future<bool> sendOTP(String userEmail) async {
    bool isSent = false;
    return isSent;
  }
}

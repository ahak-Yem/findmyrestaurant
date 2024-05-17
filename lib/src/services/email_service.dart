import 'package:findmyrestaurant/src/enums/dotenv_keys_enum.dart';
import 'package:findmyrestaurant/src/enums/html_files_enum.dart';
import 'package:findmyrestaurant/src/services/confirmation_code_service.dart';
import 'package:findmyrestaurant/src/services/dotenv_service.dart';
import 'package:findmyrestaurant/src/services/html_service.dart';

class EmailService {
  // Singleton Section
  EmailService._();
  static final EmailService _instance = EmailService._();
  factory EmailService() => _instance;
  static EmailService get instance => _instance;

  // Services
  final DotenvService _dotenvService = DotenvService.instance;
  final ConfirmationCodeService confirmationCodeService = ConfirmationCodeService();
  final HtmlService _htmlService = HtmlService.instance;
  
  // Confirmation Email Variables
  String? _confirmationEmailHtml; 
  String _confirmationCode = "";
  bool isEmailReady = false;

  // Brevo API Variables
  final String _brevoApiEndpoint = "https://api.brevo.com/v3/";
  String? _brevoApiKey;

  Future<void> initialize() async{
    _confirmationEmailHtml = await _setConfirmEmailTemplate();
    _brevoApiKey = await _dotenvService.getEnvValue(DotenvKeys.brevoApi);
  }

  Future<String> _setConfirmEmailTemplate() async{
    const HtmlFiles htmlFile = HtmlFiles.confirmationEmail;
    String templateText = "";
    try{
      String htmlOrig = await _htmlService.fetchHtml(htmlFile);
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
    const String oldHtmlStr = '<p id="confirmationCode" class="default-button"></p>';
    String newHtmlStr = '<p id="confirmationCode" class="default-button">$_confirmationCode</p>';
    String htmlContent = _htmlService.injectInHtml(htmlCode: htmlString, oldHtmlString: oldHtmlStr, newHtmlString: newHtmlStr);
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

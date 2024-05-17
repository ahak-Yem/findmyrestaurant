import 'package:findmyrestaurant/src/enums/dotenv_keys_enum.dart';
import 'package:findmyrestaurant/src/enums/html_files_enum.dart';
import 'package:findmyrestaurant/src/models/email_model.dart';
import 'package:findmyrestaurant/src/services/confirmation_code_service.dart';
import 'package:findmyrestaurant/src/services/dotenv_service.dart';
import 'package:findmyrestaurant/src/services/html_service.dart';
import 'package:findmyrestaurant/src/services/http_service.dart';

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
  late HttpService _httpService;
  
  // Confirmation Email Variables
  String? _confirmationEmailHtml; 
  String _confirmationCode = "";
  bool isEmailReady = false;

  // Brevo API Variables
  String? _brevoApiKey;

  Future<void> initialize() async{
    _confirmationEmailHtml = await _setConfirmEmailTemplate();
    _brevoApiKey = await _dotenvService.getEnvValue(DotenvKeys.brevoApi);
    try{
      _httpService = _setHttpService();
    }catch(e){
      _brevoApiKey = await _dotenvService.getEnvValue(DotenvKeys.brevoApi);
      _httpService = _setHttpService();
    }
    _httpService = _setHttpService();
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

  HttpService _setHttpService(){
    if(_brevoApiKey == null || _brevoApiKey!.isEmpty){
      throw Exception("Brevo API Key is not set");
    }
    return HttpService(
      baseUrl: "https://api.brevo.com/v3/", 
      defaultHeaders: {'content-type': 'application/json', 'api-key': _brevoApiKey!} 
    );
  }
  
  Future<bool> sendEmail(EmailModel emailModel) async {
    bool isSent = false;
    String endpoint = "smtp/email";
    try{
      _confirmationEmailHtml ??= await _setConfirmEmailTemplate();
      if(emailModel.emailHtml.isEmpty && _confirmationEmailHtml != null){
        emailModel.emailHtml = _confirmationEmailHtml!;
      }
      await _httpService.post(endpoint, body: emailModel.toJSON());
    }
    catch(e){
      isSent = false;
    }
    return isSent;
  }
}

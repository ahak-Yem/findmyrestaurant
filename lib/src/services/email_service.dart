import 'package:findmyrestaurant/src/services/dotenv_service.dart';
class EmailService {
  EmailService._();

  static final EmailService _instance = EmailService._();

  factory EmailService() => _instance;

  static EmailService get instance => _instance;

  final DotenvService _dotenvService = DotenvService.instance; 

  final String _appEmail = "findmyrestaurantde@gmail.com";
  final String _appName = "Find My Restaurant";
  
  bool _isConfigured = false;
  
  Future<bool> sendOTP(String userEmail) async {
    bool isSent = false;
    if(!_isConfigured){  
      _isConfigured=true;  
    }
    return isSent;
  }

  bool verifyOTP(String enteredOTP) {
    bool result = false;
    return result;
  }
}

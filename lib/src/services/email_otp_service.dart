class EmailOtpService {
  EmailOtpService._();

  static final EmailOtpService _instance = EmailOtpService._();

  factory EmailOtpService() => _instance;

  static EmailOtpService get instance => _instance;

  final String _appEmail = "findmyrestaurantde@gmail.com";
  final String _appName = "Find My Restaurant";

  final String _smtpHost = "smtp-relay.brevo.com";
  final String _smtpUser = "74af05001@smtp-brevo.com";
  final String _smtpPassword = "DK8XHFqL1NcbZ9v4";
  
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

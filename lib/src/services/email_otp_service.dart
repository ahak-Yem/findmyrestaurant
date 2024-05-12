import 'package:email_otp/email_otp.dart';

class EmailOtpService {
  EmailOtpService._();

  static final EmailOtpService _instance = EmailOtpService._();

  factory EmailOtpService() => _instance;

  static EmailOtpService get instance => _instance;

  final EmailOTP _emailOTP = EmailOTP();

  final String _appEmail = "findmyrestaurantde@gmail.com";
  final String _appName = "Find My Restaurant";

  final String _smtpHost = "smtp-relay.brevo.com";
  final String _smtpUser = "74af05001@smtp-brevo.com";
  final String _smtpPassword = "DK8XHFqL1NcbZ9v4";
  
  bool _isConfigured = false;
  
  Future<bool> sendOTP(String userEmail) async {
    bool isSent = false;
    if(!_isConfigured){
      _emailOTP.setConfig(
        appEmail: _appEmail,
        appName: _appName,
        userEmail: userEmail,
        otpLength: 6,
        otpType: OTPType.mixed,
      );
      
      _emailOTP.setSMTP(
        host: _smtpHost,
        auth: true,
        username: _smtpUser,
        password: _smtpPassword,
        secure: SmtpSecure.tls.secType,
        port: 587
      );

      _emailOTP.setTheme(theme: "v3");

      _isConfigured=true;  
    }
    try{
      isSent = await _emailOTP.sendOTP();
    }
    catch(e){
      return isSent;
    }
    return isSent;
  }

  Future<bool> verifyOTP(String enteredOTP) async {
    bool result = await _emailOTP.verifyOTP(otp: enteredOTP);
    return result;
  }
}
enum SmtpSecure{
  tls(secType: "TLS"),
  ssl(secType: "SSL");

  const SmtpSecure({required this.secType});
  final String secType;
}

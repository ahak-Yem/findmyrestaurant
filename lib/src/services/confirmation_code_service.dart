import 'dart:math';

class ConfirmationCodeService {
  ConfirmationCodeService._();
  static final ConfirmationCodeService _instance = ConfirmationCodeService._();
  factory ConfirmationCodeService() => _instance;
  static ConfirmationCodeService get instance => _instance;  
  
  final int _codeLength = 6;
  final Duration _codeValidityDuration = const Duration(minutes: 10);
  Duration get codeValidityDuration => _codeValidityDuration;

  final Map<String, DateTime> _codes = {};

  String generateCode() {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final code = List.generate(_codeLength, (index) => chars[Random().nextInt(chars.length)]).join();
    
    _codes[code] = DateTime.now().add(_codeValidityDuration);
    return code;
  }

  Map<bool, DateTime?> verifyCode(String code) {
    final expirationTime = _codes[code];
    if (expirationTime == null) {
      return {false: expirationTime}; 
    }
    if (DateTime.now().isAfter(expirationTime)) {
      _codes.remove(code);
      return {false: expirationTime};
    }
    _codes.remove(code);
    return {true: expirationTime};
  }
}

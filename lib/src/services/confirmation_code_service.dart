import 'dart:math';

class ConfirmationCodeService {
  final int _codeLength = 6;
  final Duration codeValidityDuration;

  final Map<String, DateTime> _codes = {};

  ConfirmationCodeService({this.codeValidityDuration = const Duration(minutes: 15)});

  String generateCode() {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final code = List.generate(_codeLength, (index) => chars[Random().nextInt(chars.length)]).join();
    
    _codes[code] = DateTime.now().add(codeValidityDuration);
    return code;
  }

  bool verifyCode(String code) {
    final expirationTime = _codes[code];
    if (expirationTime == null) {
      return false; 
    }
    if (DateTime.now().isAfter(expirationTime)) {
      _codes.remove(code);
      return false;
    }
    _codes.remove(code);
    return true;
  }
}

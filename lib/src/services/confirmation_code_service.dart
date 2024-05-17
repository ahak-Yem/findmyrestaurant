import 'dart:math';

class ConfirmationCodeService {
  final int codeLength;
  final Duration codeValidityDuration;

  final Map<String, DateTime> _codes = {};

  ConfirmationCodeService({this.codeLength = 6, this.codeValidityDuration = const Duration(minutes: 10)});

  String generateCode() {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final code = List.generate(codeLength, (index) => chars[Random().nextInt(chars.length)]).join();
    
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

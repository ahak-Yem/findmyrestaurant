import 'package:findmyrestaurant/src/enums/env_keys_enum.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DotenvService {
  static final DotenvService _instance = DotenvService._internal();

  factory DotenvService() => _instance;

  DotenvService._internal();

  static DotenvService get  instance => _instance;

  final String _fileName = '.env';

  final DotEnv _dotEnv = dotenv;

  Future<void> initialize() async{
    await _dotEnv.load(fileName: _fileName);
  }

  Future<String?> getEnvValue(EnvKeys key) async {
    if (!_dotEnv.isInitialized) {
      await initialize();
    }
    return _dotEnv.maybeGet(key.keyString);
  }
}

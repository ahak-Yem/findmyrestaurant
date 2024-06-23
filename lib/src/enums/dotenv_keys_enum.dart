enum DotenvKeys {
  brevoApi;
}

extension EnvKeysExtension on DotenvKeys {
  String get keyString {
    switch (this) {
      case DotenvKeys.brevoApi:
        return 'BREVO_API';
    }
  }
}

enum DotenvKeys {
  smtpHost,
  smtpUser,
  smtpPassword,
  brevoApi;
}

extension EnvKeysExtension on DotenvKeys {
  String get keyString {
    switch (this) {
      case DotenvKeys.smtpHost:
        return 'SMTP_HOST';
      case DotenvKeys.smtpUser:
        return 'SMTP_USER';
      case DotenvKeys.smtpPassword:
        return 'SMTP_PASSWORD';
      case DotenvKeys.brevoApi:
        return 'BREVO_API';
    }
  }
}

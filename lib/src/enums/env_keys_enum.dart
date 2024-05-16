enum EnvKeys {
  smtpHost,
  smtpUser,
  smtpPassword;
}

extension EnvKeysExtension on EnvKeys {
  String get keyString {
    switch (this) {
      case EnvKeys.smtpHost:
        return 'SMTP_HOST';
      case EnvKeys.smtpUser:
        return 'SMTP_USER';
      case EnvKeys.smtpPassword:
        return 'SMTP_PASSWORD';
      default:
        return '';
    }
  }
}

enum HtmlFiles{
  confirmationEmail;
}

extension HtmlFilesExtension on HtmlFiles{
  String get path {
    switch(this){
      case HtmlFiles.confirmationEmail:
        return "assets/html pages/confirm_email.html";
    }
  }
}
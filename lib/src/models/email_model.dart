class EmailModel {
  
  ContactModel sender;

  ContactModel receiver;

  ContactModel? replyTo;

  String emailHtml;

  String subject;

  String? previewText;

  List<String> tags;

  String? cc;
  
  String? bcc;

  EmailModel({
    required this.sender,
    required this.receiver,
    this.replyTo,
    required this.emailHtml,
    required this.subject,
    this.previewText,
    this.tags = const [],
    this.cc,
    this.bcc,
  });
} 

class ContactModel {
  String? name;
  String email;

  ContactModel({this.name, required this.email});
}
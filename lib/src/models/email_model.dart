class EmailModel {
  
  ContactModel sender;

  List<ContactModel> receivers;

  ContactModel? replyTo;

  String emailHtml;

  String subject;

  String? previewText;

  List<String>? tags;

  String? cc;
  
  String? bcc;

  EmailModel({
    required this.sender,
    required this.receivers,
    this.replyTo,
    required this.emailHtml,
    required this.subject,
    this.previewText,
    this.tags,
    this.cc,
    this.bcc,
  });

  Map<String, dynamic> toJSON() {
    final Map<String, dynamic> data = {};
    Map<String, String> receiversJSON = {};

    data['sender'] = sender.toJSON();
    for (var receiver in receivers) { 
      receiversJSON.addAll(receiver.toJSON());
    }
    data['to'] = receiversJSON;
    if (replyTo != null) {
      data['replyTo'] = replyTo?.toJSON();
    }
    data['htmlContent'] = emailHtml;
    data['subject'] = subject;
    if (previewText != null) {
      data['textContent'] = previewText;
    }
    if (tags != null && tags!.isNotEmpty) {
      data['tags'] = tags;
    }
    if (cc != null) {
      data['cc'] = cc;
    }
    if (bcc != null) {
      data['bcc'] = bcc;
    }
    return data;
  }
} 

class ContactModel {
  String? name;
  String email;

  ContactModel({this.name, required this.email});

  Map<String, String> toJSON() {
    final Map<String, String> data = {};
    if (name != null) {
      data['name'] = name!;
    }
    data['email'] = email;
    return data;
  }
}
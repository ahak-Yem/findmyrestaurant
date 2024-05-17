import 'package:findmyrestaurant/src/enums/html_files_enum.dart';
import 'package:flutter/services.dart';

class HtmlService{
  // Singleton Section
  HtmlService._();
  static final HtmlService _instance = HtmlService._();
  factory HtmlService() => _instance;
  static HtmlService get instance => _instance;

  Map<HtmlFiles, bool> htmlFiles = {HtmlFiles.confirmationEmail : false};

  String injectInHtml({required String htmlCode, required String oldHtmlString, required String newHtmlString}) {
    final RegExp regex = RegExp(RegExp.escape(oldHtmlString));
    String htmlContent = htmlCode.replaceAllMapped(regex, (match) {
      return newHtmlString;
    });
    return htmlContent;
  }

  Future<String> fetchHtml(HtmlFiles htmlFile) async{
    String htmlText = "";
    try{
      htmlText = await rootBundle.loadString(htmlFile.path);
      htmlFiles[htmlFile] = true;
    }
    catch(e){
      htmlFiles[htmlFile] = false;
    }
    return htmlText;
  }
}
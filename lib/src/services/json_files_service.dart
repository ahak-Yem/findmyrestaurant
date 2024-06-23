import 'dart:convert';
import 'package:synchronized/synchronized.dart';
import 'package:flutter/services.dart' show rootBundle;

class JsonFilesService {
  JsonFilesService._();

  factory JsonFilesService() {
    return _instance;
  }

  static final JsonFilesService _instance = JsonFilesService._();

  static JsonFilesService get instance => _instance;

  static final _lock = Lock();

  Future<Map<String, dynamic>> readAssetJsonFile(String filePath) async {
    Map<String, dynamic> fileContent = {}; 
    await _lock.synchronized(() async {
      try {
        final String jsonString = await rootBundle.loadString(filePath);
        fileContent = json.decode(jsonString);
        return fileContent;
      } 
      catch(e) {
        return fileContent;
      }
    });
    return fileContent;  
  }
}
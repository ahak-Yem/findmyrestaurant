import 'dart:convert' show json;
import 'package:flutter/services.dart' show rootBundle;
import 'package:synchronized/synchronized.dart';

import '../enums/images_paths_sections_enum.dart';

class ImagesPathsReader {

  static bool _isLoading = false;
  static final _lock = Lock();

  ImagesPathsReader._();
  
  static ImagesPathsReader? _instance;

  static ImagesPathsReader get instance {
    _instance ??= ImagesPathsReader._();
    return _instance!;
  }

  static Map<String, dynamic>? _config;

  static Future<void> _loadConfiguration() async {
    if (_config == null && !_isLoading) {
      await _lock.synchronized(() async {
        _isLoading = true;
        try {
          final String jsonString = await rootBundle.loadString('assets/imagesPaths.json');
          _config = json.decode(jsonString);
        } finally {
          _isLoading = false;
        }
      });
    }
  }

  Future<String> getImagePath(ImagesPathsSections section, String imageName) async{
    String path = "";
    if (_config == null) {
      await _loadConfiguration();
    }
    if(_config == null || _config!.isEmpty){
      return path;
    }
    path = _config!['imagePaths'][section.sectionString][imageName];
    return path;
  }
}
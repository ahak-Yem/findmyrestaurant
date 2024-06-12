import 'package:findmyrestaurant/src/enums/images%20enums/images_names.dart';
import 'package:findmyrestaurant/src/services/json_files_service.dart';
import '../enums/images enums/images_paths_sections_enum.dart';

class ImagesReaderService {

  static bool _isLoading = false;
  static const String _jsonFileRoot = 'imagePaths';
  static const String _jsonFilePath = 'assets/imagesPaths.json';
  static final JsonFilesService _jsonFilesService = JsonFilesService.instance;

  ImagesReaderService._();
  
  static ImagesReaderService? _instance;

  static ImagesReaderService get instance {
    _instance ??= ImagesReaderService._();
    return _instance!;
  }

  Future<void> initialize() async{
    await _loadConfiguration();
  }

  static Map<String, dynamic>? _config;

  static Future<void> _loadConfiguration() async {
    if (_config == null && !_isLoading) {
      _isLoading = true;
      try {
        _config = await _jsonFilesService.readAssetJsonFile(_jsonFilePath);
      } finally {
        _isLoading = false;
      }
    }
  }

  String getImagePath(ImagesPathsSections section, ImagesNames imageName){
    String path = "";
    if (_config == null) {
      _loadConfiguration();
    }
    if(_config == null || _config!.isEmpty){
      return path;
    }
    path = _config![_jsonFileRoot][section.sectionString][imageName.imageNameString];
    return path;
  }

  Future<String> getImagePathAsync(ImagesPathsSections section, ImagesNames imageName) async {
    return getImagePath(section, imageName);
  }
}
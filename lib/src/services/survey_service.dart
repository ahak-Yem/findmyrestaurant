import 'package:findmyrestaurant/src/services/json_files_service.dart';
import 'package:findmyrestaurant/src/models/dietary_survey_questions_model.dart';

class SurveyService {
  SurveyService._();

  factory SurveyService() {
    return _instance;
  }

  static final SurveyService _instance = SurveyService._();

  static SurveyService get instance => _instance;
  
  static const String _jsonFilePath = 'assets/dietary_survey.json';
  static const String _jsonQuestionsKey = 'survey';

  final JsonFilesService _jsonFilesService = JsonFilesService.instance;

  List<DietarySurveyQuestionsModel> _surveyQuestions = List.empty(growable: true);
  List<DietarySurveyQuestionsModel> get surveyQuestions => _surveyQuestions;

  Future<void> initialize() async{
    _surveyQuestions = await _setSurveyQuestionsList();
  }

  Future<List<DietarySurveyQuestionsModel>> _setSurveyQuestionsList() async {
    try {
      final Map<String, dynamic> questionsJson = await _jsonFilesService.readAssetJsonFile(_jsonFilePath);
      if(questionsJson.isEmpty){
        return List.empty();
      }
      return _parseToDietarySurveyQuestionsModelList(questionsJson);
    } 
    catch (e) {
      return [];
    }
  }

  List<DietarySurveyQuestionsModel> _parseToDietarySurveyQuestionsModelList (Map<String, dynamic> questionsMap) {
    List<dynamic>? questionsJson = questionsMap[_jsonQuestionsKey];
    if(questionsJson == null){
      return List.empty();
    }
    return questionsJson.map((questionJson) => DietarySurveyQuestionsModel.fromJson(questionJson)).toList();
  }
}

import 'package:findmyrestaurant/src/controllers/app_carousel_controller.dart';
import 'package:findmyrestaurant/src/enums/database%20enums/database_models_enum.dart';
import 'package:findmyrestaurant/src/pages/survey_question_page.dart';
import 'package:findmyrestaurant/src/services/app_launch_service.dart';
import 'package:findmyrestaurant/src/services/database_service.dart';
import 'package:findmyrestaurant/src/services/survey_service.dart';
import 'package:flutter/material.dart';
import 'package:findmyrestaurant/src/models/dietary_survey_questions_model.dart';
import 'package:findmyrestaurant/src/models/dietary_survey_user_preferences_model.dart';

class SurveyViewModel extends ChangeNotifier {
  List<DietarySurveyQuestionsModel> _surveyQuestions = List.empty();
  List<DietarySurveyQuestionsModel> get surveyQuestions => _surveyQuestions;
  
  final DietarySurveyUserPreferencesModel _surveyUserPreferences = DietarySurveyUserPreferencesModel();
  DietarySurveyUserPreferencesModel get surveyUserPreferences => _surveyUserPreferences;

  List<Widget> _surveyPages = List.empty();
  List<Widget> get surveyPages => _surveyPages;

  String? _userID;
  int currentQuestionIndex = 0;

  final SurveyService _surveyService = SurveyService.instance;
  final DatabaseService _databaseService = DatabaseService.instance;
  final AppLaunchService _appLaunchService = AppLaunchService.instance;

  AppCarouselController get appCarouselController => AppCarouselController();

  SurveyViewModel() {
    _surveyQuestions = _surveyService.surveyQuestions;
    _userID = _appLaunchService.userId;
    _surveyPages = _generateSurveyQuestionPages();
  }

  List<Widget> _generateSurveyQuestionPages() {
    return surveyQuestions.map((question) {
      return SurveyQuestionPage(
        question: question,
        onNext: (response) {
          updateUserResponse(question.id, response);
          if (currentQuestionIndex < surveyQuestions.length - 1) {
            appCarouselController.goNext(currentPage: currentQuestionIndex);
            currentQuestionIndex++;
          } else {
            saveUserPreferences();
          }
          notifyListeners();
        },
      );
    }).toList();
  }

  void updateUserResponse(String questionId, dynamic response) {
    final questionIndex = _surveyQuestions.indexWhere((q) => q.id == questionId);
    if (questionIndex >= 0) {
      _surveyUserPreferences.setPreferencesField(questionId, response);
      notifyListeners();
    }
  }

  void saveUserPreferences() async{
    if(_userID == null){
      return;  
    }
    try{
      _databaseService.save(DatabaseModelsEnum.dietaryUserPreferences, _userID, _surveyUserPreferences);
    }
    catch(e){
      return;
    }
  }

  Future<bool> onDeviceBackPressed() {
    final currentPage = appCarouselController.currentPageIndex;
    if (currentPage == 0) {
      return Future.value(false);
    }
    appCarouselController.goBack(currentPage: currentPage);
    return Future.value(false);
  }
}

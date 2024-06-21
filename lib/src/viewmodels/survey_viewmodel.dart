import 'dart:async';
import 'package:findmyrestaurant/src/controllers/app_carousel_controller.dart';
import 'package:findmyrestaurant/src/enums/database%20enums/database_models_enum.dart';
import 'package:findmyrestaurant/src/pages/survey_question_page.dart';
import 'package:findmyrestaurant/src/services/app_launch_service.dart';
import 'package:findmyrestaurant/src/services/database_service.dart';
import 'package:findmyrestaurant/src/services/survey_service.dart';
import 'package:flutter/material.dart';
import 'package:findmyrestaurant/src/models/dietary_survey_questions_model.dart';
import 'package:findmyrestaurant/src/models/user_preferences_model.dart';

class SurveyViewModel extends ChangeNotifier {
  List<DietarySurveyQuestionsModel> _surveyQuestions = List.empty();
  List<DietarySurveyQuestionsModel> get surveyQuestions => _surveyQuestions;
  
  UserPreferencesModel _surveyUserPreferences = UserPreferencesModel();
  UserPreferencesModel get surveyUserPreferences => _surveyUserPreferences;

  List<Widget> _surveyPages = List.empty();
  List<Widget> get surveyPages => _surveyPages;

  final StreamController<bool> _surveyEndedController = StreamController<bool>();
  Stream<bool> get surveyEndedController => _surveyEndedController.stream;

  String? _userID;
  int currentQuestionIndex = 0;

  final SurveyService _surveyService = SurveyService.instance;
  final DatabaseService _databaseService = DatabaseService.instance;
  final AppLaunchService _appLaunchService = AppLaunchService.instance;

  final AppCarouselController appCarouselController = AppCarouselController();

  SurveyViewModel() {
    _userID = _appLaunchService.userId;
    _surveyQuestions = _surveyService.surveyQuestions;
    _surveyUserPreferences = _appLaunchService.userPreferences ?? UserPreferencesModel();
    _surveyPages = _generateSurveyQuestionPages();
  }

  List<Widget> _generateSurveyQuestionPages() {
    return surveyQuestions.map((question) {
      return SurveyQuestionPage(
        question: question,
        onNext: (response) {
          _onNextSurveyQuestion(question.id, response);
        },
      );
    }).toList();
  }

  void _updateUserResponse(String questionId, dynamic response) {
    final questionIndex = _surveyQuestions.indexWhere((question) => question.id == questionId);
    if (questionIndex >= 0) {
      _surveyUserPreferences.setPreferencesField(questionId, response);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        notifyListeners();
      });
    }
  }

  void _saveUserPreferences() async{
    if(_userID == null){
      return;  
    }
    try{
      await _databaseService.save(DatabaseModelsEnum.dietaryUserPreferences, _userID, _surveyUserPreferences);
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

  void _onNextSurveyQuestion(String questionId, dynamic response) {
    _updateUserResponse(questionId, response);
    if (currentQuestionIndex < surveyQuestions.length - 1) {
      appCarouselController.goNext(currentPage: currentQuestionIndex);
    } else {
      _saveUserPreferences();
      _notifySurveyEnded();
    }
  }

  void onCarouselItemChanged(int index) {
    currentQuestionIndex = index;
    appCarouselController.setCurrentPageIndex(index);
  }

  void _notifySurveyEnded() {
    _surveyEndedController.add(true);
  }

  @override
  void dispose() {
    _surveyEndedController.close();
    _surveyQuestions.clear();
    _surveyPages.clear();
    super.dispose();
  }
}

import 'dart:async';

class QuestionWidgetsAnswersUtil {
  static final Map<String, dynamic> _surveyUserPreferences = {};
  static Map<String, dynamic> get surveyUserPreferences => _surveyUserPreferences;

  static final StreamController<Map<String, bool>> _isQuestionAnsweredStream = StreamController<Map<String, bool>>.broadcast();
  static Stream<Map<String, bool>> get isQuestionAnsweredStream => _isQuestionAnsweredStream.stream;

  static void setResponse(String id, dynamic response) {
    _surveyUserPreferences[id] = response;
  }

  static dynamic getResponse(String id) {
    return _surveyUserPreferences[id];
  }

  static void notifyIsQuestionAnswered(String id, bool isValueSet) {
    _isQuestionAnsweredStream.add(Map.from({id : isValueSet}));
  }
}

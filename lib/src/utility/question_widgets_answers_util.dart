class QuestionWidgetsAnswersUtil {
  static final Map<String, dynamic> _surveyUserPreferences = {};
  static Map<String, dynamic> get surveyUserPreferences => _surveyUserPreferences;

  static void setResponse(String id, dynamic response) {
    _surveyUserPreferences[id] = response;
  }

  static dynamic getResponse(String id) {
    return _surveyUserPreferences[id];
  }
}

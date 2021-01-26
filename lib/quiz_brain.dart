import 'package:quizzler/question.dart';

class QuizBrain {
  int _questionNumber = 0;
  List<Question> _questions = [
    Question('First question text', true),
    Question('Second question text', false),
    Question('Third question text', true),
  ];
  Map<String, int> _result = {'correct': 0, 'failed': 0};

  String getResult(String type) {
    return _result[type].toString();
  }

  String getQuestionText() {
    return _questions[_questionNumber].questionText;
  }

  bool getQuestionAnswer() {
    return _questions[_questionNumber].qustionAnswer;
  }

  void nextQuestion() {
    if (_questionNumber < _questions.length - 1) {
      _questionNumber++;
    }
  }

  bool isFinished() {
    return _questionNumber >= (_questions.length - 1);
  }

  void reset() {
    _questionNumber = 0;
    _result = {'correct': 0, 'failed': 0};
  }

  void updateResult(String type) {
    _result[type] += 1;
  }
}

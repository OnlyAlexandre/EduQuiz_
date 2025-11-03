import 'package:flutter/material.dart';

class QuizProvider extends ChangeNotifier {
  int _score = 0;
  int _currentQuestionIndex = 0;
  bool _isAnswered = false;
  bool _isQuizCompleted = false;

  int get score => _score;
  int get currentQuestionIndex => _currentQuestionIndex;
  bool get isAnswered => _isAnswered;
  bool get isQuizCompleted => _isQuizCompleted;

  void answerQuestion(bool isCorrect) {
    if (isCorrect) {
      _score++;
    }
    _isAnswered = true;
    notifyListeners();
  }

  void nextQuestion() {
    if (_currentQuestionIndex < 9) {
      _currentQuestionIndex++;
      _isAnswered = false;
    } else {
      _isQuizCompleted = true;
    }
    notifyListeners();
  }

  void resetQuiz() {
    _score = 0;
    _currentQuestionIndex = 0;
    _isAnswered = false;
    _isQuizCompleted = false;
    notifyListeners();
  }
}
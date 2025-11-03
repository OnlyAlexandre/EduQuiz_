import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/quiz_provider.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final w = size.width;
    final h = size.height;
    final isTablet = w > 600;
    final pad = isTablet ? w * 0.08 : 16.0;
    final questionFont = isTablet ? 32.0 : 22.0;
    final buttonFont = isTablet ? 20.0 : 15.0;
    return Consumer<QuizProvider>(
      builder: (context, quizProvider, _) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Quiz'),
            actions: [
              Padding(
                padding: EdgeInsets.only(right: pad / 2),
                child: Text(
                  'Pergunta  ${quizProvider.currentQuestionIndex + 1}/10',
                  style: TextStyle(fontSize: isTablet ? 18 : 15),
                ),
              ),
            ],
          ),
          body: Padding(
            padding: EdgeInsets.all(pad),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Center(
                    child: Text(
                      'Esta é uma pergunta de exemplo?',
                      style: TextStyle(fontSize: questionFont, fontWeight: FontWeight.w600),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  height: isTablet ? 62 : 48,
                  child: ElevatedButton(
                    onPressed: quizProvider.isAnswered
                        ? null
                        : () {
                            quizProvider.answerQuestion(true);
                          },
                    child: Text(
                      'Verdadeiro',
                      style: TextStyle(fontSize: buttonFont),
                    ),
                  ),
                ),
                SizedBox(height: isTablet ? 18 : 10),
                SizedBox(
                  width: double.infinity,
                  height: isTablet ? 62 : 48,
                  child: ElevatedButton(
                    onPressed: quizProvider.isAnswered
                        ? null
                        : () {
                            quizProvider.answerQuestion(false);
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                    ),
                    child: Text(
                      'Falso',
                      style: TextStyle(fontSize: buttonFont),
                    ),
                  ),
                ),
                SizedBox(height: isTablet ? 28 : 20),
                if (quizProvider.isAnswered)
                  SizedBox(
                    width: double.infinity,
                    height: isTablet ? 54 : 44,
                    child: ElevatedButton(
                      onPressed: () {
                        quizProvider.nextQuestion();
                        if (quizProvider.isQuizCompleted) {
                          Navigator.pushReplacementNamed(context, '/result');
                        }
                      },
                      child: Text(
                        quizProvider.currentQuestionIndex < 9 ? 'Próxima Pergunta' : 'Ver Resultado',
                        style: TextStyle(fontSize: buttonFont),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
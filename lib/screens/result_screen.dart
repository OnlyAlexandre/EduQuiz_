import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/quiz_provider.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final w = size.width;
    final isTablet = w > 600;
    final pad = isTablet ? w * 0.13 : 16.0;
    final titleFont = isTablet ? 38.0 : 28.0;
    final scoreFont = isTablet ? 64.0 : 48.0;
    final messageFont = isTablet ? 25.0 : 18.0;
    final buttonFont = isTablet ? 22.0 : 16.0;
    final quizProvider = Provider.of<QuizProvider>(context);
    final score = quizProvider.score;
    final totalQuestions = 10;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resultado'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: pad),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Quiz Concluído!',
                style: TextStyle(fontSize: titleFont, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: isTablet ? 40 : 28),
              Text(
                'Sua pontuação:',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: titleFont * 0.7),
              ),
              SizedBox(height: isTablet ? 16 : 10),
              Text(
                '$score/$totalQuestions',
                style: TextStyle(
                  fontSize: scoreFont,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              SizedBox(height: isTablet ? 32 : 22),
              Text(
                score > totalQuestions / 2
                    ? 'Parabéns! Você se saiu muito bem!'
                    : 'Você pode se sair melhor na próxima!',
                style: TextStyle(fontSize: messageFont),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: isTablet ? 48 : 32),
              SizedBox(
                width: isTablet ? 350 : double.infinity,
                height: isTablet ? 58 : 44,
                child: ElevatedButton(
                  onPressed: () {
                    quizProvider.resetQuiz();
                    Navigator.pushReplacementNamed(context, '/');
                  },
                  child: Text('Jogar Novamente', style: TextStyle(fontSize: buttonFont)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

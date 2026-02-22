import 'package:flutter/material.dart';
import '../models/questaomodel.dart';
import '../services/user_service.dart';

class QuestaoState extends ChangeNotifier {
  List<QuestaoModel> questoes = [];
  int indexAtual = 0;
  int acertos = 0;
  int erros = 0;
  int? alternativaSelecionada;
  bool quizFinalizado = false;


  void carregarQuestoes(List<QuestaoModel> lista) {
    questoes = lista;
    indexAtual = 0;
    acertos = 0;
    erros = 0;
    alternativaSelecionada = null;
    quizFinalizado = false;
    notifyListeners();
  }

  QuestaoModel get questaoAtual => questoes[indexAtual];

  /// Selecionar uma alternativa
  void selecionarAlternativa(int index) {
    alternativaSelecionada = index;
    notifyListeners();
  }

  /// Confirmar resposta
  void confirmar() {
    if (alternativaSelecionada == null) return;

    final correta = questaoAtual.gabarito;

    if (alternativaSelecionada == correta) {
      acertos++;
    } else {
      erros++;
    }

    notifyListeners();
  }

  /// Avançar para próxima
  Future<void> proximaQuestao() async {
    if (indexAtual < questoes.length - 1) {
      indexAtual++;
      alternativaSelecionada = null;
      notifyListeners();
    } else {
      await _finalizarQuiz();
    }
  }

  /// Finalizar: atualiza XP, streak, estatísticas do usuário
  Future<void> _finalizarQuiz() async {
    quizFinalizado = true;

    await UserService.atualizarStreak();

    // Atualiza estatísticas do usuário  await UserService.atualizarEstatisticas(totalRespondidas: questoes.length,totalAcertos: acertos);
    notifyListeners();
  }
}

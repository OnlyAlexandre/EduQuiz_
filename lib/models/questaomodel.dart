class QuestaoModel {
  final String id;
  final String enunciado1;
  final String? enunciado2;
  final String? enunciado3;
  final List<String> alternativas;
  final int gabarito;
  final int ano;
  final String? materia;
  final String? assunto;
  final String? vestibular;
  final String? dificuldade;
  final String? imagemURL; 

  QuestaoModel({
    required this.id,
    required this.enunciado1,
    this.enunciado2,
    this.enunciado3,
    required this.alternativas,
    required this.gabarito,
    required this.ano,
    this.materia,
    this.assunto,
    this.vestibular,
    this.dificuldade,
    this.imagemURL,
  });

  factory QuestaoModel.fromFirestore(Map<String, dynamic> data, String id) {
    return QuestaoModel(
      id: id,
      enunciado1: data['enunciado1'],
      enunciado2: data['enunciado2'],
      enunciado3: data['enunciado3'],
      alternativas: List<String>.from(data['alternativas']),
      gabarito: data['gabarito'],
      ano: data['ano'],
      materia: data['materia'],
      assunto: data['assunto'],
      vestibular: data['vestibular'],
      dificuldade: data['dificuldade'],
      imagemURL: data['imagemURL'],
    );
  }
  
}

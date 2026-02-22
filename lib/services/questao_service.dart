import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/questaomodel.dart';

class QuizService{
  
 static final _questoes = FirebaseFirestore.instance.collection('questoes');

  static Future<List<QuestaoModel>> getTodasQuestoes() async {
    final snapshot = await _questoes.get();
    return snapshot.docs.map((doc) {
      return QuestaoModel.fromFirestore(doc.data(), doc.id);
    }).toList();
  }

  static Future<List<QuestaoModel>> getPorFiltro({String? materia,String? vestibular,int? ano}) async {
    Query query = _questoes;

    if (materia != null) query = query.where('materia', isEqualTo: materia);
    if (vestibular != null) query = query.where('vestibular', isEqualTo: vestibular);
    if (ano != null) query = query.where('ano', isEqualTo: ano);

    final snapshot = await query.get();

   return snapshot.docs.map((doc) {
    final data = doc.data() as Map<String, dynamic>;
    return QuestaoModel.fromFirestore(data, doc.id);
  }).toList();

  }

  


}
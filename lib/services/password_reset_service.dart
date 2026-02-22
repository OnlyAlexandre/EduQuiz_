import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';

class PasswordResetService {
  static final _db = FirebaseFirestore.instance;

  static String gerarCodigo() {
    final random = Random();
    String code = "";

    while (true) {
      code = List.generate(6, (_) => random.nextInt(10).toString()).join();

      final freq = <String, int>{};
      for (var digit in code.split('')) {
        freq[digit] = (freq[digit] ?? 0) + 1;
      }

      final invalid = freq.values.any((count) => count > 2);
      if (!invalid) {
        return code;
      }
    }
  }

  static Future<bool> sendResetCode(String email) async {
   try {
      final querySnapshot = await _db.collection("usuarios").where("email", isEqualTo: email).get();
      if (querySnapshot.docs.isEmpty) {throw Exception("Email não encontrado na base de dados de usuários.");}

      final code = gerarCodigo();

      await _db.collection("password_reset").doc(email).set({
        "email": email,
        "code": code,
        "createdAt": FieldValue.serverTimestamp(),
        "used": false, 
      });

      print("CÓDIGO GERADO → $code (enviar por e-mail)");

      return true;
    } catch (e) {
      print("Erro ao enviar código: $e");
      return false; 
    }
  }

  static Future<bool> verifyResetCode(String email, String code) async {
    try {
      final doc = await _db.collection("password_reset").doc(email).get();

      if (!doc.exists) {return false;}

      final data = doc.data()!;
      final storedCode = data["code"];
      final used = data["used"] ?? false; 
      final createdAt = data["createdAt"] as Timestamp?;
      final now = DateTime.now();
      
      if (createdAt == null) {return false;}
      final difference = now.difference(createdAt.toDate());
      if (difference > Duration(minutes: 15)) {
        return false; 
      }

      
      if (used) {
        return false; 
      }
      if (storedCode != code) {
        return false; 
      }
      await _db.collection("password_reset").doc(email).update({
        "used": true,
      });

      return true;
    } catch (e) {
      print("Erro ao verificar código: $e");
      return false;
    }
  }
  
}

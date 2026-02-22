import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';  // Para Uint8List (web)
import 'package:flutter/foundation.dart';  // Import obrigatório para kIsWeb


class UserService {
    final String uid;
     String name;
     String? username;
     String? email;
     String? photoURL;
     DateTime? createdAt;
     int xp;
     String? course;
     String? vestibular;
     int totalSeguidores;
     int totalSeguindo;
     DateTime? ultimaStreak;
     int streak;
     int totalQuestoesRespondidas;
     int totalAcertos;
     int totalSegundosEstudados;


  UserService({
    required this.uid,
    required this.name,
    this.username,
    this.email,
    this.photoURL,
    this.createdAt,
    this.course,
    this.vestibular,

    this.totalSeguidores = 0,
    this.totalSeguindo = 0,

    this.xp = 0,
    this.ultimaStreak,
    this.streak=0,
    this.totalQuestoesRespondidas=0,
    this.totalAcertos=0,
    this.totalSegundosEstudados=0,
  });


//func do usuario diretamente

  static Future<void> syncUserAfterAuth(User user, String nome) async {
    final users = FirebaseFirestore.instance.collection('usuarios');
    final doc = await users.doc(user.uid).get();

    if (!doc.exists) {
      await users.doc(user.uid).set({
        'uid': user.uid,
        'name': nome,
        'email': user.email,
        'photoURL': null,
        'createdAt': FieldValue.serverTimestamp(),
        'ultimaStreak': null,
        'xp': 0,
        'streak': 0,
        'course': null,
        'vestibular': null,
        'totalQuestoesRespondidas': 0,
        'totalAcertos': 0,
        'totalSegundosEstudados': 0,
      });
    } 
  }

  static Future<UserService?> getUsuario() async {
    final users = FirebaseFirestore.instance.collection('usuarios');
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return null;

    final doc = await users.doc(uid).get();
    if (!doc.exists) return null;
    final data = doc.data()!;


    return UserService(
    uid: data['uid'],
    name: data['name'],
    username: data['username'],
    email: data['email'],
    photoURL: data['photoURL'],
    createdAt: (data['createdAt'] as Timestamp?)?.toDate(),
    ultimaStreak: (data['ultimaStreak'] as Timestamp?)?.toDate(),
    xp: data['xp'] ?? 0,
    streak: data['streak'] ?? 0,
    course: data['course'],
    vestibular: data['vestibular'],
    totalQuestoesRespondidas: data['totalQuestoesRespondidas'] ?? 0,
    totalAcertos: data['totalAcertos'] ?? 0,  
    totalSegundosEstudados: data['totalSegundosEstudados'] ?? 0,);
  }
  
  static Future<void> updateCursoEVestibular( String course, String vestibular,) async {
  final uid = FirebaseAuth.instance.currentUser?.uid;
  if (uid == null) return;

  final users = FirebaseFirestore.instance.collection('usuarios');

  await users.doc(uid).update({'course': course,'vestibular': vestibular});
}

  static Future<void> updateEmailNomeUsuario( String email, String nome,) async {
  final uid = FirebaseAuth.instance.currentUser?.uid;
  if (uid == null) return;

  final users = FirebaseFirestore.instance.collection('usuarios');

  await users.doc(uid).update({'email': email,'name': nome});
}

static Future<String?> updateImagemUsuario(String uid, XFile imageFile) async {

  try {
    
    final user = FirebaseAuth.instance.currentUser;
    if (user == null || user.uid != uid) {
      throw Exception('Usuário não autenticado ou UID mismatch');
    }

    Reference ref = FirebaseStorage.instance.ref().child('photoURL/${uid}.jpg');

    UploadTask uploadTask;

    Uint8List imageBytes = await imageFile.readAsBytes();
    

    uploadTask = ref.putData(imageBytes, SettableMetadata(contentType: 'application/octet-stream'));

    TaskSnapshot snapshot = await uploadTask;

    String downloadUrl = await snapshot.ref.getDownloadURL();

    await FirebaseFirestore.instance.collection('usuarios').doc(uid).update({'photoURL': downloadUrl});

    print('Upload bem-sucedido: $downloadUrl');

    return downloadUrl;
  } catch (e) {
    print('Erro no upload: $e');
    throw Exception('Erro ao fazer upload: $e');
  }
}

// func do social do usuario 

static Future<void> seguir(String uidDestino) async {
  final uid = FirebaseAuth.instance.currentUser?.uid;
  if (uid == null) return;
  final users = FirebaseFirestore.instance.collection('usuarios');

    final seguindoRef = users.doc(uid).collection('seguindo').doc(uidDestino);
    final seguidoresRef = users.doc(uidDestino).collection('seguidores').doc(uid);

 await FirebaseFirestore.instance.runTransaction((transaction) async {
  transaction.set(seguindoRef, {'seguidoEm': Timestamp.now()});transaction.set(seguidoresRef, {'seguidoEm': Timestamp.now()});});

  await users.doc(uidDestino).update({'totalSeguidores': FieldValue.increment(1)});
  await users.doc(uid).update({'totalSeguindo': FieldValue.increment(1)});

}

static Future<void> deixarDeSeguir(String uidDestino) async {
  final uid = FirebaseAuth.instance.currentUser?.uid;
  if (uid == null) return;
  final users = FirebaseFirestore.instance.collection('usuarios');

    final seguindoRef = users.doc(uid).collection('seguindo').doc(uidDestino);
    final seguidoresRef = users.doc(uidDestino).collection('seguidores').doc(uid);

 await FirebaseFirestore.instance.runTransaction((transaction) async {
  transaction.delete(seguindoRef);transaction.delete(seguidoresRef);});

  await users.doc(uidDestino).update({'totalSeguidores': FieldValue.increment(-1)});
  await users.doc(uid).update({'totalSeguindo': FieldValue.increment(-1)});

}

static Future<bool> isSeguindo(String uidDestino) async {
  final uid = FirebaseAuth.instance.currentUser?.uid;
  if (uid == null) return false;
  final users = FirebaseFirestore.instance.collection('usuarios');

    final seguindoRef = users.doc(uid).collection('seguindo').doc(uidDestino);
    final doc = await seguindoRef.get();
    return doc.exists;
}

static Future<List<UserService>> getSeguidores(String uidUsuario) async {
  final users = FirebaseFirestore.instance.collection('usuarios');
  final seguidoresRef = users.doc(uidUsuario).collection('seguidores');

  final querySnapshot = await seguidoresRef.get();
  List<UserService> seguidores = [];

  for (var doc in querySnapshot.docs) {
    final seguidorUid = doc.id;
    final userDoc = await users.doc(seguidorUid).get();
    if (userDoc.exists) {
      final data = userDoc.data()!;
      seguidores.add(UserService(
        uid: data['uid'],
        name: data['name'],
        username: data['username'],
        email: data['email'],
        photoURL: data['photoURL'],
        createdAt: (data['createdAt'] as Timestamp?)?.toDate(),
        xp: data['xp'] ?? 0,
        course: data['course'],
        vestibular: data['vestibular'],
        totalSeguidores: data['totalSeguidores'] ?? 0,
        totalSeguindo: data['totalSeguindo'] ?? 0,
        ultimaStreak: (data['ultimaStreak'] as Timestamp?)?.toDate(),
        streak: data['streak'] ?? 0,
        totalQuestoesRespondidas: data['totalQuestoesRespondidas'] ?? 0,
        totalAcertos: data['totalAcertos'] ?? 0,  
        totalSegundosEstudados: data['totalSegundosEstudados'] ?? 0,
      ));
    }
  }

  return seguidores;
}

static Future<UserService?> getUsuarioPorUid(String uid) async {
  final users = FirebaseFirestore.instance.collection('usuarios');
  if (uid.isEmpty) return null; 

  final doc = await users.doc(uid).get();
  if (!doc.exists) return null;
  final data = doc.data()!;

  return UserService(
    uid: data['uid'],
    name: data['name'],
    username: data['username'],
    email: data['email'],
    photoURL: data['photoURL'],
    createdAt: (data['createdAt'] as Timestamp?)?.toDate(),
    xp: data['xp'] ?? 0,
    course: data['course'],
    vestibular: data['vestibular'],
    totalSeguidores: data['totalSeguidores'] ?? 0,
    totalSeguindo: data['totalSeguindo'] ?? 0,
    ultimaStreak: (data['ultimaStreak'] as Timestamp?)?.toDate(),
    streak: data['streak'] ?? 0,
    totalQuestoesRespondidas: data['totalQuestoesRespondidas'] ?? 0,
    totalAcertos: data['totalAcertos'] ?? 0,
    totalSegundosEstudados: data['totalSegundosEstudados'] ?? 0,
  );
}

static Future<String?> getUsernamePorUid(String uid) async {
  final users = FirebaseFirestore.instance.collection('usuarios');
  if (uid.isEmpty) return null; 

  final doc = await users.doc(uid).get();
  if (!doc.exists) return null;
  final data = doc.data()!;

  return data['username'];
}

// func da streak...

static Future<void> atualizarStreak() async {
  final uid = FirebaseAuth.instance.currentUser?.uid;
  if (uid == null) return;

  final users = FirebaseFirestore.instance.collection('usuarios');
  final doc = await users.doc(uid).get();
  final data = doc.data()!;

  int streakAtual = data['streak'] ?? 0;
  final last = data['ultimaStreak']?.toDate();
  final today = DateTime.now();
  final todayDate = DateTime(today.year, today.month, today.day);

  bool deveAtualizarData = false;

  if (last == null) {
    streakAtual = 1;
    deveAtualizarData = true;
  } else {
    final lastDate = DateTime(last.year, last.month, last.day);
    final diff = todayDate.difference(lastDate).inDays;

    if (diff == 1) {
      streakAtual++;
      deveAtualizarData = true;
    } else if (diff > 1) {
      streakAtual = 1;
      deveAtualizarData = true;
    } 
  }

  if (deveAtualizarData) {
    await users.doc(uid).update({
      'streak': streakAtual,
      'ultimaStreak': Timestamp.now(),
    });
  }
}

}

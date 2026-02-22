import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserService {
    final String uid;
     String name;
     String? email;
     String? photoURL;
     DateTime? createdAt;
     int xp;
     int streak;
     String? course;
     String? vestibular;

  UserService({
    required this.uid,
    required this.name,
    this.email,
    this.photoURL,
    this.createdAt,
    this.xp = 0,
    this.streak = 0,
    this.course,
    this.vestibular,
  });



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
        'xp': 0,
        'streak': 0,
        'course': null,
        'vestibular': null,
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
    email: data['email'],
    photoURL: data['photoURL'],
    createdAt: (data['createdAt'] as Timestamp?)?.toDate(),
    xp: data['xp'] ?? 0,
    streak: data['streak'] ?? 0,
    course: data['course'],
    vestibular: data['vestibular'],);
  }
  
}

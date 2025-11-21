import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meu_app/screens/perfil_screen.dart';
import 'package:provider/provider.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// Import das telas
import 'screens/curso_info_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/login_screen.dart' show LoginPage;
import 'screens/home_screen.dart';
import 'screens/quiz_screen.dart';
import 'screens/result_screen.dart';
import 'screens/esqueceu_senha_screen.dart';
import 'screens/confirmacao_email_screen.dart';
import 'screens/codigo_verificacao_screen.dart';
import 'screens/nova_senha_screen.dart';
import 'providers/quiz_provider.dart';

void main() async{
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => QuizProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz App',
      debugShowCheckedModeBanner: false,
      home: const AuthGate(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,
        ),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color(0xFF6A11CB),
          secondary: const Color(0xFF2575FC),
        ),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.white),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      routes: {
        '/home': (context) => const HomeScreen(),  // ou fale, dependendo do e (context) => const OnboardingScreen(),
        '/login': (context) => const LoginPage(),
        '/signup': (context) => const SignupPage(),
        '/quiz': (context) => const QuizScreen(),
        '/result': (context) => const ResultScreen(),
        '/curso-info': (context) => const CursoInfoScreen(),
        '/esqueci-senha': (context) => const EsqueceuSenhaScreen(),
        '/confirmacao-email': (context) => const ConfirmacaoEmailScreen(),
        '/codigo-verificacao': (context) => const CodigoVerificacaoScreen(),
        '/nova-senha': (context) => const NovaSenhaScreen(),
        '/perfil': (context) => const PerfilScreen(),
      },
    );
  }
}

class AuthGate extends StatelessWidget {
    const AuthGate({super.key});

    @override
    Widget build(BuildContext context){
        return StreamBuilder<User?>(stream: FirebaseAuth.instance.userChanges(),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            return const HomeScreen();
          }else{
            return const LoginPage();
          }
        },
      );
    }
}

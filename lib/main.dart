import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// Import das telas
import 'screens/curso_info_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/login_screen.dart' show LoginPage;
import 'screens/perfil_screen.dart';
import 'screens/notificacoes_screen.dart';
import 'screens/home_screen.dart';
import 'screens/quiz_screen.dart';
import 'screens/result_screen.dart';
import 'screens/esqueceu_senha_screen.dart';
import 'screens/confirmacao_email_screen.dart';
import 'screens/codigo_verificacao_screen.dart';
import 'screens/nova_senha_screen.dart';
import 'screens/ranking_screen.dart';
import 'screens/banco_questoes_screen.dart';
import 'screens/mapa_aprendizado_screen.dart';
import 'screens/conquistas_screen.dart';
import 'screens/rodadas_rapidas_screen.dart';
import 'screens/revisar_erros_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/editar_perfil_screen.dart';
import 'screens/seguranca_conta_screen.dart';
import 'screens/preferencias_screen.dart';
import 'screens/assinatura_screen.dart';
import 'screens/acessibilidade_screen.dart';
import 'screens/missao_diaria_screen.dart';
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
      initialRoute: '/login',
      routes: {
        '/home': (context) => const HomeScreen(),
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
        '/notificacoes': (context) => const NotificacoesScreen(),
        '/ranking': (context) => const RankingScreen(),
        '/banco-questoes': (context) => const BancoQuestoesScreen(),
        '/mapa-aprendizado': (context) => const MapaAprendizadoScreen(),
        '/conquistas': (context) => const ConquistasScreen(),
        '/rodadas-rapidas': (context) => const RodadasRapidasScreen(),
        '/revisar-erros': (context) => const RevisarErrosScreen(),
        '/settings': (context) => const SettingsScreen(),
        '/editar-perfil': (context) => const EditarPerfilScreen(),
        '/seguranca-conta': (context) => const SegurancaContaScreen(),
        '/preferencias': (context) => const PreferenciasScreen(),
        '/assinatura': (context) => const AssinaturaScreen(),
        '/acessibilidade': (context) => const AcessibilidadeScreen(),
        '/missao-diaria': (context) => const MissoesDiariasScreen(),
      },
    );
  }
}

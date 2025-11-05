import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final w = size.width;
    final h = size.height;
    final isTablet = w > 600;
    final vPad = isTablet ? h * 0.08 : h * 0.03;
    final hPad = isTablet ? w * 0.18 : w * 0.04;
    final cardRad = isTablet ? 60.0 : 40.0;
    final fieldFont = isTablet ? 18.0 : 14.0;
    final titleFont = isTablet ? 38.0 : 24.0;
    final buttonFont = isTablet ? 22.0 : 18.0;
    final labelFont = isTablet ? 16.0 : 14.0;

    return Scaffold(
      backgroundColor: const Color(0xFF6A1B9A), // Roxo de fundo
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: vPad),
            // TOPO: Logo + Raposa
            Container(
              height: isTablet ? h * 0.35 : h * 0.42,
              width: double.infinity,
              color: const Color(0xFF6A1B9A),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "EDUQUIZ",
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: isTablet ? 58 : 40,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Aprenda de forma gamificada!",
                    style: GoogleFonts.poppins(
                      color: Colors.white70,
                      fontSize: isTablet ? 19 : 15,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 18),
                  Image.asset(
                    "assets/images/fox.png",
                    height: isTablet ? 130 : 100,
                    fit: BoxFit.contain,
                  ),
                ],
              ),
            ),
            // PARTE BRANCA ARREDONDADA
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(cardRad),
                  topRight: Radius.circular(cardRad),
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: hPad, vertical: vPad),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Bem-vindo de volta!",
                    style: GoogleFonts.poppins(
                      fontSize: titleFont,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF4A148C),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Digite seus dados abaixo para entrar na sua conta.",
                    style: GoogleFonts.poppins(
                      color: Colors.black54,
                      fontSize: labelFont,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Campo de E-mail
                  TextField(
                    style: GoogleFonts.poppins(fontSize: fieldFont),
                    decoration: InputDecoration(
                      labelText: "E-mail",
                      labelStyle: GoogleFonts.poppins(fontSize: fieldFont),
                      hintText: "Digite seu e-mail",
                      hintStyle: GoogleFonts.poppins(),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: isTablet ? 20 : 14,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Campo de Senha
                  TextField(
                    obscureText: true,
                    style: GoogleFonts.poppins(fontSize: fieldFont),
                    decoration: InputDecoration(
                      labelText: "Senha",
                      labelStyle: GoogleFonts.poppins(fontSize: fieldFont),
                      hintText: "Digite sua senha",
                      hintStyle: GoogleFonts.poppins(),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: isTablet ? 20 : 14,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Botão ENTRAR
                  SizedBox(
                    width: double.infinity,
                    height: isTablet ? 65 : 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF6A1B9A),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        elevation: 4,
                      ),
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/curso-info');
                      },
                      child: Text(
                        "Entrar",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: buttonFont,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/esqueci-senha');
                      },
                      child: Text(
                        "Esqueceu a senha?",
                        style: GoogleFonts.poppins(
                          color: const Color(0xFF6A1B9A),
                          fontWeight: FontWeight.w500,
                          fontSize: labelFont,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Divider(thickness: 1, height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.facebook, color: Colors.black54),
                        onPressed: () {},
                        iconSize: isTablet ? 40 : 28,
                      ),
                      IconButton(
                        icon: const Icon(Icons.g_mobiledata, color: Colors.black54),
                        onPressed: () {},
                        iconSize: isTablet ? 40 : 28,
                      ),
                      IconButton(
                        icon: const Icon(Icons.apple, color: Colors.black54),
                        onPressed: () {},
                        iconSize: isTablet ? 40 : 28,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Não tem uma conta? ",
                        style: GoogleFonts.poppins(
                          color: Colors.black87,
                          fontSize: labelFont,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.pushNamed(context, '/signup'),
                        child: Text(
                          "Registre-se",
                          style: GoogleFonts.poppins(
                            color: const Color(0xFF6A1B9A),
                            fontWeight: FontWeight.w600,
                            fontSize: labelFont,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

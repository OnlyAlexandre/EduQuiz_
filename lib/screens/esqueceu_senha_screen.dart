import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EsqueceuSenhaScreen extends StatelessWidget {
  const EsqueceuSenhaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final roxo = const Color(0xFF6A1B9A);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'EDUQUIZ',
              style: GoogleFonts.poppins(
                fontSize: 28,
                fontWeight: FontWeight.w700,
                color: roxo,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Esqueceu sua senha?',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Digite o e-mail da sua conta para receber um código de verificação',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 32),
            TextField(
              decoration: InputDecoration(
                labelText: 'Digite seu e-mail',
                labelStyle: GoogleFonts.poppins(color: Colors.grey[600]),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: roxo,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/confirmacaoEmail');
              },
              child: Text(
                'Enviar',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 32),
            Image.asset(
              'assets/images/fox.png',
              height: 120,
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Text(
                'Lembrou da sua senha? Faça login!',
                style: GoogleFonts.poppins(
                  color: roxo,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

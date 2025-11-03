import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final w = size.width;
    final h = size.height;
    final isTablet = w > 600;
    final vPad = isTablet ? h * 0.08 : h * 0.04;
    final hPad = isTablet ? w * 0.14 : w * 0.07;
    final titleFont = isTablet ? 36.0 : 24.0;
    final subtitleFont = isTablet ? 22.0 : 16.0;
    final labelFont = isTablet ? 17.0 : 14.0;
    final buttonFont = isTablet ? 20.0 : 16.0;
    final inputFont = isTablet ? 18.0 : 14.0;
    final iconSize = isTablet ? 32.0 : 24.0;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: hPad, vertical: vPad),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: isTablet ? 38 : 22),
              Text(
                "EDUQUIZ",
                style: GoogleFonts.poppins(
                  color: const Color(0xFF4A148C),
                  fontSize: titleFont,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "Crie sua conta grátis!",
                style: GoogleFonts.poppins(
                  color: Colors.black87,
                  fontSize: subtitleFont,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                "Digite seus dados para criar uma conta.",
                style: GoogleFonts.poppins(
                  color: Colors.black54,
                  fontSize: labelFont,
                ),
              ),
              const SizedBox(height: 38),
              // Campo Nome
              TextField(
                style: GoogleFonts.poppins(fontSize: inputFont),
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person_outline, color: Colors.black54, size: iconSize),
                  hintText: "Digite seu nome",
                  hintStyle: GoogleFonts.poppins(color: Colors.black45),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: isTablet ? 20 : 14),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                style: GoogleFonts.poppins(fontSize: inputFont),
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email_outlined, color: Colors.black54, size: iconSize),
                  hintText: "Digite seu e-mail",
                  hintStyle: GoogleFonts.poppins(color: Colors.black45),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: isTablet ? 20 : 14),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                obscureText: true,
                style: GoogleFonts.poppins(fontSize: inputFont),
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock_outline, color: Colors.black54, size: iconSize),
                  hintText: "Digite sua senha",
                  hintStyle: GoogleFonts.poppins(color: Colors.black45),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: isTablet ? 20 : 14),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                obscureText: true,
                style: GoogleFonts.poppins(fontSize: inputFont),
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock_outline, color: Colors.black54, size: iconSize),
                  hintText: "Confirme sua senha",
                  hintStyle: GoogleFonts.poppins(color: Colors.black45),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: isTablet ? 20 : 14),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: isTablet ? 60 : 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6A1B9A),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {},
                  child: Text(
                    "Cadastrar-se",
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: buttonFont,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  const Expanded(child: Divider(thickness: 1, endIndent: 10)),
                  Text(
                    "ou crie com",
                    style: GoogleFonts.poppins(color: Colors.black54, fontSize: inputFont),
                  ),
                  const Expanded(child: Divider(thickness: 1, indent: 10)),
                ],
              ),
              const SizedBox(height: 21),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black26),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: IconButton(
                      icon: Icon(Icons.camera_alt_outlined, color: Color(0xFF6A1B9A), size: iconSize),
                      onPressed: () {},
                    ),
                  ),
                  SizedBox(width: isTablet ? 34 : 20),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black26),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: IconButton(
                      icon: Icon(Icons.apple, color: Color(0xFF6A1B9A), size: iconSize),
                      onPressed: () {},
                    ),
                  ),
                  SizedBox(width: isTablet ? 34 : 20),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black26),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: IconButton(
                      icon: Icon(Icons.facebook, color: Color(0xFF6A1B9A), size: iconSize),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
              SizedBox(height: isTablet ? 32 : 18),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Já tem uma conta? ",
                    style: GoogleFonts.poppins(color: Colors.black87, fontSize: inputFont),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, '/login'),
                    child: Text(
                      "Faça login!",
                      style: GoogleFonts.poppins(
                        color: const Color(0xFF6A1B9A),
                        fontWeight: FontWeight.w600,
                        fontSize: inputFont,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

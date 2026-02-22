import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CursoInfoScreen extends StatefulWidget {
  const CursoInfoScreen({super.key});

  @override
  State<CursoInfoScreen> createState() => _CursoInfoScreenState();
}

class _CursoInfoScreenState extends State<CursoInfoScreen> {
  String? _instituicaoSelecionada;
  String? _cursoSelecionado;

  final List<String> vestibulares = [
    'ENEM',
    'UFRJ',
    'USP',
    'UNICAMP',
    'UFMG',
    'CIMATEC',
    'Outro',
  ];

  final List<String> cursos = [
    'Design Gráfico',
    'Ciência da Computação',
    'Engenharia',
    'Pedagogia',
    'Outro',
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.08,
            vertical: size.height * 0.08,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Logo EDUQUIZ
              Text(
                "EDUQUIZ",
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF6A1B9A),
                ),
              ),
              const SizedBox(height: 16),

              // Texto de instrução
              Text(
                "Por favor, nos diga:",
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),

              // Dropdown Vestibular
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Qual vestibular você deseja prestar?",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Colors.black87,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                dropdownColor: Colors.white,
                initialValue: _instituicaoSelecionada,
                hint: Text(
                  "Selecione aqui ↓",
                  style: GoogleFonts.poppins(color: Colors.grey[600]),
                ),
                style: GoogleFonts.poppins(color: Colors.black87),
                items: vestibulares.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value, style: GoogleFonts.poppins()),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _instituicaoSelecionada = newValue;
                  });
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        const BorderSide(color: Color(0xFFDADADA), width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        const BorderSide(color: Color(0xFF6A1B9A), width: 1.5),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Dropdown Curso
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Qual curso você deseja fazer?",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Colors.black87,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                dropdownColor: Colors.white,
                initialValue: 'Exemplo de pergunta 1',
                hint: Text(
                  "Selecione aqui ↓",
                  style: GoogleFonts.poppins(color: Colors.grey[600]),
                ),
                style: GoogleFonts.poppins(color: Colors.black),
                items: cursos.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value, style: GoogleFonts.poppins(color: Colors.black)),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _cursoSelecionado = newValue;
                  });
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        const BorderSide(color: Color(0xFFDADADA), width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        const BorderSide(color: Color(0xFF6A1B9A), width: 1.5),
                  ),
                ),
              ),
              const SizedBox(height: 40),

              // Botão "Próximo"
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: _instituicaoSelecionada != null && _cursoSelecionado != null
                      ? () {
                          // Navegar para a próxima tela
                          Navigator.pushReplacementNamed(context, '/home');
                        }
                      : null,
                  child: Text(
                    "Próximo",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF6A1B9A),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
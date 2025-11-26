import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BancoQuestoesScreen extends StatefulWidget {
  const BancoQuestoesScreen({super.key});

  @override
  State<BancoQuestoesScreen> createState() => _BancoQuestoesScreenState();
}

class _BancoQuestoesScreenState extends State<BancoQuestoesScreen> {
  String? _vestibularSelecionado;
  String? _materiaSelecionada;
  String? _anoSelecionado;
  String? _tipoQuestao;

  final List<String> vestibulares = [
    'Todos',
    'ENEM',
    'FUVEST',
    'UNICAMP',
    'UNEB',
    'UFPR',
    'UEA',
    'UNESP',
    'IME',
    'ITA',
  ];

  final List<String> materias = [
    'Todas',
    'Matemática',
    'Física',
    'Química',
    'Biologia',
    'História',
    'Geografia',
    'Português',
    'Literatura',
    'Inglês',
    'Filosofia',
    'Sociologia',
  ];

  final List<String> anos = [
    'Todos',
    '2024',
    '2023',
    '2022',
    '2021',
    '2020',
    '2019',
    '2018',
    'Antigas',
    'Novas (IA)',
  ];

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFF6A1B9A);
    const Color bgColor = Color(0xFFF8F9FA);

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Banco de Questões',
          style: GoogleFonts.poppins(
            color: Colors.black87,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // Filtros
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: Column(
              children: [
                // Dropdown Vestibular
                DropdownButtonFormField<String>(
                  value: _vestibularSelecionado,
                  decoration: InputDecoration(
                    labelText: 'Vestibular',
                    labelStyle: GoogleFonts.poppins(),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Color(0xFFDADADA)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Color(0xFFDADADA)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: primaryColor, width: 2),
                    ),
                  ),
                  hint: Text('Selecione o vestibular', style: GoogleFonts.poppins()),
                  items: vestibulares.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value, style: GoogleFonts.poppins()),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      _vestibularSelecionado = newValue;
                    });
                  },
                  style: GoogleFonts.poppins(color: Colors.black87),
                ),
                const SizedBox(height: 12),
                // Dropdown Matéria
                DropdownButtonFormField<String>(
                  value: _materiaSelecionada,
                  decoration: InputDecoration(
                    labelText: 'Matéria',
                    labelStyle: GoogleFonts.poppins(),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Color(0xFFDADADA)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Color(0xFFDADADA)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: primaryColor, width: 2),
                    ),
                  ),
                  hint: Text('Selecione a matéria', style: GoogleFonts.poppins()),
                  items: materias.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value, style: GoogleFonts.poppins()),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      _materiaSelecionada = newValue;
                    });
                  },
                  style: GoogleFonts.poppins(color: Colors.black87),
                ),
                const SizedBox(height: 12),
                // Dropdown Ano
                DropdownButtonFormField<String>(
                  value: _anoSelecionado,
                  decoration: InputDecoration(
                    labelText: 'Ano',
                    labelStyle: GoogleFonts.poppins(),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Color(0xFFDADADA)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Color(0xFFDADADA)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: primaryColor, width: 2),
                    ),
                  ),
                  hint: Text('Selecione o ano', style: GoogleFonts.poppins()),
                  items: anos.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value, style: GoogleFonts.poppins()),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      _anoSelecionado = newValue;
                    });
                  },
                  style: GoogleFonts.poppins(color: Colors.black87),
                ),
                const SizedBox(height: 12),
                // Botão de filtrar
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Aplicar filtros
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Aplicar Filtros',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 8),

          // Lista de questões
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: 15,
              itemBuilder: (context, index) {
                return _buildQuestaoCard(
                  numero: index + 1,
                  vestibular: 'ENEM',
                  materia: 'Matemática',
                  ano: '2024',
                  dificuldade: index % 3 == 0 ? 'Fácil' : index % 3 == 1 ? 'Média' : 'Difícil',
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestaoCard({
    required int numero,
    required String vestibular,
    required String materia,
    required String ano,
    required String dificuldade,
  }) {
    const Color primaryColor = Color(0xFF6A1B9A);
    
    Color dificuldadeColor;
    switch (dificuldade) {
      case 'Fácil':
        dificuldadeColor = Colors.green;
        break;
      case 'Média':
        dificuldadeColor = Colors.orange;
        break;
      case 'Difícil':
        dificuldadeColor = Colors.red;
        break;
      default:
        dificuldadeColor = Colors.grey;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFECECEC)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Questão #$numero',
                  style: GoogleFonts.poppins(
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: dificuldadeColor.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  dificuldade,
                  style: GoogleFonts.poppins(
                    color: dificuldadeColor,
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'Questão de $materia do $vestibular $ano',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Uma questão de exemplo que será exibida aqui quando você clicar para resolver...',
            style: GoogleFonts.poppins(
              color: Colors.black54,
              fontSize: 13,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(Icons.school, size: 16, color: Colors.grey[600]),
              const SizedBox(width: 4),
              Text(
                vestibular,
                style: GoogleFonts.poppins(
                  color: Colors.grey[600],
                  fontSize: 12,
                ),
              ),
              const SizedBox(width: 16),
              Icon(Icons.calendar_today, size: 16, color: Colors.grey[600]),
              const SizedBox(width: 4),
              Text(
                ano,
                style: GoogleFonts.poppins(
                  color: Colors.grey[600],
                  fontSize: 12,
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: () {
                  // Navegar para resolver questão
                  Navigator.pushNamed(context, '/quiz');
                },
                style: TextButton.styleFrom(
                  backgroundColor: primaryColor,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Resolver',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}


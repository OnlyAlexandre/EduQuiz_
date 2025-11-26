import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MapaAprendizadoScreen extends StatefulWidget {
  const MapaAprendizadoScreen({super.key});

  @override
  State<MapaAprendizadoScreen> createState() => _MapaAprendizadoScreenState();
}

class _MapaAprendizadoScreenState extends State<MapaAprendizadoScreen> {
  String? _materiaSelecionada;
  String? _assuntoSelecionado;
  Map<String, bool> _assuntosExpandidos = {};

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
  ];

  final Map<String, List<Map<String, dynamic>>> materiasAssuntos = {
    'Matemática': [
      {
        'nome': 'Álgebra',
        'subAssuntos': ['Equações', 'Inequações', 'Funções', 'Polinômios'],
        'progresso': 65,
        'questoes': 10,
      },
      {
        'nome': 'Geometria',
        'subAssuntos': ['Geometria Plana', 'Geometria Espacial', 'Trigonometria'],
        'progresso': 40,
        'questoes': 10,
      },
      {
        'nome': 'Análise Combinatória',
        'subAssuntos': ['Permutação', 'Combinação', 'Arranjo'],
        'progresso': 80,
        'questoes': 10,
      },
    ],
    'Física': [
      {
        'nome': 'Mecânica',
        'subAssuntos': ['Cinemática', 'Dinâmica', 'Energia'],
        'progresso': 50,
        'questoes': 10,
      },
      {
        'nome': 'Termodinâmica',
        'subAssuntos': ['Calor', 'Trabalho', 'Entropia'],
        'progresso': 30,
        'questoes': 10,
      },
    ],
    'Química': [
      {
        'nome': 'Química Geral',
        'subAssuntos': ['Átomos', 'Moléculas', 'Ligações'],
        'progresso': 70,
        'questoes': 10,
      },
    ],
  };

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
          'Mapa de Aprendizado',
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
          // Dropdown de seleção de matéria
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            color: Colors.white,
            child: DropdownButtonFormField<String>(
              value: _materiaSelecionada,
              decoration: InputDecoration(
                labelText: 'Selecione a matéria',
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
              hint: Text('Todas as matérias', style: GoogleFonts.poppins()),
              items: materias.map((String value) {
                return DropdownMenuItem<String>(
                  value: value == 'Todas' ? null : value,
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
          ),

          const SizedBox(height: 16),

          // Lista de blocos de assunto
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _getAssuntos().length,
              itemBuilder: (context, index) {
                final assunto = _getAssuntos()[index];
                final isExpanded = _assuntosExpandidos[assunto['nome']] ?? false;
                
                return _buildAssuntoCard(
                  assunto: assunto,
                  isExpanded: isExpanded,
                  onToggle: () {
                    setState(() {
                      _assuntosExpandidos[assunto['nome']] = !isExpanded;
                    });
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getAssuntos() {
    if (_materiaSelecionada == null || _materiaSelecionada == 'Todas') {
      // Retorna todos os assuntos de todas as matérias
      List<Map<String, dynamic>> todos = [];
      materiasAssuntos.forEach((materia, assuntos) {
        for (var assunto in assuntos) {
          todos.add({...assunto, 'materia': materia});
        }
      });
      return todos;
    } else {
      // Retorna apenas os assuntos da matéria selecionada
      final assuntos = materiasAssuntos[_materiaSelecionada] ?? [];
      return assuntos.map((a) => {...a, 'materia': _materiaSelecionada}).toList();
    }
  }

  Widget _buildAssuntoCard({
    required Map<String, dynamic> assunto,
    required bool isExpanded,
    required VoidCallback onToggle,
  }) {
    const Color primaryColor = Color(0xFF6A1B9A);
    final progresso = assunto['progresso'] as int;
    final questoes = assunto['questoes'] as int;
    final subAssuntos = assunto['subAssuntos'] as List<String>;
    final materia = assunto['materia'] as String?;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFECECEC)),
      ),
      child: Column(
        children: [
          // Cabeçalho do assunto
          InkWell(
            onTap: onToggle,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.book_outlined,
                      color: primaryColor,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (materia != null)
                          Text(
                            materia,
                            style: GoogleFonts.poppins(
                              fontSize: 11,
                              color: Colors.grey[600],
                            ),
                          ),
                        Text(
                          assunto['nome'],
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(Icons.quiz_outlined, size: 14, color: Colors.grey[600]),
                            const SizedBox(width: 4),
                            Text(
                              '$questoes questões • 25-30min',
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        // Barra de progresso
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: LinearProgressIndicator(
                            value: progresso / 100,
                            minHeight: 6,
                            backgroundColor: Colors.grey[200],
                            valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '$progresso% concluído',
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    isExpanded ? Icons.expand_less : Icons.expand_more,
                    color: Colors.grey[600],
                  ),
                ],
              ),
            ),
          ),
          
          // Sub-assuntos (expandido)
          if (isExpanded)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Column(
                children: [
                  const Divider(),
                  const SizedBox(height: 8),
                  ...subAssuntos.map((subAssunto) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: InkWell(
                        onTap: () {
                          // Navegar para questões do sub-assunto
                          Navigator.pushNamed(context, '/quiz');
                        },
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.grey[50],
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey[200]!),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.play_circle_outline, size: 20, color: primaryColor),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  subAssunto,
                                  style: GoogleFonts.poppins(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Icon(Icons.chevron_right, size: 20, color: Colors.grey[400]),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // Iniciar questões do assunto
                        Navigator.pushNamed(context, '/quiz');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Iniciar Questões',
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
        ],
      ),
    );
  }
}


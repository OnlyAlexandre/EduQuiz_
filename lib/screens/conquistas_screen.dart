import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ConquistasScreen extends StatefulWidget {
  const ConquistasScreen({super.key});

  @override
  State<ConquistasScreen> createState() => _ConquistasScreenState();
}

class _ConquistasScreenState extends State<ConquistasScreen> {
  String _filtroSelecionado = 'Todas';

  final List<String> filtros = ['Todas', 'Desbloqueadas', 'Bloqueadas'];

  final List<Map<String, dynamic>> conquistas = [
    {
      'titulo': 'Primeiro Passo',
      'descricao': 'Complete sua primeira questão',
      'icone': Icons.star,
      'cor': Colors.amber,
      'desbloqueada': true,
      'data': 'Hoje',
    },
    {
      'titulo': 'Maratonista',
      'descricao': 'Resolva 100 questões',
      'icone': Icons.directions_run,
      'cor': Colors.blue,
      'desbloqueada': true,
      'data': 'Ontem',
    },
    {
      'titulo': 'Mestre dos Números',
      'descricao': 'Acerte 50 questões de matemática',
      'icone': Icons.calculate,
      'cor': Colors.purple,
      'desbloqueada': true,
      'data': '2 dias atrás',
    },
    {
      'titulo': 'Sequência Perfeita',
      'descricao': 'Acertar 10 questões seguidas',
      'icone': Icons.local_fire_department,
      'cor': Colors.orange,
      'desbloqueada': false,
      'progresso': 7,
      'total': 10,
    },
    {
      'titulo': 'Top 10',
      'descricao': 'Entre no top 10 do ranking',
      'icone': Icons.emoji_events,
      'cor': Colors.yellow[700]!,
      'desbloqueada': false,
      'progresso': 15,
      'total': 10,
    },
    {
      'titulo': 'Estudante Dedicado',
      'descricao': 'Estude por 7 dias consecutivos',
      'icone': Icons.calendar_today,
      'cor': Colors.green,
      'desbloqueada': false,
      'progresso': 3,
      'total': 7,
    },
    {
      'titulo': 'Perfeccionista',
      'descricao': 'Acertar 100% em um simulado',
      'icone': Icons.verified,
      'cor': Colors.teal,
      'desbloqueada': false,
    },
    {
      'titulo': 'Explorador',
      'descricao': 'Complete todos os assuntos de uma matéria',
      'icone': Icons.explore,
      'cor': Colors.indigo,
      'desbloqueada': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFF6A1B9A);
    const Color bgColor = Color(0xFFF8F9FA);

    final conquistasFiltradas = _filtroSelecionado == 'Todas'
        ? conquistas
        : _filtroSelecionado == 'Desbloqueadas'
            ? conquistas.where((c) => c['desbloqueada'] == true).toList()
            : conquistas.where((c) => c['desbloqueada'] == false).toList();

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Conquistas',
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
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            color: Colors.white,
            child: Row(
              children: filtros.map((filtro) {
                final isSelected = filtro == _filtroSelecionado;
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          _filtroSelecionado = filtro;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: isSelected ? primaryColor : Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: isSelected ? primaryColor : Colors.grey[300]!,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            filtro,
                            style: GoogleFonts.poppins(
                              color: isSelected ? Colors.white : Colors.black87,
                              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),

          const SizedBox(height: 16),

          // Lista de conquistas
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.85,
              ),
              itemCount: conquistasFiltradas.length,
              itemBuilder: (context, index) {
                final conquista = conquistasFiltradas[index];
                return _buildConquistaCard(conquista);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConquistaCard(Map<String, dynamic> conquista) {
    const Color primaryColor = Color(0xFF6A1B9A);
    final desbloqueada = conquista['desbloqueada'] as bool;
    final cor = conquista['cor'] as Color;
    final icone = conquista['icone'] as IconData;

    return Container(
      decoration: BoxDecoration(
        color: desbloqueada ? Colors.white : Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: desbloqueada ? cor.withOpacity(0.3) : Colors.grey[300]!,
          width: desbloqueada ? 2 : 1,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Ícone
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: desbloqueada
                  ? cor.withOpacity(0.15)
                  : Colors.grey[300]!.withOpacity(0.5),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icone,
              size: 32,
              color: desbloqueada ? cor : Colors.grey[400],
            ),
          ),
          const SizedBox(height: 12),
          // Título
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              conquista['titulo'],
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                fontSize: 13,
                color: desbloqueada ? Colors.black87 : Colors.grey[600],
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(height: 4),
          // Descrição
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              conquista['descricao'],
              style: GoogleFonts.poppins(
                fontSize: 11,
                color: desbloqueada ? Colors.black54 : Colors.grey[500],
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          // Progresso (se bloqueada)
          if (!desbloqueada && conquista.containsKey('progresso'))
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  const SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: (conquista['progresso'] as int) /
                          (conquista['total'] as int),
                      minHeight: 4,
                      backgroundColor: Colors.grey[300],
                      valueColor: AlwaysStoppedAnimation<Color>(cor),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${conquista['progresso']}/${conquista['total']}',
                    style: GoogleFonts.poppins(
                      fontSize: 10,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            )
          else if (desbloqueada && conquista.containsKey('data'))
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                conquista['data'],
                style: GoogleFonts.poppins(
                  fontSize: 10,
                  color: cor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
        ],
      ),
    );
  }
}


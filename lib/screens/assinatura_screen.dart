import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AssinaturaScreen extends StatelessWidget {
  const AssinaturaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFF6A1B9A);
    const Color accentColor = Color(0xFFFFB300);

    final planos = [
      {
        'nome': 'Plano Gratuito',
        'preco': 'Grátis',
        'cor': Colors.grey,
        'atual': true,
        'recursos': [
          'Acesso limitado a questões',
          'Ranking básico',
          'Conquistas básicas',
        ],
      },
      {
        'nome': 'Plano Premium',
        'preco': 'R\$ 29,90/mês',
        'cor': primaryColor,
        'atual': false,
        'recursos': [
          'Acesso ilimitado a questões',
          'Ranking completo',
          'Todas as conquistas',
          'Banco de questões completo',
          'Suporte prioritário',
        ],
      },
      {
        'nome': 'Plano Ultimate',
        'preco': 'R\$ 49,90/mês',
        'cor': accentColor,
        'atual': false,
        'recursos': [
          'Tudo do Premium',
          'Questões geradas por IA',
          'Tutoriais personalizados',
          'Análise de desempenho avançada',
          'Suporte 24/7',
        ],
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Alterar Plano',
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
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: planos.map((plano) {
          final isAtual = plano['atual'] as bool;
          final cor = plano['cor'] as Color;
          
          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isAtual ? cor : Colors.grey[300]!,
                width: isAtual ? 2 : 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        plano['nome'] as String,
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                          color: cor,
                        ),
                      ),
                    ),
                    if (isAtual)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: cor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          'Atual',
                          style: GoogleFonts.poppins(
                            color: cor,
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  plano['preco'] as String,
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
                ...(plano['recursos'] as List<String>).map((recurso) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      children: [
                        Icon(Icons.check_circle, color: cor, size: 20),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            recurso,
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
                if (!isAtual) ...[
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // Implementar assinatura
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Assinatura ${plano['nome']} selecionada')),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: cor,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Assinar',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}


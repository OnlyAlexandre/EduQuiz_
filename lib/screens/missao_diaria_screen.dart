import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MissoesDiariasScreen extends StatelessWidget {
  const MissoesDiariasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F7),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Missões diárias",
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        children: [
          // CARD DE PROGRESSO DO DIA
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: const LinearGradient(
                colors: [
                  Color(0xFFDFD7FF),
                  Color(0xFFECEAFF),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.hourglass_bottom, color: Colors.black54),
                    const SizedBox(width: 8),
                    Text(
                      "Progresso de hoje",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  "0 de 3 missões feitas",
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 6),
                // barra de progresso
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: 0,
                    minHeight: 8,
                    backgroundColor: Colors.white.withAlpha(128),
                    valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF7A52FF)),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Pontos adquiridos:",
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        color: Colors.black87,
                      ),
                    ),
                    Text(
                      "0",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          // Mensagem informativa
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFFD7EEFF),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                "Complete todas as missões diárias para conseguir mais pontos!\n"
                "Todas as missões retornam às 00h.",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            "Suas missões",
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12),
          // LISTA DE MISSÕES
          _buildMissaoCard(
            titulo: "Faça sua primeira questão do dia.",
            descricao: "Faça uma questão no banco de questões para completar essa missão.",
            progressoAtual: 0,
            progressoTotal: 1,
            icone: Icons.bolt,
            corIcone: Colors.blue,
            badgeTexto: "125 XP",
            concluida: false,
          ),
          _buildMissaoCard(
            titulo: "Complete 10 questões",
            descricao: "Resolva 10 questões para ganhar pontos extras.",
            progressoAtual: 0,
            progressoTotal: 10,
            icone: Icons.quiz_outlined,
            corIcone: Colors.purple,
            badgeTexto: "250 XP",
            concluida: false,
          ),
          _buildMissaoCard(
            titulo: "Entre no ranking diário",
            descricao: "Participe de um simulado e entre no ranking.",
            progressoAtual: 1,
            progressoTotal: 1,
            icone: Icons.emoji_events_outlined,
            corIcone: Colors.amber,
            badgeTexto: "500 XP",
            concluida: true,
          ),
        ],
      ),
    );
  }

  Widget _buildMissaoCard({
    required String titulo,
    required String descricao,
    required int progressoAtual,
    required int progressoTotal,
    required IconData icone,
    required Color corIcone,
    required String badgeTexto,
    bool concluida = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(26),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: corIcone.withAlpha(26),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icone, color: corIcone),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      titulo,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      descricao,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: concluida 
                      ? const Color(0xFFE8F5E9) 
                      : const Color(0xFFF5F5F7),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  concluida ? 'Concluído' : badgeTexto,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: concluida ? const Color(0xFF4CAF50) : const Color(0xFF7A52FF),
                  ),
                ),
              ),
            ],
          ),
          if (!concluida) ...[
            const SizedBox(height: 12),
            LinearProgressIndicator(
              value: progressoAtual / progressoTotal,
              backgroundColor: Colors.grey[200],
              color: const Color(0xFF7A52FF),
              minHeight: 6,
              borderRadius: BorderRadius.circular(3),
            ),
            const SizedBox(height: 8),
            Text(
              '$progressoAtual/$progressoTotal',
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
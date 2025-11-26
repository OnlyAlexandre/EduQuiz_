import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificacoesScreen extends StatefulWidget {
  const NotificacoesScreen({super.key});

  @override
  State<NotificacoesScreen> createState() => _NotificacoesScreenState();
}

class _NotificacoesScreenState extends State<NotificacoesScreen> {
  String filtroSelecionado = "Tudo";

  final filtros = ["Tudo", "Hoje", "Ontem", "7 dias", "1 mês"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F7),

      // -------------------- APP BAR DA IMAGEM --------------------
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.6,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
        ),
        title: Text(
          "Notificações",
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
      ),

      // -------------------- CORPO --------------------
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 12),

          // -------------------- FILTROS IGUAIS À IMAGEM --------------------
          SizedBox(
            height: 40,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemBuilder: (context, index) {
                final item = filtros[index];
                final bool ativo = item == filtroSelecionado;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      filtroSelecionado = item;
                    });
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: ativo ? const Color(0xff6A4CE3) : Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: ativo
                            ? const Color(0xff6A4CE3)
                            : Colors.grey.shade300,
                        width: 1,
                      ),
                      boxShadow: ativo
                          ? [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              )
                            ]
                          : [],
                    ),
                    child: Center(
                      child: Text(
                        item,
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: ativo ? Colors.white : Colors.black87,
                        ),
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (_, __) => const SizedBox(width: 10),
              itemCount: filtros.length,
            ),
          ),

          const SizedBox(height: 40),

          // -------------------- LAYOUT DE "NENHUMA NOTIFICAÇÃO" --------------------
          Expanded(
            child: Center(
              child: Text(
                "Você não tem nenhuma notificação...",
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

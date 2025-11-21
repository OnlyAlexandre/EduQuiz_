// lib/home_screen.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meu_app/services/user_service.dart';
import 'package:meu_app/services/user_state.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeScreen extends StatefulWidget {

  final bool initialZerado; // passe true/false aqui na inicialização

  const HomeScreen({
    super.key,
    this.initialZerado = true,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late bool isZerado;
  final user = UserState.currentUser;

  @override
  void initState() {
    super.initState();
    isZerado = widget.initialZerado;
    // Aqui você pode chamar sua API e alterar isZerado quando receber resposta.
  }
  
  Future<void> _loadUser() async {
    if (UserState.currentUser == null) {
      final uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid == null) return;

      UserState.currentUser = await UserService.getUsuario();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _loadUser(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final user = UserState.currentUser;

        if (user == null) {
          return const Scaffold(
            body: Center(child: Text("Erro ao carregar usuário")),
          );
        }

        return _buildHome(user);
      },
    );
  }
  Widget _buildHome(UserService user) {
    // cores centrais do projeto
    const Color primary = Color(0xFF6A1B9A);
    const Color accent = Color(0xFFFFB300);
    const bgColor = Color(0xFFF8F9FA);

    return Scaffold(
      backgroundColor: bgColor,
      // AppBar transparente com avatar no canto direito (visual igual ao Figma)
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('EDUQUIZ',
            style: GoogleFonts.poppins(
                color: primary, fontWeight: FontWeight.w700)),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none, color: Colors.grey),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context,'/perfil');
              },
              child: const CircleAvatar(
                radius: 18,
                backgroundColor: Color(0xFFE0E0E0),
                child: Icon(Icons.person, color: Color(0xFF666666)),
              ),
            ),
          ),
        ],
      ),

      // Conteúdo rolável: cada bloco ocupa seu espaço e aparece ao rolar
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // HEADER CARD roxo (greeting + resumo curto)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: primary,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 10,
                    offset: const Offset(0, 6),
                  )
                ],
              ),
              child: Row(
                children: [
                  // texto de saudação
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Olá, ${user.name} 👋',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          isZerado
                              ? 'Vamos começar sua primeira aula?'
                              : 'Continue sua jornada de aprendizado',
                          style: GoogleFonts.poppins(
                            color: Colors.white70,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // botão para simular troca de estado (apenas para teste)
                  IconButton(
                    onPressed: () => setState(() => isZerado = !isZerado),
                    icon: const Icon(Icons.sync, color: Colors.white),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 18),

            // CARD ROW: dias / taxa de acertos (visual igual ao Figma)
            Row(
              children: [
                Expanded(child: _smallStatCard('Dias', isZerado ? '0' : '9', accent)),
                const SizedBox(width: 12),
                Expanded(child: _smallStatCard('Acertos', isZerado ? '0%' : '60%', Colors.green)),
              ],
            ),

            const SizedBox(height: 20),

            // Título Mapa de Aprendizado
            Text('Mapa de aprendizado',
                style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 10),

            // MAPA: se zerado mostra imagem/texto, se não zerado mostra lista de cards
            isZerado ? _mapaZeradoView() : _mapaNaoZeradoView(),

            const SizedBox(height: 22),

            // Ações rápidas (três botões grandes empilhados)
            Text('Ações rápidas',
                style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),
            _actionCard(
              title: 'Revisão diária',
              subtitle: 'Reforce o conteúdo estudado',
              bg: Colors.white,
              borderColor: primary,
              buttonLabel: 'INICIAR',
              icon: Icons.bolt,
              buttonBg: primary,
              buttonTextColor: Colors.white,
            ),
            const SizedBox(height: 12),
            _actionCard(
              title: 'Banco de questões',
              subtitle: 'Pratique com perguntas reais',
              bg: primary,
              borderColor: primary,
              buttonLabel: 'CONTINUAR',
              icon: Icons.question_answer_outlined,
              buttonBg: Colors.white,
              buttonTextColor: primary,
              textColor: Colors.white,
            ),
            const SizedBox(height: 12),
            _actionCard(
              title: 'Trilha de matemática',
              subtitle: 'Tópicos mais desafiadores',
              bg: accent,
              borderColor: accent,
              buttonLabel: 'REFAZER',
              icon: Icons.calculate_outlined,
              buttonBg: Colors.black,
              buttonTextColor: Colors.white,
            ),

            const SizedBox(height: 22),

            // Estatísticas de hoje — grid 2x2
            Text('Estatísticas de hoje',
                style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(child: _statCard('Questões', isZerado ? '0' : '12', Icons.help_outline)),
                const SizedBox(width: 12),
                Expanded(child: _statCard('Tempo', isZerado ? '0m' : '18m', Icons.access_time)),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(child: _statCard('Acertos', isZerado ? '0%' : '75%', Icons.check_circle_outline)),
                const SizedBox(width: 12),
                Expanded(child: _statCard('Dias ativos', isZerado ? '0' : '6', Icons.calendar_today)),
              ],
            ),

            const SizedBox(height: 36),
          ],
        ),
      ),

      // bottom bar com notch + FAB central (visual igual ao design)
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: primary,
        onPressed: () {
          // ação do + (por enquanto visual)
        },
        child: const Icon(Icons.play_arrow, size: 28, color: Colors.white),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        elevation: 9,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(onPressed: () {}, icon: Icon(Icons.home, color: primary)),
              IconButton(onPressed: () {}, icon: Icon(Icons.map_outlined, color: Colors.grey[600])),
              const SizedBox(width: 48), // espaço para FAB
              IconButton(onPressed: () {}, icon: Icon(Icons.bar_chart, color: Colors.grey[600])),
              IconButton(onPressed: () {}, icon: Icon(Icons.settings, color: Colors.grey[600])),
            ],
          ),
        ),
      ),
    );
  }

  // ---------- Widgets auxiliares (componentes do layout) ----------

  Widget _smallStatCard(String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(label, style: GoogleFonts.poppins(fontSize: 12, color: Colors.black87)),
        const SizedBox(height: 6),
        Text(value, style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w700, color: color)),
      ]),
    );
  }

  Widget _mapaZeradoView() {
    return Container(
      height: 160,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFEDEDED)),
      ),
      child: Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          const Icon(Icons.location_on_outlined, size: 36, color: Colors.grey),
          const SizedBox(height: 8),
          Text('Nenhum progresso ainda', style: GoogleFonts.poppins(color: Colors.black54)),
          const SizedBox(height: 6),
          Text('Comece sua primeira aula para preencher seu mapa',
              style: GoogleFonts.poppins(color: Colors.black38, fontSize: 12), textAlign: TextAlign.center),
        ]),
      ),
    );
  }

  Widget _mapaNaoZeradoView() {
    return Column(
      children: List.generate(3, (i) {
        return Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFECECEC)),
          ),
          child: Row(
            children: [
              CircleAvatar(backgroundColor: const Color(0xFF6A1B9A), child: Icon(Icons.play_arrow, color: Colors.white)),
              const SizedBox(width: 12),
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('Matemática ${i + 1}', style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
                  Text('10 questões', style: GoogleFonts.poppins(color: Colors.black54, fontSize: 12)),
                ]),
              ),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  backgroundColor: const Color(0xFF6A1B9A),
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: Text('Continuar', style: GoogleFonts.poppins(color: Colors.white)),
              )
            ],
          ),
        );
      }),
    );
  }

  Widget _actionCard({
    required String title,
    required String subtitle,
    required Color bg,
    required Color borderColor,
    required String buttonLabel,
    required IconData icon,
    required Color buttonBg,
    required Color buttonTextColor,
    Color? textColor,
  }) {
    final bool isPrimaryBg = bg == const Color(0xFF6A1B9A);
    final Color actualTextColor = textColor ?? (isPrimaryBg ? Colors.white : Colors.black);

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor.withOpacity(0.12)),
      ),
      child: Row(
        children: [
          Icon(icon, color: actualTextColor),
          const SizedBox(width: 12),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(title, style: GoogleFonts.poppins(fontWeight: FontWeight.w600, color: actualTextColor)),
              const SizedBox(height: 6),
              Text(subtitle, style: GoogleFonts.poppins(fontSize: 12, color: actualTextColor.withOpacity(0.85))),
            ]),
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: buttonBg,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              elevation: 0,
            ),
            child: Text(buttonLabel, style: GoogleFonts.poppins(color: buttonTextColor, fontWeight: FontWeight.w600)),
          )
        ],
      ),
    );
  }

  Widget _statCard(String title, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFECECEC)),
      ),
      child: Column(
        children: [
          Icon(icon, color: const Color(0xFF6A1B9A)),
          const SizedBox(height: 8),
          Text(value, style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 16)),
          const SizedBox(height: 6),
          Text(title, style: GoogleFonts.poppins(color: Colors.black54, fontSize: 12)),
        ],
      ),
    );
  }
}

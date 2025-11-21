// lib/home_screen.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/responsive.dart';

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

    // Responsividade
    final hPad = Responsive.getHorizontalPadding(context);
    final vPad = Responsive.getVerticalPadding(context);
    final titleFont = Responsive.getFontSize(context, mobile: 20, tablet: 24, desktop: 28);
    final greetingFont = Responsive.getFontSize(context, mobile: 18, tablet: 22, desktop: 26);
    final subtitleFont = Responsive.getFontSize(context, mobile: 13, tablet: 15, desktop: 17);
    final sectionTitleFont = Responsive.getFontSize(context, mobile: 16, tablet: 18, desktop: 20);
    final spacing = Responsive.getSpacing(context, mobile: 12, tablet: 16, desktop: 20);
    final cardPadding = Responsive.getSpacing(context, mobile: 16, tablet: 20, desktop: 24);
    final avatarRadius = Responsive.getIconSize(context, mobile: 18, tablet: 22, desktop: 26);

    return Scaffold(
      backgroundColor: bgColor,
      // AppBar transparente com avatar no canto direito (visual igual ao Figma)
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('EDUQUIZ',
            style: GoogleFonts.poppins(
                color: primary, fontWeight: FontWeight.w700, fontSize: titleFont)),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/notificacoes');
            },
            icon: const Icon(Icons.notifications_none, color: Colors.grey),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/settings');
            },
            icon: const Icon(Icons.settings_outlined, color: Colors.grey),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/perfil');
              },
              child: CircleAvatar(
                radius: avatarRadius,
                backgroundColor: const Color(0xFFE0E0E0),
                child: Icon(Icons.person, color: const Color(0xFF666666), size: avatarRadius),
              ),
            ),
          ),
        ],
      ),

      // Conteúdo rolável: cada bloco ocupa seu espaço e aparece ao rolar
      body: LayoutBuilder(
        builder: (context, constraints) {
          final maxWidth = Responsive.getMaxContentWidth(context);
          return Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: maxWidth),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: hPad, vertical: vPad),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
            // HEADER CARD roxo (greeting + resumo curto)
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(cardPadding),
              decoration: BoxDecoration(
                color: primary,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(15), // ~0.06 de opacidade
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
                            fontSize: greetingFont,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: spacing * 0.5),
                        Text(
                          isZerado
                              ? 'Vamos começar sua primeira aula?'
                              : 'Continue sua jornada de aprendizado',
                          style: GoogleFonts.poppins(
                            color: Colors.white70,
                            fontSize: subtitleFont,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Botão para missão diária
                  IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/missao-diaria');
                    },
                    icon: const Icon(Icons.flag, color: Colors.white),
                    tooltip: 'Missões diárias',
                  ),
                ],
              ),
            ),

            SizedBox(height: spacing * 1.5),

            // CARD ROW: dias / taxa de acertos (visual igual ao Figma)
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/missao-diaria');
                    },
                    child: _smallStatCard('Dias', isZerado ? '0' : '9', accent),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/perfil');
                    },
                    child: _smallStatCard('Acertos', isZerado ? '0%' : '60%', Colors.green),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Título Mapa de Aprendizado
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Mapa de aprendizado',
                    style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600)),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/mapa-aprendizado');
                  },
                  child: Text(
                    'Ver tudo',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // MAPA: se zerado mostra imagem/texto, se não zerado mostra lista de cards
            isZerado ? _mapaZeradoView() : _mapaNaoZeradoView(),

            SizedBox(height: spacing * 1.8),

            // Ações rápidas (três botões grandes empilhados)
            Text('Ações rápidas',
                style: GoogleFonts.poppins(fontSize: sectionTitleFont, fontWeight: FontWeight.w600)),
            SizedBox(height: spacing),
            _actionCard(
              title: 'Revisão diária',
              subtitle: 'Reforce o conteúdo estudado',
              bg: Colors.white,
              borderColor: primary,
              buttonLabel: 'INICIAR',
              icon: Icons.bolt,
              buttonBg: primary,
              buttonTextColor: Colors.white,
              onPressed: () {
                Navigator.pushNamed(context, '/missao-diaria');
              },
            ),
            SizedBox(height: spacing),
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
              onPressed: () {
                Navigator.pushNamed(context, '/banco-questoes');
              },
            ),
            SizedBox(height: spacing),
            _actionCard(
              title: 'Trilha de matemática',
              subtitle: 'Tópicos mais desafiadores',
              bg: accent,
              borderColor: accent,
              buttonLabel: 'REFAZER',
              icon: Icons.calculate_outlined,
              buttonBg: Colors.black,
              buttonTextColor: Colors.white,
              onPressed: () {
                Navigator.pushNamed(context, '/mapa-aprendizado');
              },
            ),

            SizedBox(height: spacing * 1.8),

            // Estatísticas de hoje — grid 2x2
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Estatísticas de hoje',
                    style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600)),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/revisar-erros');
                  },
                  child: Text(
                    'Revisar erros',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: spacing),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/banco-questoes');
                    },
                    child: _statCard('Questões', isZerado ? '0' : '12', Icons.help_outline),
                  ),
                ),
                SizedBox(width: spacing),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/perfil');
                    },
                    child: _statCard('Tempo', isZerado ? '0m' : '18m', Icons.access_time),
                  ),
                ),
              ],
            ),
            SizedBox(height: spacing * 0.8),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/perfil');
                    },
                    child: _statCard('Acertos', isZerado ? '0%' : '75%', Icons.check_circle_outline),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/missao-diaria');
                    },
                    child: _statCard('Dias ativos', isZerado ? '0' : '6', Icons.calendar_today),
                  ),
                ),
              ],
            ),

            SizedBox(height: spacing * 3),
                  ],
                ),
              ),
            ),
          );
        },
      ),

      // bottom bar com notch + FAB central (visual igual ao design)
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: primary,
        onPressed: () {
          Navigator.pushNamed(context, '/rodadas-rapidas');
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
              IconButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/home');
                },
                icon: Icon(Icons.home, color: primary),
              ),
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/mapa-aprendizado');
                },
                icon: Icon(Icons.bolt, color: Colors.grey[600]),
              ),
              const SizedBox(width: 48), // espaço para FAB
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/banco-questoes');
                },
                icon: Icon(Icons.menu_book, color: Colors.grey[600]),
              ),
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/ranking');
                },
                icon: Icon(Icons.emoji_events, color: Colors.grey[600]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ---------- Widgets auxiliares (componentes do layout) ----------

  Widget _smallStatCard(String label, String value, Color color) {
    final spacing = Responsive.getSpacing(context, mobile: 12, tablet: 14, desktop: 16);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: spacing, vertical: spacing * 1.2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(12),
      ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: Responsive.getFontSize(context, mobile: 12, tablet: 13, desktop: 14),
            color: Colors.black87,
          ),
        ),
        SizedBox(height: spacing * 0.5),
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: Responsive.getFontSize(context, mobile: 18, tablet: 22, desktop: 26),
            fontWeight: FontWeight.w700,
            color: color,
          ),
        ),
      ]),
    );
  }

  Widget _mapaZeradoView() {
    final iconSize = Responsive.getIconSize(context, mobile: 36, tablet: 42, desktop: 48);
    final spacing = Responsive.getSpacing(context, mobile: 8, tablet: 10, desktop: 12);
    final height = Responsive.getHeight(context) * (Responsive.isMobile(context) ? 0.2 : 0.15);
    
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/mapa-aprendizado');
      },
      child: Container(
        height: height,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFFEDEDED)),
        ),
        child: Center(
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Icon(Icons.location_on_outlined, size: iconSize, color: Colors.grey),
            SizedBox(height: spacing),
            Text(
              'Nenhum progresso ainda',
              style: GoogleFonts.poppins(
                color: Colors.black54,
                fontSize: Responsive.getFontSize(context, mobile: 14, tablet: 16, desktop: 18),
              ),
            ),
            SizedBox(height: spacing * 0.75),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: spacing * 2),
              child: Text(
                'Comece sua primeira aula para preencher seu mapa',
                style: GoogleFonts.poppins(
                  color: Colors.black38,
                  fontSize: Responsive.getFontSize(context, mobile: 12, tablet: 13, desktop: 14),
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: spacing * 1.5),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/mapa-aprendizado');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6A1B9A),
                padding: EdgeInsets.symmetric(
                  horizontal: spacing * 2.5,
                  vertical: spacing * 1.2,
                ),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: Text(
                'Explorar Mapa',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: Responsive.getFontSize(context, mobile: 12, tablet: 13, desktop: 14),
                ),
              ),
            ),
          ]),
        ),
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
                onPressed: () {
                  Navigator.pushNamed(context, '/quiz');
                },
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
    VoidCallback? onPressed,
  }) {
    final bool isPrimaryBg = bg == const Color(0xFF6A1B9A);
    final Color actualTextColor = textColor ?? (isPrimaryBg ? Colors.white : Colors.black);
    final cardPadding = Responsive.getSpacing(context, mobile: 14, tablet: 18, desktop: 22);
    final iconSize = Responsive.getIconSize(context, mobile: 24, tablet: 28, desktop: 32);
    final titleFont = Responsive.getFontSize(context, mobile: 15, tablet: 17, desktop: 19);
    final subtitleFont = Responsive.getFontSize(context, mobile: 12, tablet: 13, desktop: 14);
    final buttonFont = Responsive.getFontSize(context, mobile: 12, tablet: 13, desktop: 14);

    return Container(
      padding: EdgeInsets.all(cardPadding),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor.withAlpha(30)), // ~0.12 de opacidade
      ),
      child: Row(
        children: [
          Icon(icon, color: actualTextColor, size: iconSize),
          SizedBox(width: cardPadding * 0.85),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  color: actualTextColor,
                  fontSize: titleFont,
                ),
              ),
              SizedBox(height: cardPadding * 0.4),
              Text(
                subtitle,
                style: GoogleFonts.poppins(
                  fontSize: subtitleFont,
                  color: actualTextColor.withOpacity(0.85),
                ),
              ),
            ]),
          ),
          ElevatedButton(
            onPressed: onPressed ?? () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: buttonBg,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              padding: EdgeInsets.symmetric(
                horizontal: cardPadding * 0.85,
                vertical: cardPadding * 0.7,
              ),
              elevation: 0,
            ),
            child: Text(
              buttonLabel,
              style: GoogleFonts.poppins(
                color: buttonTextColor,
                fontWeight: FontWeight.w600,
                fontSize: buttonFont,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _statCard(String title, String value, IconData icon) {
    final cardPadding = Responsive.getSpacing(context, mobile: 14, tablet: 18, desktop: 22);
    final iconSize = Responsive.getIconSize(context, mobile: 24, tablet: 28, desktop: 32);
    final valueFont = Responsive.getFontSize(context, mobile: 16, tablet: 20, desktop: 24);
    final titleFont = Responsive.getFontSize(context, mobile: 12, tablet: 13, desktop: 14);
    
    return Container(
      padding: EdgeInsets.all(cardPadding),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFECECEC)),
      ),
      child: Column(
        children: [
          Icon(icon, color: const Color(0xFF6A1B9A), size: iconSize),
          SizedBox(height: cardPadding * 0.6),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w700,
              fontSize: valueFont,
            ),
          ),
          SizedBox(height: cardPadding * 0.4),
          Text(
            title,
            style: GoogleFonts.poppins(
              color: Colors.black54,
              fontSize: titleFont,
            ),
          ),
        ],
      ),
    );
  }
}

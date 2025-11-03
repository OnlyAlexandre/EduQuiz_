import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final w = constraints.maxWidth;
        final h = constraints.maxHeight;
        final isTablet = w > 600;

        // paddings adaptativos
        final horizontal = isTablet ? w * 0.13 : 18.0;
        final blockPadding = isTablet ? w * 0.03 : 10.0;
        final vertPad = isTablet ? 32.0 : 18.0;
        final fontScale = isTablet ? 1.22 : 1.0;

        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Stack(
              children: [
                SingleChildScrollView(
                  padding: EdgeInsets.only(left: 0, right: 0, top: 0, bottom: isTablet ? 44 : 24),
                  child: Column(
                    children: [
                      // Header + Olá
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: horizontal, vertical: vertPad / 2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'EDUQUIZ',
                              style: GoogleFonts.poppins(
                                color: Color(0xFF4B2676),
                                fontWeight: FontWeight.w800,
                                fontSize: 20 * fontScale,
                                letterSpacing: 1.2,
                              ),
                            ),
                            Row(
                              children: [
                                Icon(Icons.notifications_none_rounded, color: Color(0xFF4B2676), size: 24 * fontScale),
                                SizedBox(width: 14 * fontScale),
                                Icon(Icons.settings_outlined, color: Color(0xFF4B2676), size: 24 * fontScale),
                                SizedBox(width: 14 * fontScale),
                                CircleAvatar(
                                  radius: isTablet ? 25 : 18,
                                  backgroundColor: Color(0xFFF0EBF8),
                                  child: Icon(Icons.person_outline, color: Color(0xFF4B2676), size: 23 * fontScale),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: vertPad/3),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: horizontal),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Olá, João! 👋", style: GoogleFonts.poppins(fontSize: 16 * fontScale, fontWeight: FontWeight.w600, color: Color(0xFF433B4A))),
                            SizedBox(height: 3),
                            Text("Pronto para mais uma sessão de estudos?", style: GoogleFonts.poppins(fontSize: 13 * fontScale, color: Color(0xFFA498B5))),
                          ],
                        ),
                      ),
                      SizedBox(height: isTablet ? 20 : 14),
                      // Cards superiores em Row/tablet grid
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: horizontal),
                        child: isTablet
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(child: _InfoCard(fontScale: fontScale, color: Color(0xFFFDC250), value: '0%', label: 'dias consecutivos', icon: Icons.calendar_today_outlined)),
                                  SizedBox(width: blockPadding),
                                  Expanded(child: _InfoCard(fontScale: fontScale, color: Color(0xFF51B5A6), value: '7', label: 'dias consecutivos', icon: Icons.calendar_today_outlined)),
                                  SizedBox(width: blockPadding),
                                  Expanded(child: _InfoCard(fontScale: fontScale, color: Color(0xFF6EBF69), value: '80%', label: 'do curso', icon: Icons.school_outlined)),
                                ],
                              )
                            : Row(
                                children: [
                                  Expanded(child: _InfoCard(fontScale: fontScale, color: Color(0xFFFDC250), value: '0%', label: 'dias consecutivos', icon: Icons.calendar_today_outlined)),
                                  SizedBox(width: 10),
                                  Expanded(child: _InfoCard(fontScale: fontScale, color: Color(0xFF51B5A6), value: '7', label: 'dias consecutivos', icon: Icons.calendar_today_outlined)),
                                  SizedBox(width: 10),
                                  Expanded(child: _InfoCard(fontScale: fontScale, color: Color(0xFF6EBF69), value: '80%', label: 'do curso', icon: Icons.school_outlined)),
                                ],
                              ),
                      ),
                      SizedBox(height: isTablet ? 30 : 18),
                      // Mapa de Aprendizado
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: horizontal),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Mapa de aprendizado',
                                  style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 15 * fontScale, color: Color(0xFF433B4A)),
                                ),
                                Text('Matemática · ENEM', style: GoogleFonts.poppins(fontSize: 12 * fontScale, color: Color(0xFFA498B5))),
                              ],
                            ),
                            TextButton(
                              onPressed: () {},
                              child: Text('Ver mapa completo', style: GoogleFonts.poppins(fontSize: 12 * fontScale, color: Color(0xFF4B2676), fontWeight: FontWeight.bold)),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: isTablet ? 14 : 10),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: horizontal),
                        child: _LearningPathBlock(fontScale: fontScale, isTablet: isTablet),
                      ),
                      SizedBox(height: isTablet ? 16 : 8),
                      // Ações rápidas e estatísticas - grid no tablet
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: horizontal),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: vertPad),
                            Text('Ações rápidas', style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 15 * fontScale, color: Color(0xFF433B4A))),
                            SizedBox(height: 10),
                            _QuickActionsBlock(fontScale: fontScale, isTablet: isTablet),
                            SizedBox(height: isTablet ? 30 : 22),
                            Text('Estatísticas de hoje', style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 15 * fontScale, color: Color(0xFF433B4A))),
                            SizedBox(height: 10),
                            _StatsBlock(fontScale: fontScale, isTablet: isTablet),
                          ],
                        ),
                      ),
                      SizedBox(height: isTablet ? 54 : 0),
                    ],
                  ),
                ),
                if (!isTablet)
                  Positioned(left: 0, top: h * 0.24, child: _SideNavigation(fontScale: fontScale)),
                Positioned(left: 0, right: 0, bottom: 0, child: _BottomBar(fontScale: fontScale, isTablet: isTablet)),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _InfoCard extends StatelessWidget {
  final Color color;
  final String value;
  final String label;
  final IconData icon;
  final double fontScale;
  const _InfoCard({required this.color, required this.value, required this.label, required this.icon, required this.fontScale});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 68 * fontScale,
      padding: EdgeInsets.all(13 * fontScale),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10 * fontScale),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.white, size: 15 * fontScale),
              SizedBox(width: 6 * fontScale),
              Text(value, style: GoogleFonts.poppins(color: Colors.white, fontSize: 17 * fontScale, fontWeight: FontWeight.w700)),
            ],
          ),
          SizedBox(height: 6 * fontScale),
          Text(label, style: GoogleFonts.poppins(color: Colors.white.withOpacity(0.9), fontSize: 11 * fontScale, fontWeight: FontWeight.w400)),
        ],
      ),
    );
  }
}

class _LearningPathBlock extends StatelessWidget {
  final double fontScale;
  final bool isTablet;
  const _LearningPathBlock({required this.fontScale, required this.isTablet});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFF3F2F7),
        borderRadius: BorderRadius.circular(15 * fontScale),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _LearningItem(title: 'Habilidade', subtitle: '3/7 módulos', status: 'EM ANDAMENTO', fontScale: fontScale),
          Divider(indent: 22 * fontScale, endIndent: 22 * fontScale, color: Color(0xFFE2DEEB), thickness: 1),
          _LearningItem(title: 'Matemática', subtitle: '5/9 módulos', status: 'CONCLUÍDO', labelColor: Color(0xFF6EBF69), fontScale: fontScale),
          Divider(indent: 22 * fontScale, endIndent: 22 * fontScale, color: Color(0xFFE2DEEB), thickness: 1),
          _LearningItem(title: 'História', subtitle: '1/5 módulos', status: 'NÃO INICIADO', labelColor: Color(0xFFFDC250), fontScale: fontScale),
        ],
      ),
    );
  }
}

class _LearningItem extends StatelessWidget {
  final String title, subtitle, status;
  final Color? labelColor;
  final double fontScale;
  const _LearningItem({required this.title, required this.subtitle, required this.status, this.labelColor, required this.fontScale});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 8 * fontScale),
      minLeadingWidth: 30 * fontScale,
      title: Text(title, style: GoogleFonts.poppins(fontWeight: FontWeight.w600, color: Color(0xFF433B4A), fontSize: 14 * fontScale)),
      subtitle: Text(subtitle, style: GoogleFonts.poppins(fontSize: 11 * fontScale, color: Color(0xFFA498B5))),
      trailing: Container(
        padding: EdgeInsets.symmetric(horizontal: 13 * fontScale, vertical: 5 * fontScale),
        decoration: BoxDecoration(
          color: (labelColor ?? Color(0xFFB2B2B2)).withOpacity(0.12),
          borderRadius: BorderRadius.circular(11 * fontScale),
        ),
        child: Text(
          status,
          style: GoogleFonts.poppins(color: labelColor ?? Color(0xFFB2B2B2), fontWeight: FontWeight.bold, fontSize: 10 * fontScale),
        ),
      ),
    );
  }
}

class _QuickActionsBlock extends StatelessWidget {
  final double fontScale;
  final bool isTablet;
  const _QuickActionsBlock({required this.fontScale, required this.isTablet});
  @override
  Widget build(BuildContext context) {
    return isTablet
      ? Row(children: [
          Expanded(child: _QuickActionCard("Rodada Rápida", "5 questões • 5 min", "INICIAR", Color(0xFF4B2676), Colors.white, fontScale)),
          SizedBox(width: 16 * fontScale),
          Expanded(child: _QuickActionCard("Banco de Questões", "Escolha suas questões", "EXPLORAR", Color(0xFFDED6F6), Color(0xFF4B2676), fontScale)),
          SizedBox(width: 16 * fontScale),
          Expanded(child: _QuickActionCard("Trilha de matemática", "Veja questões em matemática", "FAZER", Color(0xFFFDC250), Color(0xFF4B2676), fontScale)),
        ])
      : Column(
          children: [
            Row(
              children: [
                Expanded(child: _QuickActionCard("Rodada Rápida", "5 questões • 5 min", "INICIAR", Color(0xFF4B2676), Colors.white, fontScale)),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(child: _QuickActionCard("Banco de Questões", "Escolha suas questões", "EXPLORAR", Color(0xFFDED6F6), Color(0xFF4B2676), fontScale)),
                SizedBox(width: 10),
                Expanded(child: _QuickActionCard("Trilha de matemática", "Veja questões em matemática", "FAZER", Color(0xFFFDC250), Color(0xFF4B2676), fontScale)),
              ],
            ),
          ],
        );
  }
}

class _QuickActionCard extends StatelessWidget {
  final String title, subtitle, action;
  final Color bgColor, textColor;
  final double fontScale;
  const _QuickActionCard(this.title, this.subtitle, this.action, this.bgColor, this.textColor, this.fontScale);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15 * fontScale, horizontal: 13 * fontScale),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(13 * fontScale),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.play_circle_fill_rounded, color: textColor, size: 29 * fontScale),
          SizedBox(width: 12 * fontScale),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 14 * fontScale, color: textColor)),
                SizedBox(height: 2),
                Text(subtitle, style: GoogleFonts.poppins(fontSize: 11 * fontScale, color: textColor.withOpacity(0.7))),
              ],
            ),
          ),
          SizedBox(width: 6 * fontScale),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 13 * fontScale, vertical: 6 * fontScale),
            decoration: BoxDecoration(
              color: textColor == Colors.white ? Color(0xFF51B5A6) : Colors.white,
              borderRadius: BorderRadius.circular(9 * fontScale),
            ),
            child: Text(action, style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 11 * fontScale, color: textColor == Colors.white ? Colors.white : textColor)),
          ),
        ],
      ),
    );
  }
}

class _StatsBlock extends StatelessWidget {
  final double fontScale;
  final bool isTablet;
  const _StatsBlock({required this.fontScale, required this.isTablet});
  @override
  Widget build(BuildContext context) {
    return isTablet
      ? Row(
          children: [
            Expanded(child: _StatsCard(icon: Icons.article_outlined, title: 'Questões', value: '24', fontScale: fontScale)),
            SizedBox(width: 18 * fontScale),
            Expanded(child: _StatsCard(icon: Icons.timer, title: 'Tempo', value: '24m', fontScale: fontScale)),
            SizedBox(width: 18 * fontScale),
            Expanded(child: _StatsCard(icon: Icons.notes, title: 'Apontes', value: '10', fontScale: fontScale)),
            SizedBox(width: 18 * fontScale),
            Expanded(child: _StatsCard(icon: Icons.timeline_sharp, title: 'Sequência', value: 'Tribo', fontScale: fontScale)),
          ],
        )
      : Row(
          children: [
            Expanded(child: _StatsCard(icon: Icons.article_outlined, title: 'Questões', value: '24', fontScale: fontScale)),
            SizedBox(width: 8),
            Expanded(child: _StatsCard(icon: Icons.timer, title: 'Tempo', value: '24m', fontScale: fontScale)),
            SizedBox(width: 8),
            Expanded(child: _StatsCard(icon: Icons.notes, title: 'Apontes', value: '10', fontScale: fontScale)),
            SizedBox(width: 8),
            Expanded(child: _StatsCard(icon: Icons.timeline_sharp, title: 'Sequência', value: 'Tribo', fontScale: fontScale)),
          ],
        );
  }
}

class _StatsCard extends StatelessWidget {
  final IconData icon;
  final String title, value;
  final double fontScale;
  const _StatsCard({required this.icon, required this.title, required this.value, required this.fontScale});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 13 * fontScale, horizontal: 6 * fontScale),
      decoration: BoxDecoration(
        color: Color(0xFFF3F2F7),
        borderRadius: BorderRadius.circular(13 * fontScale),
      ),
      child: Column(
        children: [
          Icon(icon, color: Color(0xFFB2A2BF), size: 22 * fontScale),
          Text(value, style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 14 * fontScale, color: Color(0xFF4B2676))),
          SizedBox(height: 3),
          Text(title, style: GoogleFonts.poppins(fontSize: 11 * fontScale, color: Color(0xFFA498B5))),
        ],
      ),
    );
  }
}

class _SideNavigation extends StatelessWidget {
  final double fontScale;
  const _SideNavigation({required this.fontScale});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _SideNavCircle(icon: Icons.play_arrow_rounded, active: true, fontScale: fontScale),
        _SideNavCircle(icon: Icons.menu_book_rounded, fontScale: fontScale),
        _SideNavCircle(icon: Icons.note_alt, fontScale: fontScale),
        _SideNavCircle(icon: Icons.insert_chart_outlined, fontScale: fontScale),
        _SideNavCircle(icon: Icons.settings, fontScale: fontScale),
      ],
    );
  }
}
class _SideNavCircle extends StatelessWidget {
  final IconData icon;
  final bool active;
  final double fontScale;
  const _SideNavCircle({required this.icon, this.active=false, required this.fontScale});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 7 * fontScale),
      child: CircleAvatar(
        backgroundColor: active ? Color(0xFF4B2676) : Color(0xFFF3F2F7),
        radius: 21 * fontScale,
        child: Icon(icon, color: active ? Colors.white : Color(0xFFB2A2BF), size: 20 * fontScale),
      ),
    );
  }
}
class _BottomBar extends StatelessWidget {
  final double fontScale;
  final bool isTablet;
  const _BottomBar({required this.fontScale, required this.isTablet});
  @override
  Widget build(BuildContext context) {
    final padding = isTablet ? EdgeInsets.symmetric(horizontal: 40 * fontScale, vertical: 11 * fontScale) : EdgeInsets.symmetric(horizontal: 12, vertical: 6);
    return Container(
      margin: EdgeInsets.only(left: isTablet ? 45 * fontScale : 22, right: isTablet ? 45 * fontScale : 22, bottom: 8 * fontScale),
      padding: padding,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(isTablet ? 27 * fontScale : 17),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 18 * fontScale, offset: Offset(0, 4)),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Icon(Icons.home_filled, color: Color(0xFF4B2676), size: 29 * fontScale),
          Icon(Icons.bolt, color: Color(0xFFD1C1EC), size: 26 * fontScale),
          Icon(Icons.pie_chart_rounded, color: Color(0xFFD1C1EC), size: 26 * fontScale),
          Icon(Icons.forum_outlined, color: Color(0xFFD1C1EC), size: 26 * fontScale),
        ],
      ),
    );
  }
}

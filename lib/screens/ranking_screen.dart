import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/responsive.dart';

const Color primary = Color(0xFF6A1B9A);
const Color gold = Color(0xFFF4B400);
const Color bg = Color(0xFFF6F7F9);

class RankingScreen extends StatefulWidget {
  const RankingScreen({super.key});

  @override
  State<RankingScreen> createState() => _RankingScreenState();
}

class _RankingScreenState extends State<RankingScreen> {
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    final hPad = Responsive.getHorizontalPadding(context);
    final vPad = Responsive.getVerticalPadding(context);
    final titleFont = Responsive.getFontSize(context, mobile: 20, tablet: 24, desktop: 28);
    
    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
            size: Responsive.getIconSize(context, mobile: 20, tablet: 22, desktop: 24),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Ranking',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            color: Colors.black,
            fontSize: titleFont,
          ),
        ),
      ),

      body: LayoutBuilder(
        builder: (context, constraints) {
          final maxWidth = Responsive.getMaxContentWidth(context);
          return Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: maxWidth),
              child: SingleChildScrollView(
                padding: EdgeInsets.all(hPad),
        child: Column(
          children: [
            _tabs(),
            const SizedBox(height: 14),
            _userPosition(),
            const SizedBox(height: 18),
            _top3(),
            const SizedBox(height: 18),
            _rankingList(),
          ],
                ),
              ),
            ),
          );
        },
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: primary,
        onPressed: () {
          Navigator.pushReplacementNamed(context, '/home');
        },
        child: const Icon(Icons.home, color: Colors.white),
      ),

      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/home');
                },
                icon: const Icon(Icons.home_outlined, color: Colors.grey),
              ),
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/mapa-aprendizado');
                },
                icon: const Icon(Icons.flash_on_outlined, color: Colors.grey),
              ),
              const SizedBox(width: 40),
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/perfil');
                },
                icon: const Icon(Icons.person_outline, color: Colors.grey),
              ),
              IconButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/ranking');
                },
                icon: const Icon(Icons.emoji_events_outlined, color: primary),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ---------- TABS ----------
  Widget _tabs() {
    final tabs = ['Enem', 'FUVEST', 'UNICAMP', 'UERJ'];
    final tabHeight = Responsive.getSpacing(context, mobile: 38, tablet: 42, desktop: 46);
    final tabFont = Responsive.getFontSize(context, mobile: 12, tablet: 13, desktop: 14);

    return SizedBox(
      height: tabHeight,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, i) => GestureDetector(
          onTap: () {
            setState(() {
              _selectedTab = i;
            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: _selectedTab == i ? primary : Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: primary),
            ),
            child: Text(
              tabs[i],
              style: GoogleFonts.poppins(
                fontSize: tabFont,
                fontWeight: FontWeight.w500,
                color: _selectedTab == i ? Colors.white : primary,
              ),
            ),
          ),
        ),
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemCount: tabs.length,
      ),
    );
  }

  // ---------- SUA POSIÇÃO ----------
  Widget _userPosition() {
    final cardPadding = Responsive.getSpacing(context, mobile: 14, tablet: 18, desktop: 22);
    final avatarRadius = Responsive.getIconSize(context, mobile: 24, tablet: 28, desktop: 32);
    final titleFont = Responsive.getFontSize(context, mobile: 14, tablet: 16, desktop: 18);
    final positionFont = Responsive.getFontSize(context, mobile: 20, tablet: 24, desktop: 28);
    final statFont = Responsive.getFontSize(context, mobile: 12, tablet: 13, desktop: 14);
    final statLabelFont = Responsive.getFontSize(context, mobile: 10, tablet: 11, desktop: 12);
    
    return Container(
      padding: EdgeInsets.all(cardPadding),
      decoration: BoxDecoration(
        color: primary,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: avatarRadius,
            backgroundColor: Colors.white,
            child: Icon(Icons.person, color: primary, size: avatarRadius),
          ),
          SizedBox(width: cardPadding * 0.85),
          Expanded(
            child: Text(
              'Sua posição\n#45',
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: titleFont,
              ),
            ),
          ),
          _stat('Pontos', '2.450'),
          _stat('Preciso', '820'),
          _stat('Tempo', '3h'),
        ],
      ),
    );
  }

  Widget _stat(String t, String v) {
    final statFont = Responsive.getFontSize(context, mobile: 12, tablet: 13, desktop: 14);
    final statLabelFont = Responsive.getFontSize(context, mobile: 10, tablet: 11, desktop: 12);
    final spacing = Responsive.getSpacing(context, mobile: 6, tablet: 8, desktop: 10);
    
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: spacing),
      child: Column(
        children: [
          Text(
            v,
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: statFont,
            ),
          ),
          Text(
            t,
            style: GoogleFonts.poppins(
              color: Colors.white70,
              fontSize: statLabelFont,
            ),
          ),
        ],
      ),
    );
  }

  // ---------- TOP 3 ----------
  Widget _top3() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '🏆 TOP 3 Campeões',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(child: _podium('2º Lugar', 'Lucas Oliveira', 'LO', '3.200')),
            const SizedBox(width: 8),
            Expanded(child: _firstPlace()),
            const SizedBox(width: 8),
            Expanded(child: _podium('3º Lugar', 'Carla Araujo', 'CA', '3.100')),
          ],
        ),
      ],
    );
  }

  Widget _firstPlace() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: gold, width: 1.5),
        borderRadius: BorderRadius.circular(14),
        color: Colors.white,
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: gold.withOpacity(0.2),
            child: Text(
              'CH',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                color: gold,
              ),
            ),
          ),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 4),
            width: double.infinity,
            decoration: BoxDecoration(
              color: gold,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              '1º Lugar',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 11,
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Carol Horta',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            '4.850 pts',
            style: GoogleFonts.poppins(
              fontSize: 11,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }

  Widget _podium(String pos, String name, String initials, String points) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(14),
        color: Colors.white,
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: Colors.grey.shade200,
            child: Text(
              initials,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 4),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              pos,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 11,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            name,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w500,
              fontSize: 12,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 2),
          Text(
            '$points pts',
            style: GoogleFonts.poppins(
              fontSize: 11,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }

  // ---------- LISTA ----------
  Widget _rankingList() {
    final names = [
      'Karina Silva',
      'Italo Ribeiro',
      'Lucas Araújo',
      'Amanda Costa',
      'Amorim',
      'Davi Dourado',
      'Pedro Santos',
      'Julia Lima',
      'Rafael Costa',
      'Mariana Silva',
    ];

    return Column(
      children: List.generate(10, (i) {
        return Container(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Text(
                '#${i + 4}',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              const SizedBox(width: 10),
              CircleAvatar(
                radius: 14,
                backgroundColor: primary.withOpacity(0.1),
                child: Text(
                  names[i].split(' ').map((n) => n[0]).take(2).join(),
                  style: GoogleFonts.poppins(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: primary,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  names[i],
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Text(
                '${4200 - i * 120} pts',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

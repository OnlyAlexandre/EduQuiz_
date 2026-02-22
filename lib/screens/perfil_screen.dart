// lib/screens/perfil_screen.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meu_app/services/user_state.dart';
import 'package:meu_app/services/user_service.dart';
import 'package:meu_app/services/user_state.dart';

// Cores definidas como constantes no escopo do arquivo
// Cores definidas como constantes no escopo do arquivo
const Color _primaryColor = Color(0xFF6A1B9A);
const Color _accentColor = Color(0xFFFFB300);
const Color _bgColor = Color(0xFFF8F9FA);

class PerfilScreen extends StatelessWidget {
  const PerfilScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
  final user = UserState.currentUser;
    return Scaffold(
      backgroundColor: _bgColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Perfil',
          style: GoogleFonts.poppins(
            color: Colors.black87,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          children: [
            // Card principal com foto e nome
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(13), // ~0.05 de opacidade
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 36,
                        backgroundImage: user!.photoURL != null ? NetworkImage(user.photoURL!) : null,
                        backgroundColor: _primaryColor.withOpacity(0.1),
                        child: user.photoURL == null
                            ? Icon(Icons.person, size: 36, color: _primaryColor)
                            : null,
                      ),
                      const SizedBox(width: 16),

                      
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(user?.name ?? 'Nome não disponível',
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                )),
                            Text(
                              user?.email ?? 'E-mail não disponível',
                              style: GoogleFonts.poppins(
                                  color: Colors.black54, fontSize: 13),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Ingressou em setembro de 2025',
                              style: GoogleFonts.poppins(
                                  color: Colors.black45, fontSize: 11),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),

                  // Linha com Rank e Pontos
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _tag('Rank #55', _primaryColor.withOpacity(0.1), _primaryColor),
                      const SizedBox(width: 10),
                      _tag('2503 pts', _accentColor.withOpacity(0.15), _accentColor),
                    ],
                  ),
                  const SizedBox(height: 18),

                  // Seguidores / Seguindo
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _followStat(Icons.people_alt_outlined, 'Seguidores', user?.totalSeguidores.toString() ?? '0'),
                      _followStat(Icons.person_add_alt_1_outlined, 'Seguindo', user?.totalSeguindo.toString() ?? '0'),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Métricas de desempenho
            Row(
              children: [
                Expanded(child: _metricCard('1,415', 'Questões resolvidas', Icons.edit_note)),
                const SizedBox(width: 10),
                Expanded(child: _metricCard('7', 'Dias consecutivos', Icons.calendar_today)),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(child: _metricCard('20', 'Conquistas', Icons.emoji_events_outlined)),
                const SizedBox(width: 10),
                Expanded(child: _metricCard('80%', 'Taxa de acertos', Icons.bar_chart)),
              ],
            ),

            const SizedBox(height: 22),

            // Conquistas recentes
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(10), // ~0.04 de opacidade
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.emoji_events_outlined, color: _primaryColor),
                      const SizedBox(width: 8),
                      Text(
                        'Conquistas recentes',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  _achievementTile(
                      'Desbloqueie uma sequência', 'Hoje', Icons.local_fire_department_outlined, Colors.orange),
                  const SizedBox(height: 6),
                  _achievementTile(
                      'Resolva 15 questões', 'Ontem', Icons.star_border, Colors.amber),

                  const SizedBox(height: 10),

                  Center(
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/conquistas');
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: _primaryColor,
                        backgroundColor: _primaryColor.withAlpha((0.1 * 255).round()),
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      child: Text(
                        'Ver todas as conquistas',
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600, fontSize: 13),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Seção de Amigos
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(10),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.people_outline, color: _primaryColor),
                      const SizedBox(width: 8),
                      Text(
                        'Amigos',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'Ver todos',
                          style: GoogleFonts.poppins(
                            color: _primaryColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 70,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 8,
                      itemBuilder: (context, index) {
                        final nomes = ['Ana', 'Pedro', 'Maria', 'João', 'Julia', 'Lucas', 'Carla', 'Rafael'];
                        return Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: Column(
                            children: [
                              CircleAvatar(
                                radius: 24,
                                backgroundColor: _primaryColor.withOpacity(0.1),
                                child: Text(
                                  nomes[index][0],
                                  style: GoogleFonts.poppins(
                                    color: _primaryColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                nomes[index],
                                style: GoogleFonts.poppins(
                                  fontSize: 11,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 80),
          ],
        ),
      ),

      // Botão flutuante roxo (central igual ao home)
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: _primaryColor,
        onPressed: () {},
        child: const Icon(Icons.flag, size: 28, color: Colors.white),
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
                onPressed: () {},
                icon: const Icon(Icons.home, color: Color(0xFF6A1B9A)),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.flash_on_outlined, color: Colors.grey[600]),
              ),
              const SizedBox(width: 48),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.person_outline, color: Colors.grey[600]),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.star_outline, color: Colors.grey[600]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ---- COMPONENTES AUXILIARES ----
  Widget _buildProfileHeader() {
         final user = UserState.currentUser;
    return Column(
      children: [
        const CircleAvatar(
          radius: 50,
          backgroundColor: Color(0xFFF0E6F6),
          child: Icon(Icons.person, size: 50, color: Color(0xFF6A1B9A)),
        ),
        const SizedBox(height: 16),
        Text(
          ' ${user?.name}',
          style: GoogleFonts.poppins(
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 4),
        Text( 
          '${user?.email}',
          style: GoogleFonts.poppins(
            color: Colors.grey[600],
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            // Navegar para edição de perfil
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF6A1B9A),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
          child: Text(
            'Editar Perfil',
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _tag(String text, Color bg, Color textColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: GoogleFonts.poppins(
            color: textColor, fontWeight: FontWeight.w600, fontSize: 12),
      ),
    );
  }

  Widget _followStat(IconData icon, String label, String value) {
    return Column(
      children: [
        Icon(icon, color: _primaryColor),
        const SizedBox(height: 4),
        Text(
          value,
          style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600, fontSize: 16, color: Colors.black87),
        ),
        Text(
          label,
          style: GoogleFonts.poppins(color: Colors.black54, fontSize: 12),
        ),
      ],
    );
  }

  Widget _metricCard(String value, String label, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          Icon(icon, color: Color(0xFF6A1B9A)),
          const SizedBox(height: 6),
          Text(value,
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w700, fontSize: 16)),
          Text(label,
              style:
                  GoogleFonts.poppins(color: Colors.black54, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _achievementTile(
      String title, String subtitle, IconData icon, Color iconColor) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        backgroundColor: iconColor.withOpacity(0.15),
        child: Icon(icon, color: iconColor),
      ),
      title: Text(title,
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 14)),
      subtitle: Text(subtitle,
          style: GoogleFonts.poppins(color: Colors.black54, fontSize: 12)),
      trailing: const Icon(Icons.chevron_right, color: Colors.black38),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      tileColor: Colors.white,
    );
  }
}

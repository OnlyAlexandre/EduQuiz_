import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AcessibilidadeScreen extends StatefulWidget {
  const AcessibilidadeScreen({super.key});

  @override
  State<AcessibilidadeScreen> createState() => _AcessibilidadeScreenState();
}

class _AcessibilidadeScreenState extends State<AcessibilidadeScreen> {
  String _tamanhoTexto = 'Médio';
  String _tamanhoTela = 'Padrão';

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFF6A1B9A);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Acessibilidade',
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
        children: [
          // Geral
          _buildSectionCard(
            icon: Icons.settings,
            title: 'Geral',
            children: [
              _buildToggleItem('Ativar recursos de acessibilidade', true),
            ],
          ),
          const SizedBox(height: 12),

          // Cognitivo
          _buildSectionCard(
            icon: Icons.psychology,
            title: 'Cognitivo',
            children: [
              _buildToggleItem('Modo de leitura simplificada', false),
              _buildToggleItem('Dicas visuais', true),
            ],
          ),
          const SizedBox(height: 12),

          // Voice over
          _buildSectionCard(
            icon: Icons.record_voice_over,
            title: 'Voice over',
            children: [
              _buildToggleItem('Narração de tela', false),
              _buildToggleItem('Descrição de imagens', false),
            ],
          ),
          const SizedBox(height: 12),

          // Tamanho do texto e tela
          _buildSectionCard(
            icon: Icons.text_fields,
            title: 'Tamanho do texto e tela',
            children: [
              _buildDropdownItem(
                'Tamanho do texto',
                _tamanhoTexto,
                ['Pequeno', 'Médio', 'Grande', 'Muito Grande'],
                (value) => setState(() => _tamanhoTexto = value!),
              ),
              _buildDropdownItem(
                'Tamanho da tela',
                _tamanhoTela,
                ['Pequeno', 'Padrão', 'Grande'],
                (value) => setState(() => _tamanhoTela = value!),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Toque
          _buildSectionCard(
            icon: Icons.touch_app,
            title: 'Toque',
            children: [
              _buildToggleItem('Áreas de toque ampliadas', false),
              _buildToggleItem('Feedback háptico', true),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSectionCard({
    required IconData icon,
    required String title,
    required List<Widget> children,
  }) {
    const Color primaryColor = Color(0xFF6A1B9A);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: primaryColor),
              const SizedBox(width: 8),
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...children,
        ],
      ),
    );
  }

  Widget _buildToggleItem(String title, bool value) {
    const Color primaryColor = Color(0xFF6A1B9A);

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 14,
              ),
            ),
          ),
          Switch(
            value: value,
            activeColor: primaryColor,
            onChanged: (newValue) {
              // Implementar toggle
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownItem(
    String title,
    String value,
    List<String> items,
    Function(String?) onChanged,
  ) {
    const Color primaryColor = Color(0xFF6A1B9A);

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            value: value,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey[50],
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xFFDADADA)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xFFDADADA)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: primaryColor, width: 2),
              ),
            ),
            items: items.map((item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(item, style: GoogleFonts.poppins()),
              );
            }).toList(),
            onChanged: onChanged,
            style: GoogleFonts.poppins(color: Colors.black87),
          ),
        ],
      ),
    );
  }
}


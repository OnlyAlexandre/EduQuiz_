import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool push = false;
  bool email = false;
  bool seguidores = false;
  bool curtidas = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF6F6F6),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Configurações",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            //---------------------------------------
            // SEÇÃO CONTA
            //---------------------------------------
            _sectionTitle("Conta"),
            _settingsCard([
              _settingsTile(Icons.person_outline, "Editar perfil", () {
                Navigator.pushNamed(context, '/editar-perfil');
              }),
              _settingsTile(Icons.lock_outline, "Segurança da conta", () {
                Navigator.pushNamed(context, '/seguranca-conta');
              }),
              _settingsTile(Icons.brush_outlined, "Preferências e Personalização", () {
                Navigator.pushNamed(context, '/preferencias');
              }),
            ]),

            const SizedBox(height: 20),

            //---------------------------------------
            // ASSINATURA
            //---------------------------------------
            _sectionTitle("Assinatura"),
            _settingsCard([
              _settingsTile(Icons.star_border, "Alterar o seu plano", () {
                Navigator.pushNamed(context, '/assinatura');
              }),
            ]),

            const SizedBox(height: 20),

            //---------------------------------------
            // ACESSIBILIDADE
            //---------------------------------------
            _sectionTitle("Acessibilidade"),
            _settingsCard([
              _settingsTile(Icons.accessibility_new_outlined, "Acessibilidade", () {
                Navigator.pushNamed(context, '/acessibilidade');
              }),
            ]),

            const SizedBox(height: 20),

            //---------------------------------------
            // NOTIFICAÇÕES
            //---------------------------------------
            _sectionTitle("Configurações de notificações"),
            _toggleCard(),

            const SizedBox(height: 20),

            //---------------------------------------
            // SUPORTE
            //---------------------------------------
            _sectionTitle("Suporte"),
            _settingsCard([
              _settingsTile(Icons.help_outline, "Central de ajuda", () {}),
            ]),

            const SizedBox(height: 30),

            //---------------------------------------
            // BOTÃO SAIR
            //---------------------------------------
            Center(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.redAccent),
                ),
                child: const Center(
                  child: Text(
                    "Sair",
                    style: TextStyle(
                      color: Colors.redAccent,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            //---------------------------------------
            // POLÍTICA DE PRIVACIDADE
            //---------------------------------------
            Center(
              child: Text(
                "Política de privacidade",
                style: TextStyle(
                  color: Colors.purple.shade700,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  //---------------------------------------
  // WIDGET – TÍTULO DE SESSÃO
  //---------------------------------------
  Widget _sectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.black87,
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
    );
  }

  //---------------------------------------
  // WIDGET – CARD GERAL
  //---------------------------------------
  Widget _settingsCard(List<Widget> tiles) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: tiles
            .map((tile) => Column(
                  children: [
                    tile,
                    if (tile != tiles.last) const Divider(height: 20),
                  ],
                ))
            .toList(),
      ),
    );
  }

  //---------------------------------------
  // ITEM PADRÃO
  //---------------------------------------
  Widget _settingsTile(IconData icon, String title, VoidCallback? onTap) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Icon(icon, color: Colors.purple, size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            ),
          ),
          const Icon(Icons.chevron_right, color: Colors.black38),
        ],
      ),
    );
  }

  //---------------------------------------
  // CARD DE TOGGLES
  //---------------------------------------
  Widget _toggleCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          _toggleItem(Icons.phone_iphone, "Notificação Push", push, (v) => setState(() => push = v)),
          const Divider(),
          _toggleItem(Icons.email_outlined, "Notificações por email", email, (v) => setState(() => email = v)),
          const Divider(),
          _toggleItem(Icons.person_add_alt, "Novos seguidores", seguidores, (v) => setState(() => seguidores = v)),
          const Divider(),
          _toggleItem(Icons.favorite_border, "Novas curtidas", curtidas, (v) => setState(() => curtidas = v)),
        ],
      ),
    );
  }

  //---------------------------------------
  // ITEM TOGGLE
  //---------------------------------------
  Widget _toggleItem(IconData icon, String title, bool value, Function(bool) onChange) {
    return Row(
      children: [
        Icon(icon, color: Colors.purple),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
          ),
        ),
        Switch(
          value: value,
          activeColor: Colors.purple,
          onChanged: onChange,
        ),
      ],
    );
  }
}

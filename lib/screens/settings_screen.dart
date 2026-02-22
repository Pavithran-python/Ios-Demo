import 'package:flutter/material.dart';
import '../theme/glass_theme.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlassTheme.iosSystemGrey6,
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 20),
          _buildSettingsGroup([
            _buildSettingsTile(Icons.person, 'New Account', Colors.blue),
            _buildSettingsTile(Icons.account_balance_wallet, 'Mailbox', Colors.orange),
          ]),
          const SizedBox(height: 20),
          _buildSettingsGroup([
            _buildSettingsTile(Icons.show_chart, 'Charts', Colors.green),
            _buildSettingsTile(Icons.newspaper, 'News', Colors.red),
            _buildSettingsTile(Icons.event_note, 'Journal', Colors.grey),
          ]),
          const SizedBox(height: 20),
          _buildSettingsGroup([
            _buildSettingsTile(Icons.info, 'About', Colors.blueGrey),
          ]),
        ],
      ),
    );
  }

  Widget _buildSettingsGroup(List<Widget> children) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border.symmetric(
          horizontal: BorderSide(color: Color(0xFFD1D1D6), width: 0.5),
        ),
      ),
      child: Column(children: children),
    );
  }

  Widget _buildSettingsTile(IconData icon, String title, Color iconColor) {
    return Column(
      children: [
        ListTile(
          leading: Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: iconColor,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Icon(icon, color: Colors.white, size: 20),
          ),
          title: Text(title),
          trailing: const Icon(Icons.chevron_right, color: Colors.grey),
        ),
        if (title != 'Journal' && title != 'About' && title != 'Mailbox')
          const Divider(height: 1, indent: 56),
      ],
    );
  }
}

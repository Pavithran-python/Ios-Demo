import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../widgets/glass_bottom_nav.dart';
import '../theme/glass_theme.dart';
import 'market_screen.dart';
import 'charts_screen.dart';
import 'trade_screen.dart';
import 'history_screen.dart';
import 'settings_screen.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const MarketScreen(),
    const ChartsScreen(),
    const TradeScreen(),
    const HistoryScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: GlassBottomNav(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../theme/glass_theme.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  int _historyIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
        actions: [
          IconButton(
            icon: const Icon(CupertinoIcons.calendar, color: GlassTheme.iosBlue),
            onPressed: () {},
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(40),
          child: Container(
            color: GlassTheme.iosSystemGrey6,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildSegment('Positions', index: 0),
                _buildSegment('Orders', index: 1),
                _buildSegment('Deals', index: 2),
              ],
            ),
          ),
        ),
      ),
      body: ListView.separated(
        itemCount: 15,
        separatorBuilder: (context, index) => const Divider(height: 1, indent: 16),
        itemBuilder: (context, index) {
          final isProfit = index % 2 == 0;
          return _buildHistoryTile(
            symbol: index % 3 == 0 ? 'EURUSD' : (index % 3 == 1 ? 'GBPUSD' : 'XAUUSD'),
            type: index % 2 == 0 ? 'buy' : 'sell',
            lots: 0.10,
            profit: isProfit ? 12.45 : -8.20,
            date: '2024.02.23 10:24',
          );
        },
      ),
    );
  }

  Widget _buildSegment(String label, {required int index}) {
    final bool isActive = _historyIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _historyIndex = index),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 6),
          decoration: BoxDecoration(
            color: isActive ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            boxShadow: isActive ? [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 4,
                offset: const Offset(0, 2),
              )
            ] : null,
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHistoryTile({
    required String symbol,
    required String type,
    required double lots,
    required double profit,
    required String date,
  }) {
    final isProfit = profit >= 0;
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                symbol,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(width: 8),
              Text(
                '$type $lots',
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
          Text(
            profit.toStringAsFixed(2),
            style: TextStyle(
              color: isProfit ? GlassTheme.iosBlue : GlassTheme.iosRed,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
      subtitle: Text(
        date,
        style: const TextStyle(fontSize: 12, color: Colors.grey),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../theme/glass_theme.dart';

class TradeScreen extends StatelessWidget {
  const TradeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trade'),
        actions: [
          IconButton(
            icon: const Icon(CupertinoIcons.plus_circle, color: GlassTheme.iosBlue),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Account Summary
          Container(
            color: GlassTheme.iosSystemGrey6.withValues(alpha: 0.5),
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _buildSummaryRow('Balance:', '10 120.45', isBold: true),
                const SizedBox(height: 4),
                _buildSummaryRow('Equity:', '10 145.20', isBold: true),
                const SizedBox(height: 4),
                _buildSummaryRow('Margin:', '150.00'),
                _buildSummaryRow('Free Margin:', '9 995.20'),
                _buildSummaryRow('Margin Level (%):', '6763.5'),
              ],
            ),
          ),
          
          // Positions Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color: GlassTheme.iosSystemGrey6,
            child: const Text(
              'Positions',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.grey),
            ),
          ),
          
          // Positions List
          Expanded(
            child: ListView.separated(
              itemCount: 3,
              separatorBuilder: (context, index) => const Divider(height: 1, indent: 16),
              itemBuilder: (context, index) {
                return _buildPositionTile(
                  symbol: index == 0 ? 'EURUSD' : (index == 1 ? 'GBPUSD' : 'XAUUSD'),
                  type: 'buy',
                  lots: index == 0 ? 0.10 : 0.05,
                  entryPrice: 1.08450,
                  currentPrice: 1.08472,
                  profit: index == 0 ? 22.00 : -5.40,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            color: isBold ? Colors.black : Colors.black54,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 13,
            color: Colors.black,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  Widget _buildPositionTile({
    required String symbol,
    required String type,
    required double lots,
    required double entryPrice,
    required double currentPrice,
    required double profit,
  }) {
    final isProfit = profit >= 0;
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      title: Row(
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
      subtitle: Text(
        '$entryPrice → $currentPrice',
        style: const TextStyle(fontSize: 13),
      ),
      trailing: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: isProfit ? GlassTheme.iosBlue : GlassTheme.iosRed,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          profit.toStringAsFixed(2),
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}

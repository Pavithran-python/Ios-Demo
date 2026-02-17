import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../widgets/glass_container.dart';
import '../widgets/glass_app_bar.dart';
import '../widgets/glass_bottom_sheet.dart';
import '../theme/glass_theme.dart';

class TradeScreen extends StatelessWidget {
  const TradeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlassAppBar(
        title: 'Trade',
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle_outline, color: GlassTheme.iosBlue),
            onPressed: () => _showNewOrder(context),
          ),
        ],
      ),
      body: Stack(
        children: [
          // Mock Chart Area
          Positioned.fill(
            child: _buildMockChart(),
          ),
          // Glass Overlay for Trade Info
          Positioned(
            top: 20,
            left: 20,
            right: 20,
            child: GlassContainer(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildStat('Balance', '\$12,450.00'),
                  _buildStat('Equity', '\$12,475.20'),
                  _buildStat('Margin', '\$450.00'),
                ],
              ),
            ).animate().slideY(begin: -0.2, end: 0).fadeIn(),
          ),
        ],
      ),
    );
  }

  Widget _buildMockChart() {
    return CustomPaint(
      painter: ChartPainter(),
    ).animate().fadeIn(duration: 800.ms);
  }

  Widget _buildStat(String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 10, color: Colors.black.withValues(alpha: 0.5)),
        ),
        Text(
          value,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black87),
        ),
      ],
    );
  }

  void _showNewOrder(BuildContext context) {
    GlassBottomSheet.show(
      context,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'New Market Order',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30),
          Row(
            children: [
              Expanded(
                child: _buildTradeButton('SELL', GlassTheme.iosRed),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildTradeButton('BUY', GlassTheme.iosGreen),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            'Lot Size: 1.00',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black.withValues(alpha: 0.7)),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildTradeButton(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.5)),
      ),
      child: Center(
        child: Text(
          label,
          style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
    );
  }
}

class ChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = GlassTheme.iosBlue.withValues(alpha: 0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final path = Path();
    path.moveTo(0, size.height * 0.7);
    
    for (double i = 0; i < size.width; i += 20) {
      path.lineTo(i, size.height * (0.4 + (i % 100) / 200));
    }

    canvas.drawPath(path, paint);

    // Add some random points
    final pointPaint = Paint()..color = GlassTheme.iosBlue;
    canvas.drawCircle(Offset(size.width * 0.5, size.height * 0.5), 4, pointPaint);
  }


  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

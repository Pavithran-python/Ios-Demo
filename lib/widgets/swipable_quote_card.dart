import 'package:flutter/material.dart';
import 'glass_container.dart';
import '../theme/glass_theme.dart';
import '../models/quote.dart';

class SwipableQuoteCard extends StatefulWidget {
  final Quote quote;
  final VoidCallback? onAdd;
  final VoidCallback? onChart;
  final VoidCallback? onDetail;

  const SwipableQuoteCard({
    super.key,
    required this.quote,
    this.onAdd,
    this.onChart,
    this.onDetail,
  });

  @override
  State<SwipableQuoteCard> createState() => _SwipableQuoteCardState();
}

class _SwipableQuoteCardState extends State<SwipableQuoteCard> {
  double _dragOffset = 0.0;
  static const double _maxDrag = 120.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Stack(
        children: [
          // Background Actions
          Positioned.fill(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _buildActionIcon(Icons.add, GlassTheme.iosBlue, widget.onAdd),
                _buildActionIcon(Icons.show_chart, Colors.orange, widget.onChart),
                _buildActionIcon(Icons.info_outline, Colors.grey, widget.onDetail),
              ],
            ),
          ),
          
          // Foreground Card
          GestureDetector(
            onHorizontalDragUpdate: (details) {
              setState(() {
                _dragOffset += details.primaryDelta!;
                _dragOffset = _dragOffset.clamp(-_maxDrag, 0.0); // Only swipe left
              });
            },
            onHorizontalDragEnd: (details) {
              setState(() {
                if (_dragOffset < -_maxDrag / 2) {
                  _dragOffset = -_maxDrag;
                } else {
                  _dragOffset = 0;
                }
              });
            },
            child: Transform.translate(
              offset: Offset(_dragOffset, 0),
              child: GlassContainer(
                padding: const EdgeInsets.all(16),
                border: Border.all(color: Colors.white, width: 2),
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withValues(alpha: 0.9),
                    Colors.white.withValues(alpha: 0.7),
                  ],
                ),

                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.quote.symbol,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          Text(
                            widget.quote.description,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                    _buildPriceColumn('Bid', widget.quote.bid, widget.quote.change >= 0),
                    const SizedBox(width: 20),
                    _buildPriceColumn('Ask', widget.quote.ask, widget.quote.change >= 0),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionIcon(IconData icon, Color color, VoidCallback? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        alignment: Alignment.center,
        child: Icon(icon, color: color, size: 24),
      ),
    );
  }

  Widget _buildPriceColumn(String label, double price, bool isUp) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 10, color: Colors.black45),
        ),
        Text(
          price.toStringAsFixed(price > 1000 ? 1 : 4),
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: isUp ? GlassTheme.iosGreen : GlassTheme.iosRed,
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import '../theme/glass_theme.dart';
import '../models/quote.dart';

class SwipableQuoteCard extends StatefulWidget {
  final Quote quote;
  final VoidCallback? onAdd;
  final VoidCallback? onChart;
  final VoidCallback? onTrade;

  const SwipableQuoteCard({
    super.key,
    required this.quote,
    this.onAdd,
    this.onChart,
    this.onTrade,
  });

  @override
  State<SwipableQuoteCard> createState() => _SwipableQuoteCardState();
}

class _SwipableQuoteCardState extends State<SwipableQuoteCard> {
  double _dragOffset = 0.0;
  static const double _maxDrag = 180.0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background Actions (Sliding buttons)
        Positioned.fill(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _buildCircularAction(Icons.add_circle, Colors.amber, widget.onTrade),
              _buildCircularAction(Icons.bar_chart, Colors.blue, widget.onChart),
              _buildCircularAction(Icons.info, GlassTheme.iosGrey, widget.onAdd),
            ],
          ),
        ),
        
        // Foreground Card
        GestureDetector(
          onHorizontalDragUpdate: (details) {
            setState(() {
              _dragOffset += details.primaryDelta!;
              _dragOffset = _dragOffset.clamp(-_maxDrag, 0.0);
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
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                border: Border(
                  bottom: BorderSide(color: GlassTheme.iosLightGrey, width: 0.5),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              child: IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Symbol and Time
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                widget.quote.symbol,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  letterSpacing: -0.5,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                '${widget.quote.change > 0 ? '+' : ''}${widget.quote.change}%',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: widget.quote.change >= 0 ? GlassTheme.iosBlue : GlassTheme.iosRed,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 1),
                          Text(
                            '14:25:31',
                            style: TextStyle(
                              fontSize: 11,
                              color: GlassTheme.iosGrey,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    // Spread
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Spread: 2',
                            style: TextStyle(
                              fontSize: 10,
                              color: GlassTheme.iosGrey,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    // Bid and Ask
                    _buildPriceBlock(widget.quote.bid, widget.quote.change >= 0),
                    const SizedBox(width: 12),
                    _buildPriceBlock(widget.quote.ask, widget.quote.change >= 0),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCircularAction(IconData icon, Color color, VoidCallback? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 60,
        alignment: Alignment.center,
        color: color,
        child: Icon(icon, color: Colors.white, size: 28),
      ),
    );
  }

  Widget _buildPriceBlock(double price, bool isUp) {
    String priceStr = price.toStringAsFixed(5);
    // For standard quotes like 1.08450, MT5 shows 1.08 in small, 45 in large, 0 in small.
    // However, some quotes are different. We'll implement a general MT5 logic.
    int decimalPos = priceStr.indexOf('.');
    String pre = priceStr.substring(0, decimalPos + 3); // e.g., '1.08'
    String mid = priceStr.substring(decimalPos + 3, decimalPos + 5); // e.g., '45'
    String post = priceStr.substring(decimalPos + 5); // e.g., '0'

    return Expanded(
      flex: 2,
      child: Container(
        height: 40,
        alignment: Alignment.centerRight,
        child: RichText(
          text: TextSpan(
            style: const TextStyle(color: Colors.black, fontSize: 13),
            children: [
              TextSpan(text: pre),
              TextSpan(
                text: mid,
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, height: 1.0),
              ),
              WidgetSpan(
                child: Transform.translate(
                  offset: const Offset(0, -6),
                  child: Text(
                    post,
                    style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

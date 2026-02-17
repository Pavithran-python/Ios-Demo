import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../widgets/glass_app_bar.dart';
import '../widgets/swipable_quote_card.dart';
import '../models/quote.dart';

class MarketScreen extends StatefulWidget {
  const MarketScreen({super.key});

  @override
  State<MarketScreen> createState() => _MarketScreenState();
}

class _MarketScreenState extends State<MarketScreen> {
  late ScrollController _scrollController;
  double _scrollOffset = 0.0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      setState(() {
        _scrollOffset = _scrollController.offset;
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: GlassAppBar(
        title: 'Quotes',
        scrollOffset: _scrollOffset,
      ),
      body: ListView.builder(
        controller: _scrollController,
        padding: const EdgeInsets.fromLTRB(16, 120, 16, 120),
        itemCount: mockQuotes.length,
        itemBuilder: (context, index) {
          return SwipableQuoteCard(
            quote: mockQuotes[index],
            onAdd: () => _showTopBarMessage(context, 'Added to favorites'),
            onChart: () => _showTopBarMessage(context, 'Opening chart...'),
            onDetail: () => _showTopBarMessage(context, 'Loading details...'),
          ).animate().fadeIn(delay: (index * 20).ms).slideY(begin: 0.1, end: 0);
        },
      ),
    );
  }

  void _showTopBarMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}

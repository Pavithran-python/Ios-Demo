import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../widgets/swipable_quote_card.dart';
import '../models/quote.dart';
import '../theme/glass_theme.dart';

class MarketScreen extends StatefulWidget {
  const MarketScreen({super.key});

  @override
  State<MarketScreen> createState() => _MarketScreenState();
}

class _MarketScreenState extends State<MarketScreen> {
  final ScrollController _scrollController = ScrollController();
  int _segmentedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        controller: _scrollController,
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 0,
            backgroundColor: Colors.white.withValues(alpha: 0.9),
            surfaceTintColor: Colors.transparent,
            leading: IconButton(
              icon: const Icon(CupertinoIcons.list_bullet, color: GlassTheme.iosBlue),
              onPressed: () {},
            ),
            title: const Text(
              'Quotes',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            actions: [
              IconButton(
                icon: const Icon(CupertinoIcons.pencil, color: GlassTheme.iosBlue),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(CupertinoIcons.add, color: GlassTheme.iosBlue),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(CupertinoIcons.search, color: GlassTheme.iosBlue),
                onPressed: () {},
              ),
            ],
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(40),
              child: Container(
                decoration: BoxDecoration(
                  color: GlassTheme.iosSystemGrey6,
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.black.withValues(alpha: 0.05),
                      width: 0.5,
                    ),
                  ),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildSegment('Simple', index: 0),
                    _buildSegment('Advanced', index: 1),
                  ],
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.only(bottom: 120),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return SwipableQuoteCard(
                    quote: mockQuotes[index],
                    onAdd: () {},
                    onChart: () {},
                    onTrade: () {},
                  );
                },
                childCount: mockQuotes.length,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSegment(String label, {required int index}) {
    final bool isActive = _segmentedIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _segmentedIndex = index),
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
}

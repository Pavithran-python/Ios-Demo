import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../widgets/glass_container.dart';
import '../widgets/swipable_quote_card.dart';
import '../models/quote.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();

  static Route route() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => const SearchScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: Tween<double>(begin: 0.95, end: 1.0).animate(
              CurvedAnimation(parent: animation, curve: Curves.easeOutBack),
            ),
            child: child,
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 400),
    );
  }
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final filteredQuotes = mockQuotes.where((q) => 
      q.symbol.toLowerCase().contains(_searchQuery.toLowerCase()) ||
      q.description.toLowerCase().contains(_searchQuery.toLowerCase())
    ).toList();

    return Scaffold(
      backgroundColor: Colors.white.withValues(alpha: 0.8),
      body: Stack(
        children: [
          // Content
          Column(
            children: [
              _buildAppBar(context),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: filteredQuotes.length,
                  itemBuilder: (context, index) {
                    final quote = filteredQuotes[index];
                    return SwipableQuoteCard(quote: quote)
                        .animate()
                        .fadeIn(delay: (index * 20).ms)
                        .moveY(begin: 20, end: 0);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return SafeArea(
      child: Container(
        height: 60,
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            _buildGlassIcon(
              const Icon(Icons.arrow_back, color: Colors.black87),
              onTap: () => Navigator.pop(context),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: GlassContainer(
                blur: 10,
                borderRadius: 30,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                border: Border.all(color: Colors.white.withValues(alpha: 0.5)),
                child: TextField(
                  controller: _searchController,
                  autofocus: true,
                  onChanged: (val) => setState(() => _searchQuery = val),
                  decoration: InputDecoration(
                    hintText: 'Search stocks...',
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: Colors.black.withValues(alpha: 0.3)),
                    icon: const Icon(Icons.search, size: 20, color: Colors.black45),
                  ),
                  style: const TextStyle(fontSize: 16, color: Colors.black87),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGlassIcon(Widget icon, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: GlassContainer(
        blur: 10,
        borderRadius: 20,
        padding: const EdgeInsets.all(8),
        border: Border.all(color: Colors.white.withValues(alpha: 0.5)),
        gradient: LinearGradient(
          colors: [
            Colors.white.withValues(alpha: 0.8),
            Colors.white.withValues(alpha: 0.4),
          ],
        ),
        child: icon,
      ),
    );
  }
}

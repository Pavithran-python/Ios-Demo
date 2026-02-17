import 'package:flutter/material.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';
import '../theme/glass_theme.dart';

class GlassBottomNav extends StatefulWidget {
  final int currentIndex;
  final Function(int) onTap;

  const GlassBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  State<GlassBottomNav> createState() => _GlassBottomNavState();
}

class _GlassBottomNavState extends State<GlassBottomNav> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 30),
      height: 80,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Base Liquid Glass Layer
          LiquidGlass(
             shape: const LiquidRoundedRectangle(
               borderRadius: 40,
             ),
             child: Container(
               color: Colors.white.withValues(alpha: 0.4),
             ),
          ),

          // Liquid Indicator Blob
          AnimatedPositioned(
            duration: const Duration(milliseconds: 600),
            curve: Curves.elasticOut,
            left: (MediaQuery.of(context).size.width - 40) / 4 * widget.currentIndex + 10,
            child: LiquidGlass(
              shape: const LiquidRoundedRectangle(
                borderRadius: 25,
              ),
              child: Container(
                width: 60,
                height: 60,
                color: GlassTheme.iosBlue.withValues(alpha: 0.3),
              ),
            ),
          ),

          // Icons Layer
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(0, Icons.show_chart, 'Quotes'),
              _buildNavItem(1, Icons.swap_horiz, 'Trade'),
              _buildNavItem(2, Icons.history, 'History'),
              _buildNavItem(3, Icons.person_outline, 'Settings'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    final isSelected = widget.currentIndex == index;
    return GestureDetector(
      onTap: () => widget.onTap(index),
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: isSelected ? GlassTheme.iosBlue : Colors.black54,
            size: 28,
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected ? GlassTheme.iosBlue : Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';
import '../theme/glass_theme.dart';

import 'dart:ui';

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

class _GlassBottomNavState extends State<GlassBottomNav> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  int _previousIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOutQuart,
    );
    _previousIndex = widget.currentIndex;
  }

  @override
  void didUpdateWidget(GlassBottomNav oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.currentIndex != oldWidget.currentIndex) {
      _previousIndex = oldWidget.currentIndex;
      _controller.forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double navWidth = screenWidth - 40; // Floating with margins
    final double tabWidth = navWidth / 5;

    return Padding(
      padding: const EdgeInsets.only(bottom: 24, left: 20, right: 20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(35),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            height: 70,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.4),
              borderRadius: BorderRadius.circular(35),
              border: Border.all(
                color: Colors.white.withOpacity(0.2),
                width: 0.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Stack(
              children: [
                // Liquid Indicator Blob
                AnimatedBuilder(
                  animation: _animation,
                  builder: (context, child) {
                    final double t = _animation.value;
                    
                    // Simple logic for stretching: 
                    // Calculate start and end positions
                    final double startPos = _previousIndex * tabWidth;
                    final double endPos = widget.currentIndex * tabWidth;
                    
                    // Determine current left and width of the 'liquid' blob
                    double left;
                    double width;
                    
                    if (t < 0.5) {
                      // Stretching part
                      left = _previousIndex < widget.currentIndex 
                          ? startPos 
                          : startPos + (endPos - startPos) * (t * 2);
                      width = tabWidth + (endPos - startPos).abs() * (t * 2);
                    } else {
                      // Shrinking part
                      left = _previousIndex < widget.currentIndex
                          ? startPos + (endPos - startPos) * ((t - 0.5) * 2)
                          : endPos;
                      width = tabWidth + (endPos - startPos).abs() * (1 - (t - 0.5) * 2);
                    }

                    return Positioned(
                      left: left + (tabWidth - 55) / 2, // Center the blob in tab width
                      top: 10,
                      child: LiquidGlass(
                        shape: LiquidRoundedRectangle(
                          borderRadius: 25,
                        ),
                        child: Container(
                          width: width > 55 ? width - (tabWidth - 55) : 55, // Adjust width while keeping it 'liquid'
                          height: 50,
                          decoration: BoxDecoration(
                            color: GlassTheme.iosBlue.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                      ),
                    );
                  },
                ),

                // Icons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildNavItem(0, CupertinoIcons.list_bullet, 'Quotes'),
                    _buildNavItem(1, CupertinoIcons.chart_bar_square, 'Charts'),
                    _buildNavItem(2, CupertinoIcons.arrow_up_down_circle, 'Trade'),
                    _buildNavItem(3, CupertinoIcons.clock, 'History'),
                    _buildNavItem(4, CupertinoIcons.settings, 'Settings'),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    final isSelected = widget.currentIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => widget.onTap(index),
        behavior: HitTestBehavior.opaque,
        child: AnimatedScale(
          duration: const Duration(milliseconds: 300),
          scale: isSelected ? 1.2 : 1.0,
          curve: Curves.elasticOut,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: isSelected ? GlassTheme.iosBlue : Colors.black45,
                size: 26,
              ),
              const SizedBox(height: 2),
              Text(
                label,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: isSelected ? GlassTheme.iosBlue : Colors.black45,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

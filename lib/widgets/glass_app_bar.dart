import 'package:flutter/material.dart';
import 'glass_container.dart';
import '../theme/glass_theme.dart';
import '../screens/search_screen.dart';

class GlassAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? leading;
  final List<Widget>? actions;
  final double scrollOffset;

  const GlassAppBar({
    super.key,
    required this.title,
    this.leading,
    this.actions,
    this.scrollOffset = 0,
  });

  @override
  Widget build(BuildContext context) {
    final double blurSigma = (scrollOffset / 50).clamp(0.0, 20.0);
    final double borderOpacity = (scrollOffset / 100).clamp(0.0, 0.2);

    return Container(
      color: Colors.transparent,
      child: Stack(
        children: [
          // Background Blur Overlay
          if (scrollOffset > 0)
            GlassContainer(
              blur: blurSigma,
              borderRadius: 0,
              border: Border(
                bottom: BorderSide(
                  color: Colors.black.withValues(alpha: borderOpacity),
                  width: 0.5,
                ),
              ),
              child: const SizedBox.expand(),
            ),
          
          SafeArea(
            child: Container(
              height: 60,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  // Leading (Menu)
                  _buildGlassIcon(
                    leading ?? const Icon(Icons.menu, color: Colors.black87),
                    onTap: () => Scaffold.of(context).openDrawer(),
                  ),
                  
                  // Centered Title
                  Expanded(
                    child: Center(
                      child: Text(
                        title,
                        style: GlassTheme.lightTheme.textTheme.titleLarge,
                      ),
                    ),
                  ),
                  
                  // Search & Actions
                  Row(
                    children: [
                      _buildGlassIcon(
                        const Icon(Icons.search, color: Colors.black87),
                        onTap: () => Navigator.push(context, SearchScreen.route()),
                      ),
                      if (actions != null) ...actions!.map((a) => Padding(
                        padding: const EdgeInsets.only(left: 12),
                        child: _buildGlassIcon(a),
                      )),
                      const SizedBox(width: 4),
                      _buildGlassIcon(const Icon(Icons.add, color: Colors.black87)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
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
        border: Border.all(color: Colors.white.withValues(alpha: 0.5), width: 1),
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

  @override
  Size get preferredSize => const Size.fromHeight(100);
}

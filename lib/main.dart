import 'package:flutter/material.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';
import 'theme/glass_theme.dart';
import 'screens/main_layout.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return LiquidGlassLayer(
      child: MaterialApp(
        title: 'MT5 Liquid Glass',
        debugShowCheckedModeBanner: false,
        theme: GlassTheme.lightTheme,
        home: const MainLayout(),
      ),
    );
  }
}

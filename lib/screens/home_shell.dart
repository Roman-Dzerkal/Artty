import 'package:flutter/material.dart';
import 'package:artty/screens/feed_screen.dart';
import 'package:artty/screens/create_screen.dart';
import 'package:artty/screens/shop_screen.dart';
import 'package:artty/screens/profile_screen.dart';

class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _index = 0;

  final _pages = const [FeedScreen(), CreateScreen(), ShopScreen(), ProfileScreen()];

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        switchInCurve: Curves.easeOut,
        switchOutCurve: Curves.easeIn,
        child: _pages[_index],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (i) => setState(() => _index = i),
        indicatorColor: scheme.primaryContainer,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.brush_outlined, color: Colors.blue), selectedIcon: Icon(Icons.brush, color: Colors.blue), label: 'Feed'),
          NavigationDestination(icon: Icon(Icons.add_circle_outline, color: Colors.purple), selectedIcon: Icon(Icons.add_circle, color: Colors.purple), label: 'Create'),
          NavigationDestination(icon: Icon(Icons.storefront_outlined, color: Colors.green), selectedIcon: Icon(Icons.storefront, color: Colors.green), label: 'Shop'),
          NavigationDestination(icon: Icon(Icons.person_outline, color: Colors.orange), selectedIcon: Icon(Icons.person, color: Colors.orange), label: 'Profile'),
        ],
      ),
    );
  }
}
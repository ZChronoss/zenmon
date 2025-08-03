import 'package:flutter/material.dart';
import 'package:zenmon/presentation/pages/home/home_page.dart';
import 'package:zenmon/presentation/pages/collection/pokemon_collection.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const PokemonCollectionPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.catching_pokemon),
            label: 'Collection',
          ),
        ],
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
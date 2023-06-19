import 'package:flutter/material.dart';
import 'cats.dart';
import 'settings.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  int _selectedIndex = 0;
  
  final _pages = <Widget>[
    const CatsPage(),
    const SettingsPage()
  ];
  
  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          child: _pages.elementAt(_selectedIndex),
        )
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings')
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTap,
      ),
    );
  }
}
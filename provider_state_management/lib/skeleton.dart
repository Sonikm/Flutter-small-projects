import 'package:flutter/material.dart';
import 'package:provider_tutorial/pages/challenge.dart';
import 'package:provider_tutorial/pages/home_page.dart';
import 'package:provider_tutorial/pages/settings_page.dart';

class Skeleton extends StatefulWidget {
  const Skeleton({super.key});

  @override
  State<Skeleton> createState() => _SkeletonState();
}

class _SkeletonState extends State<Skeleton> {
  int _selectedIndex = 2;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

 final List<Widget> _pages = [HomePage(), SettingsPage(), Challenge()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: Drawer(),
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Settings",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.file_copy),
            label: "Challenge",
          ),
        ],
      ),
    );
  }
}


  //! We need three things in this
  //* 1. Class Provider => extends ChangeNotifier notifyListeners
  //* 2. MultiProvider => 
  //* 3. .watch => listen to changes
  //* 4 .read => don't listen to changes

 


import 'package:c_sok/groupe/groupe_list.dart';
import 'package:c_sok/home.dart';
/* 
import 'package:c_sok/home1.dart';
 */
import 'package:c_sok/proclamateur/proclamateur_list.dart';
import 'package:c_sok/rapport/rapport_list.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  double? scrolledUnderElevation;
  bool shadowColor = false;
  int _selectedIndex = 0;
  final BottomNavigationBarType _bottomNavType = BottomNavigationBarType.fixed;

  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    GroupeList(),
    ProclamateurList(),
    RapportList(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 15,
        iconSize: 20,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Maison',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group_outlined),
            activeIcon: Icon(Icons.group),
            label: 'Groupe',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.accessibility_new_outlined),
            activeIcon: Icon(Icons.accessibility_new),
            label: 'Proclamateur',
            tooltip: 'Proclamateur',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.article_outlined),
              activeIcon: Icon(Icons.article),
              label: 'Rapport',
              tooltip: 'Rapport'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).indicatorColor,
        unselectedItemColor: Theme.of(context).disabledColor,
        type: _bottomNavType,
        onTap: _onItemTapped,
      ),
    );
  }
}

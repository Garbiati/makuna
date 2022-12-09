import 'package:flutter/material.dart';
import 'package:makuna/utils/util.dart';

class BottomNavigatorBarWidget extends StatefulWidget {
  const BottomNavigatorBarWidget({super.key});

  @override
  State<BottomNavigatorBarWidget> createState() =>
      _BottomNavigatorBarWidgetState();
}

class _BottomNavigatorBarWidgetState extends State<BottomNavigatorBarWidget> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      Navigator.pushNamed(context, menuIndex()[index].route);
    });
  }

  @override
  Widget build(BuildContext context) {
    _selectedIndex = menuIndex()
        .where(
            (element) => element.route == ModalRoute.of(context)?.settings.name)
        .first
        .index;
    return BottomNavigationBar(
      items: criarMenu(),
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.blueAccent,
      unselectedItemColor: Colors.black,
      onTap: _onItemTapped,
    );
  }

  List<BottomNavigationBarItem> criarMenu() {
    return menuIndex()
        .map((e) => BottomNavigationBarItem(icon: e.icon, label: e.label))
        .toList();
  }
}

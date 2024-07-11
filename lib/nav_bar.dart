import 'package:pegawai/berita_list_screen.dart';

import "package:flutter/material.dart";
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:pegawai/galery_screen.dart';
import 'package:pegawai/pegawai_screen.dart';
import 'package:pegawai/profile_screen.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  int _selectedIndex = 0;

  void _navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [
    BeritaListScreen(),
    GaleryScreen(),
    PegawaiScreen(),
    ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _pages[_selectedIndex],
        bottomNavigationBar: Container(
          color: Colors.black,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 20),
            child: GNav(
              gap: 8,
              onTabChange: _navigateBottomBar,
              padding: EdgeInsets.all(16),
              backgroundColor: Colors.black,
              color: Colors.white,
              activeColor: Colors.white,
              tabBackgroundColor: Colors.grey.shade800,
              tabs: [
                GButton(
                  icon: Icons.book,
                  text: 'Berita',
                ),
                GButton(
                  icon: Icons.photo,
                  text: 'Galery',
                ),
                GButton(
                  icon: Icons.account_box_rounded,
                  text: 'Pegawai',
                ),
                GButton(
                  icon: Icons.add_reaction_sharp,
                  text: 'Profile',
                ),
              ],
            ),
          ),
        ));
  }
}

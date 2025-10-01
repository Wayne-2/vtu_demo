// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:regentspacevtu/demo_pages/pages/finances.dart';
import 'package:regentspacevtu/demo_pages/pages/homepage.dart';
import 'package:regentspacevtu/demo_pages/pages/settings.dart';

class BottomNav extends StatefulWidget {
  final Color appNameColor;
  final Color myColor;
  final Color primaryapptheme;
  final Color homePagebgColor;
  final Color iconthemeColor;
  final String? selectedBgImagePath;

  const BottomNav({
    super.key,
    required this.appNameColor,
    required this.myColor,
    required this.primaryapptheme,
    required this.homePagebgColor,
    required this.iconthemeColor,
    required this.selectedBgImagePath,
  });

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int currentTabIndex = 0;

  late final List<Widget> pages;
  late final HomepageDemo homePage;
  late final SettingsDemo settingsPage;
  late final FinancesDemo financesPage;

  @override
  void initState() {
    super.initState();
    homePage = HomepageDemo(
      primaryapptheme: widget.primaryapptheme,
      iconthemeColor: widget.iconthemeColor,
      selectedBgImagePath: widget.selectedBgImagePath,
    );
    financesPage = FinancesDemo(
      primaryapptheme: widget.primaryapptheme,
    );
    settingsPage = const SettingsDemo();

    pages = [
      homePage,
      financesPage,
      settingsPage,
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: pages[currentTabIndex],
      bottomNavigationBar: Container(
        height: 80,
        decoration: BoxDecoration(
          color: Colors.white, // rounded corners
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(Icons.home, "Home", 0),
            _buildNavItem(Icons.wallet_rounded, "Finances", 1),
            _buildNavItem(Icons.settings, "Settings", 2),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    final isSelected = currentTabIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() => currentTabIndex = index);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? widget.primaryapptheme.withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: isSelected ? 28 : 24,
              color: isSelected ? widget.primaryapptheme : Colors.grey,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w400,
                color: isSelected ? widget.primaryapptheme : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

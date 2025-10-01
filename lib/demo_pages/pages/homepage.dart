// ignore_for_file: deprecated_member_use

import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:regentspacevtu/demo_pages/attachments/addmoney.dart';
import 'package:regentspacevtu/demo_pages/attachments/buypageshortcut.dart';
import 'package:regentspacevtu/demo_pages/attachments/electricityandcablebills.dart';
import 'package:regentspacevtu/demo_pages/attachments/notificationpage.dart';
import 'package:regentspacevtu/demo_pages/widgets/icontabs.dart';

class HomepageDemo extends StatelessWidget {
  HomepageDemo({
    super.key,
    required this.primaryapptheme,
    required this.iconthemeColor,
    required String? selectedBgImagePath,
  }) : _selectedBgImagePath = selectedBgImagePath;

  final Color primaryapptheme;
  final Color iconthemeColor;
  final String? _selectedBgImagePath;

  final List<String> images = [
    'assets/ads1.png',
    'assets/ads2.png',
  ];

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: AssetImage("assets/nophoto.png"),
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      'Hello User',
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const AddMoneyPage()),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.black, width: 1),
                          color: primaryapptheme,
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.add_circle, size: 14, color: iconthemeColor),
                            const SizedBox(width: 6),
                            Text(
                              "Add Money",
                              style: TextStyle(fontSize: 14, color: iconthemeColor),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const Notificationpage()),
                        );
                      },
                      child: const Icon(Icons.notifications_outlined, size: 22),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),

            /// Account Balance Card
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: _selectedBgImagePath == null
                      ? Image.asset(
                          'assets/newbg.png',
                          width: double.infinity,
                          height: 150,
                          fit: BoxFit.cover,
                        )
                      : Image.file(
                          File(_selectedBgImagePath),
                          width: double.infinity,
                          height: 150,
                          fit: BoxFit.cover,
                        ),
                ),
                Container(
                  width: double.infinity,
                  height: 150,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.black.withOpacity(0.3), // slight overlay for readability
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Account Balance",
                        style: TextStyle(fontSize: 16, color: Colors.white70),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "₦ 2,554,706",
                        style: GoogleFonts.lato(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: primaryapptheme,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Text("Moniepoint",
                              style: GoogleFonts.lato(color: Colors.white, fontSize: 16)),
                          const SizedBox(width: 6),
                          GestureDetector(
                            onTap: () {
                              Clipboard.setData(const ClipboardData(text: "1100336447"));
                            },
                            child: Row(
                              children: [
                                const Icon(Icons.copy, size: 16, color: Colors.white),
                                const SizedBox(width: 6),
                                Text(
                                  "1100336447",
                                  style: GoogleFonts.lato(color: Colors.white, fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            /// Services Grid
            const Text("Top-up Services", style: TextStyle(fontSize: 14)),
            const SizedBox(height: 10),
            GridView.count(
              crossAxisCount: 4,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              childAspectRatio: 0.8,
              children: [
                _buildServiceIcon(
                  context,
                  icon: Icons.phone_android,
                  label: 'Airtime',
                  page: BuyPage(
                    pageTitle: 'Buy Airtime',
                    planLabel: 'Amount',
                    planHint: 'Enter amount',
                    mobileLabel: 'Phone Number',
                    mobileHint: 'Enter phone number',
                    plans: ['₦ 500', '₦ 1000', '₦ 2000', '₦ 5000'],
                    purchaseType: 'Airtime',
                  ),
                ),
                _buildServiceIcon(
                  context,
                  icon: Icons.wifi,
                  label: 'Data',
                  page: BuyPage(
                    pageTitle: 'Buy Data',
                    planLabel: 'Select Plan',
                    planHint: 'Choose data plan',
                    mobileLabel: 'Phone Number',
                    mobileHint: 'Enter phone number',
                    plans: ['₦ 500 1.5GB', '₦ 1000 3GB', '₦ 1500 5GB', '₦ 2000 10GB'],
                    purchaseType: 'Data',
                  ),
                ),
                _buildServiceIcon(
                  context,
                  icon: Icons.bolt,
                  label: 'Electric',
                  page: const BuyUtilityPage(
                    title: "Buy Electricity",
                    transactionType: "Electricity Purchase",
                  ),
                ),
                _buildServiceIcon(
                  context,
                  icon: Icons.tv,
                  label: 'Cable',
                  page: const BuyUtilityPage(
                    title: "Buy Cable TV",
                    transactionType: "Cable TV Purchase",
                  ),
                ),
                _buildServiceIcon(context, icon: Icons.sports_soccer, label: 'Betting'),
                _buildServiceIcon(context, icon: Icons.flight, label: 'Flight'),
                _buildServiceIcon(context, icon: Icons.shopping_cart, label: 'Shop'),
                _buildServiceIcon(context, icon: Icons.generating_tokens, label: 'Results'),
              ],
            ),

            const SizedBox(height: 20),

            /// Ads Carousel
            const Text("Advertisements", style: TextStyle(fontSize: 14)),
            const SizedBox(height: 10),
            CarouselSlider(
              options: CarouselOptions(
                height: screenHeight * 0.18, // dynamic height ~18% of screen
                autoPlay: true,
                enlargeCenterPage: true,
                viewportFraction: 0.9,
              ),
              items: images.map((url) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: AssetImage(url),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceIcon(BuildContext context,
      {required IconData icon, required String label, Widget? page}) {
    return GestureDetector(
      onTap: page == null
          ? null
          : () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => page));
            },
      child: Icontabs(
        icon: icon,
        color: iconthemeColor,
        label: label,
        themecolor: primaryapptheme,
        height: 60,
        width: 60,
        iconsize: 20,
      ),
    );
  }
}

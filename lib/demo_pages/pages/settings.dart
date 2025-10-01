import 'package:flutter/material.dart';

class SettingsDemo extends StatelessWidget {
  const SettingsDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF1D3A70),
      ),
      body: ListView(
        padding: const EdgeInsets.all(15.0),
        children: [

          // --- Section 1: Account ---
          const SectionHeader(title: "Account"),
          ProfileOptionNewTile(
            title: 'Profile',
            leading: Icons.person_outline,
            onTap: () {},
          ),
          ProfileOptionNewTile(
            title: 'Linked Accounts',
            leading: Icons.link_outlined,
            onTap: () {},
          ),
          ProfileOptionNewTile(
            title: 'Referrals',
            leading: Icons.group_add_outlined,
            onTap: () {},
          ),
          ProfileOptionNewTile(
            title: 'Security',
            leading: Icons.lock_outline,
            onTap: () {},
          ),

          const SizedBox(height: 20),

          // --- Section 2: About / Support ---
          const SectionHeader(title: "App Info"),
          ProfileOptionNewTile(
            title: 'About Us',
            leading: Icons.info_outline,
            onTap: () {},
          ),
          ProfileOptionNewTile(
            title: 'FAQs',
            leading: Icons.help_outline,
            onTap: () {},
          ),

          const SizedBox(height: 20),

          // --- Section 3: Logout ---
          ProfileOptionNewTile(
            title: 'Log Out',
            leading: Icons.logout,
            isDestructive: true,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

class ProfileOptionNewTile extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final IconData leading;
  final bool isDestructive;

  const ProfileOptionNewTile({
    super.key,
    required this.title,
    required this.onTap,
    required this.leading,
    this.isDestructive = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(leading, color: isDestructive ? Colors.red : const Color(0xFF1D3A70)),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: isDestructive ? Colors.red : const Color(0xFF1D3A70),
        ),
      ),
      trailing: isDestructive
          ? null
          : const Icon(Icons.arrow_forward_ios, size: 14, color: Color(0xFF1D3A70)),
      onTap: onTap,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      tileColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
    );
  }
}

class SectionHeader extends StatelessWidget {
  final String title;
  const SectionHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, left: 4),
      child: Text(
        title.toUpperCase(),
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.grey,
        ),
      ),
    );
  }
}

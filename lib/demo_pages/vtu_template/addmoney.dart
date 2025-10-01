// ignore_for_file: avoid_print, deprecated_member_use

import 'package:flutter/material.dart';

import 'enterpin.dart';

class AddMoneyPage extends StatefulWidget {
  const AddMoneyPage({super.key});

  @override
  State<AddMoneyPage> createState() => _AddMoneyPageState();
}

class _AddMoneyPageState extends State<AddMoneyPage> {
  String amount = '';

  void _handleKeyPress(String value) {
    setState(() {
      if (value == 'back') {
        if (amount.isNotEmpty) {
          amount = amount.substring(0, amount.length - 1);
        }
      } else if (value == '0' && amount.isEmpty) {
        return; // Prevent leading zero
      } else {
        amount += value;
      }
    });
  }

  String get formattedAmount {
    if (amount.isEmpty) return '₦0.00';
    final parsed = int.tryParse(amount);
    if (parsed == null) return '₦0.00';
    return '₦${parsed.toString().replaceAllMapped(RegExp(r"\B(?=(\d{3})+(?!\d))"), (m) => ",")}.00';
  }

  void _navigateToEnterPin() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EnterPinPage(
          onPinEntered: (pin) {
            print("Amount: ₦$amount, PIN: $pin");
          },
          isError: false,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: _CustomAppBar(title: 'Add Money'),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                'How much do you want to add to your FinPadi account?',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              formattedAmount,
              style: const TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1D3A70),
              ),
            ),
            const SizedBox(height: 40),
            Expanded(
              child: _CustomKeypad(onKeyPressed: _handleKeyPress),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: GestureDetector(
                onTap: amount.isEmpty ? null : _navigateToEnterPin,
                child: Container(
                  height: 55,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: amount.isEmpty
                        ? LinearGradient(
                            colors: [Colors.grey.shade300, Colors.grey.shade400],
                          )
                        : const LinearGradient(
                            colors: [Color(0xFFF56C2A), Color(0xFFFE8C00)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                  ),
                  child: Center(
                    child: Text(
                      "Next",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: amount.isEmpty ? Colors.grey.shade600 : Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const _CustomAppBar({required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      centerTitle: true,
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.black87,
          fontWeight: FontWeight.w600,
          fontSize: 18,
        ),
      ),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Colors.black87),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomKeypad extends StatelessWidget {
  final void Function(String) onKeyPressed;

  const _CustomKeypad({required this.onKeyPressed});

  @override
  Widget build(BuildContext context) {
    final keys = [
      ['1', '2', '3'],
      ['4', '5', '6'],
      ['7', '8', '9'],
      ['', '0', 'back']
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: keys.map((row) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: row.map((key) {
                if (key.isEmpty) return const SizedBox(width: 70);

                IconData? icon = key == 'back' ? Icons.backspace_outlined : null;
                return InkWell(
                  onTap: () => onKeyPressed(key),
                  borderRadius: BorderRadius.circular(50),
                  child: Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.15),
                          blurRadius: 10,
                          offset: const Offset(2, 4),
                        )
                      ],
                    ),
                    child: Center(
                      child: icon != null
                          ? Icon(icon, color: Colors.indigo, size: 28)
                          : Text(
                              key,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                                color: Colors.indigo,
                              ),
                            ),
                    ),
                  ),
                );
              }).toList(),
            ),
          );
        }).toList(),
      ),
    );
  }
}

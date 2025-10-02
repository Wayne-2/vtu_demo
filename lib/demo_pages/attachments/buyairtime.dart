// ignore_for_file: avoid_print, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:regentspacevtu/demo_pages/vtu_services/service.dart';
import 'package:regentspacevtu/demo_pages/vtu_template/transactiondetails.dart';

class BuyAirtimePage extends StatefulWidget {
  const BuyAirtimePage({super.key});

  @override
  State<BuyAirtimePage> createState() => _BuyAirtimePageState();
}

class _BuyAirtimePageState extends State<BuyAirtimePage> {
  String? _selectedNetwork;
  final TextEditingController _mobileNumberController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  bool get isFormValid {
    return _mobileNumberController.text.trim().isNotEmpty &&
        _amountController.text.trim().isNotEmpty &&
        _selectedNetwork != null;
  }

  final List<Map<String, String>> _networks = [
    {'name': 'MTN', 'imagePath': 'assets/mtn.png'},
    {'name': 'GLO', 'imagePath': 'assets/glo.png'},
    {'name': 'Airtel', 'imagePath': 'assets/airtel.png'},
    {'name': '9Mobile', 'imagePath': 'assets/9mobile.png'},
  ];

  @override
  void initState() {
    super.initState();
    _mobileNumberController.addListener(_onFormChange);
    _amountController.addListener(_onFormChange);
  }

  void _onFormChange() => setState(() {});
  @override
  void dispose() {
    _mobileNumberController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  Future<void> _buyAirtime() async {
    final mobile = _mobileNumberController.text.trim();
    final amount = _amountController.text.trim().replaceAll(RegExp(r'[^0-9]'), ''); // clean ₦
    final network = _selectedNetwork?.toLowerCase();

    if (network == null) return;

    try {
      final vtuService = VtuService();

      // purchaseType could be "airtime" or "data"
      final result = await vtuService.buy(
        network: network,
        mobile: mobile,
        amount: amount,
        type: "airtime",
      );

      final transaction = result['content']['transactions'];

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => TransactionDetailsPage(
            transactionId: transaction['transactionId'],
            date: result['transaction_date'],
            recipient: "Mobile: ${transaction['unique_element']}",
            type: transaction['type'],
            amount: "₦${transaction['amount']}",
            fee: "₦${transaction['convinience_fee']}",
            description: transaction['product_name'],
            total: "₦${transaction['total_amount']}",
          ),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Transaction failed: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Buy Airtime',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Select Network',
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w500)),
            const SizedBox(height: 10),

            /// Networks Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: _networks.map((network) {
                final name = network['name']!;
                final imagePath = network['imagePath']!;
                return GestureDetector(
                  onTap: () => setState(() => _selectedNetwork = name),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: _selectedNetwork == name
                                ? const Color(0xFFF56C2A)
                                : Colors.transparent,
                            width: 2,
                          ),
                        ),
                        child: CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(imagePath, fit: BoxFit.contain),
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(name),
                    ],
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 24),
            const Text(
              'Enter Amount',
              style: TextStyle(fontSize: 14, color: Color(0xFF979797)),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _amountController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xFFF6F8FB),
                hintText: '₦ 0.00',
                hintStyle: const TextStyle(color: Color(0xFFC4C4C4)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
              ),
            ),

            const SizedBox(height: 24),
            const Text(
              'Enter Mobile Number',
              style: TextStyle(fontSize: 14, color: Color(0xFF979797)),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _mobileNumberController,
              keyboardType: TextInputType.phone,
              style: const TextStyle(
                  color: Color(0xFF1D3A70),
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xFFF6F8FB),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
              ),
            ),

            const SizedBox(height: 32),
            GestureDetector(
              onTap: isFormValid ? _buyAirtime : null,
              child: Container(
                width: double.infinity,
                height: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isFormValid
                      ? const Color(0xFFF56C2A)
                      : const Color(0xFFDADADA),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  "Next",
                  style: TextStyle(
                    fontSize: 16,
                    color: isFormValid
                        ? Colors.white
                        : const Color.fromARGB(125, 255, 255, 255),
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

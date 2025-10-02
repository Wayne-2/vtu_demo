// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:regentspacevtu/demo_pages/vtu_services/service.dart';
import 'package:regentspacevtu/demo_pages/vtu_template/transactiondetails.dart';

class BuyDataPage extends StatefulWidget {
  const BuyDataPage({super.key});

  @override
  State<BuyDataPage> createState() => _BuyDataPageState();
}

class _BuyDataPageState extends State<BuyDataPage> {
  String? _selectedNetwork;
  String? _selectedDataPlan;
  final TextEditingController _mobileNumberController = TextEditingController();

  final List<Map<String, String>> _networks = [
    {'name': 'MTN', 'imagePath': 'assets/mtn.png'},
    {'name': 'GLO', 'imagePath': 'assets/glo.png'},
    {'name': 'Airtel', 'imagePath': 'assets/airtel.png'},
    {'name': '9Mobile', 'imagePath': 'assets/9mobile.png'},
  ];

  final List<String> _dataPlans = [
    '500 MB (30 days) @ ₦150.00',
    '100 MB for ₦50',
    '500 MB for ₦100',
    '1 GB for ₦200'
  ];

  bool get isFormValid {
    return _mobileNumberController.text.trim().isNotEmpty &&
        _selectedNetwork != null &&
        _selectedDataPlan != null;
  }

  @override
  void dispose() {
    _mobileNumberController.dispose();
    super.dispose();
  }

  /// Extract numeric amount from selected plan string
  String _extractAmount(String plan) {
    final regex = RegExp(r'₦(\d+)');
    final match = regex.firstMatch(plan);
    return match != null ? match.group(1)! : "0";
  }

  Future<void> _buyData() async {
    final mobile = _mobileNumberController.text.trim();
    final amount = _extractAmount(_selectedDataPlan!);
    final network = _selectedNetwork?.toLowerCase();

    if (network == null) return;

    try {
      final vtuService = VtuService();

      final result = await vtuService.buy(
        network: network,
        mobile: mobile,
        amount: amount,
        type: "data",
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
          'Buy Data',
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

            /// Network selection row
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
                                ? Colors.blue
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
              'Choose Data Plan',
              style: TextStyle(fontSize: 14, color: Color(0xFF979797)),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: const Color(0xFFF6F8FB),
                borderRadius: BorderRadius.circular(8),
              ),
              child: DropdownButtonFormField<String>(
                isExpanded: true,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
                dropdownColor: Colors.white,
                value: _selectedDataPlan,
                hint: const Text(
                  'Select a plan',
                  style: TextStyle(
                      color: Color(0xFFC4C4C4),
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                ),
                icon: const Icon(Icons.arrow_drop_down),
                items: _dataPlans.map((plan) {
                  return DropdownMenuItem(
                    value: plan,
                    child: Text(plan),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _selectedDataPlan = newValue;
                  });
                },
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
              onTap: isFormValid ? _buyData : null,
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

import 'package:flutter/material.dart';
import 'package:regentspacevtu/demo_pages/attachments/bankaccount.dart';
import 'package:regentspacevtu/demo_pages/widgets/usageinfo.dart';
// import 'package:regentspacevtu/demo_pages/widgets/usageinfo.dart';

class FinancesDemo extends StatelessWidget {
  const FinancesDemo({super.key, required this.primaryapptheme});

  final Color primaryapptheme;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 110,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Color.fromARGB(255, 255, 212, 186),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    /// Left side - Avatar + Info
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 28,
                          backgroundColor: Color.fromARGB(255, 255, 198, 166),
                          child: const Icon(
                            Icons.person,
                            color: Color.fromARGB(255, 255, 115, 35),
                            size: 28,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "username",
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Prepaid - 908844343422",
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    /// Right side - Manage button
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Bankaccount(),
                          ),
                        );
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: Color.fromARGB(255, 248, 107, 26),
                        backgroundColor: Color.fromARGB(255, 255, 200, 169),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 8,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        "Manage",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Usageinfo(
                    amount: '20,000.00',
                    rating: 'Kes',
                    servicetype: 'Airtime',
                    fontsize: 14,
                  ),
                  Usageinfo(
                    amount: '4000',
                    rating: 'Mms',
                    servicetype: 'Voice Bundle',
                    fontsize: 14,
                  ),
                  Usageinfo(
                    amount: '2,903.00',
                    rating: 'Mb',
                    servicetype: 'Data Bundle',
                    fontsize: 14,
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // History Button
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // handle history
                    },
                    icon: const Icon(Icons.history, size: 18),
                    label: const Text(
                      "History",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryapptheme,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 2,
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                // Schedule Payments Button
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // handle schedule payments
                    },
                    icon: const Icon(Icons.schedule, size: 18),
                    label: const Text(
                      "Schedule",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: primaryapptheme,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(color: primaryapptheme, width: 1),
                      ),
                      elevation: 1,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Recent Transactions", style: TextStyle(fontSize: 14)),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(7.0),
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.black12, width: 1),
                      ),
                      child: Row(
                        children: [
                          // Image
                          Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.grey[100],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Icon(Icons.wallet_outlined, size: 13),
                            ),
                          ),

                          SizedBox(width: 14),

                          // Title and Time
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'loan payment',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(height: 6),
                                Text(
                                  '12:00pm',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Amount
                          Text(
                            '+3,000',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

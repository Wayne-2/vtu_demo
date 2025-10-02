import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final List<Map<String, dynamic>> _notifications = [
    {
      "title": "Airtime Purchase Successful",
      "message": "You successfully purchased ₦500 MTN Airtime for 08012345678.",
      "time": "2 min ago",
      "icon": Icons.check_circle,
      "color": Colors.green,
    },
    {
      "title": "Electricity Bill Paid",
      "message": "Your PHCN bill of ₦5,000 has been paid successfully.",
      "time": "1 hr ago",
      "icon": Icons.bolt,
      "color": Colors.orange,
    },
    {
      "title": "Data Subscription",
      "message": "1.5GB Airtel Data (₦1,000) activated on 08098765432.",
      "time": "Yesterday",
      "icon": Icons.wifi,
      "color": Colors.blue,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FB),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          "Notifications",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: _notifications.isEmpty
          ? const Center(
              child: Text(
                "No Notifications Yet",
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _notifications.length,
              itemBuilder: (context, index) {
                final item = _notifications[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  elevation: 2,
                  shadowColor: Colors.black12,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: (item["color"] as Color).withOpacity(0.1),
                      child: Icon(item["icon"], color: item["color"]),
                    ),
                    title: Text(
                      item["title"],
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: Text(
                      item["message"],
                      style: const TextStyle(fontSize: 13, color: Colors.black87),
                    ),
                    trailing: Text(
                      item["time"],
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                    onTap: () {
                      // TODO: handle tap, maybe open details page
                    },
                  ),
                );
              },
            ),
    );
  }
}

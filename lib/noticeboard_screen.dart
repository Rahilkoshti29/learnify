import 'package:flutter/material.dart';

class NoticeBoardScreen extends StatefulWidget {
  const NoticeBoardScreen({super.key});

  @override
  State<NoticeBoardScreen> createState() => _NoticeBoardScreenState();
}

class _NoticeBoardScreenState extends State<NoticeBoardScreen> {
  List<Map<String, String>> notices = [
    {
      "title": "Water Supply Maintenance",
      "date": "20 March 2026",
      "message": "Water supply will be interrupted from 10 AM to 1 PM.",
    },
    {
      "title": "Society Meeting",
      "date": "22 March 2026",
      "message": "Monthly society meeting at clubhouse at 6 PM.",
    },
    {
      "title": "Festival Celebration",
      "date": "25 March 2026",
      "message": "Celebrate Holi together in garden area.",
    },
    {
      "title": "Parking Notice",
      "date": "28 March 2026",
      "message": "Avoid parking in visitor zone.",
    },
    {
      "title": "Lift Maintenance",
      "date": "30 March 2026",
      "message": "Lift servicing will take place from 11 AM to 2 PM.",
    },
    {
      "title": "Lift Maintenance",
      "date": "30 March 2026",
      "message": "Lift servicing will take place from 11 AM to 2 PM.",
    },
    {
      "title": "Electricity Shutdown",
      "date": "2 April 2026",
      "message": "Power backup testing from 9 AM to 10 AM.",
    },
    {
      "title": "Garbage Collection Timing",
      "date": "4 April 2026",
      "message": "Please hand over garbage before 8 AM daily.",
    },
    {
      "title": "Security Alert",
      "date": "6 April 2026",
      "message": "Residents are requested to verify visitors before entry.",
    },
    {
      "title": "Garden Cleaning",
      "date": "8 April 2026",
      "message": "Garden area will remain closed till afternoon.",
    },
  ];

  void deleteNotice(int index) {
    setState(() {
      notices.removeAt(index);
    });

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Notice Removed")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],

      appBar: AppBar(
        backgroundColor: const Color(0xffE23744),
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios_new_sharp, color: Colors.white),
        ),
        centerTitle: true,
        title: const Text(
          "Notice Board",
          style: TextStyle(color: Colors.white),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: notices.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 15),
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(color: Colors.grey.shade300, blurRadius: 6),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.notifications_active,
                            color: Color(0xffE23744),
                          ),

                          const SizedBox(width: 10),

                          Expanded(
                            child: Text(
                              notices[index]["title"]!,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                          IconButton(
                            onPressed: () {
                              deleteNotice(index);
                            },
                            icon: const Icon(Icons.delete, color: Colors.red),
                          ),
                        ],
                      ),

                      const SizedBox(height: 10),

                      Text(
                        notices[index]["date"]!,
                        style: TextStyle(color: Colors.grey[600]),
                      ),

                      const SizedBox(height: 12),

                      Text(
                        notices[index]["message"]!,
                        style: const TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

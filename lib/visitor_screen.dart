import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VisitorScreen extends StatefulWidget {
  const VisitorScreen({super.key});

  @override
  State<VisitorScreen> createState() => _VisitorScreenState();
}

class _VisitorScreenState extends State<VisitorScreen> {
  List<Map<String, String>> defaultVisitors = [
    {"name": "Ramesh Patel", "time": "10:30 AM"},
    {"name": "Courier Delivery", "time": "11:15 AM"},
    {"name": "Milk Vendor", "time": "7:45 AM"},
    {"name": "Electrician", "time": "1:20 PM"},
    {"name": "Guest Visitor", "time": "5:10 PM"},
  ];

  List<Map<String, String>> visitors = [];

  @override
  void initState() {
    super.initState();
    loadVisitors();
  }

  Future<void> loadVisitors() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? savedData = prefs.getString('saved_visitors');

    if (savedData != null) {
      List decoded = jsonDecode(savedData);

      if (decoded.isNotEmpty) {
        setState(() {
          visitors = decoded.map((e) => Map<String, String>.from(e)).toList();
        });
      } else {
        visitors = List.from(defaultVisitors);
        saveVisitors();
        setState(() {});
      }
    } else {
      visitors = List.from(defaultVisitors);
      saveVisitors();
      setState(() {});
    }
  }

  Future<void> saveVisitors() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('saved_visitors', jsonEncode(visitors));
  }

  void handleVisitor(int index, String action) async {
    String visitorName = visitors[index]["name"]!;

    setState(() {
      visitors.removeAt(index);
    });

    await saveVisitors();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          action == "allow" ? "$visitorName Accepted" : "$visitorName Rejected",
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],

      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios_new_sharp, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xffE23744),
        title: const Text("Visitors", style: TextStyle(color: Colors.white)),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: visitors.length,
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
                  Text(
                    visitors[index]["name"]!,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text("Time: ${visitors[index]["time"]!}"),

                  const SizedBox(height: 15),

                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            handleVisitor(index, "allow");
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                          ),
                          child: const Text(
                            "Allow",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),

                      const SizedBox(width: 10),

                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            handleVisitor(index, "deny");
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                          ),
                          child: const Text(
                            "Deny",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

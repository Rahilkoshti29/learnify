import 'package:flutter/material.dart';
import 'package:sociohub/dashboard_screen.dart';
import 'package:sociohub/noticeboard_screen.dart';
import 'package:sociohub/payment_screen.dart';
import 'package:sociohub/visitor_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  // 🔴 Go Home function
  void goHome() {
    setState(() {
      currentIndex = 0;
    });
  }

  @override
  Widget build(BuildContext context) {

    // ✅ SAFE: create screens here (no late error)
    final List<Widget> screens = [
      const DashboardPage(), // no callback
      NoticeBoardScreen(onBackToHome: goHome),
      VisitorScreen(onBackToHome: goHome),
      PaymentScreen(onBackToHome: goHome),
    ];

    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      body: IndexedStack(
        index: currentIndex,
        children: screens,
      ),

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: currentIndex,
        selectedItemColor: const Color(0xffE23744),
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,

        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },

        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: "Notice"),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: "Visitors"),
          BottomNavigationBarItem(icon: Icon(Icons.payment), label: "Payments"),
        ],
      ),
    );
  }
}
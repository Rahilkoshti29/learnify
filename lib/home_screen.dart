import 'package:flutter/material.dart';
import 'package:sociohub/profile_screen.dart';
import 'package:sociohub/noticeboard_screen.dart';
import 'package:sociohub/visitor_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xffE23744),
        elevation: 0,
        title: const Text("SocioHub", style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),

      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Color(0xffE23744),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome Resident",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  "Manage your society easily",
                  style: TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                children: [
                  buildCard(Icons.people, "Visitors", () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const VisitorScreen()),
                    );
                  }),

                  buildCard(Icons.notifications, "Notice Board", () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const NoticeBoardScreen(),
                      ),
                    );
                  }),

                  buildCard(Icons.payment, "Payments", () {}),

                  buildCard(Icons.person, "Profile", () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const ProfileScreen()),
                    );
                  }),
                ],
              ),
            ),
          ),
        ],
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        selectedItemColor: const Color(0xffE23744),
        unselectedItemColor: Colors.grey,

        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });

          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => HomeScreen()),
            );
          }

          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => NoticeBoardScreen()),
            );
          }

          if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => ProfileScreen()),
            );
          }
        },

        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: "Notice",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }

  Widget buildCard(IconData icon, String title, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        elevation: 4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 45, color: const Color(0xffE23744)),

            const SizedBox(height: 12),

            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:sociohub/profile_screen.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      body: Column(
        children: [

          // 🔴 FIXED HEADER (NOT TOO UP)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 45, left: 15, right: 15, bottom: 20),
            decoration: const BoxDecoration(
              color: Color(0xffE23744),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
            ),
            child: Row(
              children: [

                // 👤 PROFILE CLICK
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const ProfileScreen(),
                      ),
                    );
                  },
                  child: const CircleAvatar(
                    radius: 22,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, color: Colors.grey),
                  ),
                ),

                const SizedBox(width: 12),

                const Expanded(
                  child: Text(
                    "Hello, Resident 👋",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const Icon(Icons.notifications, color: Colors.white),
              ],
            ),
          ),

          // 🔽 CONTENT
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [

                  // 🔥 WELCOME CARD (FIRST)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Welcome 👋",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text("Manage your society easily from one place."),
                      ],
                    ),
                  ),

                  const SizedBox(height: 15),

                  // 🏢 BUILDING IMAGE (PROPER)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: Image.asset(
                      "assets/1.jpg",
                      //  height: 450,
                      width: double.infinity,
                      fit: BoxFit.contain,
                    ),
                  ),

                  const SizedBox(height: 15),

                  // 🔥 SOCIETY DETAILS
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade300,
                          blurRadius: 5,
                        )
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        const Text(
                          "Society Details",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 12),

                        // 📍 Address
                        const Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.location_on, color: Colors.grey),
                            SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                "Green Valley Society, Near SG Highway, Ahmedabad, Gujarat 380015",
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 10),

                        // 🏠 Flats
                        const Row(
                          children: [
                            Icon(Icons.home, color: Colors.grey),
                            SizedBox(width: 8),
                            Text("Total Flats: 120"),
                          ],
                        ),

                        const SizedBox(height: 10),

                        // 🛡 Security
                        const Row(
                          children: [
                            Icon(Icons.security, color: Colors.grey),
                            SizedBox(width: 8),
                            Text("24x7 Security Available"),
                          ],
                        ),

                        const SizedBox(height: 15),

                        const Divider(),

                        const SizedBox(height: 10),

                        // 🏢 AMENITIES
                        const Text(
                          "Amenities",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),

                        const SizedBox(height: 10),

                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: [
                            amenityChip(Icons.pool, "Swimming Pool"),
                            amenityChip(Icons.local_parking, "Parking"),
                            amenityChip(Icons.fitness_center, "Gym"),
                            amenityChip(Icons.park, "Garden"),
                            amenityChip(Icons.sports_cricket, "Play Area"),
                            amenityChip(Icons.security, "CCTV"),
                          ],
                        ),

                        const SizedBox(height: 15),

                        const Divider(),

                        const SizedBox(height: 10),

                        // 📞 CONTACT
                        const Text(
                          "Society Contact",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),

                        const SizedBox(height: 10),

                        const Row(
                          children: [
                            Icon(Icons.phone, color: Colors.grey),
                            SizedBox(width: 8),
                            Text("+91 9876543210"),
                          ],
                        ),

                        const SizedBox(height: 8),

                        const Row(
                          children: [
                            Icon(Icons.email, color: Colors.grey),
                            SizedBox(width: 8),
                            Text("society@greenvalley.com"),
                          ],
                        ),

                        const SizedBox(height: 15),

                        const Divider(),

                        const SizedBox(height: 10),

                        // 📱 ABOUT APP
                        const Text(
                          "About App",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),

                        const SizedBox(height: 10),

                        const Text(
                          "SocioHub helps residents manage visitors, payments, and notices efficiently. It improves communication and enhances security within the society.",
                        ),
                      ],
                    ),
                  ),


                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget amenityChip(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: const Color(0xffE23744)),
          const SizedBox(width: 5),
          Text(label, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

}
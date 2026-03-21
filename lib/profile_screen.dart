import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController flatController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  bool isEditing = false;

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  Future<void> loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? userString = prefs.getString('user_data');

    if (userString != null) {
      Map<String, dynamic> userData = jsonDecode(userString);

      nameController.text = userData['name'];
      flatController.text = userData['flat'];
      mobileController.text = userData['mobile'];
      emailController.text = userData['email'];

      setState(() {});
    }
  }

  Future<void> saveUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? userString = prefs.getString('user_data');

    if (userString != null) {
      Map<String, dynamic> oldData = jsonDecode(userString);

      Map<String, dynamic> updatedData = {
        "name": nameController.text,
        "flat": flatController.text,
        "mobile": mobileController.text,
        "email": emailController.text,
        "password": oldData["password"], // keep old password safe
      };

      await prefs.setString('user_data', jsonEncode(updatedData));

      setState(() {
        isEditing = false;
      });

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Profile Updated")));
    }
  }

  Widget buildField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextField(
        controller: controller,
        enabled: isEditing,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.grey.shade100,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xffE23744), width: 2),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),

          icon: Icon(Icons.arrow_back_ios_new_sharp, color: Colors.white),
        ),
        backgroundColor: const Color(0xffE23744),
        title: const Text("Profile", style: TextStyle(color: Colors.white)),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 20),

            const CircleAvatar(
              radius: 45,
              backgroundColor: Color(0xffE23744),
              child: Icon(Icons.person, size: 50, color: Colors.white),
            ),

            const SizedBox(height: 25),

            buildField("Full Name", nameController),
            buildField("Flat Number", flatController),
            buildField("Mobile Number", mobileController),
            buildField("Email", emailController),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  if (isEditing) {
                    saveUserData();
                  } else {
                    setState(() {
                      isEditing = true;
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xffE23744),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: Text(
                  isEditing ? "Save Changes" : "Edit Profile",
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

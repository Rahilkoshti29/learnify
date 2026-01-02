import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProfilePage extends StatefulWidget {
  final int userId;

  const ProfilePage({super.key, required this.userId});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isLoading = true;
  Map<String, dynamic>? userData;

  Future<void> fetchProfile() async {
    final url = Uri.parse(
      'http://192.168.31.137:8000/api/users/profile/${widget.userId}/',

    );


    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        setState(() {
          print("STATUS CODE: ${response.statusCode}");
          print("BODY: ${response.body}");
          userData = jsonDecode(response.body);
          isLoading = false;
        });
      } else {
        showError("Failed to load profile");
      }
    } catch (e) {
      showError("Server error");
    }
  }

  void showError(String msg) {
    setState(() => isLoading = false);
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  void initState() {
    super.initState();
    fetchProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Profile")),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : userData == null
          ? const Center(child: Text("No data"))
          : Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            profileRow("Name", userData!['user_name']),
            profileRow("Email", userData!['user_email']),
            profileRow(
                "Phone", userData!['user_phone'].toString()),
            profileRow("Address", userData!['user_address']),
            profileRow(
              "Joined",
              userData!['created_at']
                  .toString()
                  .substring(0, 10),
            ),
          ],
        ),
      ),
    );
  }

  Widget profileRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Text(
            "$label: ",
            style: const TextStyle(
                fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}

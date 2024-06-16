import 'package:final_year_project/features/partner/controller/partner_controller.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = PartnerController.instance;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: Column(
        children: [
          ElevatedButton(
              onPressed: () => controller.logout(), child: const Text("logout"))
        ],
      ),
    );
  }
}

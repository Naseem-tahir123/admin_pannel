import 'package:admin_pannel/utils/app_constants.dart';
import 'package:flutter/material.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contact"),
        centerTitle: true,
        backgroundColor: AppConstants.appMainColor,
      ),
    );
  }
}

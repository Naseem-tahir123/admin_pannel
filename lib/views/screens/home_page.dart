import 'package:admin_pannel/utils/app_constants.dart';
import 'package:admin_pannel/views/widgets/drawer_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Admin Pannel"),
          centerTitle: true,
          backgroundColor: AppConstants.appMainColor),
      drawer: SafeArea(child: DrawerWidget()),
    );
  }
}

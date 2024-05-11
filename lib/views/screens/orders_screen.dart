import 'package:admin_pannel/utils/app_constants.dart';
import 'package:flutter/material.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Orders"),
        centerTitle: true,
        backgroundColor: AppConstants.appMainColor,
      ),
    );
  }
}

import 'package:admin_pannel/utils/app_constants.dart';
import 'package:flutter/material.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(" Categories"),
        centerTitle: true,
        backgroundColor: AppConstants.appMainColor,
      ),
    );
  }
}

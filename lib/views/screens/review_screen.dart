import 'package:admin_pannel/utils/app_constants.dart';
import 'package:flutter/material.dart';

class ReviewsScreen extends StatelessWidget {
  const ReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reviews"),
        centerTitle: true,
        backgroundColor: AppConstants.appMainColor,
      ),
    );
  }
}

import 'package:admin_pannel/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../screens/all_products_screen.dart';
import '../screens/all_users_screen.dart';
import '../screens/categories_screen.dart';
import '../screens/contact_screen.dart';
import '../screens/orders_screen.dart';
import '../screens/review_screen.dart';

class DrawerWidget extends StatelessWidget {
  DrawerWidget({super.key});
  final TextStyle listTextStyle =
      const TextStyle(color: AppConstants.appTextColor);
  final Icon trailingIcon =
      const Icon(Icons.arrow_forward_ios, color: AppConstants.appTextColor);

  final Map<String, IconData> leadingIcons = {
    "Users": Icons.person,
    "Orders": Icons.shopping_bag,
    "Products": Icons.shopping_cart,
    "Categories": Icons.category,
    "Contact": Icons.phone,
    "Reviews": Icons.reviews,
  };
  final Map<String, Widget> routes = {
    'Users': const AllUsersScreen(),
    'Orders': const OrdersScreen(),
    'Products': AllProductsScreen(),
    'Categories': const CategoriesScreen(),
    'Contact': const ContactScreen(),
    'Reviews': const ReviewsScreen(),
  };

  final List<Map<String, String>> drawerItems = [
    {
      "title": "Users",
    },
    {
      "title": "Orders",
    },
    {
      "title": "Products",
    },
    {
      "title": "Categories",
    },
    {
      "title": "Contact",
    },
    {
      "title": "Reviews",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppConstants.appMainColor,
      child: Wrap(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 50),
            child: ListTile(
              title: Text('Naseem Rahi'),
              subtitle: Text("naseem@gmail.com"),
              leading: CircleAvatar(
                backgroundColor: AppConstants.appTextColor,
                child: Text("N"),
              ),
            ),
          ),
          const Divider(
            color: AppConstants.appTextColor,
            thickness: 2,
            indent: 20,
            endIndent: 20,
          ),
          for (var items in drawerItems)
            InkWell(
              onTap: () {
                Get.to(() => routes[items["title"]]!);
              },
              child: ListTile(
                leading: Icon(
                  leadingIcons[items["title"]!],
                  color: AppConstants.appTextColor,
                ),
                title: Text(items["title"]!),
                trailing: trailingIcon,
              ),
            )
        ],
      ),
    );
  }
}

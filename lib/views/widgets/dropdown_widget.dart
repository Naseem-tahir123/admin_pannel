import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/category_controller.dart';

class DropdownWidget extends StatelessWidget {
  const DropdownWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoryController>(
        init: CategoryController(),
        builder: (categoryController) {
          return Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Card(
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButton<String>(
                      value: categoryController.selectedCategoryId?.value,
                      items: categoryController.categories.map((category) {
                        return DropdownMenuItem<String>(
                            value: category["categoryId"],
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      category["categoryImg"].toString()),
                                ),
                                const SizedBox(
                                  width: 20.0,
                                ),
                                Text(category["categoryName"])
                              ],
                            ));
                      }).toList(),
                      onChanged: (String? selectedValue) async {
                        categoryController.setSelectedCategory(selectedValue);
                        String? categoryName = await categoryController
                            .fetchCategoryName(selectedValue);
                        categoryController
                            .setSelectedCategoryName(categoryName);
                      },
                      hint: const Text("Select a Category"),
                      isExpanded: true,
                      elevation: 5,
                      underline: const SizedBox.shrink(),
                    ),
                  ),
                ),
              )
            ],
          );
        });
  }
}

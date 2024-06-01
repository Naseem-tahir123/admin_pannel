// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  RxList<Map<String, dynamic>> categories = <Map<String, dynamic>>[].obs;
  RxString? selectedCategoryId;
  RxString? selectedCategoryName;

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance.collection("categories").get();

      List<Map<String, dynamic>> categoriesList = [];
      querySnapshot.docs
          .forEach((DocumentSnapshot<Map<String, dynamic>> document) {
        categoriesList.add({
          "categoryId": document.id,
          "categoryName": document["categoryName"],
          "categoryImg": document["categoryImg"],
        });
      });
      categories.value = categoriesList;
      print("categories");
      update();

      // for (var document in querySnapshot.docs) {
      //   categoriesList.add({
      //     "categoryId": document.id,
      //     "categoryName": document["categoryName"],
      //     "categoryImg": document["categoryImg"],
      //   });

      // }
    } catch (e) {
      print("error: $e");
    }
  }

  // Set selected Category
  void setSelectedCategory(String? categoryId) {
    selectedCategoryId = categoryId?.obs;
    print("Selected categoryId : $selectedCategoryId");
    update();
  }

  // Fetch Category Name
  Future<String?> fetchCategoryName(String? categoryId) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection("categories")
          .doc(categoryId)
          .get();
      if (snapshot.exists) {
        return snapshot.data()?["categoryName"];
      } else {
        return null;
      }
    } catch (e) {
      print("Error : $e");
      return null;
    }
  }

  // Set Selected Category Name
  void setSelectedCategoryName(String? categoryName) {
    selectedCategoryName = categoryName?.obs;
    print(" Selected category name: $selectedCategoryName");
    update();
  }

  // Set old value of category
  // Set Selected Category Name
  void setOldValue(String? categoryId) {
    selectedCategoryId = categoryId?.obs;
    print(" Selected Category Id: $selectedCategoryId");
    update();
  }
}

import 'package:admin_pannel/models/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

class EditProductController extends GetxController {
  ProductModel productModel;
  //constructor
  EditProductController({required this.productModel});
  RxList<String> images = <String>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getRealTimeImages();
  }

  void getRealTimeImages() {
    FirebaseFirestore.instance
        .collection("products")
        .doc(productModel.productId)
        .snapshots()
        .listen((DocumentSnapshot snapshot) {
      if (snapshot.exists) {
        final data = snapshot.data() as Map<String, dynamic>?;
        if (data != null && data["productImages"] != null) {
          images.value =
              List<String>.from(data["productImages"] as List<dynamic>);
          update();
        }
      }
    });
  }

  // Deleter product image from firestorage
  Future deleteImagesFromStorage(String imageUrl) async {
    final FirebaseStorage firebaseStorage = FirebaseStorage.instance;
    try {
      Reference reference = firebaseStorage.refFromURL(imageUrl);
      await reference.delete();
    } catch (e) {
      print('$e');
    }
  }

  // Deleter Images from firestore
  Future<void> deleteImagesFromCollection(
      String imageUrl, String productId) async {
    try {
      await FirebaseFirestore.instance
          .collection("products")
          .doc(productId)
          .update({
        "productImages": FieldValue.arrayRemove([imageUrl])
      });
      update();
    } catch (e) {
      print('$e');
    }
  }
}

import 'package:admin_pannel/controllers/add_image_controller.dart';
import 'package:admin_pannel/models/product_model.dart';
import 'package:admin_pannel/utils/app_constants.dart';
import 'package:admin_pannel/views/screens/add_product_screen.dart';
import 'package:admin_pannel/views/screens/product_details_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllProductsScreen extends StatelessWidget {
   AllProductsScreen({super.key});
  final AddImageController addImageController = Get.put(AddImageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Products"),
        centerTitle: true,
        backgroundColor: AppConstants.appMainColor,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
                onTap: () {
                  Get.to(() => AddProductScreen());
                },
                child: const Icon(Icons.add)),
          )
        ],
      ),
      body: FutureBuilder(
          future: FirebaseFirestore.instance
              .collection("products")
              .orderBy("createdAt", descending: true)
              .get(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Center(
                  child: Text("Error occured while fetching users"));
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.data!.docs.isEmpty) {
              return const Center(child: Text("No Products found"));
            }
            if (snapshot.data != null) {
              return ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final data = snapshot.data!.docs[index];
                    ProductModel productModel = ProductModel(
                        productId: data["productId"],
                        categoryId: data["categoryId"],
                        productName: data["productName"],
                        categoryName: data["categoryName"],
                        salePrice: data["salePrice"],
                        fullPrice: data["fullPrice"],
                        productImages: data["productImages"],
                        deliveryTime: data["deliveryTime"],
                        isSale: data["isSale"],
                        productDescription: data["productDescription"],
                        createdAt: data["createdAt"],
                        updatedAt: data["updatedAt"]);
                    return Card(
                      elevation: 5,
                      child: ListTile(
                        onTap: () {
                          Get.to(() => ProductsDetailsScreen(
                              productModel: productModel));
                        },
                        leading: CircleAvatar(
                          backgroundColor: AppConstants.appMainColor,
                          backgroundImage: CachedNetworkImageProvider(
                              productModel.productImages[0],
                              errorListener: (err) {
                            print("Error loading image");
                            const Icon(Icons.error);
                          }),
                        ),
                        title: Text(productModel.productName),
                        subtitle: Text(productModel.productId),
                        trailing: const Icon(Icons.arrow_forward_ios),
                      ),
                    );
                  });
            }
            return Container();
          }),
    );
  }
}

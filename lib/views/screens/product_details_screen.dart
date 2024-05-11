import 'package:admin_pannel/models/product_model.dart';
import 'package:admin_pannel/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductsDetailsScreen extends StatelessWidget {
  final ProductModel productModel;
  const ProductsDetailsScreen({super.key, required this.productModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(productModel.productName),
        centerTitle: true,
        backgroundColor: AppConstants.appMainColor,
      ),
      body: Column(
        children: [
          Card(
            elevation: 5,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Product Name: "),
                      Text(productModel.productName)
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Product Description: "),
                      SizedBox(
                        width: Get.width / 2,
                        child: Text(
                          productModel.productDescription,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Product Price: "),
                      Text(productModel.salePrice != ""
                          ? productModel.salePrice
                          : productModel.fullPrice)
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Is Sale: "),
                      Text(productModel.isSale != "" ? "True" : "False")
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Delivery Time: "),
                      Text(productModel.deliveryTime.toString())
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

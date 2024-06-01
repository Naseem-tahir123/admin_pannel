import 'dart:io';

import 'package:admin_pannel/controllers/add_image_controller.dart';
import 'package:admin_pannel/controllers/category_controller.dart';
import 'package:admin_pannel/controllers/is_sale_controller.dart';
import 'package:admin_pannel/models/product_model.dart';
import 'package:admin_pannel/services/generate_ids_services.dart';
import 'package:admin_pannel/views/widgets/text_field_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/app_constants.dart';
import '../widgets/dropdown_widget.dart';

// ignore: must_be_immutable
class AddProductScreen extends StatelessWidget {
  AddProductScreen({super.key});
  final AddImageController addImageController = Get.put(AddImageController());
  final CategoryController categoryController = Get.put(CategoryController());
  final IsSaleController isSaleController = Get.put(IsSaleController());

  TextEditingController productNameController = TextEditingController();
  TextEditingController salePriceController = TextEditingController();
  TextEditingController fullPriceController = TextEditingController();
  TextEditingController deliveryTimeController = TextEditingController();
  TextEditingController productDescriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Products"),
        backgroundColor: AppConstants.appMainColor,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Select Images"),
                  const SizedBox(width: 10),
                  ElevatedButton(
                      onPressed: () {
                        addImageController.showImagesPickerDialog();
                      },
                      child: const Text("Select Images"))
                ],
              ),
            ),

            //  category Images
            GetBuilder<AddImageController>(
                init: AddImageController(),
                builder: (imageController) {
                  return imageController.selectedImages.isNotEmpty
                      ? SizedBox(
                          width: MediaQuery.of(context).size.width - 20,
                          height: Get.height / 5,
                          child: GridView.builder(
                              itemCount: imageController.selectedImages.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2),
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        20.0), // Adjust the radius as needed
                                    image: DecorationImage(
                                      image: FileImage(File(imageController
                                          .selectedImages[index].path)),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  height: Get.height / 5,
                                  width: Get.width / 2,
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        top: 6,
                                        right: 6,
                                        child: InkWell(
                                          onTap: () {
                                            imageController.removeImage(index);
                                            print(imageController
                                                .selectedImages.length);
                                          },
                                          child: const CircleAvatar(
                                            backgroundColor:
                                                AppConstants.appMainColor,
                                            child: Icon(
                                              Icons.close,
                                              color: AppConstants.appTextColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                        )
                      : const SizedBox.shrink();
                }),
            //  category dropdown
            const DropdownWidget(),

            // isSale toggele
            GetBuilder<IsSaleController>(
                init: IsSaleController(),
                builder: (isSaleController) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Is Sale : "),
                            Switch(
                                activeColor: AppConstants.appMainColor,
                                value: isSaleController.isSale.value,
                                onChanged: (value) {
                                  isSaleController.isSaleToggle(value);
                                })
                          ],
                        ),
                      ),
                    ),
                  );
                }),

            // Form
            const SizedBox(
              height: 10,
            ),
            TextFields(
              text: "Product Name",
              controller: productNameController,
            ),
            Obx(() {
              return isSaleController.isSale.value
                  ? TextFields(
                      text: "Sale Price", controller: salePriceController)
                  : const SizedBox.shrink();
            }),
            TextFields(
              text: "Full Price",
              controller: fullPriceController,
            ),
            TextFields(
              text: "Delivery Time",
              controller: deliveryTimeController,
            ),
            TextFields(
              text: "Description",
              controller: productDescriptionController,
            ),
            ElevatedButton(
                onPressed: () async {
                  // String productId = GenerateIds().generateProductId();
                  // print(productId);
                  try {
                    await addImageController
                        .uploadFuction(addImageController.selectedImages);
                    print(addImageController.arrImagesUrl);
                    String productId = GenerateIds().generateProductId();
                    ProductModel productModel = ProductModel(
                        productId: productId,
                        categoryId:
                            categoryController.selectedCategoryId.toString(),
                        productName: productNameController.text.trim(),
                        categoryName:
                            categoryController.selectedCategoryName.toString(),
                        salePrice: salePriceController.text != ""
                            ? salePriceController.text.trim()
                            : "",
                        fullPrice: fullPriceController.text.trim(),
                        productImages: addImageController.arrImagesUrl,
                        deliveryTime: deliveryTimeController.text.trim(),
                        isSale: isSaleController.isSale.value,
                        productDescription:
                            productDescriptionController.text.trim(),
                        createdAt: DateTime.now(),
                        updatedAt: DateTime.now());
                    await FirebaseFirestore.instance
                        .collection("products")
                        .doc(productId)
                        .set(productModel.toMap());
                  } catch (e) {
                    print("$e");
                  }
                },
                child: const Text("Upload"))
          ],
        ),
      ),
    );
  }
}

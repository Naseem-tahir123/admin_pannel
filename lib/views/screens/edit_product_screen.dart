import 'package:admin_pannel/controllers/edit_product_controller.dart';
import 'package:admin_pannel/models/product_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/category_controller.dart';
import '../../controllers/is_sale_controller.dart';
import '../../utils/app_constants.dart';

// ignore: must_be_immutable
class EditProductScreen extends StatelessWidget {
  ProductModel productModel;
  EditProductScreen({super.key, required this.productModel});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditProductController>(
        init: EditProductController(productModel: productModel),
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Edit Product ${productModel.productName}"),
              centerTitle: true,
            ),
            body: Container(
              child: Column(
                children: [
                  SingleChildScrollView(
                      child: SizedBox(
                    width: MediaQuery.of(context).size.width - 20,
                    height: Get.height / 5,
                    child: GridView.builder(
                        itemCount: controller.images.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 2,
                                crossAxisSpacing: 2),
                        itemBuilder: (BuildContext context, int index) {
                          return Stack(
                            children: [
                              CachedNetworkImage(
                                imageUrl: controller.images[index],
                                fit: BoxFit.contain,
                                height: Get.height / 5.5,
                                width: Get.width / 2,
                                placeholder: (context, url) => const Center(
                                  child: CupertinoActivityIndicator(),
                                ),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                              Positioned(
                                top: 6,
                                right: 6,
                                child: InkWell(
                                  onTap: () async {
                                    await controller.deleteImagesFromStorage(
                                        controller.images[index].toString());
                                    controller.deleteImagesFromCollection(
                                        controller.images[index].toString(),
                                        productModel.productId);
                                    // EasyLoading.dismiss();
                                  },
                                  child: const CircleAvatar(
                                    backgroundColor: AppConstants.appMainColor,
                                    child: Icon(
                                      Icons.close,
                                      color: AppConstants.appTextColor,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }),
                  )),
                  GetBuilder<CategoryController>(
                      init: CategoryController(),
                      builder: (categoryController) {
                        return Column(
                          children: [
                            Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Card(
                                elevation: 10,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: DropdownButton<String>(
                                    value: categoryController
                                        .selectedCategoryId?.value,
                                    items: categoryController.categories
                                        .map((category) {
                                      return DropdownMenuItem<String>(
                                          value: category["categoryId"],
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              CircleAvatar(
                                                backgroundImage: NetworkImage(
                                                    category["categoryImg"]
                                                        .toString()),
                                              ),
                                              const SizedBox(
                                                width: 20.0,
                                              ),
                                              Text(category["categoryName"])
                                            ],
                                          ));
                                    }).toList(),
                                    onChanged: (String? selectedValue) async {
                                      categoryController
                                          .setSelectedCategory(selectedValue);
                                      String? categoryName =
                                          await categoryController
                                              .fetchCategoryName(selectedValue);
                                      categoryController
                                          .setSelectedCategoryName(
                                              categoryName);
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
                      }),

                  // is sale old value
                  GetBuilder<IsSaleController>(
                      init: IsSaleController(),
                      builder: (isSaleController) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                ],
              ),
            ),
          );
        });
  }
}

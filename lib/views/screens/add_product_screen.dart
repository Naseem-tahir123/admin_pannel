import 'dart:io';

import 'package:admin_pannel/controllers/add_image_controller.dart';
import 'package:admin_pannel/controllers/category_controller.dart';
import 'package:admin_pannel/controllers/is_sale_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/app_constants.dart';
import '../widgets/dropdown_widget.dart';

class AddProductScreen extends StatelessWidget {
  AddProductScreen({super.key});
  final AddImageController addImageController = Get.put(AddImageController());
  final CategoryController categoryController = Get.put(CategoryController());
  final IsSaleController isSaleController = Get.put(IsSaleController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Products"),
        backgroundColor: AppConstants.appMainColor,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
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
                })
          ],
        ),
      ),
    );
  }
}

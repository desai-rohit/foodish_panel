import 'dart:io';

import 'package:flutter/material.dart';
import 'package:food_app_panel/const.dart';
import 'package:food_app_panel/pages/additem/additem_provider.dart';
import 'package:food_app_panel/pages/user/userprovider.dart';
import 'package:food_app_panel/services/api_services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddItem extends StatefulWidget {
  const AddItem({super.key});

  @override
  State<AddItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<UserProvider>(context, listen: false)
          .getRestaurantWonerData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final namefocus = FocusNode();
    final pricefocus = FocusNode();
    final desfocus = FocusNode();

    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    return Consumer<AddItemProvider>(
      builder: (context, value, child) {
        return Scaffold(
          appBar: AppBar(),
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  GestureDetector(
                      onTap: () async {
                        XFile? pickedFile = await ImagePicker().pickImage(
                          source: ImageSource.gallery,
                          maxWidth: 1800,
                          maxHeight: 1800,
                        );
                        if (pickedFile != null) {
                          //value.imageFile = File(pickedFile.path);
                          value.imagepickFile(File(pickedFile.path));
                        }
                      },
                      child: value.imageFile != null
                          ? Image.file(
                              value.imageFile!,
                              width: 350,
                              height: 250,
                              filterQuality: FilterQuality.medium,
                            )
                          : Image.asset(
                              "assets/add_image.png",
                              width: 150,
                              height: 150,
                              cacheHeight: 500,
                              cacheWidth: 500,
                            )),
                  const SizedBox(
                    height: 24,
                  ),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    focusNode: namefocus,
                    onFieldSubmitted: (v) {
                      FocusScope.of(context).requestFocus(pricefocus);
                    },
                    controller: value.foodNameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text("Food Name"),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    focusNode: pricefocus,
                    onFieldSubmitted: (v) {
                      FocusScope.of(context).requestFocus(desfocus);
                    },
                    controller: value.foodPriceController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text("Price"),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    textInputAction: TextInputAction.done,
                    focusNode: desfocus,
                    onFieldSubmitted: (v) {
                      FocusScope.of(context).unfocus();
                    },
                    controller: value.foodDesController,
                    maxLines: 10,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text("Descripation"),
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: ElevatedButton(
                          onPressed: () {
                            value.isloading == true
                                ? const Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : value
                                    .uploadImage(value.imageFile!.path)
                                    .then((v) {
                                    postItem(
                                            foodname:
                                                value.foodNameController.text,
                                            price:
                                                value.foodPriceController.text,
                                            des: value.foodDesController.text,
                                            gmail: currentEmail,
                                            restautantName: userProvider
                                                .restaurantWonerData[0]
                                                .restaurantName)
                                        .then((v) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content: Text(
                                                  "Products Add Successfully")));

                                      value.foodNameController.clear();
                                      value.foodPriceController.clear();
                                      value.foodDesController.clear();
                                      value.imageFile = null;
                                    });
                                  });
                          },
                          child: const Text("Add Item"))),
                  const SizedBox(
                    height: 100,
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

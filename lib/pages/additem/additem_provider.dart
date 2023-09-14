import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class AddItemProvider extends ChangeNotifier {
  bool isloading = false;
  TextEditingController foodNameController = TextEditingController();
  TextEditingController foodPriceController = TextEditingController();
  TextEditingController foodDesController = TextEditingController();

  File? imageFile;

  imagepickFile(image) async {
    imageFile = image;
    // ? Image.file(imageFile!)
    // : Image.asset("assets/burgar.png");
    notifyListeners();
  }

  Future<bool> uploadImage(String filename) async {
    isloading == true;
    var request = http.MultipartRequest("POST",
        Uri.parse("https://food-api-sable.vercel.app/productsuploadimg"));

    if (filename.isNotEmpty) {
      http.MultipartFile singleFile = await http.MultipartFile.fromPath(
          'image', filename,
          contentType: MediaType('image', 'jpeg'));

      request.files.add(singleFile);
    }
    var res = await request.send();

    if (res.statusCode == 200) {
      isloading == false;
      return true;
    } else {
      isloading == false;
      return false;
    }
  }
}

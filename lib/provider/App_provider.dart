import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:food_app_panel/model/order_model.dart';
import 'package:food_app_panel/model/products_model.dart';
import 'package:food_app_panel/model/restaurant_model.dart';
import 'package:food_app_panel/pages/bottom_nav.dart';
import 'package:food_app_panel/services/api_services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class AppProvider extends ChangeNotifier {
  TextEditingController nameController = TextEditingController();
  TextEditingController restautantNameController = TextEditingController();
  TextEditingController gmailController = TextEditingController();
  TextEditingController passworController = TextEditingController();

  TextEditingController loginGmailController = TextEditingController();
  TextEditingController loginPassworController = TextEditingController();

  List<RestaurantModel> restaurantList = [];

  String? finalEmail;

  TextEditingController foodNameController = TextEditingController();
  TextEditingController foodPriceController = TextEditingController();
  TextEditingController foodDesController = TextEditingController();

  TextEditingController areaController = TextEditingController();
  TextEditingController landmarkController = TextEditingController();

  TextEditingController productsNameUpdateController = TextEditingController();
  TextEditingController productsdesUpdateController = TextEditingController();
  TextEditingController productspriceUpdateController = TextEditingController();

  TextEditingController userNameController = TextEditingController();
  TextEditingController userGmailController = TextEditingController();
  TextEditingController userRestaurantNameController = TextEditingController();
  TextEditingController userPasswordController = TextEditingController();

  File? imageFile;

  List<OrderModel> data = [];

  final _apiServices = ApiServices();
  List<Products> _products = [];
  bool isloading = false;
  List<Products> get prodcutsData => _products;

  List<RestaurantModel> _restaurantWoner = [];
  List<RestaurantModel> get restaurantWonerData => _restaurantWoner;

  List<OrderModel> _order = [];
  List<OrderModel> get orderData => _order;

  StreamController<List<OrderModel>> streamController =
      StreamController<List<OrderModel>>();

  getemail(email) {
    finalEmail = email;
    notifyListeners();
  }

  userloginSharedPrefrance(context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("email", loginGmailController.text).then(
          (value) => Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const BottomNav())),
        );
    notifyListeners();
  }

  imagepickFile(image) async {
    imageFile = image;
    // ? Image.file(imageFile!)
    // : Image.asset("assets/burgar.png");
    notifyListeners();
  }

  newOrderUpdate(id) {
    isloading = true;
    orderUpdate(
      id: id,
      gmail: finalEmail.toString(),
      orderaccepted: true,
      ordership: false,
    ).then((value) => getOrderData());
    isloading = false;
    notifyListeners();
  }

  shipOrderUpdate(id) {
    isloading = true;
    orderUpdate(
      id: id,
      gmail: finalEmail.toString(),
      orderaccepted: true,
      ordership: true,
    ).then((value) => getOrderData());
    isloading = false;
    notifyListeners();
  }

  Future<void> getAllProducts() async {
    isloading = true;
    notifyListeners();
    final response = await _apiServices.getProducts(finalEmail);
    _products = response;
    isloading = false;
    notifyListeners();
  }

  Future<void> getRestaurantWonerData() async {
    isloading = true;
    notifyListeners();
    final response = await _apiServices.getRestaurantWoner(finalEmail);
    _restaurantWoner = response;
    isloading = false;
    notifyListeners();
  }

  Future<void> getOrderData() async {
    isloading = true;
    notifyListeners();
    final response = await _apiServices.getOrders(finalEmail);
    _order = response;
    isloading = false;
    streamController.sink.add(orderData);
    data;
    notifyListeners();
  }

  // getOrders() async {
  //   var res =
  //       await http.get(Uri.parse("https://food-api-sable.vercel.app/order/$finalEmail"));
  //   if (res.statusCode == 200) {
  //     var orderdata = orderModelFromJson(res.body.toString());
  //     streamController.sink.add(orderdata);
  //     data = orderdata;
  //     return data;
  //   }
  //   notifyListeners();
  // }

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

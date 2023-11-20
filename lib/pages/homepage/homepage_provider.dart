import 'package:flutter/material.dart';
import 'package:food_app_panel/const.dart';
import 'package:food_app_panel/model/products_model.dart';
import 'package:food_app_panel/pages/homepage/homepage_services.dart';

class HomePageProvider extends ChangeNotifier {
  bool isloading = false;

  final homepageService = HomePageService();

  List<Products> _products = [];

  List<Products> get prodcutsData => _products;

  Future<void> getAllProducts() async {
    isloading = true;
    notifyListeners();
    final response = await homepageService.getProducts(currentEmail);
    _products = response;
    isloading = false;
    notifyListeners();
  }

  Future<void> getcategoryProducts(
      {required String gmail, String? category}) async {
    isloading = true;
    notifyListeners();
    final response = await homepageService.getcategoryProductsList(
        gmail: gmail, category: category);
    _products = response;
    isloading = false;
    prodcutsData;
    notifyListeners();
  }
}

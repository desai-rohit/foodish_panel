import 'package:flutter/material.dart';
import 'package:food_app_panel/const.dart';
import 'package:food_app_panel/model/restaurant_model.dart';
import 'package:food_app_panel/pages/bottom_nav.dart';
import 'package:food_app_panel/services/api_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider extends ChangeNotifier {
  bool isloading = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController restautantNameController = TextEditingController();
  TextEditingController gmailController = TextEditingController();
  TextEditingController passworController = TextEditingController();

  TextEditingController loginGmailController = TextEditingController();
  TextEditingController loginPassworController = TextEditingController();

  List<RestaurantModel> _restaurantWoner = [];
  List<RestaurantModel> get restaurantWonerData => _restaurantWoner;

  final _apiServices = ApiServices();

  List<RestaurantModel> restaurantList = [];

  userloginSharedPrefrance(context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("email", loginGmailController.text).then(
          (value) => Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const BottomNav())),
        );
    notifyListeners();
  }

  Future<void> getRestaurantWonerData() async {
    isloading = true;
    notifyListeners();
    final response = await _apiServices.getRestaurantWoner(currentEmail);
    _restaurantWoner = response;
    isloading = false;
    notifyListeners();
  }
}

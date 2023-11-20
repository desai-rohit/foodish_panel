import 'package:flutter/material.dart';
import 'package:food_app_panel/const.dart';
import 'package:food_app_panel/model/restaurant_model.dart';
import 'package:food_app_panel/pages/user/user_services.dart';
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

  final userService = UserService();

  List<RestaurantModel> restaurantList = [];

  userloginSharedPrefrance(context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("email", loginGmailController.text);
      
    notifyListeners();
  }

  Future<void> getRestaurantWonerData() async {
    isloading = true;
    notifyListeners();
    final response = await userService.getRestaurantWoner(currentEmail);
    _restaurantWoner = response;
    isloading = false;
    notifyListeners();
  }

  Future<void> userloginprovider(gmail,password, context) async {
  isloading = true;
  notifyListeners();
   userService.userlogin(gmail: gmail, password: password,context: context);
    isloading = false;
    notifyListeners();
  }
}

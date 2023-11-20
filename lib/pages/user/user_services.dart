import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:food_app_panel/comman/urls.dart';
import 'package:food_app_panel/const.dart';
import 'package:food_app_panel/model/restaurant_model.dart';
import 'package:food_app_panel/pages/bottom_nav.dart';
import 'package:food_app_panel/pages/user/loginpage.dart';
import 'package:food_app_panel/pages/user/userprovider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';


class UserService{

    Future<List<RestaurantModel>> getRestaurantWoner(email) async {
    var res = await http
        .get(Uri.parse("$apilink/restaurant/$email"));
    if (res.statusCode == 200) {
      var data = restaurantModelFromJson(res.body.toString());
      return data;
    }
    return [];
  }

  Future<Object> userlogin(
    {required String gmail, required String password, context}) async {
  var response = await http.post(
    Uri.parse('$apilink/restaurantlogin'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      "gmail": gmail,
      'password': password,
    }),
  );
  if (response.statusCode == 200) {
    Provider.of<UserProvider>(context, listen: false)
        .userloginSharedPrefrance(context);
        getcurrentEmail();
    return Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const BottomNav()));
  } else if (response.statusCode == 400) {
    return ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("worng password")));
  } else {
    return ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("worng email and password")));
  }
}

Future<Object> usersignup(
    {String? ownersName,
    String? gmail,
    String? restautantName,
    String? password,
    required context}) async {
  var response = await http.post(
    Uri.parse('$apilink/restaurantsignup'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      'ownersName': ownersName,
      'restaurantName': restautantName,
      "openTimeing": "String",
      "closeTimeing": "String",
      'gmail': gmail,
      "password": password,
      "address": [
        {
          "lat": "lat",
          "lng": "lng",
          "area": "area",
          "nearbyLandmark": "landmark"
        }
      ]
    }),
  );
  if (response.body == "user already exists") {
    return ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("User Already exists")));
  } else {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const LoginPage()));
    return ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("User Create Successfully")));
  }
}
}
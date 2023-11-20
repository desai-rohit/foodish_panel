// import 'dart:convert';
// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:food_app_panel/const.dart';
// import 'package:food_app_panel/model/order_modelcopy.dart';
// import 'package:food_app_panel/model/order_model.dart';
// import 'package:food_app_panel/model/products_model.dart';
// import 'package:food_app_panel/model/restaurant_model.dart';
// import 'package:food_app_panel/pages/bottom_nav.dart';
// import 'package:food_app_panel/pages/user/loginpage.dart';
// import 'package:food_app_panel/pages/user/userprovider.dart';
// import 'package:http/http.dart' as http;
// import 'package:http_parser/http_parser.dart';
// import 'package:provider/provider.dart';

// Future<http.Response> restaurantWoners({
//   String? ownersName,
//   String? gmail,
//   String? restautantName,
//   String? password,
// }) async {
//   return await http.post(
//     Uri.parse('$apilink/restaurantOwnersCreate'),
//     headers: <String, String>{
//       'Content-Type': 'application/json; charset=UTF-8',
//     },
//     body: jsonEncode(<String, dynamic>{
//       'ownersName': ownersName,
//       'restaurantName': restautantName,
//       "openTimeing": "String",
//       "closeTimeing": "String",
//       'gmail': gmail,
//       "password": password,
//       "address": [
//         {
//           "lat": "lat",
//           "lng": "lng",
//           "area": "area",
//           "nearbyLandmark": "landmark"
//         }
//       ]
//     }),
//   );
// }

// Future<http.Response> postItem({
//   String? foodname,
//   String? price,
//   String? gmail,
//   String? restautantName,
//   String? des,
//   String?category
// }) async {
//   return await http.post(
//     Uri.parse('$apilink/additem'),
//     headers: <String, String>{
//       'Content-Type': 'application/json; charset=UTF-8',
//     },
//     body: jsonEncode(<String, dynamic>{
//       'foodName': foodname,
//       'price': price,
//       "restuarantName": restautantName,
//       'gmail': gmail,
//       "des": des,
//       "category":category
//     }),
//   );
// }

// Future<http.Response> updateUsername({
//   required String gmail,
//   String? ownersName,
//   String? restaurantName,
// }) async {
//   return await http.put(
//     Uri.parse('$apilink/wonerupdate/$gmail'),
//     headers: <String, String>{
//       'Content-Type': 'application/json; charset=UTF-8',
//     },
//     body: jsonEncode(<String, dynamic>{
//       "ownersName": ownersName,
//       "restaurantName": restaurantName,
//     }),
//   );
// }

// uploadImage(String filename) async {
//   var request = http.MultipartRequest(
//       'POST', Uri.parse("$apilink/upload"));
//   request.files.add(await http.MultipartFile.fromPath('user_file', filename));
//   var res = await request.send();
//   print(res);
// }

//Future<http.StreamedResponse>
// Future<bool> uploadImage(String filename) async {
//   var request = http.MultipartRequest(
//       "POST", Uri.parse("$apilink/productsuploadimg"));

//   if (filename.isNotEmpty) {
//     http.MultipartFile singleFile = await http.MultipartFile.fromPath(
//         'image', filename,
//         contentType: MediaType('image', 'jpeg'));

//     request.files.add(singleFile);
//   }
//   var res = await request.send();

//   if (res.statusCode == 200) {
//     return true;
//   } else {
//     return false;
//   }
// }

// uploadFile(Uri filename) async {
//   var postUri =
//       Uri.parse("$apilink/productsuploadimg");
//   var request = http.MultipartRequest("POST", postUri);
//   //request.fields['user'] = 'blah';
//   request.files.add(http.MultipartFile.fromBytes(
//       'image', await File.fromUri(filename).readAsBytes(),
//       contentType: MediaType('image', 'jpeg')));

//   request.send().then((response) {
//     if (response.statusCode == 200) {}
//   });
// }

// Future<http.Response> orderUpdate(
//     {required String gmail,
//     bool? orderaccepted,
//     bool? ordership,
//     required String id}) async {
//   return await http.put(
//     Uri.parse('$apilink/order/$gmail&$id'),
//     headers: <String, String>{
//       'Content-Type': 'application/json; charset=UTF-8',
//     },
//     body: jsonEncode(<String, dynamic>{
//       "orderaccepted": orderaccepted,
//       "ordership": ordership
//     }),
//   );
// }

class ApiServices {
  // Future<List<Products>> getProducts(email) async {
  //   var res = await http
  //       .get(Uri.parse("$apilink/products/$email"));
  //   if (res.statusCode == 200) {
  //     var data = productsFromJson(res.body.toString());
  //     return data;
  //   }
  //   return [];
  // }

  // Future<List<RestaurantModel>> getRestaurantWoner(email) async {
  //   var res = await http
  //       .get(Uri.parse("$apilink/restaurant/$email"));
  //   if (res.statusCode == 200) {
  //     var data = restaurantModelFromJson(res.body.toString());
  //     return data;
  //   }
  //   return [];
  // }

  
  // Future<List<OrderModel>> getOrders(email) async {
  //   var res = await http
  //       .get(Uri.parse("$apilink/order/$email"));
  //   if (res.statusCode == 200) {
  //     var data = orderModelFromJson(res.body.toString());
  //     return data;
  //   }
  //   return [];
  // }




  // Stream<List<OrderModelCopy>> getOrderslist(email) async* {
  //   var res = await http
  //       .get(Uri.parse("$apilink/order/$email"));
  //   if (res.statusCode == 200) {
  //     var data = orderModelcopyFromJson(res.body.toString());
  //     yield data;
  //   }
  //  // yield [];
  // }

  // Future<List<Products>> getcategoryProductsList(
  //     {String? gmail, String? category}) async {
  //   var res = await http.get(Uri.parse(
  //       "$apilink/products/$gmail&$category"));
  //   if (res.statusCode == 200) {
  //     var data = productsFromJson(res.body.toString());
  //     return data;
  //   }
  //   return [];
  // }
}

// Future<Products> productUpdate(
//     {required String id, String? foodName, String? des, String? price}) async {
//   final response = await http.put(
//     Uri.parse('$apilink/productsUpdate/$id'),
//     headers: <String, String>{
//       'Content-Type': 'application/json; charset=UTF-8',
//     },
//     body: jsonEncode(
//         <String, dynamic>{"foodName": foodName, "des": des, "price": price}),
//   );
//   if (response.statusCode == 200) {
//     return Products.fromJson(jsonDecode(response.body));
//   } else {
//     throw Exception('Failed to update album.');
//   }
// }

// Future<http.Response> updateUser(
//     {required String gmail,
//     String? lat,
//     String? lng,
//     String? flat,
//     String? area,
//     String? landmark}) async {
//   return await http.put(
//     Uri.parse('$apilink/wonerupdate/$gmail'),
//     headers: <String, String>{
//       'Content-Type': 'application/json; charset=UTF-8',
//     },
//     body: jsonEncode(<String, dynamic>{
//       "address": [
//         {
//           "lat": lat,
//           "lng": lng,
//           "flatHouseNo": flat,
//           "area": area,
//           "nearbyLandmark": landmark
//         }
//       ]
//     }),
//   );
// }

// Future<Object> userlogin(
//     {required String gmail, required String password, context}) async {
//   var response = await http.post(
//     Uri.parse('$apilink/restaurantlogin'),
//     headers: <String, String>{
//       'Content-Type': 'application/json; charset=UTF-8',
//     },
//     body: jsonEncode(<String, String>{
//       "gmail": gmail,
//       'password': password,
//     }),
//   );
//   if (response.statusCode == 200) {
//     Provider.of<UserProvider>(context, listen: false)
//         .userloginSharedPrefrance(context);
//         getcurrentEmail();
//     return Navigator.pushReplacement(
//         context, MaterialPageRoute(builder: (context) => const BottomNav()));
//   } else if (response.statusCode == 400) {
//     return ScaffoldMessenger.of(context)
//         .showSnackBar(const SnackBar(content: Text("worng password")));
//   } else {
//     return ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("worng email and password")));
//   }
// }

// Future<Object> usersignup(
//     {String? ownersName,
//     String? gmail,
//     String? restautantName,
//     String? password,
//     required context}) async {
//   var response = await http.post(
//     Uri.parse('$apilink/restaurantsignup'),
//     headers: <String, String>{
//       'Content-Type': 'application/json; charset=UTF-8',
//     },
//     body: jsonEncode(<String, dynamic>{
//       'ownersName': ownersName,
//       'restaurantName': restautantName,
//       "openTimeing": "String",
//       "closeTimeing": "String",
//       'gmail': gmail,
//       "password": password,
//       "address": [
//         {
//           "lat": "lat",
//           "lng": "lng",
//           "area": "area",
//           "nearbyLandmark": "landmark"
//         }
//       ]
//     }),
//   );
//   if (response.body == "user already exists") {
//     return ScaffoldMessenger.of(context)
//         .showSnackBar(const SnackBar(content: Text("User Already exists")));
//   } else {
//     Navigator.pushReplacement(
//         context, MaterialPageRoute(builder: (context) => const LoginPage()));
//     return ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("User Create Successfully")));
//   }
// }

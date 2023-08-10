import 'dart:convert';
import 'dart:io';

import 'package:food_app_panel/model/order_model.dart';
import 'package:food_app_panel/model/products_model.dart';
import 'package:food_app_panel/model/restaurant_model.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

Future<http.Response> restaurantWoners({
  String? ownersName,
  String? gmail,
  String? restautantName,
  String? password,
}) async {
  return await http.post(
    Uri.parse('https://food-api-sable.vercel.app/restaurantOwnersCreate'),
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
}

getRestaurantWoners() async {
  try {
    var res = await http
        .get(Uri.parse("https://food-api-sable.vercel.app/restaurantList"));
    if (res.statusCode == 200) {
      var data = restaurantModelFromJson(res.body.toString());
      return data;
    } else {
      print("error");
    }
  } catch (error) {
    throw Exception('Failed to update album.');
  }
}

Future<http.Response> postItem({
  String? foodname,
  String? price,
  String? gmail,
  String? restautantName,
  String? des,
}) async {
  return await http.post(
    Uri.parse('https://food-api-sable.vercel.app/additem'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      'foodName': foodname,
      'price': price,
      "restuarantName": restautantName,
      'gmail': gmail,
      "des": des,
    }),
  );
}

Future<http.Response> updateUsername({
  required String gmail,
  String? ownersName,
  String? restaurantName,
}) async {
  return await http.put(
    Uri.parse('https://food-api-sable.vercel.app/wonerupdate/$gmail'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      "ownersName": ownersName,
      "restaurantName": restaurantName,
    }),
  );
}

// uploadImage(String filename) async {
//   var request = http.MultipartRequest(
//       'POST', Uri.parse("https://food-api-sable.vercel.app/upload"));
//   request.files.add(await http.MultipartFile.fromPath('user_file', filename));
//   var res = await request.send();
//   print(res);
// }

//Future<http.StreamedResponse>
Future<bool> uploadImage(String filename) async {
  var request = http.MultipartRequest(
      "POST", Uri.parse("https://food-api-sable.vercel.app/productsuploadimg"));

  if (filename.isNotEmpty) {
    http.MultipartFile singleFile = await http.MultipartFile.fromPath(
        'image', filename,
        contentType: MediaType('image', 'jpeg'));

    request.files.add(singleFile);
  }
  var res = await request.send();

  if (res.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}

uploadFile(Uri filename) async {
  var postUri =
      Uri.parse("https://food-api-sable.vercel.app/productsuploadimg");
  var request = http.MultipartRequest("POST", postUri);
  //request.fields['user'] = 'blah';
  request.files.add(http.MultipartFile.fromBytes(
      'image', await File.fromUri(filename).readAsBytes(),
      contentType: MediaType('image', 'jpeg')));

  request.send().then((response) {
    if (response.statusCode == 200) print("Uploaded!");
  });
}

Future<http.Response> orderUpdate(
    {required String gmail,
    bool? orderaccepted,
    bool? ordership,
    required String id}) async {
  return await http.put(
    Uri.parse('https://food-api-sable.vercel.app/order/$gmail&$id'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      "orderaccepted": orderaccepted,
      "ordership": ordership
    }),
  );
}

class ApiServices {
  Future<List<Products>> getProducts(email) async {
    var res = await http
        .get(Uri.parse("https://food-api-sable.vercel.app/products/$email"));
    if (res.statusCode == 200) {
      var data = productsFromJson(res.body.toString());
      return data;
    }
    return [];
  }

  Future<List<RestaurantModel>> getRestaurantWoner(email) async {
    var res = await http
        .get(Uri.parse("https://food-api-sable.vercel.app/restaurant/$email"));
    if (res.statusCode == 200) {
      var data = restaurantModelFromJson(res.body.toString());
      return data;
    }
    return [];
  }

  Future<List<OrderModel>> getOrders(email) async {
    var res = await http
        .get(Uri.parse("https://food-api-sable.vercel.app/order/$email"));
    if (res.statusCode == 200) {
      var data = orderModelFromJson(res.body.toString());
      return data;
    }
    return [];
  }
}

Future<Products> productUpdate(
    {required String id, String? foodName, String? des, String? price}) async {
  final response = await http.put(
    Uri.parse('https://food-api-sable.vercel.app/productsUpdate/$id'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(
        <String, dynamic>{"foodName": foodName, "des": des, "price": price}),
  );
  if (response.statusCode == 200) {
    return Products.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to update album.');
  }
}

Future<http.Response> updateUser(
    {required String gmail,
    String? lat,
    String? lng,
    String? flat,
    String? area,
    String? landmark}) async {
  return await http.put(
    Uri.parse('https://food-api-sable.vercel.app/wonerupdate/$gmail'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      "address": [
        {
          "lat": lat,
          "lng": lng,
          "flatHouseNo": flat,
          "area": area,
          "nearbyLandmark": landmark
        }
      ]
    }),
  );
}

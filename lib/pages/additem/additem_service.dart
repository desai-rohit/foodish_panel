import 'dart:convert';

import 'package:food_app_panel/comman/urls.dart';
import 'package:http/http.dart' as http;

class AdditemService{

  Future<http.Response> postItem({
  String? foodname,
  String? price,
  String? gmail,
  String? restautantName,
  String? des,
  String?category
}) async {
  return await http.post(
    Uri.parse('$apilink/additem'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      'foodName': foodname,
      'price': price,
      "restuarantName": restautantName,
      'gmail': gmail,
      "des": des,
      "category":category
    }),
  );
}
}
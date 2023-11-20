import 'dart:convert';

import 'package:food_app_panel/comman/urls.dart';
import 'package:food_app_panel/model/products_model.dart';
import 'package:http/http.dart' as http;


class UpdateproductService{

  Future<Products> productUpdate(
    {required String id, String? foodName, String? des, String? price}) async {
  final response = await http.put(
    Uri.parse('$apilink/productsUpdate/$id'),
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
}
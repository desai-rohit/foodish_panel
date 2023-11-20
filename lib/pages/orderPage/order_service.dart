import 'dart:convert';
import 'package:food_app_panel/comman/urls.dart';
import 'package:food_app_panel/model/order_model.dart';
import 'package:food_app_panel/model/order_modelcopy.dart';
import 'package:http/http.dart' as http;


class OrderService{
  Future<http.Response> orderUpdate(
    {required String gmail,
    bool? orderaccepted,
    bool? ordership,
    required String id}) async {
  return await http.put(
    Uri.parse('$apilink/order/$gmail&$id'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      "orderaccepted": orderaccepted,
      "ordership": ordership
    }),
  );
}
  Future<List<OrderModel>> getOrders(email) async {
    var res = await http
        .get(Uri.parse("$apilink/order/$email"));
    if (res.statusCode == 200) {
      var data = orderModelFromJson(res.body.toString());
      return data;
    }
    return [];
  }

  Stream<List<OrderModelCopy>> getOrderslist(email) async* {
    var res = await http
        .get(Uri.parse("$apilink/order/$email"));
    if (res.statusCode == 200) {
      var data = orderModelcopyFromJson(res.body.toString());
      yield data;
    }
   // yield [];
  }
}
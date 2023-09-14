import 'dart:async';

import 'package:flutter/material.dart';
import 'package:food_app_panel/const.dart';
import 'package:food_app_panel/model/order_model.dart';
import 'package:food_app_panel/services/api_services.dart';

class OrderPageProvider extends ChangeNotifier {
  List<OrderModel> data = [];
  final _apiServices = ApiServices();
  bool isloading = false;

  List<OrderModel> _order = [];
  List<OrderModel> get orderData => _order;

  StreamController<List<OrderModel>> streamController =
      StreamController<List<OrderModel>>();

  Future<void> getOrderData() async {
    isloading = true;
    notifyListeners();
    final response = await _apiServices.getOrders(currentEmail);
    _order = response;
    isloading = false;
    streamController.sink.add(orderData);
    data;
    notifyListeners();
  }

  newOrderUpdate(id) {
    isloading = true;
    orderUpdate(
      id: id,
      gmail: currentEmail!,
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
      gmail: currentEmail!,
      orderaccepted: true,
      ordership: true,
    ).then((value) => getOrderData());
    isloading = false;
    notifyListeners();
  }
}

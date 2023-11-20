import 'dart:async';

import 'package:flutter/material.dart';
import 'package:food_app_panel/const.dart';
import 'package:food_app_panel/model/order_model.dart';
import 'package:food_app_panel/pages/orderPage/order_service.dart';

class OrderPageProvider extends ChangeNotifier {
  // List<OrderModel> data = [];
  final orderService = OrderService();
  bool isloading = false;

  List<OrderModel> _order = [];
  List<OrderModel> get orderData => _order;

  // StreamController<List<OrderModel>> streamController =
  //     StreamController<List<OrderModel>>();



    Future<void> getOrderData() async {
    isloading = true;
    notifyListeners();
    final response = await orderService.getOrders(currentEmail);
    _order = response;
    isloading = false;
    // streamController.sink.add(orderData);
    // data;
    notifyListeners();
  }

  newOrderUpdate(id) {
    isloading = true;
    OrderService().orderUpdate(
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
   OrderService().orderUpdate(
      id: id,
      gmail: currentEmail!,
      orderaccepted: true,
      ordership: true,
    ).then((value) => getOrderData());
    isloading = false;
    notifyListeners();
  }
}

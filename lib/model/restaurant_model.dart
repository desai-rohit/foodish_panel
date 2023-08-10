// To parse this JSON data, do
//
//     final restaurantModel = restaurantModelFromJson(jsonString);

import 'dart:convert';

List<RestaurantModel> restaurantModelFromJson(String str) =>
    List<RestaurantModel>.from(
        json.decode(str).map((x) => RestaurantModel.fromJson(x)));

String restaurantModelToJson(List<RestaurantModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RestaurantModel {
  String id;
  String ownersName;
  String restaurantName;
  String openTimeing;
  String closeTimeing;
  String gmail;
  String password;
  List<Address> address;
  int v;

  RestaurantModel({
    required this.id,
    required this.ownersName,
    required this.restaurantName,
    required this.openTimeing,
    required this.closeTimeing,
    required this.gmail,
    required this.password,
    required this.address,
    required this.v,
  });

  factory RestaurantModel.fromJson(Map<String, dynamic> json) =>
      RestaurantModel(
        id: json["_id"],
        ownersName: json["ownersName"],
        restaurantName: json["restaurantName"],
        openTimeing: json["openTimeing"],
        closeTimeing: json["closeTimeing"],
        gmail: json["gmail"],
        password: json["password"],
        address:
            List<Address>.from(json["address"].map((x) => Address.fromJson(x))),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "ownersName": ownersName,
        "restaurantName": restaurantName,
        "openTimeing": openTimeing,
        "closeTimeing": closeTimeing,
        "gmail": gmail,
        "password": password,
        "address": List<dynamic>.from(address.map((x) => x.toJson())),
        "__v": v,
      };
}

class Address {
  String lat;
  String lng;
  String area;
  String nearbyLandmark;
  String id;

  Address({
    required this.lat,
    required this.lng,
    required this.area,
    required this.nearbyLandmark,
    required this.id,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        lat: json["lat"],
        lng: json["lng"],
        area: json["area"],
        nearbyLandmark: json["nearbyLandmark"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "lat": lat,
        "lng": lng,
        "area": area,
        "nearbyLandmark": nearbyLandmark,
        "_id": id,
      };
}

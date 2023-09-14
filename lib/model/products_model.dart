import 'dart:convert';

List<Products> productsFromJson(String str) =>
    List<Products>.from(json.decode(str).map((x) => Products.fromJson(x)));

String productsToJson(List<Products> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Products {
  final String? id;
  final String? image;
  final String? name;
  final int? price;
  final String? restorantName;
  final String? des;

  Products({
    required this.id,
    required this.image,
    required this.name,
    required this.price,
    required this.restorantName,
    required this.des,
  });

  factory Products.fromJson(Map<String, dynamic> json) => Products(
        id: json["_id"],
        image: json["image"],
        name: json["foodName"],
        price: json["price"],
        restorantName: json["restuarantName"],
        des: json["des"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "image": image,
        "name": name,
        "price": price,
        "restorant_name": restorantName,
        "des": des,
      };
}

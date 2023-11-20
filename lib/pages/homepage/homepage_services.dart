import 'package:food_app_panel/comman/urls.dart';
import 'package:food_app_panel/model/products_model.dart';
import 'package:http/http.dart' as http;


class HomePageService{
    Future<List<Products>> getProducts(email) async {
    var res = await http
        .get(Uri.parse("$apilink/products/$email"));
    if (res.statusCode == 200) {
      var data = productsFromJson(res.body.toString());
      return data;
    }
    return [];
  }

  
  Future<List<Products>> getcategoryProductsList(
      {String? gmail, String? category}) async {
    var res = await http.get(Uri.parse(
        "$apilink/products/$gmail&$category"));
    if (res.statusCode == 200) {
      var data = productsFromJson(res.body.toString());
      return data;
    }
    return [];
  }
}
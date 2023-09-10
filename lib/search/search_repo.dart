import 'dart:convert';

import 'package:ecommerce_app/products/models/product_data_model.dart';
import 'package:http/http.dart' as http;

class SearchRepo {
  static Future<List<ProductModel>> fetchProducts(String querry) async {
    var client = http.Client();
    List<ProductModel> searchProducts = [];
    try {
      var response = await client
          .get(Uri.parse("https://dummyjson.com/products/search?q=$querry"));
      print(response.body);
      Map<String, dynamic> result = jsonDecode(response.body);

      for (int i = 0; i < result.length; i++) {
        ProductModel product = ProductModel.fromJson(result);
        searchProducts.add(product);
      }

      return searchProducts;
    } catch (e) {
      print(e);
      throw Exception(e.toString());
    }
  }
}

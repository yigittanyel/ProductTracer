import 'dart:convert';
import 'package:http/http.dart' as http;

import 'product_model.dart';

class ProductService {
  static const String baseUrl = 'https://localhost:44364/api/Products';

  static Future<List<ProductModel>> getProducts() async {
    final response = await http.get(Uri.parse('$baseUrl/getProducts'));

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse.map((json) => ProductModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  static Future<ProductModel> getProduct(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/getProduct/$id'));

    if (response.statusCode == 200) {
      dynamic jsonResponse = jsonDecode(response.body);
      return ProductModel.fromJson(jsonResponse);
    } else if (response.statusCode == 404) {
      throw Exception('Product not found');
    } else {
      throw Exception('Failed to load product');
    }
  }

  static Future<ProductModel> addProduct(ProductModel product) async {
    final response = await http.post(
      Uri.parse('$baseUrl/addProduct'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(product.toJson()), // toJson() metodunu kullanıyoruz.
    );

    if (response.statusCode == 200) {
      dynamic jsonResponse = jsonDecode(response.body);
      return ProductModel.fromJson(jsonResponse);
    } else {
      throw Exception('Failed to add product');
    }
  }

  static Future<ProductModel> updateProduct(
      int id, ProductModel product) async {
    final response = await http.put(
      Uri.parse('$baseUrl/updateProduct/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(product.toJson()), // toJson() metodunu kullanıyoruz.
    );

    if (response.statusCode == 200) {
      dynamic jsonResponse = jsonDecode(response.body);
      return ProductModel.fromJson(jsonResponse);
    } else if (response.statusCode == 404) {
      throw Exception('Product not found');
    } else {
      throw Exception('Failed to update product');
    }
  }

  static Future<ProductModel> deleteProduct(int id) async {
    final response =
        await http.delete(Uri.parse('$baseUrl/deleteProduct/$id'));

    if (response.statusCode == 200) {
      dynamic jsonResponse = jsonDecode(response.body);
      return ProductModel.fromJson(jsonResponse);
    } else if (response.statusCode == 404) {
      throw Exception('Product not found');
    } else {
      throw Exception('Failed to delete product');
    }
  }
}

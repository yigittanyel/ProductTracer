import 'package:flutter/material.dart';
import 'package:flutter_app/productService.dart';
import 'package:flutter_app/product_model.dart';

import 'productEditScreen.dart';

class ProductDetailScreen extends StatelessWidget {
  final int productId;
  final ProductService apiService = ProductService();

  ProductDetailScreen(this.productId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Detail'),
      ),
      body: FutureBuilder<ProductModel>(
        future: ProductService.getProduct(productId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Exception: ${snapshot.error}'));
          } else {
            final product = snapshot.data!;
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ListTile(
                  title: Text(product.name),
                  subtitle: Text('Price: ${product.price}'),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    _editProduct(context, product);
                  },
                  child: Text('Edit'),
                ),
              ],
            );
          }
        },
      ),
    );
  }

  void _editProduct(BuildContext context, ProductModel product) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductEditScreen(product: product),
      ),
    );
  }
}

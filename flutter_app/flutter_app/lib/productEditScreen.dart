import 'package:flutter/material.dart';
import 'package:flutter_app/product_model.dart';

class ProductEditScreen extends StatelessWidget {
  final ProductModel product;

  ProductEditScreen({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              initialValue: product.name,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextFormField(
              initialValue: product.price.toString(),
              decoration: InputDecoration(labelText: 'Price'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // TODO: Güncelleme işlemi için gereken kodları ekleyin.
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}

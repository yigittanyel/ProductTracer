import 'package:flutter/material.dart';
import 'package:flutter_app/productListPage.dart';
import 'package:flutter_app/productService.dart';
import 'package:flutter_app/product_model.dart';

import 'productDetail.dart';

class ProductAddScreen extends StatefulWidget {
  @override
  _ProductAddScreenState createState() => _ProductAddScreenState();
}

class _ProductAddScreenState extends State<ProductAddScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  void _addProduct() async {
    String name = _nameController.text;
    double price = double.tryParse(_priceController.text) ?? 0.0;

    // Yeni ürün modeli oluştur
    ProductModel newProduct = ProductModel(
      id: 0, // ID'yi burada belirtmeye gerek yok, API tarafında otomatik atanacak
      name: name,
      price: price.toInt(), // 2 basamaklı fiyat
    );

    try {
      // Yeni ürünü API'ye gönder ve eklenen ürünü al
      ProductModel addedProduct = await ProductService.addProduct(newProduct);

      // Ekleme işlemi başarılı, ürün detay sayfasına geçiş yap
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProductListScreen(),
        ),
      );
    } catch (e) {
      // Ekleme işlemi başarısız, kullanıcıya hata mesajı göster
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('There was an error while adding product.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _priceController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Price'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                _addProduct();
              },
              child: Text('Add Product'),
            ),
          ],
        ),
      ),
    );
  }
}

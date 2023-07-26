import 'package:flutter/material.dart';
import 'package:flutter_app/productService.dart';
import 'package:flutter_app/product_model.dart';

import 'addProduct.dart';

class ProductListScreen extends StatelessWidget {
  final ProductService apiService = ProductService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product List'),
      ),
      body: FutureBuilder<List<ProductModel>>(
        future: ProductService.getProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Exception: ${snapshot.error}'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data?.length ?? 0,
              itemBuilder: (context, index) {
                final product = snapshot.data![index];
                return Card(
                  child: ListTile(
                    title: Text(product.name),
                    subtitle: Text('Price: ${product.price}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            _showEditAlertDialog(context, product);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            _showDeleteAlertDialog(context, product);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Yeni ürün ekleme ekranına yönlendirme işlemi yapabilirsiniz.
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ProductAddScreen()));
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _showEditAlertDialog(BuildContext context, ProductModel product) {
    final TextEditingController _nameController =
        TextEditingController(text: product.name);
    final TextEditingController _priceController =
        TextEditingController(text: product.price.toString());

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit Product'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextFormField(
              controller: _priceController,
              decoration: InputDecoration(labelText: 'Price'),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Kapatma işlemi
            },
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              _updateProduct(context, product.id, _nameController.text,
                  int.parse(_priceController.text));
            },
            child: Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showDeleteAlertDialog(BuildContext context, ProductModel product) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete Product'),
        content: Text('Are you sure you want to delete this product?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(
                  context, false); // Kapatma işlemi ve "Hayır" değeri dönüşü
            },
            child: Text('No'),
          ),
          ElevatedButton(
            onPressed: () async {
              await _deleteProduct(context, product.id);
            },
            child: Text('Yes'),
          ),
        ],
      ),
    );
  }

  Future<void> _updateProduct(
      BuildContext context, int productId, String name, int price) async {
    try {
      ProductModel updatedProduct =
          ProductModel(id: productId, name: name, price: price);
      await ProductService.updateProduct(productId, updatedProduct);
      Navigator.pop(context); // Alert dialog kapatma
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Product updated successfully.'),
          backgroundColor: Colors.green,
        ),
      );
      // Güncelleme işlemi başarılıysa sayfayı yenilemek için
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ProductListScreen()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to update product.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _deleteProduct(BuildContext context, int productId) async {
    try {
      await ProductService.deleteProduct(productId);
      Navigator.pop(context); // Alert dialog kapatma
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Product deleted successfully.'),
          backgroundColor: Colors.green,
        ),
      );
      // Silme işlemi başarılıysa sayfayı yenilemek için
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ProductListScreen()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to delete product.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}

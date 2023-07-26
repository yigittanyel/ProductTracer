class ProductModel {
  final int id;
  final String name;
  final int price;

  ProductModel({
    required this.id,
    required this.name,
    required this.price,
  });

  ProductModel copyWith({
    int? id,
    String? name,
    int? price,
  }) {
    return ProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
    );
  }

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      price: json['price'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
    };
  }
}

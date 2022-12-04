import 'package:flutter_sklad/domain/entity/product_entity.dart';
import 'dart:ffi';

class Product extends ProductEntity {
  int? id;
  late String description;
  late double price;
  late String name;
  late int exists;
  late int productCategoryId;
  late int stockId;
  late int count;
  late String vendor;

  Product({required this.description, required this.price, required this.name, required this.exists, required this.productCategoryId, required this.stockId, required this.count, required this.vendor}) : super(description: description, price: price, name: name, exists: exists, productCategoryId: productCategoryId, stockId: stockId, count: count, vendor: vendor);

  Map<String, dynamic> toMap() {
    return {
      'description': description,
      'price': price,
      'name': name,
      'exists': exists,
      'productCategoryId': productCategoryId,
      'stockId': stockId,
      'count': count,
      'vendor': vendor
    };
  }

  factory Product.toFromMap(Map<String, dynamic> json) {
    return Product(description: json['description'], price: json['price'], name: json['name'], exists: json['exists'], productCategoryId: json['productCategoryId'], stockId: json['stockId'], count: json['count'], vendor: json['vendor']);
  }
}

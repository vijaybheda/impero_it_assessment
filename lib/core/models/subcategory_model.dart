import 'product_model.dart';

class SubCategory {
  final int id;
  final String name;
  final List<Product>? products;

  SubCategory({required this.id, required this.name, this.products});

  factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
        id: json['Id'] ?? json['subCategoryId'] ?? json['id'],
        name: json['Name'] ?? json['subCategoryName'] ?? json['name'],
        products: json['Product'] != null 
            ? (json['Product'] as List)
                .map((prod) => Product.fromJson(prod))
                .toList()
            : null,
      );

  Map<String, dynamic> toJson() => {
        'Id': id,
        'Name': name,
        if (products != null) 'Product': products!.map((p) => p.toJson()).toList(),
      };
}

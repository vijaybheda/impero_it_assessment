import 'package:impero_it_assessment/core/constants/app_strings.dart';

class Product {
  final int id;
  final String name;
  final String priceCode;
  final String imageName;
  final String color; // We'll generate this from the name or use a default

  Product({
    required this.id,
    required this.name,
    required this.priceCode,
    required this.imageName,
    required this.color,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['Id'] ?? json['productId'] ?? json['id'],
      name: json['Name'] ?? json['productName'] ?? json['name'],
      priceCode: json['PriceCode'] ?? json['priceCode'] ?? AppStrings.defaultPriceCode,
      imageName: json['ImageName'] ?? json['imageName'] ?? AppStrings.defaultImageName,
      color: json['color'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'Id': id,
    'Name': name,
    'PriceCode': priceCode,
    'ImageName': imageName,
    'color': color,
  };
}

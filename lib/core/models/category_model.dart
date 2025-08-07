import 'subcategory_model.dart';

class Category {
  final int id;
  final String name;
  final List<SubCategory>? subCategories;

  Category({required this.id, required this.name, this.subCategories});

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json['Id'] ?? json['categoryId'] ?? json['id'],
        name: json['Name'] ?? json['categoryName'] ?? json['name'],
        subCategories: json['SubCategories'] != null 
            ? (json['SubCategories'] as List)
                .map((sub) => SubCategory.fromJson(sub))
                .toList()
            : null,
      );

  Map<String, dynamic> toJson() => {
        'Id': id,
        'Name': name,
        if (subCategories != null) 'SubCategories': subCategories!.map((s) => s.toJson()).toList(),
      };
}

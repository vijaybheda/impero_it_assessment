import 'package:get/get.dart';
import 'package:impero_it_assessment/core/constants/api_endpoints.dart';
import 'package:impero_it_assessment/core/constants/app_strings.dart';
import 'package:impero_it_assessment/core/models/category_model.dart';
import 'package:impero_it_assessment/core/models/product_model.dart';
import 'package:impero_it_assessment/core/models/subcategory_model.dart';
import 'package:impero_it_assessment/core/network/api_client.dart';

class ProductRepository {
  final ApiClient _apiClient = Get.find<ApiClient>();

  Future<List<Category>> fetchCategories() async {
    print('🔧 ProductRepository: fetchCategories called');
    try {
      final response = await _apiClient.post(
        ApiEndpoints.product.dashboard,
        body: {
          'CategoryId': 0,
          'DeviceManufacturer': AppStrings.deviceManufacturer,
          'DeviceModel': AppStrings.deviceModel,
          'DeviceToken': AppStrings.deviceTokenPlaceholder,
          'PageIndex': 1,
        },
      );
      print('🔧 ProductRepository: API response received: ${response.toString()}');

      if (response['Result'] != null && response['Result']['Category'] != null) {
        final List<dynamic> categoriesData = response['Result']['Category'];
        print('🔧 ProductRepository: Found ${categoriesData.length} categories in response');
        
        final categories = categoriesData.map((json) => Category.fromJson(json)).toList();
        print('🔧 ProductRepository: Parsed ${categories.length} categories');
        
        for (final category in categories) {
          print('🔧 ProductRepository: Category: ${category.name} (ID: ${category.id})');
        }
        
        return categories;
      } else {
        print('🔧 ProductRepository: No categories found in response');
        print('🔧 ProductRepository: Response structure: ${response.keys}');
        if (response['Result'] != null) {
          print('🔧 ProductRepository: Result keys: ${response['Result'].keys}');
        }
        return [];
      }
    } catch (e) {
      print('🔧 ProductRepository: Error fetching categories: $e');
      return [];
    }
  }

  Future<List<SubCategory>> fetchAllSubCategories(int categoryId) async {
    print('🔧 ProductRepository: fetchAllSubCategories called for categoryId: $categoryId');
    List<SubCategory> allSubCategories = [];
    int pageIndex = 1;
    bool hasMoreData = true;

    try {
      while (hasMoreData) {
        print('🔧 ProductRepository: Fetching subcategories page $pageIndex');
        final response = await _apiClient.post(
          ApiEndpoints.product.dashboard,
          body: {
            'CategoryId': categoryId,
            'PageIndex': pageIndex,
          },
        );
        print('🔧 ProductRepository: Subcategories API response for page $pageIndex: ${response.toString()}');

        if (response['Result'] != null && 
            response['Result']['Category'] != null && 
            response['Result']['Category'].isNotEmpty) {
          
          final category = response['Result']['Category'][0];
          print('🔧 ProductRepository: Found category in response: ${category['Name']}');
          
          if (category['SubCategories'] != null) {
            final List<dynamic> subCategoriesData = category['SubCategories'];
            print('🔧 ProductRepository: Found ${subCategoriesData.length} subcategories in page $pageIndex');
            
            final List<SubCategory> pageSubCategories = subCategoriesData
                .map((json) => SubCategory.fromJson(json))
                .toList();
            
            allSubCategories.addAll(pageSubCategories);
            print('🔧 ProductRepository: Added ${pageSubCategories.length} subcategories, total now: ${allSubCategories.length}');
            
            // Check if we have more data (assuming API returns empty array when no more data)
            if (pageSubCategories.isEmpty) {
              print('🔧 ProductRepository: No more subcategories found, stopping pagination');
              hasMoreData = false;
            } else {
              pageIndex++;
            }
          } else {
            print('🔧 ProductRepository: No SubCategories field in response');
            hasMoreData = false;
          }
        } else {
          print('🔧 ProductRepository: No valid response structure for subcategories');
          hasMoreData = false;
        }
      }
      
      print('🔧 ProductRepository: Returning ${allSubCategories.length} total subcategories');
      return allSubCategories;
    } catch (e) {
      print('🔧 ProductRepository: Error fetching subcategories: $e');
      return [];
    }
  }

  Future<List<Product>> fetchAllProducts(int subCategoryId) async {
    print('🔧 ProductRepository: fetchAllProducts called for subCategoryId: $subCategoryId');
    List<Product> allProducts = [];
    int pageIndex = 1;
    bool hasMoreData = true;

    try {
      while (hasMoreData) {
        print('🔧 ProductRepository: Fetching products page $pageIndex');
        final response = await _apiClient.post(
          ApiEndpoints.product.productList,
          body: {
            'SubCategoryId': subCategoryId,
            'PageIndex': pageIndex,
          },
        );
        print('🔧 ProductRepository: Products API response for page $pageIndex: ${response.toString()}');

        if (response['Result'] != null) {
          final List<dynamic> productsData = response['Result'];
          print('🔧 ProductRepository: Found ${productsData.length} products in page $pageIndex');
          
          final List<Product> pageProducts = productsData
              .map((json) => Product.fromJson(json))
              .toList();
          
          allProducts.addAll(pageProducts);
          print('🔧 ProductRepository: Added ${pageProducts.length} products, total now: ${allProducts.length}');
          
          // Check if we have more data (assuming API returns empty array when no more data)
          if (pageProducts.isEmpty) {
            print('🔧 ProductRepository: No more products found, stopping pagination');
            hasMoreData = false;
          } else {
            pageIndex++;
          }
        } else {
          print('🔧 ProductRepository: No valid response structure for products');
          hasMoreData = false;
        }
      }
      
      print('🔧 ProductRepository: Returning ${allProducts.length} total products');
      for (final product in allProducts) {
        print('🔧 ProductRepository: Product: ${product.name} - Image: ${product.imageName} - Color: ${product.color}');
      }
      
      return allProducts;
    } catch (e) {
      print('🔧 ProductRepository: Error fetching products: $e');
      return [];
    }
  }

  // Helper method to check if category is Ceramic
  bool isCeramicCategory(Category category) {
    // Check if category name contains "ceramic" (case-insensitive)
    // Also include "Bathroom & Kitchen Tiles" as it contains the actual products
    return category.name.toLowerCase().contains('ceramic') ||
           category.name.toLowerCase().contains('bathroom') ||
           category.name.toLowerCase().contains('kitchen');
  }

  // Helper method to get category display name
  String getCategoryDisplayName(Category category) {
    // For Ceramic and Bathroom & Kitchen Tiles categories, show full functionality
    if (isCeramicCategory(category)) {
      return category.name;
    }
    // For other categories, show as description only
    return '${category.name} (Description Only)';
  }
}

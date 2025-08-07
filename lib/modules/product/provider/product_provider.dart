import 'package:get/get.dart';
import 'package:impero_it_assessment/core/constants/app_strings.dart';
import 'package:impero_it_assessment/core/models/category_model.dart';
import 'package:impero_it_assessment/core/models/product_model.dart';
import 'package:impero_it_assessment/core/models/subcategory_model.dart';
import 'package:impero_it_assessment/modules/product/repository/product_repository.dart';

class ProductProvider extends GetxController {
  final ProductRepository _repository = Get.find<ProductRepository>();

  // Observable variables
  final RxList<Category> categories = <Category>[].obs;
  final RxList<SubCategory> subCategories = <SubCategory>[].obs;
  final RxList<Product> products = <Product>[].obs;
  final RxMap<int, String> selectedColors = <int, String>{}.obs;
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final RxBool isLoadingSubCategories = false.obs;
  final RxBool isLoadingProducts = false.obs;

  @override
  void onInit() {
    super.onInit();
    print('🔧 ProductProvider: onInit called');
    loadCategories();
  }

  Future<void> loadCategories() async {
    print('🔧 ProductProvider: loadCategories called');
    try {
      isLoading.value = true;
      errorMessage.value = '';
      print('🔧 ProductProvider: Setting isLoading to true');

      final categoriesList = await _repository.fetchCategories();
      categories.value = categoriesList;
      print('🔧 ProductProvider: Loaded ${categoriesList.length} categories');

      // Find the first category that has subcategories (Bathroom & Kitchen Tiles)
      Category? categoryWithSubcategories;
      for (final category in categoriesList) {
        if (_repository.isCeramicCategory(category)) {
          categoryWithSubcategories = category;
          break;
        }
      }

      if (categoryWithSubcategories != null) {
        print('🔧 ProductProvider: Found category with subcategories: ${categoryWithSubcategories.name} (ID: ${categoryWithSubcategories.id})');
        await loadSubCategories(categoryWithSubcategories.id);
      } else {
        print('🔧 ProductProvider: No category with subcategories found');
      }
    } catch (e) {
      print('🔧 ProductProvider: Error loading categories: $e');
      errorMessage.value = '${AppStrings.errorLoadingCategories}: $e';
    } finally {
      isLoading.value = false;
      print('🔧 ProductProvider: Setting isLoading to false');
    }
  }

  Future<void> loadSubCategories(int categoryId) async {
    print('🔧 ProductProvider: loadSubCategories called for categoryId: $categoryId');
    try {
      isLoadingSubCategories.value = true;
      errorMessage.value = '';
      print('🔧 ProductProvider: Setting isLoadingSubCategories to true');

      // Check if this is a Ceramic category
      final category = categories.firstWhereOrNull((c) => c.id == categoryId);
      if (category != null && _repository.isCeramicCategory(category)) {
        print('🔧 ProductProvider: Loading subcategories for Ceramic category: ${category.name}');
        // Load all subcategories with pagination for Ceramic category
        final subCategoriesList = await _repository.fetchAllSubCategories(categoryId);
        subCategories.value = subCategoriesList;
        print('🔧 ProductProvider: Loaded ${subCategoriesList.length} subcategories');

        if (subCategories.isNotEmpty) {
          // Load products from ALL subcategories to get maximum variety
          List<Product> allProducts = [];
          
          print('🔧 ProductProvider: Loading products from all ${subCategories.length} subcategories');
          
          for (int i = 0; i < subCategories.length; i++) {
            final subCategory = subCategories[i];
            print('🔧 ProductProvider: Loading products for subcategory ${i + 1}/${subCategories.length}: ${subCategory.name} (ID: ${subCategory.id})');
            
            try {
              final productsList = await _repository.fetchAllProducts(subCategory.id);
              allProducts.addAll(productsList);
              print('🔧 ProductProvider: Loaded ${productsList.length} products from ${subCategory.name}');
            } catch (e) {
              print('🔧 ProductProvider: Error loading products from ${subCategory.name}: $e');
            }
          }
          
          // Set all products
          products.value = allProducts;
          print('🔧 ProductProvider: Total products loaded: ${allProducts.length}');
          
          // Initialize selected colors with product colors
          selectedColors.clear();
          for (int i = 0; i < products.length; i++) {
            selectedColors[i] = products[i].color;
            print('🔧 ProductProvider: Product $i: ${products[i].name} - Color: ${products[i].color} - Image: ${products[i].imageName}');
          }
        } else {
          print('🔧 ProductProvider: No subcategories found, skipping product loading');
        }
      } else {
        print('🔧 ProductProvider: Category is not Ceramic or not found, showing empty lists');
        // For non-Ceramic categories, just show empty list
        subCategories.value = [];
        products.value = [];
      }
    } catch (e) {
      print('🔧 ProductProvider: Error loading subcategories: $e');
      errorMessage.value = '${AppStrings.errorLoadingSubcategories}: $e';
    } finally {
      isLoadingSubCategories.value = false;
      print('🔧 ProductProvider: Setting isLoadingSubCategories to false');
    }
  }

  Future<void> loadProducts(int subCategoryId) async {
    print('🔧 ProductProvider: loadProducts called for subCategoryId: $subCategoryId');
    try {
      isLoadingProducts.value = true;
      errorMessage.value = '';
      print('🔧 ProductProvider: Setting isLoadingProducts to true');

      // Load all products with pagination
      final productsList = await _repository.fetchAllProducts(subCategoryId);
      products.value = productsList.cast<Product>();
      print('🔧 ProductProvider: Loaded ${productsList.length} products');

      // Initialize selected colors with product colors
      selectedColors.clear();
      for (int i = 0; i < products.length; i++) {
        selectedColors[i] = products[i].color;
        print('🔧 ProductProvider: Product $i: ${products[i].name} - Color: ${products[i].color} - Image: ${products[i].imageName}');
      }
    } catch (e) {
      print('🔧 ProductProvider: Error loading products: $e');
      errorMessage.value = '${AppStrings.errorLoadingProducts}: $e';
    } finally {
      isLoadingProducts.value = false;
      print('🔧 ProductProvider: Setting isLoadingProducts to false');
    }
  }

  void updateColor(int rowIndex, String color) {
    selectedColors[rowIndex] = color;
  }

  void clearError() {
    errorMessage.value = '';
  }

  // Getter for current products (for design strip)
  List<Product> get currentProducts {
    return products;
  }

  // Helper method to check if category is Ceramic
  bool isCeramicCategory(Category category) {
    final isCeramic = _repository.isCeramicCategory(category);
    print('🔧 ProductProvider: isCeramicCategory(${category.name}) = $isCeramic');
    return isCeramic;
  }

  // Helper method to get category display name
  String getCategoryDisplayName(Category category) {
    return _repository.getCategoryDisplayName(category);
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:impero_it_assessment/core/constants/app_strings.dart';
import 'package:impero_it_assessment/modules/product/provider/product_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late TabController _tabController;
  final ProductProvider productProvider = Get.put(ProductProvider());

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 11, vsync: this);
    print('🔧 HomeScreen: initState called');
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
    print('🔧 HomeScreen: dispose called');
  }

  @override
  Widget build(BuildContext context) {
    print('🔧 HomeScreen: build method called');
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              child: Text(
                AppStrings.appTitle,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.grey[800],
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list, color: Colors.white),
            onPressed: () {
              // Filter functionality
            },
          ),
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {
              // Search functionality
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.grey[300],
          labelStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          unselectedLabelStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
          tabs: [
            Tab(text: AppStrings.ceramic),
            Tab(text: AppStrings.porcelain),
            Tab(text: AppStrings.woodEffect),
            Tab(text: AppStrings.mosaics),
            Tab(text: AppStrings.patterns),
            Tab(text: AppStrings.outdoor),
            Tab(text: AppStrings.nonSlips),
            Tab(text: AppStrings.newRanges),
            Tab(text: AppStrings.endOfLine),
            Tab(text: AppStrings.modulars),
            Tab(text: AppStrings.wabiSabi),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Ceramic Tab - Keep existing functionality
          _buildCeramicTab(),

          // Other tabs - Show centered text
          _buildInfoTab(AppStrings.porcelain),
          _buildInfoTab(AppStrings.woodEffect),
          _buildInfoTab(AppStrings.mosaics),
          _buildInfoTab(AppStrings.patterns),
          _buildInfoTab(AppStrings.outdoor),
          _buildInfoTab(AppStrings.nonSlips),
          _buildInfoTab(AppStrings.newRanges),
          _buildInfoTab(AppStrings.endOfLine),
          _buildInfoTab(AppStrings.modulars),
          _buildInfoTab(AppStrings.wabiSabi),
        ],
      ),
    );
  }

  Widget _buildCeramicTab() {
    print('🔧 HomeScreen: _buildCeramicTab called');
    return Column(
      children: [
        // Main Content Area
        Expanded(
          child: Obx(() {
            print('🔧 HomeScreen: Obx rebuild triggered');
            print('🔧 HomeScreen: isLoading = ${productProvider.isLoading.value}');
            print('🔧 HomeScreen: errorMessage = ${productProvider.errorMessage.value}');
            print('🔧 HomeScreen: categories.length = ${productProvider.categories.length}');
            print('🔧 HomeScreen: products.length = ${productProvider.products.length}');
            print(
              '🔧 HomeScreen: isLoadingSubCategories = ${productProvider.isLoadingSubCategories.value}',
            );
            print('🔧 HomeScreen: isLoadingProducts = ${productProvider.isLoadingProducts.value}');

            if (productProvider.isLoading.value) {
              print('🔧 HomeScreen: Showing loading indicator');
              return const Center(child: CircularProgressIndicator());
            }

            if (productProvider.errorMessage.isNotEmpty) {
              print('🔧 HomeScreen: Showing error message: ${productProvider.errorMessage.value}');
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Error: ${productProvider.errorMessage.value}',
                      style: const TextStyle(color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => productProvider.loadCategories(),
                      child: Text(AppStrings.retry),
                    ),
                  ],
                ),
              );
            }

            if (productProvider.categories.isEmpty) {
              print('🔧 HomeScreen: No categories available');
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.category_outlined, size: 64, color: Colors.grey),
                    const SizedBox(height: 16),
                    Text(
                      'No categories available',
                      style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Please check your connection and try again',
                      style: TextStyle(fontSize: 14, color: Colors.grey[500]),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            }

            // Show loading for subcategories/products
            if (productProvider.isLoadingSubCategories.value ||
                productProvider.isLoadingProducts.value) {
              print('🔧 HomeScreen: Showing loading for subcategories/products');
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 16),
                    Text('Loading Ceramic products...'),
                  ],
                ),
              );
            }

            // Check if we have Ceramic products
            if (productProvider.products.isEmpty) {
              print('🔧 HomeScreen: No Ceramic products available');
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.inventory_2_outlined, size: 64, color: Colors.grey),
                    const SizedBox(height: 16),
                    Text(
                      'No Ceramic products available',
                      style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Please select a Ceramic category to view products',
                      style: TextStyle(fontSize: 14, color: Colors.grey[500]),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            }

            print(
              '🔧 HomeScreen: Building product sections with ${productProvider.products.length} products',
            );
            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _buildProductSection(AppStrings.excellence, _getExcellenceProducts()),
                const SizedBox(height: 24),
                _buildProductSection(AppStrings.etruscan, _getEtruscanProducts()),
                const SizedBox(height: 24),
                _buildProductSection(AppStrings.urban, _getUrbanProducts()),
                const SizedBox(height: 24),
                _buildProductSection(AppStrings.valentina, _getValentinaProducts()),
              ],
            );
          }),
        ),
      ],
    );
  }

  Widget _buildInfoTab(String tabName) {
    print('🔧 HomeScreen: _buildInfoTab called for $tabName');
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(_getTabIcon(tabName), size: 80, color: Colors.grey[400]),
          const SizedBox(height: 24),
          Text(
            tabName,
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.grey[700]),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            'This tab is currently under development',
            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'Content will be available soon',
            style: TextStyle(fontSize: 14, color: Colors.grey[500]),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  IconData _getTabIcon(String tabName) {
    switch (tabName) {
      case AppStrings.porcelain:
        return Icons.celebration;
      case AppStrings.woodEffect:
        return Icons.forest;
      case AppStrings.mosaics:
        return Icons.grid_4x4;
      case AppStrings.patterns:
        return Icons.pattern;
      case AppStrings.outdoor:
        return Icons.outdoor_grill;
      case AppStrings.nonSlips:
        return Icons.safety_divider;
      case AppStrings.newRanges:
        return Icons.new_releases;
      case AppStrings.endOfLine:
        return Icons.inventory;
      case AppStrings.modulars:
        return Icons.grid_view;
      case AppStrings.wabiSabi:
        return Icons.spa;
      default:
        return Icons.category;
    }
  }

  Widget _buildProductSection(String title, List<Map<String, dynamic>> products) {
    print('🔧 HomeScreen: _buildProductSection called for $title with ${products.length} products');

    if (products.isEmpty) {
      print('🔧 HomeScreen: No products found for section $title');
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          const SizedBox(height: 12),
          Container(
            height: 120,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: const Center(
              child: Text(
                'No products available',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ),
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              print('🔧 HomeScreen: Building product item $index: ${product['name']}');
              return Container(
                width: 100,
                margin: const EdgeInsets.only(right: 12),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: product['isSelected'] ? Colors.blue : Colors.grey[300]!,
                              width: product['isSelected'] ? 2 : 1,
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: _buildProductImage(product['imageUrl']),
                          ),
                        ),
                        if (product['priceCode']?.isNotEmpty == true)
                          Positioned(
                            top: 4,
                            left: 4,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: Colors.lightBlue,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                product['priceCode'],
                                style: const TextStyle(
                                  fontSize: 10,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Expanded(
                      child: Text(
                        product['name'],
                        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildProductImage(String? imageUrl) {
    print('🔧 HomeScreen: _buildProductImage called with URL: $imageUrl');

    if (imageUrl == null || imageUrl.isEmpty) {
      print('🔧 HomeScreen: Image URL is null or empty, showing placeholder');
      return Container(
        color: Colors.grey[200],
        child: const Icon(Icons.image_not_supported, color: Colors.grey, size: 32),
      );
    }

    // Check if URL already contains the base URL
    final trimmedUrl = imageUrl.trim();
    String fullImageUrl;

    if (trimmedUrl.startsWith('http')) {
      // URL already contains full path
      fullImageUrl = trimmedUrl;
    } else {
      // URL is relative, construct full URL
      fullImageUrl = trimmedUrl;
    }

    print('🔧 HomeScreen: Full image URL: $fullImageUrl');

    return CachedNetworkImage(
      imageUrl: fullImageUrl,
      fit: BoxFit.cover,
      placeholder:
          (context, url) => Container(
            color: Colors.grey[200],
            child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
          ),
      errorWidget:
          (context, url, error) => Container(
            color: Colors.grey[200],
            child: const Icon(Icons.error_outline, color: Colors.grey, size: 32),
          ),
      memCacheWidth: 160, // 80 * 2 for better quality
      memCacheHeight: 160,
    );
  }

  List<Map<String, dynamic>> _getExcellenceProducts() {
    print('🔧 HomeScreen: _getExcellenceProducts called');
    print('🔧 HomeScreen: Total products available: ${productProvider.products.length}');

    // Filter products based on actual data from API - looking for premium/white products
    final products =
        productProvider.products
            .where(
              (product) =>
                  product.name.toLowerCase().contains('white') ||
                  product.name.toLowerCase().contains('matt') ||
                  product.name.toLowerCase().contains('rect') ||
                  product.name.toLowerCase().contains('bellagio') ||
                  product.name.toLowerCase().contains('ama') ||
                  product.name.toLowerCase().contains('aspen'),
            )
            .toList();

    print('🔧 HomeScreen: Found ${products.length} excellence products');
    for (final product in products) {
      print('🔧 HomeScreen: Excellence product: ${product.name}');
    }

    // Fallback: if no products match, take first 25% of products
    if (products.isEmpty && productProvider.products.isNotEmpty) {
      final fallbackProducts =
          productProvider.products.take((productProvider.products.length / 4).ceil()).toList();
      print(
        '🔧 HomeScreen: Using fallback - taking first ${fallbackProducts.length} products for Excellence',
      );
      return fallbackProducts
          .map(
            (product) => {
              'name': product.name,
              'imageUrl': product.imageName,
              'priceCode': product.priceCode,
              'isSelected': false,
            },
          )
          .toList();
    }

    return products
        .map(
          (product) => {
            'name': product.name,
            'imageUrl': product.imageName,
            'priceCode': product.priceCode,
            'isSelected': false,
          },
        )
        .toList();
  }

  List<Map<String, dynamic>> _getEtruscanProducts() {
    print('🔧 HomeScreen: _getEtruscanProducts called');

    // Filter products based on actual data from API - looking for classic/traditional products
    final products =
        productProvider.products
            .where(
              (product) =>
                  product.name.toLowerCase().contains('bowland') ||
                  product.name.toLowerCase().contains('bodo') ||
                  product.name.toLowerCase().contains('belvedere') ||
                  product.name.toLowerCase().contains('altea') ||
                  product.name.toLowerCase().contains('acquarella'),
            )
            .toList();

    print('🔧 HomeScreen: Found ${products.length} etruscan products');
    for (final product in products) {
      print('🔧 HomeScreen: Etruscan product: ${product.name}');
    }

    // Fallback: if no products match, take next 25% of products
    if (products.isEmpty && productProvider.products.isNotEmpty) {
      final startIndex = (productProvider.products.length / 4).ceil();
      final endIndex = (productProvider.products.length / 2).ceil();
      final fallbackProducts =
          productProvider.products.skip(startIndex).take(endIndex - startIndex).toList();
      print(
        '🔧 HomeScreen: Using fallback - taking products ${startIndex}-${endIndex} for Etruscan',
      );
      return fallbackProducts
          .map(
            (product) => {
              'name': product.name,
              'imageUrl': product.imageName,
              'priceCode': product.priceCode,
              'isSelected': false,
            },
          )
          .toList();
    }

    return products
        .map(
          (product) => {
            'name': product.name,
            'imageUrl': product.imageName,
            'priceCode': product.priceCode,
            'isSelected': false,
          },
        )
        .toList();
  }

  List<Map<String, dynamic>> _getUrbanProducts() {
    print('🔧 HomeScreen: _getUrbanProducts called');

    // Filter products based on actual data from API - looking for modern/urban products
    final products =
        productProvider.products
            .where(
              (product) =>
                  product.name.toLowerCase().contains('blade') ||
                  product.name.toLowerCase().contains('stony') ||
                  product.name.toLowerCase().contains('silex') ||
                  product.name.toLowerCase().contains('shape'),
            )
            .toList();

    print('🔧 HomeScreen: Found ${products.length} urban products');
    for (final product in products) {
      print('🔧 HomeScreen: Urban product: ${product.name}');
    }

    // Fallback: if no products match, take next 25% of products
    if (products.isEmpty && productProvider.products.isNotEmpty) {
      final startIndex = (productProvider.products.length / 2).ceil();
      final endIndex = (productProvider.products.length * 3 / 4).ceil();
      final fallbackProducts =
          productProvider.products.skip(startIndex).take(endIndex - startIndex).toList();
      print('🔧 HomeScreen: Using fallback - taking products ${startIndex}-${endIndex} for Urban');
      return fallbackProducts
          .map(
            (product) => {
              'name': product.name,
              'imageUrl': product.imageName,
              'priceCode': product.priceCode,
              'isSelected': false,
            },
          )
          .toList();
    }

    return products
        .map(
          (product) => {
            'name': product.name,
            'imageUrl': product.imageName,
            'priceCode': product.priceCode,
            'isSelected': false,
          },
        )
        .toList();
  }

  List<Map<String, dynamic>> _getValentinaProducts() {
    print('🔧 HomeScreen: _getValentinaProducts called');

    // Filter products based on actual data from API - looking for luxury/premium products
    final products =
        productProvider.products
            .where(
              (product) =>
                  product.name.toLowerCase().contains('belvedere') ||
                  product.name.toLowerCase().contains('altea') ||
                  product.name.toLowerCase().contains('acquarella') ||
                  product.name.toLowerCase().contains('perla') ||
                  product.name.toLowerCase().contains('avorio'),
            )
            .toList();

    print('🔧 HomeScreen: Found ${products.length} valentina products');
    for (final product in products) {
      print('🔧 HomeScreen: Valentina product: ${product.name}');
    }

    // Fallback: if no products match, take remaining 25% of products
    if (products.isEmpty && productProvider.products.isNotEmpty) {
      final startIndex = (productProvider.products.length * 3 / 4).ceil();
      final fallbackProducts = productProvider.products.skip(startIndex).toList();
      print(
        '🔧 HomeScreen: Using fallback - taking remaining products from index $startIndex for Valentina',
      );
      return fallbackProducts
          .map(
            (product) => {
              'name': product.name,
              'imageUrl': product.imageName,
              'priceCode': product.priceCode,
              'isSelected': false,
            },
          )
          .toList();
    }

    return products
        .map(
          (product) => {
            'name': product.name,
            'imageUrl': product.imageName,
            'priceCode': product.priceCode,
            'isSelected': false,
          },
        )
        .toList();
  }
}

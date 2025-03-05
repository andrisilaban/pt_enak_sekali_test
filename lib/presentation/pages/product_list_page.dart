import 'package:flutter/material.dart';
import '../../domain/entities/product.dart';
import '../../domain/usecases/get_products.dart';
import '../../domain/usecases/search_products.dart';
import '../../domain/usecases/filter_products_by_category.dart';
import '../widgets/product_grid_item.dart';

class ProductListPage extends StatefulWidget {
  final GetProducts getProducts;
  final SearchProducts searchProducts;
  final FilterProductsByCategory filterProductsByCategory;

  const ProductListPage({
    super.key,
    required this.getProducts,
    required this.searchProducts,
    required this.filterProductsByCategory,
  });

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  List<Product> _products = [];
  final int _limit = 10;
  int _skip = 0;
  bool _isLoading = false;
  String _searchQuery = '';
  String _selectedCategory = '';
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchProducts();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200 &&
        !_isLoading) {
      _fetchProducts();
    }
  }

  Future<void> _fetchProducts() async {
    if (_isLoading) return;
    setState(() => _isLoading = true);

    List<Product> newProducts;
    if (_searchQuery.isNotEmpty) {
      newProducts = await widget.searchProducts.execute(_searchQuery);
    } else if (_selectedCategory.isNotEmpty) {
      newProducts = await widget.filterProductsByCategory.execute(
        _selectedCategory,
      );
    } else {
      newProducts = await widget.getProducts.execute(_limit, _skip);
    }

    setState(() {
      _products.addAll(newProducts);
      _skip += _limit;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          height: 40,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextField(
            onChanged: (value) {
              setState(() {
                _searchQuery = value;
                _products = [];
                _skip = 0;
              });
              _fetchProducts();
            },
            decoration: InputDecoration(
              hintText: 'Cari Produk...',
              prefixIcon: const Icon(Icons.search, color: Colors.grey),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 15,
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  for (var category in [
                    'beauty',
                    'fragrances',
                    'furniture',
                    'groceries',
                  ])
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: ChoiceChip(
                        label: Text(category),
                        selected: _selectedCategory == category,
                        onSelected: (bool selected) {
                          setState(() {
                            _selectedCategory = selected ? category : '';
                            _products = [];
                            _skip = 0;
                          });
                          _fetchProducts();
                        },
                        selectedColor: Colors.blue,
                        labelStyle: TextStyle(
                          color:
                              _selectedCategory == category
                                  ? Colors.white
                                  : Colors.black,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 5),
            Expanded(
              child: GridView.builder(
                controller: _scrollController,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7,
                ),
                itemCount: _products.length,
                itemBuilder: (context, index) {
                  return ProductGridItem(product: _products[index]);
                },
              ),
            ),
            if (_isLoading)
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: CircularProgressIndicator(),
              ),
          ],
        ),
      ),
    );
  }
}

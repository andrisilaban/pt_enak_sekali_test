import 'package:flutter/material.dart';
import 'data/data_sources/remote_data_source.dart';
import 'data/repositories/product_repository_impl.dart';
import 'domain/usecases/get_products.dart';
import 'domain/usecases/search_products.dart';
import 'domain/usecases/filter_products_by_category.dart';
import 'presentation/pages/product_list_page.dart';
import 'presentation/pages/splash_page.dart';

void main() {
  final remoteDataSource = RemoteDataSource();
  final productRepository = ProductRepositoryImpl(remoteDataSource);
  final getProducts = GetProducts(productRepository);
  final searchProducts = SearchProducts(productRepository);
  final filterProductsByCategory = FilterProductsByCategory(productRepository);

  runApp(
    MyApp(
      getProducts: getProducts,
      searchProducts: searchProducts,
      filterProductsByCategory: filterProductsByCategory,
    ),
  );
}

class MyApp extends StatelessWidget {
  final GetProducts getProducts;
  final SearchProducts searchProducts;
  final FilterProductsByCategory filterProductsByCategory;

  const MyApp({
    super.key,
    required this.getProducts,
    required this.searchProducts,
    required this.filterProductsByCategory,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PT Enak Sekali Test',
      home: FutureBuilder(
        future: Future.delayed(const Duration(seconds: 0)),
        builder: (context, snapshot) {
          return SplashPage(
            nextScreen: ProductListPage(
              getProducts: getProducts,
              searchProducts: searchProducts,
              filterProductsByCategory: filterProductsByCategory,
            ),
            getProducts: getProducts,
            searchProducts: searchProducts,
            filterProductsByCategory: filterProductsByCategory,
          );
        },
      ),
    );
  }
}

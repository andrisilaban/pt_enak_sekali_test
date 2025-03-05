import '../entities/product.dart';

abstract class ProductRepository {
  Future<List<Product>> getProducts(int limit, int skip);
  Future<List<Product>> searchProducts(String query);
  Future<List<Product>> filterProductsByCategory(String category);
}

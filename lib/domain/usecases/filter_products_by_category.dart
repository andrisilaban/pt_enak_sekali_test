import '../entities/product.dart';
import '../repositories/product_repository.dart';

class FilterProductsByCategory {
  final ProductRepository repository;

  FilterProductsByCategory(this.repository);

  Future<List<Product>> execute(String category) {
    return repository.filterProductsByCategory(category);
  }
}

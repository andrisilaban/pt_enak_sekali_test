import '../entities/product.dart';
import '../repositories/product_repository.dart';

class SearchProducts {
  final ProductRepository repository;

  SearchProducts(this.repository);

  Future<List<Product>> execute(String query) {
    return repository.searchProducts(query);
  }
}

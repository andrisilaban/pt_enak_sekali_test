import '../entities/product.dart';
import '../repositories/product_repository.dart';

class GetProducts {
  final ProductRepository repository;

  GetProducts(this.repository);

  Future<List<Product>> execute(int limit, int skip) {
    return repository.getProducts(limit, skip);
  }
}

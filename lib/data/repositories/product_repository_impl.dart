import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../data_sources/remote_data_source.dart';

class ProductRepositoryImpl implements ProductRepository {
  final RemoteDataSource remoteDataSource;

  ProductRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Product>> getProducts(int limit, int skip) async {
    final data = await remoteDataSource.get(
      'products',
      queryParameters: {'limit': limit.toString(), 'skip': skip.toString()},
    );
    return (data['products'] as List)
        .map(
          (e) => Product(
            id: e['id'],
            title: e['title'],
            description: e['description'],
            price: e['price'].toDouble(),
            category: e['category'],
            thumbnail: e['thumbnail'],
            rating: e['rating'].toDouble(),
            shippingInformation: e['shippingInformation'],
          ),
        )
        .toList();
  }

  @override
  Future<List<Product>> searchProducts(String query) async {
    final data = await remoteDataSource.get(
      'products/search',
      queryParameters: {'q': query},
    );
    return (data['products'] as List)
        .map(
          (e) => Product(
            id: e['id'],
            title: e['title'],
            description: e['description'],
            price: e['price'].toDouble(),
            category: e['category'],
            thumbnail: e['thumbnail'],
            rating: e['rating'].toDouble(),
            shippingInformation: e['shippingInformation'],
          ),
        )
        .toList();
  }

  @override
  Future<List<Product>> filterProductsByCategory(String category) async {
    final data = await remoteDataSource.get('products/category/$category');
    return (data['products'] as List)
        .map(
          (e) => Product(
            id: e['id'],
            title: e['title'],
            description: e['description'],
            price: e['price'].toDouble(),
            category: e['category'],
            thumbnail: e['thumbnail'],
            rating: e['rating'].toDouble(),
            shippingInformation: e['shippingInformation'],
          ),
        )
        .toList();
  }
}

import 'dart:convert';
import 'package:http/http.dart' as http;

class RemoteDataSource {
  Future<dynamic> get(
    String path, {
    Map<String, String>? queryParameters,
  }) async {
    final uri = Uri.https('dummyjson.com', path, queryParameters);
    final response = await http.get(uri);
    return jsonDecode(response.body);
  }
}

import 'package:dio/dio.dart';
import 'package:news/util/constants/api_urls.dart';

class ApiService {
  final Dio _dio;

  ApiService() : _dio = Dio() {
    _dio.options.baseUrl = ApiUrls.baseUrl;
    _dio.options.headers = {"Content-Type": "application/json"};
  }

  Future<Response> getJokes() async {
    try {
      final response = await _dio.get(
        ApiUrls.joke,
      );
      print(response);
      return response;
    } catch (e) {
      throw Exception('Failed to load joke: $e');
    }
  }
}

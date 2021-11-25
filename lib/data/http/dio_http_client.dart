import 'package:dio/dio.dart';
import 'package:flutter_demo/core/logger.dart';
import 'package:flutter_demo/data/http/http_client.dart' as client_interface;

class DioHttpClient extends client_interface.HttpClient {
  DioHttpClient(this._dio);

  late final Dio _dio;

  @override
  Future<T?> get<T>(
    String path, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response =
          await _dio.get<T>(path, queryParameters: queryParameters);
      return response.data;
    } catch (e, trace) {
      logger.e("Network error", e, trace);
      //TODO: Handle error messages here and convert to unique model
      rethrow;
    }
  }
}

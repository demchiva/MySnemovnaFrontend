import 'package:dio/dio.dart';

class NetworkManager {
  final Dio _dio = Dio();

  Future<Response<dynamic>> get({
    required final String path,
    final Map<String, dynamic>? queryParameters,
  }) async =>
      _dio.get(path, queryParameters: queryParameters);
}

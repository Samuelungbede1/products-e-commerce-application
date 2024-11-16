import 'package:dio/dio.dart';
import 'package:e_commerce/core/constant/api_constant.dart';

class ApiService {
  final Dio _dio = Dio(BaseOptions(baseUrl: ApiConstants.baseUrl));

  Future<Response> get(String endpoint) async {
    return await _dio.get(endpoint);
  }

  Future<Response> post(String endpoint, Map<String, dynamic> data) async {
    return await _dio.post(endpoint, data: data);
  }
}

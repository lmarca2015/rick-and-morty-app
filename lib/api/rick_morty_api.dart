import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

class RickMortyApi {

  static Dio get _dio => GetIt.I<Dio>();

  static Future get(String path, {required Map<String, dynamic> queryParameters}) async {
    try {
      final resp = await _dio.get(path, queryParameters: queryParameters);

      return resp;
    }  on DioException catch (_) {
      throw ('Error en el GET');
    }
  }

  static Future post(String path, Map<String, dynamic> data) async {
    final formData = FormData.fromMap(data);

    try {
      final resp = await _dio.post(path, data: formData);
      return resp.data;
    } on DioException catch (_) {
      throw ('Error en el POST');
    }
  }
}

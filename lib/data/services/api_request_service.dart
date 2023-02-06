import 'package:dio/dio.dart';

const String baseUrl = "https://fakestoreapi.com";

class APIRequest {
  final String url;

  APIRequest({required this.url});

  Dio _dio() {
    return Dio(BaseOptions(baseUrl: baseUrl, headers: {
      'Content-Type': 'application/json',
    }));
  }

  void get(
      {Function()? beforeSend,
      Function(dynamic data)? onSuccess,
      Function(dynamic error)? onError}) {
    _dio().get(url, ).then((response) {
      if (onSuccess != null) {
        onSuccess(response.data);
      }
    }).catchError((error) {
      if (onError != null) {
        onError(error);
      }
    });
  }
}

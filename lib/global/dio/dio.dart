import 'package:dio/dio.dart';

// ignore: avoid_classes_with_only_static_members
class MyDio {
  static const baseUrl = 'http://192.168.0.206:3000/api'; //local ip
  static BaseOptions options = BaseOptions(baseUrl: baseUrl);

  static Future<Dio> provideDio() async {
    final Dio dio = Dio(options);
    return dio;
  }
}

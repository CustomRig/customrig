import 'package:dio/dio.dart';

// ignore: avoid_classes_with_only_static_members
class MyDio {
  // static const baseUrl = 'http://10.0.2.2:3000/api'; //local ip
  static const baseUrl = 'https://custom-rig.herokuapp.com/api'; //heroku
  static BaseOptions options = BaseOptions(baseUrl: baseUrl);

  static Future<Dio> provideDio() async {
    final Dio dio = Dio(options);
    return dio;
  }
}

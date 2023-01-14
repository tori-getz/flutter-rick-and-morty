import 'package:dio/native_imp.dart';
import 'package:dio_logger/dio_logger.dart';
import 'package:flutter_rick_and_morty/core/constants.dart';

class HttpClient extends DioForNative {
  HttpClient([super.baseOptions]) {
    options
      ..baseUrl = Constants.baseUrl
      ..connectTimeout = 15000
      ..receiveTimeout = 15000;

    interceptors.add(dioLoggerInterceptor);
  }
}

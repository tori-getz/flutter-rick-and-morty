import 'package:dio/dio.dart';
import 'package:dio/native_imp.dart';
import 'package:dio_logger/dio_logger.dart';
import 'package:flutter_rick_and_morty/core/constants.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class HttpClient extends DioForNative {
  HttpClient(@factoryParam BaseOptions? super.baseOptions) {
    options
      ..baseUrl = Constants.baseUrl
      ..connectTimeout = 15000
      ..receiveTimeout = 15000;

    interceptors.add(dioLoggerInterceptor);
  }
}

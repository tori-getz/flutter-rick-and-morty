import 'package:dio/dio.dart';
import 'package:flutter_rick_and_morty/core/constants.dart';
import 'package:flutter_rick_and_morty/core/networking/network_info.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
abstract class ExternalModule {
  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

  @LazySingleton(as: NetworkInfo)
  NetworkInfoImpl get networkInfo =>
      NetworkInfoImpl(InternetConnectionChecker());

  @singleton
  Dio dio() {
    final dio = Dio()
      ..options.baseUrl = Constants.baseUrl
      ..options.connectTimeout = 15000
      ..options.receiveTimeout = 15000;

    return dio;
  }
}

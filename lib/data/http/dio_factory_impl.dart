import 'dart:developer';
import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_demo/data/http/dio_factory.dart';

class DioFactoryImpl extends DioFactory {
  DioFactoryImpl(this._baseUrl, {String? proxyIp}) : _proxyIp = proxyIp;

  final String _baseUrl;
  final String? _proxyIp;

  void _setupProxy(Dio dio) {
    if (_proxyIp != null) {
      debugPrint('Proxy Enabled');
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate;
          (HttpClient client) {
        client.findProxy = (Uri uri) => 'PROXY $_proxyIp;';
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      };
    }
  }

  @override
  Dio create() {
    final BaseOptions options = BaseOptions(
      baseUrl: _baseUrl,
    );
    Dio dio = Dio(options);
    dio.interceptors.addAll(
      [
        LogInterceptor(
          requestBody: true,
          logPrint: (Object obj) => log(
            obj.toString(),
          ),
        ),
      ],
    );
    _setupProxy(dio);
    return dio;
  }
}

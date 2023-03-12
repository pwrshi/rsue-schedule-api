import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';

Dio getDio() {
  var dio = Dio();
  dio.options.headers = {HttpHeaders.userAgentHeader: 'Mozilla/5.0 (X11; Linux x86_64; rv:99.0) Gecko/20100101 Firefox/99.0'},
  // Игнорирует всратый сертификат
  (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
      (HttpClient client) {
    // коллбэчит что всё ок
    client.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    return client;
  };
  return dio;
}

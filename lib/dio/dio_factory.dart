import 'package:dio/dio.dart';

class DioFactory {
  final _timeout = const Duration(seconds: 60);

  /// Создание сконфигурированного Dio-клиента.
  Future<Dio> create({required String baseUrl, required Dio dio}) async {
    final options = _createOptions(baseUrl: baseUrl);
    dio.options = options;
    final interceptors = await _createInterceptors();
    interceptors.forEach(dio.interceptors.add);
    return dio;
  }

  Future<List<Interceptor>> _createInterceptors() async {
    final interceptors = <Interceptor>[
      InterceptorsWrapper(
        onRequest:  (options, handler) {
          options.headers['Content-Type'] = 'application/json';
          options.headers['Access-Control-Allow-Origin'] = '*';
          options.headers['Accept'] = 'application/json';
          return handler.next(options);
        }
      ),
      InterceptorsWrapper(
        onRequest: (option, handler) {
          print('url: ${option.uri} \ndata: ${option.data}');
          return handler.next(option);
        },
        onResponse: (Response response, ResponseInterceptorHandler handler) {
          print(response.data);
          print(response.realUri);
          handler.next(response);
        },
        onError: (error, handler) {
          print('error!!!\n\n url: ${error.response?.realUri}\n\n data: ${error.response?.data}');
          return handler.next(error);
        },
      ),
    ];
    return interceptors;
  }

  BaseOptions _createOptions({required String baseUrl}) {
    return BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: _timeout,
      receiveTimeout: _timeout,
      sendTimeout: _timeout,
    );
  }
}
import 'package:dio/dio.dart';
import 'package:reservation_site/consts/urls.dart';
import 'package:reservation_site/dio/dio_factory.dart';


abstract class DioManager {
  static final dio = Dio();

  static Future<void> init() async {
    final dioFactory = DioFactory();
    await dioFactory.create(
      baseUrl: Urls.mainUrl,
      dio: DioManager.dio,
    );
  }
}

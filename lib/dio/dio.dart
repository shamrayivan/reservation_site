import 'package:dio/dio.dart';
import 'package:reservation_site/consts/urls.dart';
import 'package:reservation_site/dio/dio_factory.dart';


class DioManager {
  final dio = Dio();

  Future<void> init() async {
    final dioFactory = DioFactory();
    await dioFactory.create(
      baseUrl: Urls.mainUrl,
      dio: dio,
    );
  }
}

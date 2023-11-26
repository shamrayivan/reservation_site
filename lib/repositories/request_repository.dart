import 'package:reservation_site/consts/urls.dart';
import 'package:reservation_site/dio/dio.dart';

abstract class RequestRepository {
  static Future<void> createRequest(
      {required String guestName,
      required String guestPhone,
      required int persons,
      required String dateStart,
      required String? note}) async {
    final response = await DioManager().dio.post<dynamic>(Urls.request, data: {
      'guestName': guestName,
      'guestPhone': guestPhone,
      'persons': persons,
      'dateStart': dateStart,
      'note': note
    });
    print(response.data);
  }
}

import 'package:dio/dio.dart';
import 'package:reservation_site/consts/urls.dart';
import 'package:reservation_site/dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:reservation_site/utils/clear_phone.dart';

abstract class RequestRepository {
  static Future<void> createRequest(
      {required String guestName,
      required String guestPhone,
      required String persons,
      required String dateStart,
      required String? note}) async {
    // final res = await http.post(Uri.parse(Urls.request),
    //     body:
    // {'guestName': '1',
    //   'guestPhone': '76543212345',
    //   'persons': '3',
    //   'dateStart': '2023-12-01T21:55:22.397',
    //   'note': '1'}
    // {
    //   'guestName': guestName,
    //   'guestPhone': guestPhone,
    //   'persons': persons,
    //   'dateStart': dateStart,
    //   'note': note
    // }
    // );
    // final response = await DioManager().dio.post<dynamic>(Urls.request, data: {
    //   'guestName': guestName,
    //   'guestPhone': guestPhone,
    //   'persons': persons,
    //   'dateStart': dateStart,
    //   'note': note
    // }););
    final response = await DioManager.dio.post<dynamic>(Urls.request, data: {
      'guestName': guestName,
      'guestPhone': cleanPhoneNumber(number: guestPhone),
      'persons': persons,
      'dateStart': dateStart,
      'note': note
    });
  }
}

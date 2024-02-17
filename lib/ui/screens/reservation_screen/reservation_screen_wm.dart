import 'package:flutter/cupertino.dart' hide Action;
import 'package:flutter/material.dart' hide Action;
import 'package:intl/intl.dart';
import 'package:relation/relation.dart';
import 'package:reservation_site/model/common/widget_model_standart.dart';
import 'package:reservation_site/repositories/request_repository.dart';
import 'dart:js' as js;

import 'package:reservation_site/ui/screens/thank_screen/thank_screen.dart';

class ReservationScreenWm extends WidgetModelStandard {
  final nameController = TextEditingAction();
  final phoneController = TextEditingAction();
  final noteController = TextEditingAction();
  final personState = StreamedState<int>();
  final dateState = StreamedStateNS<DateTime>(DateTime.now());
  final dateTimeState = StreamedStateNS<String>('');
  final timeState = StreamedStateNS<TimeOfDay>(const TimeOfDay(hour: 20, minute: 0));

  final scrollController = ScrollController();

  final onSendRequest = Action<BuildContext>();

  final loadingState = StreamedStateNS<bool>(false);

  final enableRequestButton = StreamedStateNS<bool>(false);

  @override
  void onInit() {}

  @override
  void onBind() {
    for (final stream in [
      nameController.stream,
      phoneController.stream,
      personState.stream,
      dateState.stream,
    ]) {
      subscribe(stream, (value) {
        _validation();
      });
    }

    subscribe(onSendRequest.stream, (context) async {
      loadingState.accept(true);
      doFutureHandleError(
          RequestRepository.createRequest(
              guestName: nameController.controller.text,
              guestPhone: '${phoneController.controller.text}',
              persons: personState.value.toString(),
              dateStart: dateState.value.toString(),
              note: noteController.controller.text), onValue: (value) async {
        if (context != null) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Заявка на бронирование отправлена. Скоро с Вами свяжутся :)'),));
          await Future.delayed(const Duration(seconds: 1));
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const ThankScreen()),);
        }
      }, onError: (e, s) {
        doFutureHandleError(RequestRepository.sendToTelegram(
            guestName: nameController.controller.text,
            guestPhone: '${phoneController.controller.text}',
            persons: personState.value.toString(),
            dateStart: DateFormat('HH:mm dd MMMM yyyy', 'ru').format(dateState.value),
            note: noteController.controller.text), onError: (e,s){
          if (context != null) {
            showDialog(
              context: context,
              builder: (context) {
                return SizedBox(
                  width: 300,
                  child: Center(
                    child: Container(
                      decoration: const BoxDecoration(
                          color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(12))),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Что-то пошло не так.\nПопробуйте связаться с нами по телефону:',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontFamily: 'Helvetica'),
                            ),
                            GestureDetector(
                              onTap: () async {
                                js.context.callMethod('open', ['tel:9202404747']);
                              },
                              child: const Text(
                                '8 (920) 240-47-47',
                                style: TextStyle(fontFamily: 'Helvetica', fontWeight: FontWeight.w600, fontStyle: FontStyle.italic),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }
        });
      }, onFinally: () {
        loadingState.accept(false);
      });
    });
  }

  void _validation() {
    if (nameController.controller.text.isNotEmpty &&
        phoneController.controller.text.length == 15 &&
        personState.value != null &&
        dateTimeState.value.isNotEmpty) {
      enableRequestButton.accept(true);
    } else {
      enableRequestButton.accept(false);
    }
  }
}

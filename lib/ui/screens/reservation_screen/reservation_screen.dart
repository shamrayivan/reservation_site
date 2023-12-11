import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mwwm/mwwm.dart';
import 'package:relation/relation.dart';
import 'package:reservation_site/ui/screens/reservation_screen/reservation_screen_wm.dart';
import 'package:reservation_site/ui/widgets/phone_text_field.dart';
import 'package:reservation_site/ui/widgets/text_input.dart';

class ReservationScreen extends CoreMwwmWidget {
  ReservationScreen({
    Key? key,
  }) : super(
          key: key,
          widgetModelBuilder: (_) => ReservationScreenWm(),
        );

  @override
  State<StatefulWidget> createState() => _ReservationScreenState();
}

class _ReservationScreenState extends WidgetState<ReservationScreenWm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          fit: StackFit.expand,
          alignment: Alignment.topCenter,
          children: [
            Image.asset(
              'assets/images/backgroundImage.png',
              fit: BoxFit.cover,
            ),
            ListView(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(height: 6,),
                const Center(
                  child: Text(
                    'Игуана',
                    style: TextStyle(
                      color: Colors.amberAccent,
                      fontSize: 32,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 26,
                ),
                const Center(
                  child: Text(
                    'Забронировать стол',
                    style: TextStyle(
                      color: Colors.amberAccent,
                      fontSize: 20,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Column(
                  children: [
                    const Text(
                      'Давайте знакомиться *',
                      style: TextStyle(
                        color: Colors.amberAccent,
                        fontSize: 16,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: 300,
                        child: CustomTextField(
                          fontFamily: 'Helvetica',
                          controller: wm.nameController.controller,
                          enabled: true,
                          hintText: 'Как вас зовут?',
                          hintColor: Colors.grey,
                          keyboardType: TextInputType.text,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Желаемая дата и время *',
                      style: TextStyle(
                        color: Colors.amberAccent,
                        fontSize: 16,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: 300,
                        child: StreamedStateBuilderNS(
                          streamedStateNS: wm.dateState,
                          builder: (context, date) {
                            return GestureDetector(
                              onTap: () async {
                                final newDate = await showDatePicker(
                                  context: context,
                                  initialDate: date ,
                                  firstDate: DateTime(DateTime.now().year - 1),
                                  lastDate: DateTime(DateTime.now().year + 1),
                                  builder: (context, child) {
                                    DateTime currentDate = DateTime.now();
                                    return Theme(
                                      data: ThemeData(
                                        fontFamily: 'Helvetica',
                                        colorScheme: const ColorScheme.light(
                                          primary: Colors.black,
                                          onPrimary: Colors.white,
                                          onSurface: Colors.black,
                                        ),
                                        textButtonTheme: TextButtonThemeData(
                                          style: TextButton.styleFrom(
                                            foregroundColor: Colors.black,
                                            textStyle: const TextStyle(
                                              fontFamily: 'Helvetica',
                                            ),
                                          ),
                                        ),
                                      ),
                                      child: Dialog(
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(24.0),
                                          ),
                                        ),
                                        child: ConstrainedBox(
                                          constraints: const BoxConstraints(maxWidth: 400),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              CalendarDatePicker(
                                                initialDate:  wm.dateState.value,
                                                firstDate: DateTime(DateTime.now().year - 1),
                                                lastDate: DateTime(DateTime.now().year + 1),
                                                onDateChanged: (date) {
                                                  currentDate = date;
                                                },
                                              ),
                                              SizedBox(
                                                height: 120,
                                                child: Transform.scale(
                                                  scale: 0.9,
                                                  child: CupertinoTimerPicker(
                                                    initialTimerDuration: Duration(hours: wm.timeState.value.hour, minutes: wm.timeState.value.minute),
                                                    minuteInterval: 15,
                                                    mode: CupertinoTimerPickerMode.hm,
                                                    onTimerDurationChanged: (value) {
                                                      final timeOfDay = TimeOfDay.fromDateTime(DateTime(0).add(value));
                                                      wm.timeState.accept(timeOfDay);
                                                    },
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(10.0),
                                                child: Container(
                                                  alignment: AlignmentDirectional.centerEnd,
                                                  child: OverflowBar(
                                                    spacing: 2,
                                                    children: <Widget>[
                                                      TextButton(
                                                        onPressed: () {
                                                          Navigator.pop(context,);
                                                        },
                                                        child: const Text(
                                                          "Отмена",
                                                          style: TextStyle(
                                                            fontSize: 18,
                                                          ),
                                                        ),
                                                      ),
                                                      TextButton(
                                                        onPressed: () {
                                                          Navigator.pop(context, currentDate);
                                                        },
                                                        child: const Text(
                                                          "Ок",
                                                          style: TextStyle(
                                                            fontSize: 18,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                                if(newDate != null) {
                                  wm.dateState.accept(DateTime(newDate.year, newDate.month, newDate.day, wm.timeState.value.hour, wm.timeState.value.minute));
                                  wm.dateTimeState.accept(DateFormat('dd MMMM HH:mm', 'ru').format(wm.dateState.value));
                                } else {
                                  // wm.timeState.accept(const TimeOfDay(hour: 20, minute: 0));
                                }
                                print(newDate);
                              },
                              child:
                              Container(
                                decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(12))),
                                child: StreamedStateBuilderNS(
                                  streamedStateNS: wm.dateTimeState,
                                  builder: (context, dateTime) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
                                      child: Text(dateTime, style: const TextStyle(fontFamily: 'Helvetica'),),
                                    );
                                  }
                                ),)
                            );
                          }
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Примерное количество персон *',
                      style: TextStyle(
                        color: Colors.amberAccent,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    SizedBox(
                      height: 50,
                      width: 300,
                      child: Stack(
                        children: [
                          RawScrollbar(
                            crossAxisMargin: -4,
                            controller: wm.scrollController,
                            thumbColor: Colors.amberAccent,
                            thumbVisibility: true,
                            thickness: 1,
                            child: ListView.separated(
                              separatorBuilder: (context, index) {
                                return const SizedBox(
                                  width: 16,
                                );
                              },
                              controller: wm.scrollController,
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              physics: const AlwaysScrollableScrollPhysics(),
                              itemCount: 8,
                              itemBuilder: (context, index) {
                                return StreamedStateBuilder(
                                  streamedState: wm.personState,
                                  builder: (context, countPerson) {
                                    return GestureDetector(
                                      onTap: () {
                                        wm.personState.accept(index + 1);
                                      },
                                      child: Container(
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            width: 0.5,
                                              color: index + 1 != countPerson ? Colors.amberAccent : Colors.white),
                                            shape: BoxShape.circle,
                                            color: index + 1 == countPerson
                                                ? Colors.amberAccent
                                                : Colors.black.withOpacity(0.9)),
                                        child: Center(
                                          child: Text(
                                            (index + 1).toString(),
                                            style: TextStyle(
                                              color: index + 1 == countPerson
                                                  ? Colors.black
                                                  : Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                          // Align(alignment: Alignment.centerLeft,
                          //   child: IconButton(onPressed: (){}, icon: Icon(Icons.arrow_back_ios),  color: Colors.amberAccent,),),
                          // Align(alignment: Alignment.centerRight,
                          // child: IconButton(onPressed: (){}, icon: Icon(Icons.arrow_forward_ios),  color: Colors.amberAccent,),)
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const Text(
                      'Номер телефона *',
                      style: TextStyle(
                        color: Colors.amberAccent,
                        fontSize: 16,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                          width: 300,
                          child: PhoneTextFormField(
                            phoneController: wm.phoneController.controller,
                          )),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    const Text(
                      'Оставьте Ваши пожелания',
                      style: TextStyle(
                        color: Colors.amberAccent,
                        fontSize: 16,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: 300,
                        child: CustomTextField(
                          isForm: true,
                          fontFamily: 'Helvetica',
                          controller: wm.noteController.controller,
                          enabled: true,
                          hintText: 'Мы обязательно их учтём',
                          hintColor: Colors.grey,
                          keyboardType: TextInputType.text,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                  ],
                ),
                Column(
                  children: [
                    StreamedStateBuilderNS(
                      streamedStateNS: wm.enableRequestButton,
                      builder: (context, enable) {
                        return OutlinedButton(
                          style: OutlinedButton.styleFrom(backgroundColor: Colors.black),
                          onPressed: () {
                            enable ?
                            wm.onSendRequest.accept(context) : ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text('Заполните все данные, которые помечены звёздочкой', style: TextStyle(fontFamily: 'Helvetica'),),
                            ));;
                            // RequestRepository.createRequest(guestName: guestName, guestPhone: guestPhone, persons: persons, dateStart: dateStart, note: note)
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
                            child: Text(
                              'Отправить заявку',
                              style: TextStyle(color: enable ? Colors.amberAccent : Colors.amberAccent.withOpacity(0.5), fontSize: 16),
                            ),
                          ),
                        );
                      }
                    ),
                  ],
                ),
              ],
            ),
            StreamedStateBuilderNS(streamedStateNS: wm.loadingState, builder: (context, loading){
              return loading ? Container(
                color: Colors.black.withOpacity(0.7),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                          height: 40,
                          width: 40,
                          child: CircularProgressIndicator(color: Colors.amberAccent,)),
                    ],
                  )) : const SizedBox();
            })
          ],
        ),
      ),
    );
  }
}

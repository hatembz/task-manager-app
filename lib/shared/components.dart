import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:mymanager/provider/cubit/cubit.dart';
import 'package:mymanager/shared/constants.dart';

class Taskitem extends StatelessWidget {
  const Taskitem({
    Key? key,
    required this.index,
    required this.task,
  }) : super(key: key);
  final int index;
  final List task;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showBottomSheet(
            elevation: 20,
            context: context,
            builder: (context) {
              return Container(
                color: Colors.white,
                height: MediaQuery.of(context).size.height * 0.35,
                width: double.infinity,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      width: 100,
                      height: 5,
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(20)),
                    ),
                    const Spacer(),
                    TextButton(
                      style: TextButton.styleFrom(
                          maximumSize: const Size.fromHeight(50),
                          fixedSize: Size.fromWidth(
                              MediaQuery.of(context).size.width * 0.9),
                          elevation: 2,
                          primary: Colors.white,
                          backgroundColor: purpleClr,
                          padding: const EdgeInsets.all(10),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14))),
                      onPressed: () {
                        AppCubit.get(context).updateDatabase(
                            status: "done", id: task[index]["id"]);
                      },
                      child: const Text(
                        "Task Complete",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                          maximumSize: const Size.fromHeight(50),
                          fixedSize: Size.fromWidth(
                              MediaQuery.of(context).size.width * 0.9),
                          elevation: 2,
                          primary: Colors.white,
                          backgroundColor: pinkClr,
                          padding: const EdgeInsets.all(10),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14))),
                      onPressed: () {
                        AppCubit.get(context)
                            .deleteDatabase(id: task[index]["id"]);
                      },
                      child: const Text(
                        "Delete Task ",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          maximumSize: const Size.fromHeight(50),
                          fixedSize: Size.fromWidth(
                              MediaQuery.of(context).size.width * 0.9),
                          //  elevation: 2,
                          primary: Colors.white,
                          backgroundColor: Colors.white,
                          padding: const EdgeInsets.all(10),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14))),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Close",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    const Spacer()
                  ],
                ),
              );
            });
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        width: MediaQuery.of(context).size.width * 0.78,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: task[index]["color"] == "purple"
              ? purpleClr
              : task[index]["color"] == "pink"
                  ? pinkClr
                  : yellowClr,
        ),
        child: Row(
          children: [
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task[index]["title"],
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
                const SizedBox(
                  height: 6,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.timelapse,
                      color: Colors.grey[200],
                      size: 15,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      "${task[index]["start"]} - ${task[index]["end"]}",
                      style: TextStyle(fontSize: 13, color: Colors.grey[100]),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  task[index]["note"],
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ],
            )),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              height: 60,
              width: 0.5,
              color: Colors.grey[200]!.withOpacity(0.7),
            ),
            RotatedBox(
              quarterTurns: 3,
              child: Text(
                task[index]["status"] != "new" ? "COMPLETED" : "TODO",
                style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget datebar(BuildContext context) {
  return Container(
    padding: const EdgeInsets.only(bottom: 4),
    child: DatePicker(
      DateTime.now().subtract(const Duration(days: 3)),
      initialSelectedDate: DateTime.now(),
      selectionColor: Colors.transparent,
      selectedTextColor: pinkClr,
      dateTextStyle: const TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.w600,
        color: Colors.grey,
      ),
      dayTextStyle: const TextStyle(
        fontSize: 10.0,
        color: Colors.grey,
      ),
      monthTextStyle: const TextStyle(
        fontSize: 10.0,
        color: Colors.grey,
      ),
      onDateChange: (date) {
        AppCubit.get(context).datechange(date);
      },
    ),
  );
}

// ignore: must_be_immutable
class Inputfield extends StatelessWidget {
  bool readonly;
  final TextEditingController controller;
  // ignore: prefer_typing_uninitialized_variables
  final prefix;
  // ignore: prefer_typing_uninitialized_variables
  final suffix;
  final String hint;
  // ignore: prefer_typing_uninitialized_variables
  final validator;
  final TextInputType? keyboardtype;
  final VoidCallback? ontap;
  Inputfield({
    Key? key,
    this.prefix,
    this.suffix,
    required this.hint,
    this.ontap,
    this.validator,
    required this.controller,
    required this.readonly,
    this.keyboardtype,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardtype,
      validator: (String? value) {
        if (value!.isEmpty) {
          return " must not be empty";
        }
      },
      controller: controller,
      onTap: ontap,
      readOnly: readonly,
      decoration: InputDecoration(
        hintText: hint,
        suffixIcon: suffix != null
            ? Icon(
                suffix,
              )
            : null,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
      ),
    );
  }
}

class Formfelidheder extends StatelessWidget {
  final String title;

  // ignore: use_key_in_widget_constructors
  const Formfelidheder({required this.title}) : super();
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
          fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
    );
  }
}

int createUniqueId() {
  return DateTime.now().millisecondsSinceEpoch.remainder(100000);
}

class NotificationWeekAndTime {
  final int month;
  final int dayOfTheWeek;
  final TimeOfDay timeOfDay;

  NotificationWeekAndTime({
    required this.month,
    required this.dayOfTheWeek,
    required this.timeOfDay,
  });
}

Future<NotificationWeekAndTime?> pickSchedule(
  BuildContext context, {
  required date,
  required month,
  required TimeOfDay time,
}) async {
  List<String> weekdays = [
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun',
  ];
  DateTime now = DateTime.now();
  TimeOfDay? timeOfDay = TimeOfDay.fromDateTime(
    now.add(
      const Duration(minutes: 1),
    ),
  );
  int? selectedDay;
  selectedDay = weekdays.indexWhere((element) {
        return element == date;
      }) +
      1;
  timeOfDay = time;
  return NotificationWeekAndTime(
      month: month, dayOfTheWeek: selectedDay, timeOfDay: timeOfDay);
}

Future<void> createReminderNotification(
    NotificationWeekAndTime notificationSchedule,
    {required String title,
    required String body}) async {
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: createUniqueId(),
      channelKey: 'scheduled_channel',
      title: title,
      body: body,
      notificationLayout: NotificationLayout.Default,
    ),
    schedule: NotificationCalendar(
      month: notificationSchedule.month,
      weekday: notificationSchedule.dayOfTheWeek,
      hour: notificationSchedule.timeOfDay.hour,
      minute: notificationSchedule.timeOfDay.minute,
      second: 0,
      millisecond: 0,
      repeats: true,
    ),
  );
}

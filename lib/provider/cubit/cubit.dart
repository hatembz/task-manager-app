import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mymanager/pages/splash_screen.dart';
import 'package:mymanager/provider/cubit/states.dart';
import 'package:sqflite/sqflite.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());
  late Database database;
  static AppCubit get(context) => BlocProvider.of(context);
  List<bool> isSelected = <bool>[false, false, false];
  List task = [];
  bool isvisible = false;
  int value = 0;
  String selectedDate = DateFormat.yMEd().format(DateTime.now());

  TimeOfDay time = TimeOfDay.fromDateTime(
    DateTime.now().add(
      const Duration(minutes: 1),
    ),
  );
  TimeOfDay endtime = TimeOfDay.now();
  endtimeinitialization(TimeOfDay value) {
    endtime = value;
    emit(OnEndTimechange());
  }

  TimeOfDay reminderTime = TimeOfDay.now();
  void changereminderval(int val) {
    var min = endtime.minute;
    reminderTime = endtime.replacing(
        hour: min - val < 0 ? endtime.hour - 1 : endtime.hour,
        minute: min - val < 0 ? min + 60 - val : min - val);
    print("time is" + reminderTime.toString());
    value = val;
    emit(OnReminderUpdate());
  }

  colorpick(index) {
    isSelected = [false, false, false];
    isSelected[index] = !isSelected[index];
    emit(OnColorUpdate());

    return isSelected;
  }

  void datechange(date) {
    selectedDate = DateFormat.yMEd().format(date);

    emit(Ondatechange());
  }

  void updateDatabase({
    required String status,
    required int id,
  }) async {
    await database.rawUpdate(
        'UPDATE tasks SET status = ? WHERE id = ?', [status, id]).then((value) {
      getFromDatabase(database);
      emit(AppUpdateDbState());
    });
  }

  void deleteDatabase({required int id}) async {
    await database
        .rawDelete('DELETE FROM tasks WHERE id = ?', [id]).then((value) {
      getFromDatabase(database);
      emit(AppDeleteDbState());
    }).catchError((error) {});
  }

  void creatDataBase() {
    openDatabase("todo.db", version: 1, onCreate: (database, version) {
      database
          .execute(
              "CREATE TABLE tasks(id INTEGER PRIMARY KEY,title TEXT,note TEXT,date TEXT,start TEXT,end TEXT,reminder TEXT,color TEXT,status TEXT)")
          // ignore: avoid_print
          .then((value) => print("table created"))
          .catchError((error) {
        // ignore: avoid_print
        print("error eccured when creating table ${error.toString()}");
      });
    }, onOpen: (database) {
      getFromDatabase(database);
      // ignore: avoid_print
      print("database opened");
    }).catchError((error) {
      // ignore: avoid_print
      print('error eccured when creating db ${error.toString()}');
    }).then((value) {
      database = value;
      emit(AppOnCreateDbState());
    });
  }

  insertToDataBase(
      {required String title,
      required String? note,
      required String? date,
      required String? starttime,
      required String? endtime,
      required String? reminder,
      required String? color}) {
    database.transaction((txn) async {
      await txn
          .rawInsert(
              "INSERT INTO tasks(title,note,date,start,end,reminder,color,status)VALUES('$title','$note','$date','$starttime','$endtime','$reminder','$color','new')")
          .then((value) {
        // ignore: avoid_print
        print("$value inserted");
        emit(AppOninsertDbState());
        getFromDatabase(database);
        // ignore: avoid_print
        print("database opened");
      }).catchError((error) {
        // ignore: avoid_print
        print('error on inserting data ${error.toString()}');
      });
    });
  }

  void getFromDatabase(database) async {
    task = [];
    emit(AppGetDbLoadingState());
    database.rawQuery("SELECT * FROM tasks").then((value) {
      task = value;
      emit(AppGetFromDbState());
    });
  }

  // ignore: non_constant_identifier_names
  void NotificationAnitialaziation(BuildContext context) {
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Allow Notifications'),
            content: const Text('Our app would like to send you notifications'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Don\'t Allow',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 18,
                  ),
                ),
              ),
              TextButton(
                  onPressed: () => AwesomeNotifications()
                      .requestPermissionToSendNotifications()
                      .then((_) => Navigator.pop(context)),
                  child: const Text(
                    'Allow',
                    style: TextStyle(
                      color: Colors.teal,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ))
            ],
          ),
        );
      }
    });

    AwesomeNotifications().actionStream.listen((notification) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (_) => const splashScreen(),
        ),
        (route) => route.isFirst,
      );
    });

    emit(OnNotificationAnitialaziation());
  }

  @override
  Future<void> close() {
    AwesomeNotifications().actionSink.close();
    AwesomeNotifications().createdSink.close();
    return super.close();
  }
}

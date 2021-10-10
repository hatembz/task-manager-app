import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mymanager/pages/splash_screen.dart';
import 'package:mymanager/provider/bloc_observer.dart';
import 'package:mymanager/provider/cubit/cubit.dart';
import 'package:mymanager/shared/constants.dart';

void main() {
  AwesomeNotifications().initialize(
    '',
    [
      NotificationChannel(
        channelKey: 'scheduled_channel',
        channelName: 'Scheduled Notifications',
        defaultColor: Colors.teal,
        locked: true,
        importance: NotificationImportance.High,
      ),
    ],
  );

  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => AppCubit()..creatDataBase(),
        child: MaterialApp(
            home: const splashScreen(),
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              colorScheme: const ColorScheme.light(
                primary: purpleClr,
                primaryVariant: purpleClr,
                secondary: pinkClr,
                secondaryVariant: pinkClr,
              ),
              appBarTheme: AppBarTheme(
                  color: Colors.grey[50],
                  elevation: 0.0,
                  iconTheme: const IconThemeData(color: purpleClr)),
              scaffoldBackgroundColor: Colors.grey[50],
              backgroundColor: Colors.grey[100],
              brightness: Brightness.light,
            )));
  }
}

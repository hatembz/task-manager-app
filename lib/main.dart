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
            textTheme: TextTheme(
              // bodyText1: TextStyle(color: Colors.white,fontSize: ),
              bodyText2: TextStyle(
                  color: Colors.black,
                  fontSize: 26,
                  fontWeight: FontWeight.bold),
              headline1: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
              headline2: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
              headline3: TextStyle(
                fontSize: 10.0,
                color: Colors.black,
              ),
              headline4: TextStyle(
                color: Colors.grey[600],
                fontSize: 18,
              ),
            ),
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
          ),
          darkTheme: ThemeData(
            textTheme: TextTheme(
              // bodyText1: TextStyle(color: Colors.white,fontSize: ),
              bodyText2: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold),
              headline1: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
              headline2: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
              headline3: TextStyle(
                fontSize: 10.0,
                color: Colors.white,
              ),
              headline4: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
            colorScheme: ColorScheme.dark(
              primary: purpleClr,
              primaryVariant: purpleClr,
              secondary: pinkClr,
              secondaryVariant: pinkClr,
            ),
            appBarTheme: AppBarTheme(
                backgroundColor: Color(0xff3a3a38),
                elevation: 0.0,
                iconTheme: const IconThemeData(color: purpleClr)),
            scaffoldBackgroundColor: Color(0xff3a3a38),
            backgroundColor: Color(0xff3a3a38),
          ),
          themeMode: ThemeMode.system,
        ));
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mymanager/pages/add_task_page.dart';
import 'package:mymanager/provider/cubit/cubit.dart';
import 'package:mymanager/provider/cubit/states.dart';
import 'package:mymanager/shared/components.dart';
import 'package:mymanager/shared/constants.dart';
import 'package:flutter_svg/svg.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (contextn, state) {
        if (state is AppOnCreateDbState) {
          AppCubit.get(context).NotificationAnitialaziation(context);
        }

        if (state is AppDeleteDbState) Navigator.pop(context);
        if (state is AppUpdateDbState) Navigator.pop(context);
      },
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        var task = cubit.task;
        var tasks = task
            .where((element) => element["date"] == cubit.selectedDate)
            .toList();

        tasks.sort((a, b) {
          return int.parse(a["start"].split(":")[0])
              .compareTo(int.parse(b["start"].split(":")[0]));
        });
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.grey[50],
            title: const Text(
              "your daily Schedule",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            elevation: 0.0,
            centerTitle: true,
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            DateFormat.yMMMd().format(DateTime.now()),
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 18,
                            ),
                          ),
                          const Text(
                            "Today",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 26,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      )),
                      TextButton.icon(
                          label: const Text("Add task"),
                          icon: const Icon(Icons.add),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AddTask()));
                          },
                          style: TextButton.styleFrom(
                              maximumSize: const Size.fromHeight(50),
                              fixedSize: const Size.fromWidth(130),
                              elevation: 2,
                              primary: Colors.white,
                              backgroundColor: purpleClr,
                              padding: const EdgeInsets.all(10),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14)))),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  datebar(context),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  tasks.isEmpty
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              "assets/images/task.svg",
                              color: purpleClr.withOpacity(0.5),
                              height: 90,
                              semanticsLabel: 'Task',
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 10),
                              child: Text(
                                "You do not have any tasks yet!\nAdd new tasks to make your days productive.",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            const SizedBox(
                              height: 80,
                            ),
                          ],
                        )
                      : Expanded(
                          child: ListView.separated(
                            separatorBuilder: (context, index) {
                              return const Divider();
                            },
                            itemCount: tasks.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Taskitem(
                                task: tasks,
                                index: index,
                              );
                            },
                          ),
                        ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

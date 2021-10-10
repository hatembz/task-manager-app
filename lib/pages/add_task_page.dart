import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mymanager/provider/cubit/cubit.dart';
import 'package:mymanager/provider/cubit/states.dart';
import 'package:mymanager/shared/components.dart';
import 'package:mymanager/shared/constants.dart';

// ignore: must_be_immutable
class AddTask extends StatelessWidget {
  var titleController = TextEditingController();

  var starttimeController = TextEditingController();

  var endTimeController = TextEditingController();

  var dateController = TextEditingController();

  var notController = TextEditingController();

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  AddTask({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Form(
                key: formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Add Task",
                      style:
                          TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    const Formfelidheder(title: "Title"),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.015,
                    ),
                    Inputfield(
                      readonly: false,
                      controller: titleController,
                      hint: "The Task Title",
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.015,
                    ),
                    const Formfelidheder(title: "Note"),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.015,
                    ),
                    Inputfield(
                      readonly: false,
                      controller: notController,
                      hint: "Any Extra Info",
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.015,
                    ),
                    const Formfelidheder(title: "Date"),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.015,
                    ),
                    Inputfield(
                      keyboardtype: TextInputType.datetime,
                      readonly: false,
                      controller: dateController,
                      ontap: () {
                        datepicker(context).then((value) => dateController
                            .text = DateFormat.yMEd().format(value!));
                      },
                      hint: "EX: 12 february 2020 ",
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.015,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Formfelidheder(title: "Start Time"),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.01,
                              ),
                              Inputfield(
                                readonly: true,
                                suffix: Icons.timer,
                                controller: starttimeController,
                                ontap: () {
                                  showTimePicker(
                                          context: context,
                                          initialTime: AppCubit().time)
                                      .then((value) {
                                    AppCubit.get(context)
                                        .endtimeinitialization(value!);
                                    /*     DateTime parsedTime = DateFormat.jm().parse(
                                        value.format(context).toString());
 */
                                    starttimeController.text =
                                        value.format(context).toString();

                                    // DateFormat('HH:mm').format(parsedTime);
                                  });
                                },
                                hint: "EX: 11:00",
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Formfelidheder(title: "End Time"),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.01,
                              ),
                              Inputfield(
                                readonly: true,
                                suffix: Icons.timer,
                                controller: endTimeController,
                                ontap: () {
                                  showTimePicker(
                                    context: context,
                                    initialTime: AppCubit.get(context).endtime,
                                  ).then((TimeOfDay? value) {
                                    /*      DateTime parsedTime = DateFormat.jms()
                                        .parse(
                                            value!.format(context).toString());
 */
                                    endTimeController.text =
                                        value!.format(context).toString();
                                    // DateFormat('HH:mm').format(parsedTime);
                                  });
                                  /* Navigator.push(
                                      context,
                                      showPicker(
                                          is24HrFormat: true,
                                          blurredBackground: true,
                                          context: context,
                                          value: AppCubit.get(context).endtime,
                                          onChange: (value) {
                                            DateTime parsedTime =
                                                DateFormat.jm().parse(value
                                                    .format(context)
                                                    .toString());

                                            endTimeController.text =
                                                DateFormat('HH:mm')
                                                    .format(parsedTime);
                                          })); */
                                },
                                hint: "EX: 12:00",
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.015,
                    ),
                    const Formfelidheder(title: "Reminder"),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.015,
                    ),
                    DropdownButtonFormField(
                      hint: const Text("5 min early"),
                      onChanged: (int? value) {
                        AppCubit.get(context).changereminderval(value!);
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14)),
                      ),
                      items: const [
                        DropdownMenuItem(
                          child: Text("none"),
                          value: 0,
                        ),
                        DropdownMenuItem(
                          child: Text("5 min"),
                          value: 5,
                        ),
                        DropdownMenuItem(
                          child: Text("10 min"),
                          value: 10,
                        ),
                        DropdownMenuItem(
                          child: Text("15 min"),
                          value: 15,
                        )
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Formfelidheder(title: "color"),
                            ToggleButtons(
                              borderColor: Colors.transparent,
                              selectedBorderColor: Colors.transparent,
                              fillColor: Colors.transparent,
                              splashColor: Colors.transparent,
                              children: [
                                CircleAvatar(
                                  backgroundColor: purpleClr,
                                  child: Visibility(
                                    visible:
                                        AppCubit.get(context).isSelected[0],
                                    child: const Icon(
                                      Icons.done,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                CircleAvatar(
                                  backgroundColor: pinkClr,
                                  child: Visibility(
                                    visible:
                                        AppCubit.get(context).isSelected[1],
                                    child: const Icon(
                                      Icons.done,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                CircleAvatar(
                                  backgroundColor: yellowClr,
                                  child: Visibility(
                                    visible:
                                        AppCubit.get(context).isSelected[2],
                                    child: const Icon(
                                      Icons.done,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                              isSelected: AppCubit.get(context).isSelected,
                              onPressed: (index) {
                                AppCubit.get(context).colorpick(index);
                              },
                            )
                          ],
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                              elevation: 2,
                              maximumSize: const Size.fromHeight(50),
                              fixedSize: const Size.fromWidth(130),
                              primary: Colors.white,
                              backgroundColor: purpleClr,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14))),
                          child: const Text(
                            "Create task",
                          ),
                          onPressed: () async {
                            if (formkey.currentState!.validate()) {
                              AppCubit.get(context).insertToDataBase(
                                title: titleController.text,
                                date: dateController.text,
                                starttime: starttimeController.text,
                                color:
                                    AppCubit.get(context).isSelected[0] == true
                                        ? "purple"
                                        : AppCubit.get(context).isSelected[1] ==
                                                true
                                            ? "pink"
                                            : "yellow",
                                endtime: endTimeController.text,
                                note: notController.text,
                                reminder:
                                    AppCubit.get(context).value.toString(),
                              );

                              NotificationWeekAndTime? pickedSchedule =
                                  await pickSchedule(context,
                                      date: dateController.text.split(",")[0],
                                      time: AppCubit.get(context).reminderTime,
                                      month: int.parse(
                                        dateController.text
                                            .split(",")[1]
                                            .split("/")[0],
                                      ));

                              if (pickedSchedule != null) {
                                createReminderNotification(pickedSchedule,
                                    title: titleController.text,
                                    body: notController.text);
                              }
                              Navigator.pop(context);
                            } else {}
                          },
                        ),
                      ],
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

  Future<DateTime?> datepicker(BuildContext context) {
    return showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2030));
  }
}

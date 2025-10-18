import 'package:attandace_app/model/models.dart';
import 'package:attandace_app/services/attendance_service.dart';
import 'package:attandace_app/services/dateBase.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:slide_to_act/slide_to_act.dart';

class Attandence extends StatefulWidget {
  const Attandence({super.key});

  @override
  State<Attandence> createState() => _AttandenceState();
}

class _AttandenceState extends State<Attandence> {
  final GlobalKey<SlideActionState> key = GlobalKey();

  @override
  void initState() {
    Provider.of<AttendanceService>(context, listen: false).getAttendancedate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final attendance = Provider.of<AttendanceService>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              Text(
                'WELCOME',
                style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade500),
              ),
              Consumer<Datebase>(
                builder: (context, value, child) {
                  return FutureBuilder(
                    future: value.getUserDate(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        UserModels user = snapshot.data!;
                        return Text(
                            user.name != '' ? user.name : "#${user.employeeID}",
                            style: TextStyle(
                              fontSize: 34,
                              fontWeight: FontWeight.bold,
                            ));
                      }
                      return SizedBox(
                        width: 88,
                        child: LinearProgressIndicator(),
                      );
                    },
                  );
                },
              ),
              const SizedBox(height: 20),
              Text(
                'Today Status',
                style: TextStyle(
                    fontSize: 27,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade500),
              ),
              Container(
                margin: const EdgeInsets.only(top: 12.0, bottom: 30),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10,
                          offset: const Offset(2, 2)),
                    ]),
                child: Row(
                  children: [
                    Expanded(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                          const Text(
                            'Checked In',
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.black54),
                          ),
                          const SizedBox(
                            width: 88,
                            child: Divider(),
                          ),
                          Text(
                            attendance.attandanceModel?.checkIn ?? '--/--',
                            style: const TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ])),
                    Expanded(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Checked Out',
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54),
                        ),
                        const SizedBox(
                          width: 88,
                          child: Divider(),
                        ),
                        Text(
                          attendance.attandanceModel?.checkOut ?? '--/--',
                          style: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ))
                  ],
                ),
              ),
              Text(
                DateFormat('dd MMMM yyyy').format(DateTime.now()),
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 0, 0, 0)),
              ),
              StreamBuilder(
                  stream: Stream.periodic(Duration(seconds: 1)),
                  builder: (context, snapshot) {
                    return Text(
                      DateFormat('hh:mm ss a').format(DateTime.now()),
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54),
                    );
                  }),
              Container(
                  margin: const EdgeInsets.only(top: 26),
                  child: Builder(
                    builder: (context) {
                      return SlideAction(
                        key: key,
                        text: attendance.attandanceModel?.checkIn == null
                            ? 'Slide To Check in'
                            : 'Slide To Check Out',
                        textStyle: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54),
                        innerColor: const Color.fromARGB(255, 68, 214, 55),
                        outerColor: const Color.fromARGB(255, 255, 255, 255),
                        onSubmit: () async {
                          await attendance.checkAttendanceDate(context);
                          key.currentState!.reset();
                        },
                      );
                    },
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

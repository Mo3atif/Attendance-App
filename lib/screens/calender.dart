import 'package:attandace_app/model/attandance_model.dart';
import 'package:attandace_app/services/attendance_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:simple_month_year_picker/simple_month_year_picker.dart';

class Calender extends StatefulWidget {
  const Calender({super.key});

  @override
  State<Calender> createState() => _CalenderState();
}

class _CalenderState extends State<Calender> {
  @override
  Widget build(BuildContext context) {
    final attendanceService = Provider.of<AttendanceService>(context);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 40,
          ),
          Text(
            'My Attendance',
            style: TextStyle(fontSize: 29, fontWeight: FontWeight.bold),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                attendanceService.attendanceHistory,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              OutlinedButton(
                  onPressed: () async {
                    final selectedDate =
                        await SimpleMonthYearPicker.showMonthYearPickerDialog(
                            context: context, disableFuture: true);
                    String pickedDate =
                        DateFormat('yyyy-MM').format(selectedDate);
                    attendanceService.attandanceHistory = pickedDate;
                  },
                  child: Text('Pick Date'))
            ],
          ),
          Expanded(
              child: FutureBuilder(
            future: attendanceService.getattandanceHistory(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data.length > 0) {
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      AttandanceModel attendanceService = snapshot.data[index];
                      return Container(
                        margin: EdgeInsets.only(
                          top: 12,
                          left: 20,
                          right: 20,
                          bottom: 20,
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  offset: Offset(2, 2),
                                  blurRadius: 4,
                                  color: Colors.black54)
                            ]),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.all(20),
                                margin: EdgeInsets.only(),
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 197, 10, 10),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                ),
                                child: Center(
                                  child: Text(
                                    DateFormat('EE \n dd')
                                        .format(attendanceService.createdAt),
                                    style: TextStyle(
                                        color: const Color.fromARGB(
                                            255, 255, 255, 255),
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                                child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Check in',
                                  style: TextStyle(
                                      color: const Color.fromARGB(255, 0, 0, 0),
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 88,
                                  child: Divider(),
                                ),
                                Text(
                                  attendanceService.checkIn,
                                  style: TextStyle(
                                      color: const Color.fromARGB(255, 0, 0, 0),
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            )),
                            Expanded(
                                child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Check Out',
                                  style: TextStyle(
                                      color: const Color.fromARGB(255, 0, 0, 0),
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 88,
                                  child: Divider(),
                                ),
                                Text(
                                  attendanceService.checkOut?.toString() ??
                                      '--/--',
                                  style: TextStyle(
                                      color: const Color.fromARGB(255, 0, 0, 0),
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ))
                          ],
                        ),
                      );
                    },
                  );
                } else {
                  return Center(
                    child: Text(
                      'No Data Found',
                      style: TextStyle(fontSize: 26),
                    ),
                  );
                }
              }
              return LinearProgressIndicator(
                backgroundColor: Colors.white,
                color: Colors.grey,
              );
            },
          ))
        ],
      ),
    );
  }
}

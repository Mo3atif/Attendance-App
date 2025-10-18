








import 'package:attandace_app/screens/attandence.dart';
import 'package:attandace_app/screens/calender.dart';
import 'package:attandace_app/screens/profile.dart';
import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class Company extends StatefulWidget {
  const Company({super.key});

  @override
  State<Company> createState() => _CompanyState();
}

class _CompanyState extends State<Company> {
  List<IconData> buttonNavIcon = const[
    FontAwesomeIcons.solidCalendarDays,
    FontAwesomeIcons.solidUser,
    FontAwesomeIcons.check,
  ];
int currentIndex=1;
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: IndexedStack(
        index: currentIndex,
        children: [
          Calender(),
          ProfileScreen(),
          Attandence(),
        ],
      ),
     
      bottomNavigationBar:Container(
        height: 70,
        margin: EdgeInsets.only(left: 12, right: 12, bottom: 24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(color: Colors.black26, offset: Offset(2, 2)),
          ]
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            for(int i=0; i < buttonNavIcon.length;i++)...{
              Expanded(child: GestureDetector(
                onTap: () {
                  setState(() {
                    currentIndex=i;
                  });
                },
             child: Center(
              child: FaIcon(buttonNavIcon[i],
              color: i==currentIndex ?Colors.redAccent:Colors.black,
              size: i==currentIndex? 35:26,),
             ),
              )
              )
            }
          ],
        ),
      )
    );
  }
}

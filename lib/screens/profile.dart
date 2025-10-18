import 'package:attandace_app/services/auth_services.dart';
import 'package:attandace_app/services/dateBase.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final dbService = Provider.of<Datebase>(context);
    // Using below conditions because build can be called multiple times
    dbService.allDepartments.isEmpty ? dbService.getDepartmentList() : null;
    nameController.text.isEmpty
        ? nameController.text = dbService.usermodel?.name ?? ''
        : null;
    return Scaffold(
        body: dbService.usermodel == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        alignment: Alignment.topRight,
                        child: TextButton.icon(
                            onPressed: () {
                             Provider.of<AuthServices>(context, listen: false)
                                .signOut(context);
                            },
                            icon: const Icon(Icons.logout),
                            label: const Text("Sign Out")),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.redAccent),
                        child: const Center(
                          child: Icon(
                            Icons.person,
                            size: 50,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text("Employee ID : ${dbService.usermodel?.employeeID}"),
                      const SizedBox(
                        height: 30,
                      ),
                      
                    ],
                  ),
                ),
              ));
  }
}

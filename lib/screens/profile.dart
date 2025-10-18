import 'package:attandace_app/model/department_model.dart';
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
  return Scaffold(
      body: Center(
        child: Text("Profile Screen"),
      ),
    );
  }
}

import 'package:attandace_app/screens/company.dart';
import 'package:attandace_app/screens/login_page.dart';
import 'package:attandace_app/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SpleashScreen extends StatelessWidget {
  const SpleashScreen({super.key});

  @override
  Widget build(BuildContext context) {
   final authServices = Provider.of<AuthServices>(context);
    return authServices.currentUser == null ? LoginPage() : Company();
  }
}

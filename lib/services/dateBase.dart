import 'dart:math';

import 'package:attandace_app/constent/constent.dart';
import 'package:attandace_app/model/department_model.dart';
import 'package:attandace_app/model/models.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Datebase extends ChangeNotifier {
  final SupabaseClient _supabase = Supabase.instance.client;
  List<DepartmentModel> allDepartments = [];
  int? employeeDepartment;
  UserModels? usermodel;

  String genreateEmployeeID() {
    final random = Random();
    const allcharecter = 'MoAtif1234567890';
    final randomString = List.generate(
      8,
      (index) => allcharecter[random.nextInt(allcharecter.length)],
    ).join();
    return randomString;
  }

  Future insertNewUserDate(String email, var id) async {
    await _supabase.from(Constent.employeesTabel).insert({
      'id': id,
      'email': email,
      'name': '',
      'employeeID': genreateEmployeeID(),
      'department': null,
    });
  }

  Future<UserModels> getUserDate() async {
    final userDate = await _supabase
        .from(Constent.employeesTabel)
        .select()
        .eq('id', _supabase.auth.currentUser!.id)
        .single();
    usermodel = UserModels.fromJson(userDate);
    employeeDepartment == null
        ? employeeDepartment = usermodel!.department
        : null;
    return usermodel!;
  }

  Future<void> getDepartmentList() async {
    final List result = await _supabase.from(Constent.departmentTable).select();
    allDepartments = result
        .map((department) => DepartmentModel.fromJson(department))
        .toList();
    notifyListeners();
  }

  Future updateUserData(String name, BuildContext context) async {
    await _supabase.from(Constent.employeesTabel).update({
      'name': name,
      'department': allDepartments,
    }).eq('id', _supabase.auth.currentUser!.id);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Profile Updated Successfully'),
      ),
    );
    notifyListeners();
  }
}

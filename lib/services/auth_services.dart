import 'package:attandace_app/screens/company.dart';
import 'package:attandace_app/services/dateBase.dart';
import 'package:attandace_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthServices extends ChangeNotifier {
  final SupabaseClient _supabase = Supabase.instance.client;
  final Datebase _datebase = Datebase();
  bool _isLoding = false;
  get isLoding => _isLoding;

  set setIsLoding(bool value) {
    _isLoding = value;
    notifyListeners();
  }

  Future regstireEmployye(
      String email, String password, BuildContext context) async {
    try {
      setIsLoding = true;
      if (email == '' || password == '') {
        throw 'Please fill all the fields';
      }
      final AuthResponse response = await _supabase.auth.signUp(
        email: email,
        password: password,
      );
      if (response != null) {
        await _datebase.insertNewUserDate(email, response.user!.id);
        Utils.showSnackBar(context, 'registration successfuly ! ',
            color: Colors.green);
        loginEmployye(email, password, context);
        
      }
    } catch (e) {
      setIsLoding = false;
      Utils.showSnackBar(context, e.toString(), color: Colors.red);
    }
  }

  Future loginEmployye(
      String email, String password, BuildContext context) async {
    try {
      setIsLoding = true;
      if (email == '' || password == '') {
        throw 'Please fill all the fields';
      }
      final AuthResponse response = await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Company()));
      setIsLoding = false;
    } catch (e) {
      setIsLoding = false;
      Utils.showSnackBar(context, e.toString(), color: Colors.red);
    }
  }

  Future signOut(BuildContext context) async {
    await _supabase.auth.signOut();
    Navigator.pop(context);
    notifyListeners();
  }

  User? get currentUser => _supabase.auth.currentUser;
}

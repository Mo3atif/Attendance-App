import 'package:attandace_app/constent/constent.dart';
import 'package:attandace_app/model/attandance_model.dart';
import 'package:attandace_app/services/location_services.dart';
import 'package:attandace_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AttendanceService extends ChangeNotifier {
  final SupabaseClient _supabaseClient = Supabase.instance.client;

  String _attendanceHistory =DateFormat('MMMM yyyy').format(DateTime.now());
   
  get attendanceHistory => _attendanceHistory;
   
      set attandanceHistory(String value) {
        _attendanceHistory = value;
        notifyListeners();
      }

  AttandanceModel? attandanceModel;
  String todayDate = DateFormat('dd MMMM yyyy').format(DateTime.now());
  bool _isLoding = false;
  get isLoding => _isLoding;

  set setIsLoding(bool value) {
    _isLoding = value;
    notifyListeners();
  }

  Future getAttendancedate() async {
    List result = await _supabaseClient
        .from(Constent.attendanceTable)
        .select()
        .eq('employeeID', _supabaseClient.auth.currentUser!.id)
        .eq('date', todayDate);
    if (result.isNotEmpty) {
      attandanceModel = AttandanceModel.fromJson(result.first);
    }
    notifyListeners();
  }

  Future checkAttendanceDate(BuildContext context) async {
    final locationDate=await LocationServices().initialize(context);
    if (locationDate!=null) {
      if (attandanceModel?.checkIn == null) {
      await _supabaseClient.from(Constent.attendanceTable).insert({
        'employeeID': _supabaseClient.auth.currentUser!.id,
        'date': todayDate,
        'check_in': DateFormat('HH:mm').format(DateTime.now()),
        'check_inlocation': locationDate,
      });
    } else if (attandanceModel?.checkOut == null) {
      await _supabaseClient
          .from(Constent.attendanceTable)
          .update({
            'check_out': DateFormat('HH:mm').format(DateTime.now()),
            'check_outlocation': locationDate,
          })
          .eq('date', todayDate)
          .eq('employeeID', _supabaseClient.auth.currentUser!.id);
    } else {
      Utils.showSnackBar(context, 'You have already checked out today');
    }
    }
    
    getAttendancedate();
  }
  Future <List<AttandanceModel>> getattandanceHistory()async{
    final List date=await _supabaseClient.from(Constent.attendanceTable)
    .select()
    .eq('employeeID', _supabaseClient.auth.currentUser!.id)
     .textSearch('date', "'$_attendanceHistory'",config: 'english')
    .order('created_at', ascending: false);
    return date.map((attendance) => AttandanceModel.fromJson(attendance)).toList();
  }
}

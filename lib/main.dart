


import 'package:attandace_app/screens/calender.dart';
import 'package:attandace_app/screens/spleash_screen.dart';
import 'package:attandace_app/services/attendance_service.dart';
import 'package:attandace_app/services/auth_services.dart';
import 'package:attandace_app/services/dateBase.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://tmmptydmygubihnwqpqn.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InRtbXB0eWRteWd1YmlobndxcHFuIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjAzOTkzMzMsImV4cCI6MjA3NTk3NTMzM30.6k5O5kdO1Tj0NiQ7rV0xkhU-3_UnVatMaiL28TT-gn4',
  );
print('✅ Supabase initialized!');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthServices()),
        ChangeNotifierProvider(create: (context) => Datebase()),
         ChangeNotifierProvider(create: (context) => AttendanceService()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          
        ),
        title: 'Attendance App',
        debugShowCheckedModeBanner: false,
        home: const SpleashScreen(),
      ),
    );
  }
}


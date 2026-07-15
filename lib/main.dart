import 'package:flutter/material.dart';
import 'package:printing_press_app/view/admin/admin_homepage.dart';
import 'package:printing_press_app/view/user/userhomepage.dart';
import 'package:printing_press_app/view/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const AdminHomepage(),
    );
  }
}

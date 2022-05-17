import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_list/data.dart';
import 'package:todo_list/screens/homescreen.dart';

const taskBoxName = '';
void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());
  Hive.registerAdapter(PriorityAdapter());
  await Hive.openBox<Task>(taskBoxName);
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: primaryVariantColor));
  runApp(const MyApp());
}

const Color primaryColor = Color(0xff794CFF);
const Color primaryVariantColor = Color(0xff5C0AFF);
const Color primaryTextColor = Color(0xff1D2830);
const secondaryTextColor = Color(0xffAFBED0);
const normalPriority = Color(0xffF09819);
const lowPriority = Color(0xff3BE1F1);
const highPriority = primaryColor;

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          colorScheme: const ColorScheme.light(
              primary: primaryColor,
              onPrimary: Colors.white,
              primaryContainer: primaryVariantColor,
              background: Color(0xffF3F5F8),
              onBackground: primaryTextColor,
              surface: Colors.white,
              onSurface: primaryTextColor,
              secondary: primaryColor,
              onSecondary: Colors.white),
          textTheme: GoogleFonts.poppinsTextTheme(const TextTheme(
              headline6: TextStyle(fontWeight: FontWeight.w700)))),
      home: const HomeScreen(),
    );
  }
}

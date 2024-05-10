import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf_creator/Screens/home_screen.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

Color kPrimaryColor = const Color.fromARGB(255, 4, 161, 182);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Pdf Creator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF222f3e),
        appBarTheme: AppBarTheme(
          backgroundColor: kPrimaryColor,
        ),
        textTheme: GoogleFonts.poppinsTextTheme(),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(15),
            backgroundColor: kPrimaryColor,
            shape: const CircleBorder(),
          ),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}

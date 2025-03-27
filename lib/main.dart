import 'package:festival_diary1_app/views/splash_screen_ui.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(FestivalDiary1App());
}

class FestivalDiary1App extends StatefulWidget {
  const FestivalDiary1App({super.key});

  @override
  State<FestivalDiary1App> createState() => _FestivalDiary1AppState();
}

class _FestivalDiary1AppState extends State<FestivalDiary1App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreenUI(),
      theme: ThemeData(
        textTheme:
            GoogleFonts.notoSansThaiTextTheme(Theme.of(context).textTheme),
      ),
    );
  }
}

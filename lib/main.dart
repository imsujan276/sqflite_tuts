import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sqflite_tuts/screens/todo_screen.dart';

import 'generated/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TODO',
      debugShowCheckedModeBanner: false,
      locale: Locale('ne'),
      theme: ThemeData(
        fontFamily: GoogleFonts.ubuntu().fontFamily,
        primaryColor: Color(0xff4CAF50),
        accentColor: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      home: TodoListScreen(),
    );
  }
}

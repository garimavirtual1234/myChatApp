
import 'package:flutter/material.dart';

class CustomTheme {
  static Color kTextColor = Colors.white;
  static Color kBorderColor = Colors.yellow;

  static Color lightThemeColor = Colors.yellow,
      white = Colors.white,
      black = Colors.black;

  // light theme
  static final lightTheme = ThemeData(

    primaryColor: lightThemeColor,
    brightness: Brightness.light,
    scaffoldBackgroundColor: black,

    appBarTheme: AppBarTheme(
      centerTitle: false,
      backgroundColor: Colors.white,
      //  scrolledUnderElevation: 0,
      titleTextStyle: TextStyle(
        fontWeight: FontWeight.w500,
        color: black,
        fontSize: 21, //20
      ),
      iconTheme: const IconThemeData(color: Colors.black),
      elevation: 0,
      actionsIconTheme: const IconThemeData(color: Colors.black),
      // systemOverlayStyle: SystemUiOverlayStyle(
      //   statusBarColor: lightThemeColor,
      //   statusBarIconBrightness: Brightness.light,
      // ),
    ),


    inputDecorationTheme: InputDecorationTheme(

      fillColor: Colors.white,
      filled: true,
      isDense: true,

      border:  OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide:  BorderSide(color: CustomTheme.kBorderColor)
      ),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide:  BorderSide(color:CustomTheme.kBorderColor)
      ),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide:  BorderSide(color: CustomTheme.kBorderColor)
      ),
    ),


    textTheme: TextTheme(
      headlineLarge: TextStyle(
          color: lightThemeColor,
          fontWeight: FontWeight.bold,

      ),
      headlineMedium:  TextStyle(
          color: Colors.black,fontWeight: FontWeight.bold,

      ),
      bodyMedium:  TextStyle(
          color: Colors.black,

          fontWeight: FontWeight.bold
      ),
      bodySmall:  TextStyle(

        fontWeight: FontWeight.w500,

      ),
      labelSmall:  TextStyle(
          color: Colors.black,

          fontWeight: FontWeight.normal
      ),
    ),
  );

  // dark theme
  // static final darkTheme = ThemeData(
  //   primaryColor: darkThemeColor,
  //   brightness: Brightness.dark,
  //   scaffoldBackgroundColor: black,
  //   useMaterial3: true,
  //   fontFamily: GoogleFonts.poppins().fontFamily,
  //   switchTheme: SwitchThemeData(
  //     trackColor:
  //     WidgetStateProperty.resolveWith<Color>((states) => darkThemeColor),
  //   ),
  //   appBarTheme: AppBarTheme(
  //     centerTitle: true,
  //     backgroundColor: black,
  //     scrolledUnderElevation: 0,
  //     titleTextStyle: TextStyle(
  //       fontWeight: FontWeight.w500,
  //       color: white,
  //       fontSize: 23, //20
  //     ),
  //     iconTheme: IconThemeData(color: darkThemeColor),
  //     elevation: 0,
  //     actionsIconTheme: IconThemeData(color: darkThemeColor),
  //     systemOverlayStyle: SystemUiOverlayStyle(
  //       statusBarColor: black,
  //       statusBarIconBrightness: Brightness.light,
  //     ),
  //   ),
  // );

  // colors

// darkThemeColor = Colors.yellow;
}
import 'package:flutter/material.dart';

import '../constants/constants.dart';

ThemeData darkThemeData() {
  return ThemeData.dark().copyWith(
    primaryColor: kPrimaryDarkColor,
    scaffoldBackgroundColor: kSecondaryDarkColor,
    iconTheme: const IconThemeData(color: kPrimaryyDarkColor),
    // textTheme: TextTheme(),
    colorScheme: const ColorScheme.dark().copyWith(
      primary: kPrimaryDarkColor,
      secondary: kSecondaryColor,
      error: kErrorColor,
    ),
    appBarTheme: appBarDarkTheme(),
    bottomNavigationBarTheme: bottomNavigationBarDarkTheme(),

    //brightness: Brightness.light,
    // iconTheme: IconThemeData(color: Colors.black),
    //  textTheme: TextTheme(
    //    headline6: TextStyle(color: Color(0XFF8B8B8B), fontSize: 18),
    //  ),

    // appBarTheme: AppBarTheme(
    //   elevation: 0
    // ),
    // primarySwatch: Colors.grey,
    //fontFamily: "Muli",
    // appBarTheme: appBarTheme(),
    //   inputDecorationTheme: inputDecorationTheme(),
    // visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}

ThemeData lightThemeData() {
  return ThemeData.light().copyWith(
      primaryColor: kPrimaryColor,
      scaffoldBackgroundColor: kSecondaryLightColor,
      iconTheme: const IconThemeData(
        color: kPrimaryColor,
      ),
      // textTheme: TextTheme(),
      colorScheme: const ColorScheme.light().copyWith(
        primary: kPrimaryColor,
        secondary: kSecondaryColor,
        error: kErrorColor,
      ),
      appBarTheme: appBarLightTheme(),
    
        
      
      //brightness: Brightness.light,
      // iconTheme: IconThemeData(color: Colors.black),
      //  textTheme: TextTheme(
      //    headline6: TextStyle(color: Color(0XFF8B8B8B), fontSize: 18),
      //  ),

      // appBarTheme: AppBarTheme(
      //   elevation: 0,
      //   backgroundColor: getPrimaryColorTheme(),

      // ),
      // primarySwatch: Colors.grey,
      //fontFamily: "Muli",
      // inputDecorationTheme: inputDecorationTheme(),
      // visualDensity: VisualDensity.adaptivePlatformDensity,
      );
}

// InputDecorationTheme inputDecorationTheme() {
//   OutlineInputBorder outlineInputBorder = OutlineInputBorder(
//     borderRadius: BorderRadius.circular(
//       10,
//     ),
//   );
//   return InputDecorationTheme(
//     contentPadding: const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
//     enabledBorder: outlineInputBorder,
//     focusedBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(10),
//         borderSide: const BorderSide(color: kPrimaryLightColor)
//         // gapPadding: 30
//         ),
//     hintStyle: const TextStyle(
//       color: Colors.grey,
//     ),
//     border: outlineInputBorder,

//     // If  you are using latest version of flutter then lable text and hint text shown like this
//     // if you r using flutter less then 1.20.* then maybe this is not working properly
//     // if we are define our floatingLabelBehavior in our theme then it's not applayed
//   );
// }

// TextTheme textTheme() {
//   return TextTheme(

//     bodyText1: TextStyle(color: kTextColor),
//     bodyText2: TextStyle(color: kTextColor),
//   );
// }

AppBarTheme appBarDarkTheme() {
  return AppBarTheme(
    toolbarHeight: 75,
    backgroundColor: kPrimaryyDarkColor,
    
    elevation: 2,
    shadowColor: Colors.grey.shade600,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
      bottomLeft: Radius.circular(25),
      bottomRight: Radius.circular(25),
    )),
    // leadingWidth: double.infinity,
  );
}

BottomNavigationBarThemeData bottomNavigationBarDarkTheme() {
  return const BottomNavigationBarThemeData(
    backgroundColor: kPrimaryyDarkColor,
    elevation: 0.2,
  );
}

AppBarTheme appBarLightTheme() {
  return AppBarTheme(
    toolbarHeight: 75,
    backgroundColor: kPrimaryColor,
    
    elevation: 2,
    shadowColor: Colors.grey.shade500,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
      bottomLeft: Radius.circular(25),
      bottomRight: Radius.circular(25),
    )),
    // leadingWidth: double.infinity,
  );
}

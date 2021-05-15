import 'package:chat/config/constants.dart';
import 'package:flutter/material.dart';

class CustomTheme {
  static ThemeData of(context) {
    var theme = Theme.of(context);

    return theme.copyWith(
      appBarTheme: theme.appBarTheme.copyWith(
        actionsIconTheme: IconThemeData(
          color: kDefautFontColor,
        ),
        iconTheme: IconThemeData(
          color: kDefautFontColor,
        ),
        backgroundColor: kDefaultBackgroundColor,
        titleTextStyle: TextStyle(
          color: kDefautFontColor,
        ),
      ),
      textTheme: theme.textTheme.copyWith(
        headline1: theme.textTheme.headline1!.copyWith(
          fontSize: kDefaultFontSize * 4,
        ),
        bodyText1: theme.textTheme.bodyText1!.copyWith(
          fontSize: kDefaultFontSize,
          letterSpacing: 1,
          height: 1.3,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          primary: kCTAColor,
          padding: const EdgeInsets.symmetric(
            horizontal: kDefaultPadding * 1.5,
            vertical: kDefaultPadding / 1.5,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              kDefaultPadding / 2,
            ),
          ),
        ),
      ),
    );
  }
}

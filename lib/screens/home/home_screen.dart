import 'package:chat/responsive.dart';
import 'package:chat/screens/home/responsive/desktop.dart';
import 'package:chat/screens/home/responsive/mobile.dart';
import 'package:chat/screens/home/responsive/tablet.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Responsive(
      mobile: MobileResponsiveScreen(),
      tablet: TableResponsiveScreen(),
      desktop: DesktopResponsiveScreen(),
    );
  }
}

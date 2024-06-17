import 'package:flutter/material.dart';
import 'package:world_traveller/colors/colors.dart';

class CustomBackground extends StatelessWidget {
  final Widget child;

  const CustomBackground({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: primaryColorSkyBlue.withOpacity(0.25),
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          Positioned.fill(
            child: Container(
              color: primaryColorSkyBlue.withOpacity(0.0),
            ),
          ),
          Positioned.fill(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Divider(
                  color: primaryColorOcenBlue,
                  height: 1,
                ),
              ],
            ),
          ),
          Positioned.fill(
            child: Center(
              child: Opacity(
                opacity: 0.15,
                child: Image.asset(
                  'assets/img/logo-main.png',
                  width: 350,
                  height: 350,
                ),
              ),
            ),
          ),
          Positioned.fill(
            child:
                child, // This will display whatever child you pass to CustomBackground
          ),
        ],
      ),
    );
  }
}

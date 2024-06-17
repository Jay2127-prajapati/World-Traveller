import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:world_traveller/colors/colors.dart';

class InfoCard extends StatelessWidget {
  const InfoCard({
    super.key,
    required this.name,
    required this.professions,
  });

  final String name, professions;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(
        backgroundColor: secondaryColorBlack,
        child: Icon(
          CupertinoIcons.person,
          color: secondaryColorWhite,
        ),
      ),
      title: Text(
        name,
        style: const TextStyle(color: secondaryColorWhite),
      ),
      subtitle: Text(
        professions,
        style: const TextStyle(color: secondaryColorWhite),
      ),
    );
  }
}

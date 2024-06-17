import 'package:flutter/cupertino.dart';
import 'package:world_traveller/colors/colors.dart';

class SettingSwitch extends StatelessWidget {
  final String title;
  final Color bgColor;
  final Color iconColor;
  final IconData icon;
  final bool value;
  final Function(bool value) onTap;
  const SettingSwitch({
    super.key,
    required this.title,
    required this.bgColor,
    required this.iconColor,
    required this.icon,
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: bgColor,
            ),
            child: Icon(
              icon,
              color: iconColor,
            ),
          ),
          const SizedBox(width: 20),
          Text(
            title,
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: 'poppins'),
          ),
          const Spacer(),
          Text(
            value ? "On" : "Off",
            style: const TextStyle(
                fontSize: 13.5,
                color: secondaryColorGrey,
                fontFamily: 'roboto',
                fontWeight: FontWeight.w600),
          ),
          const SizedBox(width: 20),
          CupertinoSwitch(value: value, onChanged: onTap),
        ],
      ),
    );
  }
}

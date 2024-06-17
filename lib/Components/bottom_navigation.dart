import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:world_traveller/colors/colors.dart';
import 'package:get/get.dart';
import 'package:world_traveller/home/car_details.dart';
import 'package:world_traveller/home/chat_screen.dart';
import 'package:world_traveller/home/driver_detail.dart';
import 'package:world_traveller/home/home_screen.dart';
import 'package:world_traveller/home/location_screen.dart';
import 'package:world_traveller/home/settings_screen.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({
    Key? key,
  }) : super(key: key);

  @override
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  late NavigationController _navigationController;

  @override
  void initState() {
    super.initState();
    _navigationController = Get.put(
        NavigationController()); // Initialize NavigationController instance
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());

    return Scaffold(
      bottomNavigationBar: Obx(() => CurvedNavigationBar(
            backgroundColor: primaryColorSkyBlue.withOpacity(0.25),
            buttonBackgroundColor: primaryColorOcenBlue,
            color: primaryColorSkyBlue.withOpacity(0.5),
            animationDuration: const Duration(milliseconds: 300),
            index: _navigationController.selectedIndex
                .value, // Use selectedIndex from NavigationController
            items: const <Widget>[
              Icon(Icons.home, size: 26, color: Colors.white),
              Icon(Icons.drive_eta_rounded, size: 26, color: Colors.white),
              Icon(Icons.add, size: 26, color: Colors.white),
              Icon(Icons.chat, size: 26, color: Colors.white),
              Icon(Icons.person, size: 26, color: Colors.white),
            ],
            onTap: (index) {
              controller.selectedIndex.value = index;
              setState(() {}); // Trigger a rebuild to update the UI
            },
          )),
      body: Obx(() => _navigationController
          .screens[_navigationController.selectedIndex.value]),
    );
  }
}

// ignore: unused_element
List<Widget> _buildNavigationItems() {
  return [
    _buildNavigationItem(Icons.home, 26, secondaryColorWhite),
    _buildNavigationItem(Icons.drive_eta_rounded, 26, secondaryColorWhite),
    _buildNavigationItem(Icons.add, 26, secondaryColorWhite),
    _buildNavigationItem(Icons.location_on_outlined, 26, secondaryColorWhite),
    _buildNavigationItem(Icons.person, 26, secondaryColorWhite),
  ];
}

Widget _buildNavigationItem(IconData icon, double size, Color color) {
  return NavigationDestination(
    icon: Icon(icon, size: size, color: color),
    size: size,
    color: color,
  );
}

class NavigationDestination extends StatelessWidget {
  final Icon icon;
  final double size;
  final Color color;

  const NavigationDestination({
    required this.icon,
    required this.size,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        icon,
      ],
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final screens = [
    const HomeScreen(),
    CarDetailsScreen(),
    const DriverDetailScreen(),
    ChatScreen(),
    const AccountScreen()
  ];
}

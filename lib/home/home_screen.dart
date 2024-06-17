import 'package:flutter/material.dart';
import 'package:world_traveller/Components/custom_background.dart';
import 'package:world_traveller/Components/image_cursol.dart';
import 'package:world_traveller/Components/side_drawer.dart';
import 'package:world_traveller/colors/colors.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:world_traveller/home/notification_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    _showWelcomeMessage();
    _showGreetingMessage();
  }

  Future<void> _showWelcomeMessage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool showWelcomeMessage = prefs.getBool('showWelcomeMessage') ?? false;

    if (showWelcomeMessage) {
      String? userName = prefs.getString('userName');
      print(
          'Username from SharedPreferences: $userName'); // Add this line to check if the username is retrieved
      if (userName != null) {
        Fluttertoast.showToast(
          msg: "Welcome $userName",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.blue,
          textColor: secondaryColorBlack,
          fontSize: 16.0,
        );
      }
      // Clear the flag
      await prefs.setBool('showWelcomeMessage', false);
    }
  }

  void _showGreetingMessage() async {
    DateTime now = DateTime.now();
    String greeting;

    int hour = now.hour % 12;

    if (hour < 6) {
      greeting = "Good night";
    } else if (hour < 12) {
      greeting = "Good morning";
    } else if (hour < 17) {
      greeting = "Good afternoon";
    } else if (hour < 20) {
      greeting = "Good evening";
    } else {
      greeting = "Good night";
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userName = prefs.getString('userName');

    if (userName != null) {
      greeting = "$greeting, $userName";
    }

    Fluttertoast.showToast(
      msg: greeting,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: secondaryColorWhite,
      textColor: secondaryColorBlack,
      fontSize: 16.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight + 1),
        child: AppBar(
          backgroundColor: primaryColorSkyBlue.withOpacity(0.4),
          title: const Text(
            'World Traveller',
            style: TextStyle(
              color: secondaryColorBlack,
              fontWeight: FontWeight.bold,
              fontFamily: 'poppins',
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.notifications),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NotificationScreen()),
                );
              },
            ),
          ],
        ),
      ),
      body: CustomBackground(
        child: Column(
          children: [
            ImageSliderWidget(
              imagePaths: [
                'assets/img/kakashi.jpg',
                'assets/img/jiraya.jpg',
                'assets/img/jiraya-sad.jpg'
              ],
            ),
          ],
        ),
      ),
      drawer: Stack(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.75,
              child: SideMenu(),
            ),
          ),
        ],
      ),
    );
  }
}

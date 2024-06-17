import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:world_traveller/Components/side_drawer.dart';
import 'package:world_traveller/authentication/login_screen.dart';
import 'package:world_traveller/colors/colors.dart';
import 'package:world_traveller/home/profile_screnn.dart';
import 'package:world_traveller/modules/forward_button.dart';
import 'package:world_traveller/modules/setting_item.dart';
import 'package:world_traveller/modules/setting_switch.dart';
import 'package:world_traveller/components/custom_background.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  bool isDarkMode = false;

  Future<void> _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Clear user session data
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) =>
              LoginScreen(onLogout: () {})), // Pass onLogout callback
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
            onPressed: () {},
          ),
        ],
      ),
      body: CustomBackground(
        // Use CustomBackground here
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Settings",
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 40),
                const Text(
                  "Account",
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'roboto'),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: Row(
                    children: [
                      Image.asset("assets/img/businessman.png",
                          width: 70, height: 70),
                      const SizedBox(width: 20),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Jay Prajapati",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w900,
                                fontFamily: 'poppins'),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Manager",
                            style: TextStyle(
                                fontSize: 14,
                                color: secondaryColorBlack,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'poppins'),
                          )
                        ],
                      ),
                      const Spacer(),
                      ForwardButton(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ProfileScreen(),
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                const Text(
                  "Settings",
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'roboto'),
                ),
                const SizedBox(height: 20),
                SettingItem(
                  title: "Language",
                  icon: Ionicons.earth,
                  bgColor: Orange100,
                  iconColor: Orange,
                  value: "English",
                  onTap: () {},
                ),
                const Divider(
                  color: primaryColorOcenBlue,
                ), // Add a divider here
                SettingItem(
                  title: "Notifications",
                  icon: Ionicons.notifications,
                  bgColor: SkuBlue100,
                  iconColor: primaryColorSkyBlue,
                  onTap: () {},
                ),
                const Divider(
                  color: primaryColorOcenBlue,
                ), // Add a divider here
                SettingSwitch(
                  title: "Dark Mode",
                  icon: Ionicons.earth,
                  bgColor: Purple100,
                  iconColor: Purple,
                  value: isDarkMode,
                  onTap: (value) {
                    setState(() {
                      isDarkMode = value;
                    });
                  },
                ),
                const Divider(
                  color: primaryColorOcenBlue,
                ), // Add a divider here
                SettingItem(
                  title: "Logout",
                  icon: Ionicons.nuclear,
                  bgColor: Red100,
                  iconColor: secondaryColorRed,
                  onTap: _logout, // Call _logout method on tap
                ),
              ],
            ),
          ),
        ),
      ),
      drawer: Stack(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.75,
              child: const SideMenu(),
            ),
          ),
        ],
      ),
    );
  }
}

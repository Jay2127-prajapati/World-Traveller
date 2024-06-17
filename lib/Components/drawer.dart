import 'package:flutter/material.dart';
import 'package:world_traveller/Components/header_drawer.dart';
import 'package:world_traveller/colors/colors.dart';
import 'package:world_traveller/home/chat_screen.dart';
import 'package:world_traveller/home/home_screen.dart';
import 'package:world_traveller/home/notification_screen.dart';
import 'package:world_traveller/home/search_screen.dart';
import 'package:world_traveller/home/settings_screen.dart';

class SideDrawer extends StatefulWidget {
  @override
  _SideDrawerState createState() => _SideDrawerState();
}

class _SideDrawerState extends State<SideDrawer> {
  var currentPage = DrawerSections.home; // Initialize currentPage to Home

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    late Widget container;

    // Determine the appropriate container widget based on the currentPage
    if (currentPage == DrawerSections.home) {
      container = const HomeScreen();
    } else if (currentPage == DrawerSections.search) {
      container = const SearchScreen();
    } else if (currentPage == DrawerSections.notifications) {
      container = NotificationScreen();
    } else if (currentPage == DrawerSections.chat) {
      container = ChatScreen();
    } else if (currentPage == DrawerSections.settings) {
      container = const AccountScreen();
    } else {
      container = Container();
    }

    return Scaffold(
      body:
          // This will be replaced with the appropriate content based on currentPage
          Drawer(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                MyHeaderDrawer(),
                MyDrawerList(), // Call MyDrawerList method here
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Move MyDrawerList method inside the _SideDrawerState class
  Widget MyDrawerList() {
    return Container(
      padding: const EdgeInsets.only(
        top: 15,
      ),
      child: Column(
        // shows the list of menu drawer
        children: [
          menuItem(1, "Home", Icons.home_outlined,
              currentPage == DrawerSections.home ? true : false),
          menuItem(2, "Search", Icons.search,
              currentPage == DrawerSections.search ? true : false),
          menuItem(3, "Notifications", Icons.notifications_none,
              currentPage == DrawerSections.notifications ? true : false),
          menuItem(4, "Chats", Icons.chat,
              currentPage == DrawerSections.chat ? true : false),
          const Divider(),
          menuItem(5, "Settings", Icons.settings_outlined,
              currentPage == DrawerSections.settings ? true : false),
          menuItem(6, "Logout", Icons.logout_rounded,
              currentPage == DrawerSections.notifications ? true : false),
        ],
      ),
    );
  }

  // Move menuItem method inside the _SideDrawerState class
  Widget menuItem(int id, String title, IconData icon, bool selected) {
    return Material(
      color: selected ? primaryColorSkyBlue : Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
          setState(() {
            if (id == 1) {
              currentPage = DrawerSections.home;
            } else if (id == 2) {
              currentPage = DrawerSections.search;
            } else if (id == 3) {
              currentPage = DrawerSections.notifications;
            } else if (id == 4) {
              currentPage = DrawerSections.chat;
            } else if (id == 5) {
              currentPage = DrawerSections.settings;
            } else if (id == 6) {
              currentPage = DrawerSections.logout;
            }
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              Expanded(
                child: Icon(
                  icon,
                  size: 20,
                  color: Colors.black,
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum DrawerSections { home, search, notifications, chat, settings, logout }

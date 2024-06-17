import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:world_traveller/colors/colors.dart';
import 'package:world_traveller/modules/edit_item.dart';
import 'package:world_traveller/components/custom_background.dart'; // Import your CustomBackground component

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String gender = "man";

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
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Ionicons.chevron_back_outline),
        ),
        leadingWidth: 80,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {},
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () {},
              style: IconButton.styleFrom(
                backgroundColor: primaryColorSkyBlue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                fixedSize: Size(60, 50),
                elevation: 3,
              ),
              icon: Icon(Ionicons.checkmark, color: secondaryColorWhite),
            ),
          ),
        ],
      ),
      body: CustomBackground(
        // Wrap the content with CustomBackground
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Account",
                  style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'roboto'),
                ),
                const SizedBox(height: 40),
                EditItem(
                  title: "Photo",
                  widget: Column(
                    children: [
                      Image.asset(
                        "assets/img/businessman.png",
                        height: 100,
                        width: 100,
                      ),
                      TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          foregroundColor: secondaryColorBlack,
                        ),
                        child: const Text("Upload Image"),
                      )
                    ],
                  ),
                ),
                const EditItem(
                  title: "Name",
                  widget: TextField(),
                ),
                const SizedBox(height: 40),
                EditItem(
                  title: "Gender",
                  widget: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            gender = "man";
                          });
                        },
                        style: IconButton.styleFrom(
                          backgroundColor:
                              gender == "man" ? primaryColorOcenBlue : Grey200,
                          fixedSize: const Size(50, 50),
                        ),
                        icon: Icon(
                          Ionicons.male,
                          color: gender == "man"
                              ? secondaryColorWhite
                              : secondaryColorBlack,
                          size: 18,
                        ),
                      ),
                      const SizedBox(width: 20),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            gender = "woman";
                          });
                        },
                        style: IconButton.styleFrom(
                          backgroundColor: gender == "woman"
                              ? primaryColorOcenBlue
                              : Grey200,
                          fixedSize: const Size(50, 50),
                        ),
                        icon: Icon(
                          Ionicons.female,
                          color: gender == "woman"
                              ? secondaryColorWhite
                              : secondaryColorBlack,
                          size: 18,
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                const EditItem(
                  widget: TextField(),
                  title: "Age",
                ),
                const SizedBox(height: 40),
                const EditItem(
                  widget: TextField(),
                  title: "Email",
                ),
              ],
            ),
          ),
        ),
      ),
      // bottomNavigationBar: CustomBottomNavigationBar(
      //   currentIndex: _currentIndex,
      //   onTap: (index) {
      //     setState(() {
      //       _currentIndex = index;
      //     });
      //   },
      // ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:world_traveller/Components/Info_card.dart';
import 'package:world_traveller/Components/side_menu_tile.dart';
import 'package:world_traveller/Utils/rive_utils.dart';
import 'package:world_traveller/colors/colors.dart';
import 'package:world_traveller/modules/rive_assets.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({super.key});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  StateMachineController? controller;

  RiveAssets selectedMenu = sideMenus.first;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 310,
        height: double.infinity,
        color: primaryColorOcenBlue,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const InfoCard(
                name: "Jay Prajapati",
                professions: "Manager",
              ),
              Padding(
                padding: const EdgeInsets.only(left: 24, top: 32, bottom: 16),
                child: Text('Browse'.toUpperCase(),
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: White70)),
              ),
              ...sideMenus.map(
                (menu) => SideMenuTile(
                  menu: menu,
                  riveonInit: (artboard) {
                    controller = RiveUtils.getRiveController(artboard,
                        stateMachineName: menu.stateMachineName);
                    menu.input = controller!.findSMI("active") as SMIBool;
                  },
                  press: () {
                    menu.input!.change(true);
                    Future.delayed(Duration(seconds: 1), () {
                      menu.input!.change(false);
                    });
                    setState(() {
                      selectedMenu = menu;
                    });
                  },
                  isActive: selectedMenu == menu,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 24, top: 32, bottom: 16),
                child: Text('Feactures'.toUpperCase(),
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: White70)),
              ),
              ...sideMenus2.map(
                (menu) => SideMenuTile(
                  menu: menu,
                  riveonInit: (artboard) {
                    controller = RiveUtils.getRiveController(artboard,
                        stateMachineName: menu.stateMachineName);
                    menu.input = controller!.findSMI("active") as SMIBool;
                  },
                  press: () {
                    menu.input!.change(true);
                    Future.delayed(Duration(seconds: 1), () {
                      menu.input!.change(false);
                    });
                    setState(() {
                      selectedMenu = menu;
                    });
                  },
                  isActive: selectedMenu == menu,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

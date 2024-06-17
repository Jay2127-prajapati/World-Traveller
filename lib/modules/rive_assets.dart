import 'package:rive/rive.dart';

class RiveAssets {
  final String artboard, stateMachineName, title, src;
  late SMIBool? input;

  RiveAssets(this.src,
      {required this.artboard,
      required this.stateMachineName,
      required this.title,
      this.input});

  set setInput(SMIBool status) {
    input = status;
  }
}

List<RiveAssets> sideMenus = [
  RiveAssets("assets/riv/icons.riv",
      artboard: "HOME", stateMachineName: "HOME_interactivity", title: "Home"),
  RiveAssets("assets/riv/search.riv",
      artboard: "SEARCH",
      stateMachineName: "SEARCH_Interactivity",
      title: "Search"),
  RiveAssets("assets/riv/bell.riv",
      artboard: "BELL",
      stateMachineName: "BELL_Interactivity",
      title: "Notification"),
  RiveAssets("assets/riv/chat.riv",
      artboard: "CHAT", stateMachineName: "CHAT_Interactivity", title: "Chat"),
];

List<RiveAssets> sideMenus2 = [
  RiveAssets("assets/riv/icons.riv",
      artboard: "SETTINGS",
      stateMachineName: "SETTINGS_interactivity",
      title: "Settings"),
  RiveAssets("assets/riv/search.riv",
      artboard: "LOGOUT",
      stateMachineName: "LOGOUT_Interactivity",
      title: "Logout"),
];

import 'package:flutter/material.dart';
import 'package:world_traveller/Components/custom_background.dart';
import 'package:world_traveller/Components/side_drawer.dart';
import 'package:world_traveller/colors/colors.dart';
import 'package:world_traveller/home/chat_message_screen.dart';

class ChatScreen extends StatelessWidget {
  final List<String> chatUsers = [
    'Joy',
    'Bob',
    'Charlie',
    'David',
    'Emma',
    'Frank',
    'Grace',
    'Harry',
    'Ivy',
    'Jack'
  ];

  final List<String> lastMessageTimes = [
    '10:15 AM',
    '11:30 PM',
    '09:45 AM',
    '03:20 PM',
    '02:00 PM',
    '08:45 AM',
    '01:10 PM',
    '04:30 PM',
    '07:20 AM',
    '06:15 PM'
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColorSkyBlue.withOpacity(0.4),
          title: const Text(
            'Chats',
            style: TextStyle(
              color: secondaryColorBlack,
              fontWeight: FontWeight.bold,
              fontFamily: 'poppins',
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                // Open search delegate
                showSearch(context: context, delegate: ChatSearch(chatUsers));
              },
            ),
            IconButton(
              icon: Icon(Icons.more_vert),
              onPressed: () {
                // Implement more options
              },
            ),
          ],
        ),
        body: CustomBackground(
          child: ChatList(
            chatUsers: chatUsers,
            lastMessageTimes: lastMessageTimes,
          ),
        ),
        drawer: Drawer(
          child: CustomBackground(child: const SideMenu()),
        ),
      ),
    );
  }
}

class ChatList extends StatelessWidget {
  final List<String> chatUsers;
  final List<String> lastMessageTimes;

  const ChatList({
    Key? key,
    required this.chatUsers,
    required this.lastMessageTimes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: chatUsers.length,
      itemBuilder: (BuildContext context, int index) {
        return ChatTile(
          name: chatUsers[index],
          lastMessage: 'Last message in chat ${index + 1}',
          time: lastMessageTimes[index],
        );
      },
    );
  }
}

class ChatTile extends StatelessWidget {
  final String name;
  final String lastMessage;
  final String time;

  ChatTile({
    required this.name,
    required this.lastMessage,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: White70,
        // You can use a network image URL or local asset path here
        backgroundImage: AssetImage(_getImageForUser(name)),
        child: null, // Remove the child to display only the image
      ),
      title: Text(name),
      subtitle: Text(lastMessage),
      trailing: Text(time),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatMessagesScreen(userName: name),
          ),
        );
      },
    );
  }

  // Define a function to get the image path based on the user's name
  String _getImageForUser(String userName) {
    // Replace these with your image assets or URLs
    Map<String, String> userImages = {
      'Joy': 'assets/img/kakashi.jpg',
      'Bob': 'assets/img/kakashi_two.jpg',
      'Charlie': 'assets/img/jiraya.jpg',
      'David': 'assets/img/jiraya-sad.jpg',
      'Emma': 'assets/img/sakura-bold.jpg',
      'Frank': 'assets/img/naruto.png',
      'Grace': 'assets/img/naruto.jpg',
      'Harry': 'assets/img/turtle.jpg',
      'Ivy': 'assets/img/sakura.jpg',
      'Jack': 'assets/img/kid-turtle.jpg',
      // Add more user-image mappings here
    };
    // Check if the user's image is available, otherwise return a default image
    return userImages[userName] ?? 'assets/default_avatar.jpg';
  }
}

class ChatSearch extends SearchDelegate<String> {
  final List<String> chatUsers;

  ChatSearch(this.chatUsers);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final List<String> searchResults = chatUsers
        .where((user) => user.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: searchResults.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(searchResults[index]),
          onTap: () {
            // Navigate to chat screen with the selected user
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    ChatMessagesScreen(userName: searchResults[index]),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<String> searchResults = chatUsers
        .where((user) => user.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: searchResults.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(searchResults[index]),
          onTap: () {
            // Navigate to chat screen with the selected user
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    ChatMessagesScreen(userName: searchResults[index]),
              ),
            );
          },
        );
      },
    );
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme.copyWith(
      primaryColor: primaryColorSkyBlue.withOpacity(0.4),
      textTheme: theme.textTheme.copyWith(
        titleLarge: const TextStyle(
          color: secondaryColorBlack,
          fontWeight: FontWeight.bold,
          fontFamily: 'poppins',
        ),
      ),
    );
  }
}

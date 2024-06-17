import 'package:flutter/material.dart';
import 'package:world_traveller/Components/custom_background.dart';
import 'package:world_traveller/Components/side_drawer.dart';
import 'package:world_traveller/colors/colors.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<NotificationItem> notifications = [];
  late final NotificationSearchDelegate _searchDelegate;

  @override
  void initState() {
    super.initState();
    _searchDelegate = NotificationSearchDelegate(notifications: notifications);
    // Add sample notifications
    notifications = [
      // Your sample notifications
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColorSkyBlue.withOpacity(0.4),
        title: Text(
          'Notifications',
          style: TextStyle(
            color: secondaryColorBlack,
            fontWeight: FontWeight.w500,
            fontFamily: 'poppins',
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: _searchDelegate,
              );
            },
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return CustomBackground(
            child: ListView.separated(
              itemCount: notifications.length,
              separatorBuilder: (BuildContext context, int index) => Divider(),
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: Icon(notifications[index].icon),
                  title: Text(notifications[index].title),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(notifications[index].content),
                      SizedBox(height: 4),
                      Text(
                        notifications[index].timestamp.toString(),
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                  trailing: notifications[index].isRead
                      ? null
                      : CircleAvatar(
                          backgroundColor: secondaryColorRed,
                          radius: 8,
                        ),
                  onTap: () {
                    setState(() {
                      notifications[index].markAsRead();
                    });
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NotificationDetailsScreen(
                          notification: notifications[index],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add a new notification
          setState(() {
            notifications.add(NotificationItem(
              icon: Icons.notifications,
              title: 'New Notification',
              content: 'This is a new notification.',
              timestamp: DateTime.now(),
              isRead: false,
            ));
          });
        },
        child: Icon(Icons.add),
      ),
      drawer: Drawer(
        child: CustomBackground(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.75,
            child: const SideMenu(),
          ),
        ),
      ),
    );
  }
}

class NotificationSearchDelegate extends SearchDelegate<NotificationItem> {
  final List<NotificationItem> notifications;

  NotificationSearchDelegate({required this.notifications});

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
        close(
            context,
            NotificationItem(
              icon: Icons.notifications,
              title: '',
              content: '',
              timestamp: DateTime.now(),
              isRead: false,
            ));
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = notifications.where((notification) {
      return notification.title.toLowerCase().contains(query.toLowerCase()) ||
          notification.content.toLowerCase().contains(query.toLowerCase()) ||
          (notification.message != null &&
              notification.message!
                  .toLowerCase()
                  .contains(query.toLowerCase()));
    }).toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(results[index].title),
          onTap: () {
            close(context, results[index]);
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final results = notifications.where((notification) {
      return notification.title.toLowerCase().contains(query.toLowerCase()) ||
          notification.content.toLowerCase().contains(query.toLowerCase()) ||
          (notification.message != null &&
              notification.message!
                  .toLowerCase()
                  .contains(query.toLowerCase()));
    }).toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(results[index].title),
          onTap: () {
            close(context, results[index]);
          },
        );
      },
    );
  }

  @override
  String get searchFieldLabel => 'Search Notifications';
}

class NotificationDetailsScreen extends StatelessWidget {
  final NotificationItem notification;

  const NotificationDetailsScreen({required this.notification});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColorSkyBlue.withOpacity(0.4),
        title: Text(
          'Notifications',
          style: TextStyle(
            color: secondaryColorBlack,
            fontWeight: FontWeight.w500,
            fontFamily: 'poppins',
          ),
        ),
      ),
      body: CustomBackground(
        // Wrap the content with CustomBackground
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                notification.content,
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 16),
              Text(
                'Received at: ${notification.timestamp}',
                style: TextStyle(fontSize: 14),
              ),
              SizedBox(height: 16),
              if (notification.message != null)
                Text(
                  'Message: ${notification.message}',
                  style: TextStyle(fontSize: 14),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class NotificationItem {
  final IconData icon;
  final String title;
  final String content;
  final DateTime timestamp;
  bool isRead;
  final String? message;

  NotificationItem({
    required this.icon,
    required this.title,
    required this.content,
    required this.timestamp,
    required this.isRead,
    this.message,
  });

  void markAsRead() {
    isRead = true;
  }
}

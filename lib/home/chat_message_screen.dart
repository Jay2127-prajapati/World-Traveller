import 'package:flutter/material.dart';
import 'package:world_traveller/colors/colors.dart';
import 'package:world_traveller/Components/custom_background.dart';

class ChatMessagesScreen extends StatefulWidget {
  final String userName;

  const ChatMessagesScreen({Key? key, required this.userName})
      : super(key: key);

  @override
  _ChatMessagesScreenState createState() => _ChatMessagesScreenState();
}

class _ChatMessagesScreenState extends State<ChatMessagesScreen> {
  final TextEditingController _textEditingController = TextEditingController();
  List<ChatMessage> _messages = []; // Define the list of messages

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              color: Colors.transparent, // Adjust the color as needed
            ),
          ),
          Positioned.fill(
            child: GestureDetector(
              onTap: () {
                // Unfocus the text field when tapping outside of it
                FocusScope.of(context).unfocus();
              },
              child: Scaffold(
                appBar: AppBar(
                  backgroundColor: primaryColorSkyBlue.withOpacity(0.4),
                  title: Text(
                    widget.userName,
                    style: const TextStyle(
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
                        showSearch(
                          context: context,
                          delegate: ChatMessageSearch(messages: _messages),
                        );
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
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: _messages.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              title: Text(_messages[index].text),
                            );
                          },
                        ),
                      ),
                      _buildInputField(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputField() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _textEditingController,
              decoration: const InputDecoration(
                hintText: 'Type a message...',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(width: 8.0),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: () {
              _sendMessage();
            },
          ),
        ],
      ),
    );
  }

  void _sendMessage() {
    String messageText = _textEditingController.text.trim();
    if (messageText.isNotEmpty) {
      ChatMessage message = ChatMessage(text: messageText);
      setState(() {
        _messages.add(message);
        _textEditingController.clear();
      });
    }
  }
}

class ChatMessageSearch extends SearchDelegate<ChatMessage> {
  final List<ChatMessage> messages;

  ChatMessageSearch({required this.messages});

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
        close(context, ChatMessage(text: '')); // Passing an empty ChatMessage
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final List<ChatMessage> searchResults = messages
        .where((message) =>
            message.text.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: searchResults.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(searchResults[index].text),
          onTap: () {
            // Do something when a search result is tapped
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<ChatMessage> searchResults = messages
        .where((message) =>
            message.text.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: searchResults.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(searchResults[index].text),
          onTap: () {
            // Do something when a search suggestion is tapped
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

class ChatMessage {
  final String text;

  ChatMessage({required this.text});
}

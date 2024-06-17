import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // Import the image picker package
import 'package:world_traveller/Components/custom_background.dart';
import 'package:world_traveller/Components/driver_card.dart';
import 'package:world_traveller/colors/colors.dart';
import 'package:world_traveller/home/notification_screen.dart';

class DriverDetailScreen extends StatefulWidget {
  const DriverDetailScreen({Key? key}) : super(key: key);

  @override
  State<DriverDetailScreen> createState() => _DriverDetailScreenState();
}

class _DriverDetailScreenState extends State<DriverDetailScreen> {
  List<Widget> _cards = [];

  bool _isFormVisible = false;

  void _toggleFormVisibility() {
    setState(() {
      _isFormVisible = !_isFormVisible;
    });
  }

  void _deleteCard(int index) {
    setState(() {
      _cards.removeAt(index);
    });
  }

  void _addEmptyCard() {
    int newIndex = _cards.length; // Get the index of the newly added card
    setState(() {
      _cards.insert(
        0, // Insert at the beginning of the list
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: DriverCard(
            driverName: '',
            licenseNumber: '',
            contact: '',
            onUpdate: (
              String driverName,
              String licenseNumber,
              String contact,
              File? image,
            ) {},
            onDelete: (int index) {
              _deleteCard(index);
            },
            index: newIndex,
            driver: null,
          ),
        ),
      );
    });
  }

  // Method to pick an image from the gallery
  Future<File?> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      return File(pickedImage.path);
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    _generateCards(); // Call _generateCards initially to start with an empty list
  }

  void _generateCards() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColorSkyBlue.withOpacity(0.4),
        title: const Text(
          'Driver Details',
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
                MaterialPageRoute(
                  builder: (context) => NotificationScreen(),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: CustomBackground(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20), // Add some spacing from the top
              ..._cards,
            ],
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addEmptyCard(); // Add an empty card
        },
        child: Icon(_isFormVisible ? Icons.close : Icons.add),
      ),
    );
  }
}

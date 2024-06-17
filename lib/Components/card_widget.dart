import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:world_traveller/Components/car_details_com.dart';

class UserCard extends StatefulWidget {
  final CarDetails carDetails;
  final Function(CarDetails) onUpdate;
  final Function() onDelete;
  final int index;
  final Function() onImageTap; // Add onImageTap callback

  const UserCard({
    required this.carDetails,
    required this.onUpdate,
    required this.onDelete,
    required this.index,
    required this.onImageTap, // Initialize onImageTap
  });

  @override
  _UserCardState createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  TextEditingController _carNameController = TextEditingController();
  TextEditingController _engineTypeController = TextEditingController();
  TextEditingController _serviceStatusController = TextEditingController();
  TextEditingController _currentKilometersController = TextEditingController();
  TextEditingController _currentLocationController = TextEditingController();
  TextEditingController _driverController = TextEditingController();
  TextEditingController _contactController = TextEditingController();
  File? _image;

  bool _isEditMode = false;

  @override
  void initState() {
    _carNameController.text = widget.carDetails.carName;
    _engineTypeController.text = widget.carDetails.engineType;
    _serviceStatusController.text = widget.carDetails.serviceStatus;
    _currentKilometersController.text = widget.carDetails.currentKilometers;
    _currentLocationController.text = widget.carDetails.currentLocation;
    _driverController.text = widget.carDetails.driver;
    _contactController.text = widget.carDetails.contact;
    _image = widget.carDetails.image; // Initialize image from carDetails
    super.initState();
  }

  void _toggleEditMode() {
    setState(() {
      _isEditMode = !_isEditMode;
    });
  }

  Future<void> _getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  if (_isEditMode) {
                    _getImage(); // Call getImage when in edit mode
                  } else {
                    widget.onImageTap(); // Call onImageTap callback otherwise
                  }
                },
                child: _image != null
                    ? Image.file(_image!,
                        height: 100, width: 100, fit: BoxFit.cover)
                    : Icon(Icons.image, size: 100),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _carNameController,
                enabled: _isEditMode,
                decoration: InputDecoration(labelText: 'Car Name'),
              ),
              TextField(
                controller: _engineTypeController,
                enabled: _isEditMode,
                decoration: InputDecoration(labelText: 'Engine Type'),
              ),
              TextField(
                controller: _serviceStatusController,
                enabled: _isEditMode,
                decoration: InputDecoration(labelText: 'Service Status'),
              ),
              TextField(
                controller: _currentKilometersController,
                enabled: _isEditMode,
                decoration: InputDecoration(labelText: 'Current Kilometers'),
              ),
              TextField(
                controller: _currentLocationController,
                enabled: _isEditMode,
                decoration: InputDecoration(labelText: 'Current Location'),
              ),
              TextField(
                controller: _driverController,
                enabled: _isEditMode,
                decoration: InputDecoration(labelText: 'Driver'),
              ),
              TextField(
                controller: _contactController,
                enabled: _isEditMode,
                decoration: InputDecoration(labelText: 'Contact'),
              ),
              SizedBox(height: 16.0),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: _isEditMode ? _toggleEditMode : null,
                      child: Text(_isEditMode ? 'Cancel' : 'Edit'),
                    ),
                    SizedBox(width: 10), // Add space between buttons
                    ElevatedButton(
                      onPressed: () {
                        if (_isEditMode) {
                          widget.onUpdate(CarDetails(
                            carName: _carNameController.text,
                            engineType: _engineTypeController.text,
                            serviceStatus: _serviceStatusController.text,
                            currentKilometers:
                                _currentKilometersController.text,
                            currentLocation: _currentLocationController.text,
                            driver: _driverController.text,
                            contact: _contactController.text,
                            image: _image, // Pass the image data
                          ));
                          _toggleEditMode();
                        } else {
                          _toggleEditMode();
                        }
                      },
                      child: Text(_isEditMode ? 'Save' : 'Update'),
                    ),
                    SizedBox(width: 10), // Add space between buttons
                    ElevatedButton(
                      onPressed: () {
                        widget.onDelete();
                      },
                      child: Text('Delete'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

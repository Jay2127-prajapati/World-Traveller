import 'dart:io';

import 'package:flutter/material.dart';

class DriverCard extends StatefulWidget {
  final String driverName;
  final String licenseNumber;
  final String contact;
  final Function(
    String driverName,
    String licenseNumber,
    String contact,
    File? image,
  ) onUpdate;

  final Function(int)? onDelete;
  final int index;

  const DriverCard({
    required this.driverName,
    required this.licenseNumber,
    required this.contact,
    required this.onUpdate,
    required this.onDelete,
    required this.index,
    required driver,
  });

  @override
  _DriverCardState createState() => _DriverCardState();
}

class _DriverCardState extends State<DriverCard> {
  TextEditingController _driverNameController = TextEditingController();
  TextEditingController _licenseNumberController = TextEditingController();
  TextEditingController _contactController = TextEditingController();
  File? _image;

  bool _isEditMode = false;

  @override
  void dispose() {
    _driverNameController.dispose();
    _licenseNumberController.dispose();
    _contactController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _driverNameController.text = widget.driverName;
    _licenseNumberController.text = widget.licenseNumber;
    _contactController.text = widget.contact;
    super.initState();
  }

  void _toggleEditMode() {
    setState(() {
      _isEditMode = !_isEditMode;
    });
  }

  Future<void> _getImage() async {
    // Implement image picking logic here
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
                    _getImage();
                  }
                },
                child: _image != null
                    ? Image.file(_image!,
                        height: 100, width: 100, fit: BoxFit.cover)
                    : Icon(Icons.image, size: 100),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _driverNameController,
                enabled: _isEditMode,
                decoration: InputDecoration(labelText: 'Driver Name'),
              ),
              TextField(
                controller: _licenseNumberController,
                enabled: _isEditMode,
                decoration: InputDecoration(labelText: 'License Number'),
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
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        if (_isEditMode) {
                          widget.onUpdate(
                            _driverNameController.text,
                            _licenseNumberController.text,
                            _contactController.text,
                            _image,
                          );
                          _toggleEditMode();
                        } else {
                          _toggleEditMode();
                        }
                      },
                      child: Text(_isEditMode ? 'Save' : 'Update'),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        widget.onDelete?.call(widget.index);
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

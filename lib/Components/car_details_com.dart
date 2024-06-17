import 'dart:io';

class CarDetails {
  String carName = '';
  String engineType = '';
  String serviceStatus = '';
  String currentKilometers = '';
  String currentLocation = '';
  String driver = '';
  String contact = '';
  File? image;

  CarDetails({
    this.carName = '',
    this.engineType = '',
    this.serviceStatus = '',
    this.currentKilometers = '',
    this.currentLocation = '',
    this.driver = '',
    this.contact = '',
    this.image,
  });
}

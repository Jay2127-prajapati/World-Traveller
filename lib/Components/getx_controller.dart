import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Import GetX
import 'package:world_traveller/Components/car_details_com.dart';
import 'package:world_traveller/Components/card_widget.dart';
import 'package:world_traveller/Components/custom_background.dart';
import 'package:world_traveller/colors/colors.dart';

class CarDetailsController extends GetxController {
  final RxList<CarDetails> _carDetailsList = <CarDetails>[].obs;

  RxList<CarDetails> get carDetailsList => _carDetailsList;

  void addEmptyCard() {
    _carDetailsList.add(CarDetails());
  }

  void updateCarDetails(int index, CarDetails carDetails) {
    _carDetailsList[index] = carDetails;
  }

  void deleteCarDetails(int index) {
    _carDetailsList.removeAt(index);
  }
}

class CarDetailsScreen extends StatelessWidget {
  final CarDetailsController carDetailsController =
      Get.put(CarDetailsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColorSkyBlue.withOpacity(0.4),
        title: const Text(
          'Vehicle Details',
          style: TextStyle(
            color: secondaryColorBlack,
            fontWeight: FontWeight.bold,
            fontFamily: 'poppins',
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: CustomBackground(
        child: Obx(
          () => SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 20), // Add some spacing from the top
                for (int i = 0;
                    i < carDetailsController.carDetailsList.length;
                    i++)
                  UserCard(
                    carDetails: carDetailsController.carDetailsList[i],
                    onUpdate: (CarDetails carDetails) {
                      // Explicitly specify the type
                      carDetailsController.updateCarDetails(i, carDetails);
                    },
                    onDelete: () {
                      carDetailsController.deleteCarDetails(i);
                    },
                    index: i, onImageTap: () {}, // Pass the index
                  ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: carDetailsController.addEmptyCard,
        child: Icon(Icons.add),
      ),
    );
  }
}

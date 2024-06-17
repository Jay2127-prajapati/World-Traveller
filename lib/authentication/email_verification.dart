import 'package:flutter/material.dart';
import 'package:world_traveller/authentication/otp_screen.dart';
import 'package:world_traveller/colors/colors.dart';

class EmailVerification extends StatefulWidget {
  const EmailVerification({Key? key}) : super(key: key);

  @override
  State<EmailVerification> createState() => _EmailVerificationState();
}

class _EmailVerificationState extends State<EmailVerification> {
  TextEditingController _emailController = TextEditingController();
  bool _showWarning = false;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset:
          false, // Prevents resizing when keyboard appears
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [primaryColorSkyBlue, primaryColorOcenBlue],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 30.0,
            ),
            Center(
              child: Image.asset(
                'assets/img/logo-main.png',
                width: screenWidth * 0.68,
                height: screenWidth * 0.8,
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            const Text(
              'Email Verification',
              style: TextStyle(
                fontSize: 25.0,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
                color: secondaryColorWhite,
                fontFamily: 'Poppins',
                letterSpacing: 1.0,
              ),
            ),
            const SizedBox(
              height: 50.0,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                      child: TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          hintText: 'Enter Your Register Email',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: _showWarning
                                  ? secondaryColorRed
                                  : primaryColorOcenBlue,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                color: secondaryColorRed, width: 1.5),
                          ),
                          fillColor: secondaryColorWhite,
                          filled: true,
                          labelStyle: const TextStyle(
                            color: secondaryColorBlack,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins',
                            fontSize: 13.5,
                          ),
                          hintStyle: TextStyle(
                            color: primaryColorGrass.withOpacity(0.5),
                            fontSize: 12.0,
                          ),
                        ),
                        style: const TextStyle(
                          color: secondaryColorBlack,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Roboto',
                          fontSize: 15.0,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 50.0,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          if (_emailController.text.isNotEmpty) {
                            // Navigate to the new screen
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => OtpScreen(),
                              ),
                            );
                          } else {
                            _showWarning = true;
                          }
                        });
                      },
                      child: Text(
                        'Verify',
                        style: TextStyle(
                          color: secondaryColorWhite,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Roboto',
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColorSkyBlue,
                        padding: EdgeInsets.symmetric(
                          vertical: 8.0,
                          horizontal: screenWidth * 0.36,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.5),
                        ),
                      ),
                    ),
                    if (_showWarning)
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          'Please enter your email.',
                          style: TextStyle(
                            color: secondaryColorRed,
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:world_traveller/authentication/login_screen.dart';
import 'package:world_traveller/colors/colors.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  bool _showPasswordWarning = false;
  bool _showConfirmPasswordWarning = false;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
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
              'Forgot Password',
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
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          hintText: 'Enter Your New Password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: _showPasswordWarning
                                  ? secondaryColorRed
                                  : primaryColorOcenBlue,
                              width: _showPasswordWarning ? 1.5 : 1.0,
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
                      height: 30.0,
                    ),
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                      child: TextFormField(
                        controller: _confirmPasswordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Confirm Password',
                          hintText: 'Re-enter Password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: _showConfirmPasswordWarning
                                  ? secondaryColorRed
                                  : primaryColorOcenBlue,
                              width: _showConfirmPasswordWarning ? 1.5 : 1.0,
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
                          String password = _passwordController.text;
                          String confirmPassword =
                              _confirmPasswordController.text;
                          bool isValid =
                              _validatePassword(password, confirmPassword);
                          if (isValid) {
                            // Navigate to the new screen
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => LoginScreen(
                                  onLogout: () {},
                                ),
                              ),
                            );
                          }
                        });
                      },
                      child: Text(
                        'Save',
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
                    if (_showPasswordWarning || _showConfirmPasswordWarning)
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          'Password does not match or does not meet requirements.',
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

  bool _validatePassword(String password, String confirmPassword) {
    bool isValid = true;
    if (password != confirmPassword) {
      isValid = false;
      setState(() {
        _showPasswordWarning = true;
        _showConfirmPasswordWarning = true;
      });
    } else {
      setState(() {
        _showPasswordWarning = false;
        _showConfirmPasswordWarning = false;
      });
    }
    if (password.length < 8) {
      isValid = false;
      setState(() {
        _showPasswordWarning = true;
      });
    }
    return isValid;
  }
}

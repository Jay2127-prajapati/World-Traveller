import 'package:flutter/material.dart';
import 'package:world_traveller/authentication/forgotpass_screen.dart';
import 'package:world_traveller/colors/colors.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({Key? key}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  late List<String?> _otpValues = List.filled(4, null);
  late List<TextEditingController> _controllers =
      List.generate(4, (_) => TextEditingController());

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/img/logo-main.png',
                width: MediaQuery.of(context).size.width * 0.68,
                height: MediaQuery.of(context).size.height * 0.3,
              ),
              const SizedBox(height: 20.0),
              const Text(
                'OTP Verification',
                style: TextStyle(
                  fontSize: 25.0,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                  color: secondaryColorWhite,
                  fontFamily: 'Poppins',
                  letterSpacing: 1.0,
                ),
              ),
              const SizedBox(height: 50.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  4,
                  (index) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.17,
                      height: MediaQuery.of(context).size.width * 0.19,
                      child: TextField(
                        controller: _controllers[index],
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        maxLength: 1,
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            setState(() {
                              _otpValues[index] = value;
                              if (index < 3) {
                                FocusScope.of(context).nextFocus();
                              }
                            });
                          } else {
                            setState(() {
                              _otpValues[index] = null;
                              if (index > 0) {
                                FocusScope.of(context).previousFocus();
                              }
                            });
                          }
                        },
                        decoration: InputDecoration(
                          counter: Offstage(),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: _otpValues[index] != null
                                  ? Colors.green
                                  : Colors.red,
                              width: 1.5,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.green,
                              width: 1.5,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          filled: true,
                          fillColor: secondaryColorWhite,
                        ),
                        style: TextStyle(
                          color: secondaryColorBlack,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 50.0),
              ElevatedButton(
                onPressed: () {
                  // Navigate to a new screen here
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ForgotPassword(),
                    ),
                  );
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
                    horizontal: MediaQuery.of(context).size.width * 0.34,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.5),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

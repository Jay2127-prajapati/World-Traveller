import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:world_traveller/Components/bottom_navigation.dart';
import 'package:world_traveller/authentication/signup_screen.dart';
import 'package:world_traveller/colors/colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key, required Null Function() onLogout})
      : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? _emailError;
  String? _passwordError;

  final FirebaseAuth _auth =
      FirebaseAuth.instance; // Define FirebaseAuth instance
  final GoogleSignIn _googleSignIn =
      GoogleSignIn(); // Define GoogleSignIn instance

  void _validateAndSubmit() async {
    setState(() {
      _emailError = null;
      _passwordError = null;
    });

    if (_formKey.currentState!.validate()) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final storedEmail = prefs.getString('email');
      final storedPassword = prefs.getString('password');

      if (storedEmail == _emailController.text &&
          storedPassword == _passwordController.text) {
        // Credentials matched, navigate to next screen
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CustomBottomNavigationBar()),
        );
      } else {
        setState(() {
          _emailError = 'Invalid email or password';
          _passwordError = 'Invalid email or password';
        });
      }
    }
  }

  String? _emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter Email Address';
    }
    if (!value.contains('@')) {
      return 'Wrong email id, please check your correct email address and enter here';
    }
    return null;
  }

  String? _passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter Password';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height;
    final screenWidth = mediaQuery.size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [primaryColorSkyBlue, primaryColorOcenBlue],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Image.asset(
                    'assets/img/logo-main.png',
                    width: screenWidth * 0.6,
                    height: screenHeight * 0.38,
                  ),
                ),
                const Text(
                  'Welcome Back',
                  style: TextStyle(
                    fontSize: 25.0,
                    color: secondaryColorWhite,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                    letterSpacing: 1.5,
                  ),
                ),
                const SizedBox(height: 20.0),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                  child: TextFormField(
                    controller: _emailController,
                    validator: _emailValidator,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      hintText: 'Enter Your Register Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: primaryColorOcenBlue),
                      ),
                      errorText: _emailError,
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            BorderSide(color: secondaryColorRed, width: 1.5),
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
                const SizedBox(height: 20.0),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                  child: TextFormField(
                    controller: _passwordController,
                    validator: _passwordValidator,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      hintText: 'Enter Your Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: primaryColorOcenBlue),
                      ),
                      errorText: _passwordError,
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            BorderSide(color: secondaryColorRed, width: 1.5),
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
                const SizedBox(height: 10.0),
                Container(
                  margin: EdgeInsets.only(right: 23.0),
                  alignment: Alignment.bottomRight,
                  child: InkWell(
                    onTap: () {
                      // Implement forgot password functionality
                    },
                    child: const Text(
                      'Forgot Password?',
                      style: TextStyle(
                        color: secondaryColorWhite,
                        fontFamily: 'Roboto',
                        fontSize: 16.8,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30.0),
                ElevatedButton(
                  onPressed: _validateAndSubmit,
                  child: Text(
                    'Login',
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
                const SizedBox(height: 20.0),
                const Opacity(
                  opacity: 0.5,
                  child: Divider(
                    height: 1.0,
                    color: secondaryColorGrey,
                    thickness: 1.5,
                    indent: 20.0,
                    endIndent: 10.0,
                  ),
                ),
                const SizedBox(height: 25.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                      child: Image.asset(
                        'assets/img/google.png',
                        width: 40,
                        height: 40,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        _handleGoogleSignIn();
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.05),
                        child: Image.asset(
                          'assets/img/apple.png',
                          width: 40,
                          height: 40,
                        ),
                      ),
                    ),
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                      child: Image.asset(
                        'assets/img/facebook.png',
                        width: 40,
                        height: 40,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30.0),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignupScreen()),
                    );
                  },
                  child: Text(
                    'Create New Account?',
                    style: TextStyle(
                      color: secondaryColorWhite,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.0,
                      fontFamily: 'Roboto',
                      fontSize: 20.0,
                    ),
                  ),
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                ),
                const SizedBox(height: 40.0),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _handleGoogleSignIn() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );
        final UserCredential userCredential =
            await _auth.signInWithCredential(credential);
        if (userCredential.user != null) {
          // Google login successful, navigate to next screen
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CustomBottomNavigationBar()),
          );
        }
      }
    } catch (error) {
      print(error);
    }
  }
}

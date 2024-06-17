import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:world_traveller/Components/bottom_navigation.dart';
import 'package:world_traveller/authentication/login_screen.dart';
import 'package:world_traveller/colors/colors.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  String? _usernameError;
  String? _emailError;
  String? _mobileError;
  String? _passwordError;

  Future<void> _signUpWithEmailAndPassword() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('username', _usernameController.text);
      prefs.setString('email', _emailController.text);
      prefs.setString('password', _passwordController.text);
      prefs.setString('mobile', _mobileController.text);

      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
              email: _emailController.text.trim(),
              password: _passwordController.text.trim());

      // Navigate to next screen upon successful signup
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => CustomBottomNavigationBar()),
      );
    } on FirebaseAuthException catch (e) {
      print('Failed to create user: ${e.message}');
      setState(() {
        _emailError = e.message;
      });
    }
  }

  Future<void> _handleGoogleSignUp() async {
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
          // Google sign-up successful, navigate to next screen
          Navigator.pushReplacement(
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

  String? _usernameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter Username';
    }
    return null;
  }

  String? _emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter Email Address';
    }
    if (!value.contains('@')) {
      return '* Wrong email id please check your correct email address and enter here';
    }
    return null;
  }

  String? _passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter Password';
    }
    if (!_isValidPassword(value)) {
      return '* Password must contain uppercase, lowercase, special characters, numerical value, and be at least 6 characters long';
    }
    return null;
  }

  bool _isValidPassword(String password) {
    final minLength = 6;
    final hasUppercase = password.contains(RegExp(r'[A-Z]'));
    final hasLowercase = password.contains(RegExp(r'[a-z]'));
    final hasDigit = password.contains(RegExp(r'\d'));
    final hasSpecialCharacter =
        password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));

    return password.length >= minLength &&
        hasUppercase &&
        hasLowercase &&
        hasDigit &&
        hasSpecialCharacter;
  }

  String? _mobileValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter Mobile No.';
    }
    if (!value.contains(RegExp(r'^[0-9]+$'))) {
      return 'Please enter a valid Mobile No.';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height;
    final screenWidth = mediaQuery.size.width;

    return Scaffold(
      resizeToAvoidBottomInset:
          false, // Prevents resizing when keyboard appears
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [primaryColorSkyBlue, primaryColorOcenBlue],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
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
                      fit: BoxFit.contain,
                    ),
                  ),
                  const Text(
                    'Let\'s Start',
                    style: TextStyle(
                      fontSize: 28.0,
                      color: secondaryColorWhite,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                      letterSpacing: 1.5,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  TextFormField(
                    controller: _usernameController,
                    validator: _usernameValidator,
                    decoration: InputDecoration(
                      labelText: 'Username',
                      hintText: 'Enter Your Username',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(color: primaryColorOcenBlue),
                      ),
                      errorText: _usernameError,
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
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
                  SizedBox(height: screenHeight * 0.02),
                  TextFormField(
                    controller: _emailController,
                    validator: _emailValidator,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      hintText: 'Enter Your Register Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(color: primaryColorOcenBlue),
                      ),
                      errorText: _emailError,
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
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
                  SizedBox(height: screenHeight * 0.02),
                  TextFormField(
                    controller: _mobileController,
                    validator: _mobileValidator,
                    keyboardType:
                        TextInputType.phone, // Enable numeric keyboard
                    decoration: InputDecoration(
                      labelText: 'Mobile No.',
                      hintText: 'Enter Your Mobile No.',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(color: primaryColorOcenBlue),
                      ),
                      errorText: _mobileError,
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
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
                  SizedBox(height: screenHeight * 0.02),
                  TextFormField(
                    controller: _passwordController,
                    validator: _passwordValidator,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      hintText: 'Enter Your Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(color: primaryColorOcenBlue),
                      ),
                      errorText: _passwordError,
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
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
                  SizedBox(height: screenHeight * 0.03),
                  ElevatedButton(
                    onPressed: _signUpWithEmailAndPassword,
                    child: Text(
                      'Signup',
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
                  SizedBox(height: 20.0),
                  Opacity(
                    opacity: 0.5,
                    child: Divider(
                      height: 1.0,
                      color: secondaryColorGrey,
                      thickness: 1.5,
                      indent: 20.0,
                      endIndent: 10.0,
                    ),
                  ),
                  SizedBox(height: 25.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: _handleGoogleSignUp,
                        child: Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.05),
                          child: Image.asset(
                            'assets/img/google.png',
                            width: 40,
                            height: 40,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.05),
                        child: Image.asset(
                          'assets/img/apple.png',
                          width: 40,
                          height: 40,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.05),
                        child: Image.asset(
                          'assets/img/facebook.png',
                          width: 40,
                          height: 40,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 40.0),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(
                            onLogout: () {},
                          ),
                        ),
                      );
                    },
                    child: Text(
                      'Already Have an Account? Login',
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
                  SizedBox(height: 20.0),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

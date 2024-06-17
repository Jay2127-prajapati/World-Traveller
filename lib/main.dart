import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:world_traveller/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: 'AIzaSyCyOtnZlD3mxbFj81Fe0i4ovy6BIgiPcn0',
        appId: '1:236666783296:android:cf290a1fe83fab471541a5',
        messagingSenderId: '236666783296',
        projectId: 'world-traveller-4dea7',
        storageBucket: 'world-traveller-4dea7.appspot.com'),
  );
  runApp(const Home());
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mini_project/View Model/db_data_manager.dart';
import 'package:mini_project/Views/Splash_screen/splash.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DataManager>(
      create: (context) => DataManager(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Mini Project',
        home: SplashScreen(),
      ),
    );
  }
}

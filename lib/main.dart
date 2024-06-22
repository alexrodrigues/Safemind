import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:safemind/screens/detail_screen.dart';
import 'package:safemind/screens/login_screen.dart';
import 'package:safemind/screens/tab_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: "/",
      routes: {
        "/": (ctx) => const TabScreen(),
        DetailsScreen.ROUTE_NAME: (context) => const DetailsScreen(),
        LoginScreen.ROUTE_NAME: (context) => const LoginScreen()
      },
    );
  }
}

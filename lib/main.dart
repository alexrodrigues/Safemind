import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:safemind/providers/therapists_provider.dart';
import 'package:safemind/screens/detail_screen.dart';
import 'package:safemind/screens/login_screen.dart';
import 'package:safemind/screens/signup_screen.dart';
import 'package:safemind/screens/tab_screen.dart';
import 'package:safemind/di/injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  
  // Initialize dependency injection
  configureDependencies();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: TherapistsProvider()),
      ],
      child: MaterialApp(
        title: 'Safemind',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: "/",
        debugShowCheckedModeBanner: false,
        routes: {
          "/": (ctx) => const TabScreen(),
          DetailsScreen.ROUTE_NAME: (context) => const DetailsScreen(),
          LoginScreen.ROUTE_NAME: (context) => const LoginScreen(),
          SignUpScreen.ROUTE_NAME: (context) => SignUpScreen(),
        },
      ),
    );
  }
}

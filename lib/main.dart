import 'package:eaty_tourist/pages/splash.dart';
import 'package:eaty_tourist/services/impact.dart';
import 'package:eaty_tourist/utils/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
          create: (context) => Preferences()..init(), //Preferences classe creata da noi
          // This creates the preferences when the provider is creater. With lazy = true (default), the preferences would be initialized when first accessed, but we need them for the other services
          lazy: false,
        ),
        Provider(
          create: (context) => ImpactService(
            // We pass the newly created preferences to the service
            Provider.of<Preferences>(context, listen: false),
          )
        ),
      ],
      child: MaterialApp(
        title: 'eaty tourist',
        theme: ThemeData(
          primaryColor: Colors.greenAccent,
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blueGrey),
        ),
        home: const Splash(),
      ),
    );
  }
}



import 'package:eaty_tourist/models/db.dart';
import 'package:eaty_tourist/pages/splash.dart';
import 'package:eaty_tourist/services/impact.dart';
import 'package:eaty_tourist/utils/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  // database inizialization 
  WidgetsFlutterBinding.ensureInitialized();
  final db = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  runApp(Provider<AppDatabase>.value(value: db, child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the application root 
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        //provider for Preferences
        Provider(
          create: (context) => Preferences()..init(), 
          // This creates the preferences when the provider is creater. 
          //With lazy = true (default), the preferences would be initialized when first accessed, 
          //but we need them for the other services
          lazy: false,
        ),
        //provider for ImpactService
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



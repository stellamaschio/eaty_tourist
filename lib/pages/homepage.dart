import 'package:eaty_tourist/models/db.dart';
import 'package:eaty_tourist/models/foods.dart';
import 'package:eaty_tourist/models/listFoods.dart';
import 'package:eaty_tourist/pages/information/foodAndRestaurants.dart';
import 'package:eaty_tourist/pages/login/login_ob.dart';
import 'package:eaty_tourist/pages/profile.dart';
import 'package:eaty_tourist/pages/splash.dart';
import 'package:eaty_tourist/pages/splash_out.dart';
import 'package:eaty_tourist/pages/statistics.dart';
import 'package:eaty_tourist/pages/home.dart';
import 'package:eaty_tourist/providers/home_provider.dart';
import 'package:eaty_tourist/services/impact.dart';
import 'package:eaty_tourist/utils/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<Foods> foodList = ListFoods.foodList;
  int _selIdx = 0;

  void changePage(int index){
    setState(() {
      _selIdx = index;
    });
  }

  Widget selectPage(int index){
    switch(index){
      case 0:
        return Home();
      case 1: 
        return Statistics();
      default: 
        return Home();
    }
  }

  @override
  Widget build(BuildContext context){
    return ChangeNotifierProvider<HomeProvider>(
      create: (context) => HomeProvider(
        Provider.of<ImpactService>(context, listen: false),
        Provider.of<AppDatabase>(context, listen: false)
      ),
      lazy: false,
      builder: (context, child) => Scaffold(
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Color(0xA969F0AF),
                ),
                child: Text('eaty tourist',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.bold,
                    fontSize: 43,
                    height: 3.5,
                    color: Color(0xFF607D8B),
                  ),
                ),
              ),
              ListTile(
                leading: Icon(MdiIcons.hamburger),
                title: Text('Food and Restaurants',
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade600,
                    fontSize: 15,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => FoodAndRestaurant()));
                },
              ),
              ListTile(
                leading: Icon(MdiIcons.logout),
                title: Text('Logout',
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade600,
                    fontSize: 15,
                  ),
                ),
                onTap: () => _toLoginPage(context),
              ),
            ],
          ),
        ),
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Color(0xFF607D8B),),
          backgroundColor: const Color(0xA969F0AF),
          title: Text('eaty tourist',
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
              color: Color(0xFF607D8B),
              fontWeight: FontWeight.bold,
              fontSize: 28,
            ),
          ),
          actions: [
            Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 0.0,
                  horizontal: 15.0,
                ),
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      fullscreenDialog: true,
                      builder: (context) => Profile()));
                  }, 
                  icon: const Icon(
                    MdiIcons.accountCircle,
                    size: 40,
                  ),
                ),
              ),
          ],
        ),
        body:selectPage(_selIdx),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Color(0xFF607D8B),
          selectedItemColor: Color(0xA969F0AF),
          unselectedItemColor: Colors.white,
          selectedLabelStyle: GoogleFonts.montserrat(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
          unselectedLabelStyle: GoogleFonts.montserrat(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
          currentIndex: _selIdx,
          onTap: (value) {
            changePage(value);
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(MdiIcons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(MdiIcons.chartBar),
              label: 'Statistics',
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _toLoginPage(BuildContext context) async{
    
    final pref = await Provider.of<Preferences>(context, listen: false);
    pref.resetSettings();

    //Pop the drawer first 
    Navigator.pop(context);
    //Then pop the HomePage
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => SplashOut()));
  }
}
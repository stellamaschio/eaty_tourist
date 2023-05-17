import 'package:eaty_tourist/pages/login/login_ob.dart';
import 'package:eaty_tourist/pages/login/loginpage.dart';
import 'package:eaty_tourist/pages/profile.dart';
import 'package:eaty_tourist/pages/statistics.dart';
import 'package:eaty_tourist/pages/map.dart';
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
  int _selIdx = 0;

  void changePage(int index){
    setState(() {
      _selIdx = index;
    });
  }

  Widget selectPage(int index){
    switch(index){
      case 0:
        return Map();
      case 1: 
        return Statistics();
      default: 
        return Map();
    }
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
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
              title: Text('Food and Restaurants'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(MdiIcons.bankOutline),
              title: Text('Places and Museum'),
              onTap: () {},
            ),
            SizedBox(height: 50,),
            ListTile(
              leading: Icon(MdiIcons.key),
              title: Text('Password'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(MdiIcons.logout),
              title: Text('Logout'),
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
        backgroundColor: Color(0xA9B7F4D6),
        selectedItemColor: Color(0xA31DA7DD),
        selectedLabelStyle: GoogleFonts.montserrat(
          color: Color(0xFF607D8B),
        ),
        unselectedLabelStyle: GoogleFonts.montserrat(
          color: Color(0xFF607D8B),
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
    );
  }

  Future<void> _toLoginPage(BuildContext context) async{
    
    final pref = await Provider.of<Preferences>(context, listen: false);
    pref.resetSettings();

    //Pop the drawer first 
    Navigator.pop(context);
    //Then pop the HomePage
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Login()));
  }
}
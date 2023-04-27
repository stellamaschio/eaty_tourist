import 'package:eaty_tourist/pages/profile.dart';
import 'package:eaty_tourist/pages/statistics.dart';
import 'package:eaty_tourist/pages/map.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';


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
              child: Text('eaty tourist',
                textAlign: TextAlign.center,
              ),
              decoration: BoxDecoration(
                color: Colors.greenAccent,
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
              onTap: () {},
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('eaty tourist'),
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
        currentIndex: _selIdx,
        onTap: (value) {
          changePage(value);
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(MdiIcons.map),
            label: 'Map',
          ),
          BottomNavigationBarItem(
            icon: Icon(MdiIcons.chartBar),
            label: 'Statistics',
          ),
        ],
      ),
    );
  }

}
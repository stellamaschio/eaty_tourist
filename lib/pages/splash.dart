import 'package:eaty_tourist/pages/homepage.dart';
import 'package:eaty_tourist/pages/login/login_ob.dart';
import 'package:eaty_tourist/services/impact.dart';
import 'package:eaty_tourist/utils/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Splash extends StatelessWidget{
  const Splash({super.key});

  void _toLoginPage(BuildContext context){
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Login()));
  }

  void _toHomePage(BuildContext context) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: ((context) => HomePage())));
  } 

  void _checkAuth(BuildContext context) async {
    var prefs = Provider.of<Preferences>(context, listen: false);
    String? username = prefs.username;
    String? password = prefs.password;

    // no user logged in the app
    if (username == null || password == null) {
      Future.delayed(const Duration(seconds: 1), () => _toLoginPage(context));
    } 
    else {
      ImpactService service = Provider.of<ImpactService>(context, listen: false);
      bool responseAccessToken = await service.checkSavedToken();
      bool refreshAccessToken = await service.checkSavedToken(refresh: true);

      // if we have a valid token for impact, proceed
      if (responseAccessToken || refreshAccessToken) {
        Future.delayed(const Duration(seconds: 1), () => _toHomePage(context));
      } 
      else {
        Future.delayed(const Duration(seconds: 1), () => _toLoginPage(context));
      }
    }
  }

  @override
  Widget build(BuildContext context){
    
    Future.delayed(Duration(seconds: 1), () => _checkAuth(context));

    return Material(
      child: Container(
        color: const Color(0xA969F0AF),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text('eaty tourist',
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                color: Color(0xFF607D8B),
                fontWeight: FontWeight.bold,
                fontSize: 50,
              ),
            ),
            CircularProgressIndicator(
              strokeWidth: 5,
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF607D8B)),
            ),
          ],
        ),
      ),
    );
  }
}
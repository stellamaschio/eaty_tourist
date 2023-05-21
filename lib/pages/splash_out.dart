import 'package:eaty_tourist/pages/login/login_ob.dart';
import 'package:eaty_tourist/utils/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SplashOut extends StatelessWidget{
  const SplashOut({super.key});

  void _toLoginPage(BuildContext context){
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Login()));
  } 

  @override
  Widget build(BuildContext context){

    Future.delayed(Duration(seconds: 2), () => _toLoginPage(context));
    
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
                textStyle: TextStyle(fontSize: 50),
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
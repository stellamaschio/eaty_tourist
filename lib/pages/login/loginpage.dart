import 'package:flutter/material.dart';
import 'package:eaty_tourist/pages/homepage.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  static const routename = 'LoginPage';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
  }//initState

  Future<String> _loginUser(LoginData data) async {
    if(data.name == 'bug@expert.com' && data.password == '123456'){

      final sp = await SharedPreferences.getInstance();
      sp.setString('username', data.name);
      
      return '';
    } else {
      return 'Wrong credentials';
    }
  } // _loginUser

  Future<String> _signUpUser(SignupData data) async {
    return 'To be implemented';
  } // _signUpUser

  Future<String> _recoverPassword(String email) async {
    return 'Recover password functionality needs to be implemented';
  } // _recoverPassword

  @override
  Widget build(BuildContext context) {
    
    return FlutterLogin(
      title: 'eaty tourist',
       theme: LoginTheme(
        primaryColor: Colors.greenAccent,
        accentColor: Color(0xFF607D8B),
        errorColor: Color(0xFFF44336),
        titleStyle: GoogleFonts.montserrat(
          fontWeight: FontWeight.bold,
          textStyle: TextStyle(fontSize: 50),
        ),
            
        bodyStyle: GoogleFonts.montserrat(
          decoration: TextDecoration.underline,
        ),

        textFieldStyle: TextStyle(
          color: Colors.black,
        ),
        
        buttonStyle: GoogleFonts.montserrat(
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
        
        cardTheme: CardTheme(
          color: Colors.white,
          elevation: 5,
          //margin: EdgeInsets.only(top: 15),
          //shape: ContinuousRectangleBorder(
              //borderRadius: BorderRadius.circular(20.0)),
        ),
        
        inputTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.grey.withOpacity(0.2),
          contentPadding: EdgeInsets.zero,
          errorStyle: GoogleFonts.montserrat(
            color: Colors.red,
          ),
          labelStyle: GoogleFonts.montserrat(fontSize: 12),
        ),
        
        buttonTheme: LoginButtonTheme(
          splashColor: Colors.purple,
          backgroundColor: Colors.blueGrey,
          
          
          // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          // shape: CircleBorder(side: BorderSide(color: Colors.green)),
          // shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(55.0)),
        ),
      ),

      messages: LoginMessages(
        //userHint: 'User',
        //passwordHint: 'Pass',
        //confirmPasswordHint: 'Confirm',
        loginButton: 'LOGIN',
        signupButton: 'SIGN UP',

        //forgotPasswordButton: 'Forgot huh?',
        //recoverPasswordButton: 'HELP ME',
        //goBackButton: 'GO BACK',
        //confirmPasswordError: 'Not match!',
        //recoverPasswordDescription:
          //  'Lorem Ipsum is simply dummy text of the printing and typesetting industry',
        //recoverPasswordSuccess: 'Password rescued successfully',
      ),

      onLogin: _loginUser,
      //onSignup: _signUpUser,
      onRecoverPassword: _recoverPassword,
      onSubmitAnimationCompleted: () async{
        _toHomePage(context);
      },
    );
  } // build

  void _toHomePage(BuildContext context){
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
  }//_
// LoginScreen
}







  
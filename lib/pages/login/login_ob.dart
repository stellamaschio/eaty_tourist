import 'package:eaty_tourist/pages/homepage.dart';
import 'package:eaty_tourist/services/impact.dart';
import 'package:flutter/material.dart';
import 'package:eaty_tourist/utils/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';


class Login extends StatefulWidget {
  static const route = '/login/';
  static const routeDisplayName = 'LoginPage';

  Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  static bool _passwordVisible = false;

  final TextEditingController userController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool isLoading = false;

  void _showPassword() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }

  void _buttonState(){
    setState(() {
      isLoading = !isLoading;
    });
  }

  // ottiene i token utilizzando le credenziali dell'utente che si sta loggando a impact
  Future<bool> _loginImpact(String name, String password, BuildContext context) async {
    ImpactService service = Provider.of<ImpactService>(context, listen: false);
    bool logged = await service.getTokens(name, password);
    return logged;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      body: Column(
        children: [
          SizedBox(height: 160),
          Text('eaty tourist',
              style: GoogleFonts.montserrat(
                color: const Color(0xFF607D8B),
                fontWeight: FontWeight.bold,
                fontSize: 58,
              ),
            ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 50, 
              vertical: 30,
            ),        
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              elevation: 30,
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    const SizedBox(height: 30,),
                    Text('Login',
                      style: GoogleFonts.montserrat(
                        color: const Color(0xFF607D8B),
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                      ),
                    ),
                    Text('Please login to use our app',
                      style: GoogleFonts.montserrat(
                        fontSize: 16,
                      )
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    Row(
                      children: [
                        SizedBox(width: 10),
                        Text('Username',
                          style: GoogleFonts.montserrat(
                            fontSize: 18, 
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ]
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10, 
                      ),
                      child: TextFormField(
                        style: GoogleFonts.montserrat(),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            _buttonState();
                            return 'Username is required';
                          } 
                          return null;
                        },
                        controller: userController,
                        cursorColor: const Color(0xFF607D8B),
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(
                              color: Color(0xFF607D8B),
                            ),
                          ),
                          border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(15))),
                          prefixIcon: const Icon(
                            Icons.person,
                            color: Color(0xFF607D8B),
                          ),
                          hintText: 'Username',
                          hintStyle: const TextStyle(
                            color: Color(0xFF607D8B),
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        SizedBox(width: 10),
                        Text('Password',
                          style: GoogleFonts.montserrat(
                            fontSize: 18, 
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ]
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10, 
                      ),
                      child: TextFormField(
                        style: GoogleFonts.montserrat(),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            _buttonState();
                            return 'Password is required';
                          } 
                          return null;
                        },
                        controller: passwordController,
                        cursorColor: const Color(0xFF607D8B),
                        obscureText: !_passwordVisible,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(
                              color: Color(0xFF607D8B),
                            ),
                          ),
                          border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(15))),
                          prefixIcon: const Icon(
                            MdiIcons.key,
                            color: Color(0xFF607D8B),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              // Based on passwordVisible state choose the icon
                              _passwordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              _showPassword();
                            },
                          ),
                          hintText: 'Password',
                          hintStyle: const TextStyle(
                            color: Color(0xFF607D8B),
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    Align(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: ElevatedButton(
                              onPressed: () async{
                                _buttonState();

                                if (_formKey.currentState!.validate()) {
                                  var prefs = Provider.of<Preferences>(context, listen: false);
                                  prefs.username = userController.text;
                                  prefs.password = passwordController.text;
            
                                  bool? validation = await _loginImpact(userController.text, passwordController.text, context);
                                  
                                  if (!validation) {
                                    Future.delayed(
                                      const Duration(milliseconds: 1500), () => {
                                        _buttonState(),
                                        // if not correct show message
                                        ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                            backgroundColor: Colors.red,
                                            behavior: SnackBarBehavior.floating,
                                            margin: EdgeInsets.all(8),
                                            content: Row(
                                              children: [
                                                Icon(MdiIcons.alertOctagonOutline,
                                                  color: Colors.white,
                                                ),
                                              SizedBox(width: 10,),
                                              Text('Wrong Credentials'),
                                              ],
                                            ),
                                            duration: Duration(seconds: 2),
                                          )
                                        )
                                      }
                                    );
                                  }
                                  else{
                                    ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                        backgroundColor: Colors.blueAccent,
                                        behavior: SnackBarBehavior.floating,
                                        margin: EdgeInsets.all(8),
                                        content: Row(
                                          children: [
                                            Icon(MdiIcons.informationOutline,
                                              color: Colors.white,
                                            ),
                                            SizedBox(width: 10,),
                                            Text('You are also logging to Impact'),
                                          ],
                                        ),
                                        duration: Duration(seconds: 4),
                                      )
                                    );
                                    Future.delayed(
                                      const Duration(seconds: 3), () => {
                                        _buttonState(),
                                    
                                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                                                builder: (context) => HomePage()))
                                      }
                                    );
                                  }
                                }
                              },
                              style: ButtonStyle(
                                //maximumSize: const MaterialStatePropertyAll(Size(50, 20)),
                                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15))),
                                elevation: MaterialStateProperty.all(0),
                                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                                  const EdgeInsets.symmetric(
                                    horizontal: 40, 
                                    vertical: 15,
                                  ),
                                ),
                                foregroundColor:
                                  MaterialStateProperty.all<Color>(Colors.white),
                                backgroundColor: MaterialStateProperty.all<Color>(
                                  const Color(0xFF607D8B)
                                )
                              ),
                              child: (isLoading)
                                ? CircularProgressIndicator(color: Colors.white,)
                                : Text('LOGIN',
                                    style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                            ),
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
          ),
        ],
      ),
    );
  }
}


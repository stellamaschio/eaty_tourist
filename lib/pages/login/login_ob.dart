import 'package:eaty_tourist/pages/homepage.dart';
import 'package:eaty_tourist/services/impact.dart';
import 'package:flutter/material.dart';
import 'package:eaty_tourist/utils/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

// this class is used for logging to the app

class Login extends StatefulWidget {
  static const route = '/login/';
  static const routeDisplayName = 'LoginPage';

  const Login({Key? key}) : super(key: key);

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

  // get the tokens using the credentials of the user that is logging to the app and also to impact
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
          const SizedBox(height: 160),
          Text('eaty tourist',
              style: GoogleFonts.montserrat(
                color: const Color(0xFF607D8B),
                fontWeight: FontWeight.bold,
                fontSize: 52,
              ),
            ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 30, 
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
                    const SizedBox(height: 20,),
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
                    const SizedBox(height: 40,),
                    Row(
                      children: [
                        const SizedBox(width: 15),
                        Text('Username',
                          style: GoogleFonts.montserrat(
                            fontSize: 17, 
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
                        horizontal: 15, 
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
                        const SizedBox(width: 15),
                        Text('Password',
                          style: GoogleFonts.montserrat(
                            fontSize: 17, 
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
                        horizontal: 15, 
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
                    const SizedBox(height: 20),
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
                                  
                                  // if credentials are NOT correct
                                  if (!validation) {
                                    Future.delayed(
                                      const Duration(milliseconds: 1500), () => {
                                        _buttonState(),
                                        // if not correct show message
                                        ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                            backgroundColor: Colors.red,
                                            behavior: SnackBarBehavior.floating,
                                            margin: const EdgeInsets.all(8),
                                            content: Row(
                                              children: [
                                                const Icon(MdiIcons.alertOctagonOutline,
                                                  color: Colors.white,
                                                ),
                                                const SizedBox(width: 10,),
                                                Text('Wrong Credentials',
                                                  style: GoogleFonts.montserrat(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            duration: const Duration(seconds: 2),
                                          )
                                        )
                                      }
                                    );
                                  }
                                  // if credentials are correct
                                  else{
                                    await Provider.of<ImpactService>(context, listen: false).getPatient();
                                    ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                        backgroundColor: Colors.blueAccent,
                                        behavior: SnackBarBehavior.floating,
                                        margin: const EdgeInsets.all(8),
                                        content: Row(
                                          children: [
                                            const Icon(MdiIcons.informationOutline,
                                              color: Colors.white,
                                            ),
                                            const SizedBox(width: 10,),
                                            Text('You are also logging to Impact',
                                              style: GoogleFonts.montserrat(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                        duration: const Duration(seconds: 4),
                                      )
                                    );
                                    Future.delayed(
                                      const Duration(seconds: 3), () => {
                                        _buttonState(),
                                    
                                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                                                builder: (context) => const HomePage()))
                                      }
                                    );
                                  }
                                }
                              },
                              style: ButtonStyle(
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
                                ? const CircularProgressIndicator(color: Colors.white,)
                                : Text('LOGIN',
                                    style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18
                                    ),
                                  ),
                            ),
                          ),
                          const SizedBox(height: 10),
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


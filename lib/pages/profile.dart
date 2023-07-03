import 'package:eaty_tourist/utils/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

enum Gender { male, female }

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _Profile();
}

class _Profile extends State<Profile> {
  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  Gender? _gender;
  late int gen = -1;

  bool save = false;
  bool cancel = false;
  bool loadedPrefs = false;

  void _saveState(){
    setState(() {
      save = !save;
    });
  }
  void _cancelState(){
    setState(() {
      cancel = !cancel;
    });
  }

   @override
  void initState() {
    super.initState();
    
    // set the preferences if there are saved
    var prefs = Provider.of<Preferences>(context, listen: false);
    if(prefs.name==null && prefs.surname==null){
      loadedPrefs = false;
      _gender = Gender.male;
      gen = 0;
    }
    else{
      loadedPrefs = true;
      if(gen==0){
        _gender = Gender.male;
      }
      else{
        _gender = Gender.female;
      }
      
    }
      
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Color(0xFF607D8B),
        ),
        backgroundColor: const Color(0xA969F0AF),
        title: Text('Profile',
          textAlign: TextAlign.center,
          style: GoogleFonts.montserrat(
            color: const Color(0xFF607D8B),
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              const Icon(MdiIcons.accountCircle,
                color: Color(0xFF607D8B),
                size: 110,
              ),
              const SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10, 
                ),
                child: Row(
                  children: [
                    Text('Gender:',
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: Colors.grey.shade800,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Radio<Gender>(
                        value: Gender.male,
                        groupValue: _gender,
                        onChanged: (Gender? value) {
                          setState(() {
                            _gender = value;
                          });
                        }),
                    Text('Male',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: Colors.grey.shade800,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Radio<Gender>(
                        value: Gender.female,
                        groupValue: _gender,
                        onChanged: (Gender? value) {
                          setState(() {
                            _gender = value;
                          });
                        }),
                    Text('Female',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: Colors.grey.shade800,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40,),
              Row(
                children: [
                  const SizedBox(width: 10),
                  Text('Name',
                    style: GoogleFonts.montserrat(
                      fontSize: 18, 
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade800,
                    ),
                  ),
                ]
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                child: (loadedPrefs)
                  ? Text('${Provider.of<Preferences>(context, listen: false).name}',
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                  )
                  : TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        width: 3,
                        color: Color(0xFF607D8B),
                      ),
                    ),
                    border: UnderlineInputBorder(),
                    prefixIcon: Icon(
                      Icons.person,
                      color: Color(0xFF607D8B),
                    ),
                    hintText: 'Name',
                    hintStyle: TextStyle(color: Color(0xFF607D8B)),
                  ),
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(height: 25,),
              Row(
                children: [
                  const SizedBox(width: 10),
                  Text('Surname',
                    style: GoogleFonts.montserrat(
                      fontSize: 18, 
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade800,
                    ),
                  ),
                ]
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10, 
                ),
                child: (loadedPrefs)
                  ? Text('${Provider.of<Preferences>(context, listen: false).surname}',
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                  )
                  : TextFormField(
                  controller: surnameController,
                  decoration: const InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        width: 3,
                        color: Color(0xFF607D8B),
                      ),
                    ),
                    border: UnderlineInputBorder(),
                    prefixIcon: Icon(
                      Icons.person,
                      color: Color(0xFF607D8B),
                    ),
                    hintText: 'Surname',
                    hintStyle: TextStyle(color: Color(0xFF607D8B)),
                  ),
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(height: 70,),
              (loadedPrefs)
              ? ElevatedButton(
                onPressed: () {
                  _cancelState();
                  if (loadedPrefs) {
                    var prefs = Provider.of<Preferences>(context, listen: false);
                    prefs.name = null;
                    prefs.surname = null;
                    gen = 0;
                    _gender = Gender.male;
                    loadedPrefs = false;
                  }
                },
                style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15))),
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      const EdgeInsets.symmetric(
                        horizontal: 38,
                        vertical: 13,
                      ),
                    ),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    backgroundColor: MaterialStateProperty.all<Color>(
                        const Color(0xFF607D8B))),
                child: Text('Clear',
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              )
              : ElevatedButton(
                onPressed: () {
                  _saveState();
                  if (_formKey.currentState!.validate()) {
                    var prefs = Provider.of<Preferences>(context, listen: false);
                    prefs.name = nameController.text;
                    prefs.surname = surnameController.text;
                    if(_gender == Gender.male){
                      gen = 0;
                    }
                    else{
                      gen = 1;
                    }
                    loadedPrefs = true;
                  }
                },
                style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15))),
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      const EdgeInsets.symmetric(
                        horizontal: 38,
                        vertical: 13,
                      ),
                    ),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    backgroundColor: MaterialStateProperty.all<Color>(
                        const Color(0xFF607D8B))),
                child: Text('SAVE',
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              
            ],
          ),
        ),
      ),
    );
  }
}

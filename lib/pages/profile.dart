import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

enum Gender { male, female }

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _Profile();
}

class _Profile extends State<Profile> {
  TextEditingController ageController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  Gender? _gender = Gender.male;

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
            color: Color(0xFF607D8B),
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
              SizedBox(
                height: 20,
              ),
              Image.asset('assets/avatar.png', scale: 1.5),
              SizedBox(height: 50,),
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
                    SizedBox(width: 50),
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
                    SizedBox(width: 30),
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
              SizedBox(height: 10,),
              Row(
                children: [
                  SizedBox(width: 10),
                  Text('Age',
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
                child: TextFormField(
                  controller: ageController,
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: const BorderSide(
                        width: 3,
                        color: Color(0xFF607D8B),
                      ),
                    ),
                    border: UnderlineInputBorder(),
                    prefixIcon: const Icon(
                      Icons.person,
                      color: Color(0xFF607D8B),
                    ),
                    hintText: 'Age',
                    hintStyle: const TextStyle(color: Color(0xFF607D8B)),
                  ),
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  ),
                ),
              ),
              SizedBox(height: 25,),
              Row(
                children: [
                  SizedBox(width: 10),
                  Text('Weight',
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
                child: TextFormField(
                  controller: weightController,
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: const BorderSide(
                        width: 3,
                        color: Color(0xFF607D8B),
                      ),
                    ),
                    border: UnderlineInputBorder(),
                      prefixIcon: const Icon(
                        MdiIcons.weightKilogram,
                        color: Color(0xFF607D8B),
                    ),
                    hintText: 'Weight',
                    hintStyle: const TextStyle(color: Color(0xFF607D8B)),
                  ),
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  ),
                ),
              ),
              SizedBox(height: 25,),
              Row(
                children: [
                  SizedBox(width: 10),
                  Text('Height',
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
                child: TextFormField(
                  controller: heightController,
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: const BorderSide(
                        width: 3,
                        color: Color(0xFF607D8B),
                      ),
                    ),
                    border: UnderlineInputBorder(),
                      prefixIcon: const Icon(
                        MdiIcons.humanMaleHeight,
                        color: Color(0xFF607D8B),
                    ),
                    hintText: 'Height',
                    hintStyle: const TextStyle(color: Color(0xFF607D8B)),
                  ),
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

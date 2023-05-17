import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
        title: Text(
          'Profile',
          textAlign: TextAlign.center,
          style: GoogleFonts.montserrat(
            color: Color(0xFF607D8B),
            fontWeight: FontWeight.bold,
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
              SizedBox(
                height: 50,
              ),
              Row(
                children: [
                  Text(
                    'Gender:',
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(width: 40),
                  Radio<Gender>(
                      value: Gender.male,
                      groupValue: _gender,
                      onChanged: (Gender? value) {
                        setState(() {
                          _gender = value;
                        });
                      }),
                  Text(
                    'Male',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(width: 10),
                  Radio<Gender>(
                      value: Gender.female,
                      groupValue: _gender,
                      onChanged: (Gender? value) {
                        setState(() {
                          _gender = value;
                        });
                      }),
                  Text(
                    'Female',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Age',
                ),
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w500,
                ),
                controller: ageController,
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Weight',
                ),
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w500,
                ),
                controller: weightController,
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Height',
                ),
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w500,
                ),
                controller: heightController,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

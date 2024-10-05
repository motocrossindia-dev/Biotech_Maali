import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Column(
        children: [
          Image.asset('assets/png/Login_Image.png'),

          Text('Varification', style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w400))
        ],
      ),
    );
  }
}
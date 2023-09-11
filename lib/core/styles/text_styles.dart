import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  final TextStyle sRegular = GoogleFonts.poppins(
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
    fontSize: 12,
    decoration: TextDecoration.none,
    letterSpacing: 0,
  );
  final TextStyle sThick = GoogleFonts.poppins(
    fontWeight: FontWeight.w600,
    fontStyle: FontStyle.normal,
    fontSize: 12,
    decoration: TextDecoration.none,
    letterSpacing: 0,
  );
  final TextStyle mRegular = GoogleFonts.poppins(
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
    fontSize: 18,
    decoration: TextDecoration.none,
    letterSpacing: 0,
  );
  final TextStyle mThick = GoogleFonts.poppins(
    fontWeight: FontWeight.w600,
    fontStyle: FontStyle.normal,
    fontSize: 18,
    decoration: TextDecoration.none,
    letterSpacing: 0,
  );

  final lThin = GoogleFonts.nunito(
    fontWeight: FontWeight.w300,
    fontStyle: FontStyle.normal,
    fontSize: 26,
    decoration: TextDecoration.none,
    letterSpacing: 0,
  );

  final lRegular = GoogleFonts.raleway(
    fontWeight: FontWeight.w500,
    fontStyle: FontStyle.normal,
    fontSize: 26,
    decoration: TextDecoration.none,
    letterSpacing: 0,
  );

  final lThick = GoogleFonts.raleway(
    fontWeight: FontWeight.w800,
    fontStyle: FontStyle.normal,
    fontSize: 26,
    decoration: TextDecoration.none,
    letterSpacing: 0,
  );
}

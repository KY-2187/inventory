import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color purple = Color(0xFF003566);
const Color red = Color.fromARGB(255, 237, 76, 92);
const Color grey = Color(0xFFF2F6F7);
const Color darkGrey = Color(0xFF495057);

TextStyle get titleStyle {
  return GoogleFonts.jost(
    color: purple,
    fontSize: 28,
  );
}

TextStyle get logStyle {
  return GoogleFonts.roboto(
    color: darkGrey,
    fontSize: 14
  );
}

TextStyle get subTitleStyle {
  return GoogleFonts.lato(
      fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey);
}

TextStyle get inputTitleStyle {
  return GoogleFonts.lato(
      fontSize: 18, fontWeight: FontWeight.bold, color: purple);
}

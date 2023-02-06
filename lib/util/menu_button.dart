import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inventory/theme.dart';

class MenuButton extends StatelessWidget {
  final IconData iconImage;
  final String buttonText;
  final Function()? onTap;

  const MenuButton(
      {Key? key,
      required this.iconImage,
      required this.buttonText,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Material(
        elevation: 4,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        child: Container(
            height: 180,
            width: 180,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(iconImage, color: purple, size: 48),
                SizedBox(height: 17),
                Text(buttonText,
                    style: GoogleFonts.jost(
                        fontSize: 16, color: Color(0xFFBCC2E0)))
              ],
            )),
      ),
    );
  }
}

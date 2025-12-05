import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constant/color.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    Key? key,
    required this.title, // Make it required
  }) : super(key: key);

  final String title; // Non-nullable

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: appBarColor,
      centerTitle: true,
      title: Text(
        title, // No need for ! now
        style: GoogleFonts.roboto(
            textStyle: const TextStyle(
                fontSize: 22,
                color: white,
                fontWeight: FontWeight.w700)),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
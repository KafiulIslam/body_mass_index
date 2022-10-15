import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constant/color.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  const CustomAppBar({
    Key? key,
    this.title,
  }) : super(key: key);

  final String? title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: appBarColor,
      centerTitle: true,
      title: Text(
        title!,
        style: GoogleFonts.roboto(
            textStyle: const TextStyle(
                fontSize: 35,
                color: white,
                fontWeight: FontWeight.w700)),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
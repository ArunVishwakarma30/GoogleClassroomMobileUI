import 'dart:ui';

import 'package:flutter/src/painting/text_style.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle customStyle(double size, Color col, FontWeight fw){
  return GoogleFonts.poppins(color: col, fontWeight: fw, fontSize: size);
}

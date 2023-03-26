import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

myStyle(double size,[Color? clr,FontWeight? fw]){
  return GoogleFonts.nunito(
      fontSize: size,
      color:clr ??Colors.black, //default black
      fontWeight: fw
  );
}

myTextStyle([double? size,FontWeight? fw, Color? clr,]){
  return TextStyle(
      // fontFamily: 'myCustomFont',
    fontSize: size??16.0,
    color: clr??Colors.white,
    fontWeight:fw?? FontWeight.w200
  );
}

formTextStyle(){
  return GoogleFonts.nunito(
      fontSize: 16,
      color:Color(0xff8A8A8E), //default black
      fontWeight: FontWeight.w400
  );
}

const Color textClrLight = Color(0xffE4E4E6);
const Color textClrThin = Color(0xffE9E9EB);
const Color bgClr = Color(0xff191A22);
const Color btnClr = Color(0xff246BFD);
const Color cardClr = Color(0xff292B3E);
const Color selectedItemClr = Color(0xffF8F8F8);
const Color unselectedItemClr = Color(0xff8A8A8E);
const Color circleAbtrBgColor = Color(0xff8E8E93);
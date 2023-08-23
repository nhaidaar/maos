import 'package:flutter/material.dart';

const Color greyColor = Color(0xff292D32);
const Color greyWhiteColor = Color(0xffD9D9D9);
const Color whiteColor = Color(0xffF5F5F5);
const Color blackColor = Color(0xff121212);
const Color whiteBackground = Color(0xffFFFFFF);
Color greyBlur60 = Colors.black.withOpacity(0.6);
Color greyBlur40 = Colors.black.withOpacity(0.4);
Color greyBlur25 = Colors.black.withOpacity(0.25);
Color greyBlur20 = Colors.black.withOpacity(0.2);
Color greyBlur10 = Colors.black.withOpacity(0.1);

TextStyle semiboldTS = const TextStyle(
    fontFamily: 'PlusJakartaSans', fontSize: 12, fontWeight: FontWeight.w600);

TextStyle mediumTS = const TextStyle(
    fontFamily: 'PlusJakartaSans', fontSize: 12, fontWeight: FontWeight.w500);

TextStyle regularTS = const TextStyle(
    fontFamily: 'PlusJakartaSans', fontSize: 12, fontWeight: FontWeight.w400);

TextStyle actionButton = const TextStyle(
    fontFamily: 'Montserrat', fontSize: 12, fontWeight: FontWeight.w500);

InputBorder defaultInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(10),
  borderSide: BorderSide(color: greyBlur10),
);

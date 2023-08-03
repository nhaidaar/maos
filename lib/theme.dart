import 'package:flutter/material.dart';

const Color greyColor = Color(0xff292D32);
const Color greyWhiteColor = Color(0xffD9D9D9);
const Color whiteColor = Color(0xffF5F5F5);
const Color blackColor = Color(0xff121212);
const Color whiteBackground = Color(0xffFFFFFF);
Color greyBlur60 = Colors.black.withOpacity(0.6);
Color greyBlur40 = Colors.black.withOpacity(0.4);
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

List<String> apikey = [
  'pub_2641270ecc76cc552d8816cced3dcf5f18da3',
  'pub_2648234c3f04a67afab9de7957db71d02e30d',
  'pub_26483986242a95351a9e59eeb67d73c3352cd',
  'pub_2658746deb6669ee59c33a66e5cdbd0d8f91a',
];

// String newsDomain = 'liputan6,sindonews,bola,harianjogja,jpnn';

List<String> newsCategory = [
  'top',
  'sports',
  'technology',
  'business',
  'entertainment',
  'science',
  'health',
  'world',
  'politics'
];

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// These constants are used for initializing Firebase
const kApiKey = "AIzaSyAipwchueYRMQhdswHq-HvbnQOXWIf5DN8";
const kAuthDomain = "fir-flutter-479eb.firebaseapp.com";
const kProjectId = "fir-flutter-479eb";
const kStorageBucket = "fir-flutter-479eb.appspot.com";
const kMessagingSenderId = "985079857939";
const kAppId = "1:985079857939:web:e3106b184d8d5affc450e6";

// These constants are used for sending email. It is used to send a post request
const kPostUrl = 'https://api.emailjs.com/api/v1.0/email/send';
const kContentType = 'application/json';
const kServiceId = 'service_lce03ol';
const kTemplateId = 'template_p3x59sr';
const kUserId = 'dVUn9I_CeROfYzKXa';

// These variable are for styling the text
const kColorDarkBlue = Color.fromARGB(255, 56, 91, 133);
const kColorPearlWhite = Color.fromARGB(255, 219, 217, 217);
var kLoginTextTitle1 = GoogleFonts.rubik(
    fontSize: 35, color: kColorDarkBlue, fontWeight: FontWeight.bold);
var kLoginTextTitle2 = GoogleFonts.rubik(
    fontSize: 30, color: Colors.black, fontWeight: FontWeight.bold);
var kLoginTextSubTitle = GoogleFonts.rubik(fontSize: 15, color: Colors.black);
var kTextTitle = GoogleFonts.rubik(
    fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold);
var kTextSubTitle = GoogleFonts.rubik(fontSize: 20, color: Colors.black);
var kLeadDetailsTextH1 =
    GoogleFonts.rubik(fontSize: 25, fontWeight: FontWeight.bold);
var kLeadDetailsTextH2 = GoogleFonts.rubik(
    fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold);
var kLeadDetailsTextH3 = GoogleFonts.rubik(fontSize: 15, color: Colors.black);
var kLeadDetailsTextH4 = GoogleFonts.rubik(
  fontSize: 15,
  color: kColorDarkBlue,
);
var kLeadDetailsTextH5 = GoogleFonts.rubik(fontSize: 11, color: Colors.black);
var kLeadDetailsTextH6 = GoogleFonts.rubik(
  fontSize: 11,
  color: kColorDarkBlue,
);
var kEditLeadTextH1 = GoogleFonts.rubik(fontSize: 25, color: Colors.black);
var kEditLeadTextH2 = GoogleFonts.rubik(fontSize: 18, color: Colors.black);
var kPanelTextH1 = GoogleFonts.rubik(fontSize: 30, color: Colors.black);
var kNavigationText = GoogleFonts.rubik(fontSize: 18, color: kColorDarkBlue);
var kUserText = GoogleFonts.rubik(fontSize: 14, color: kColorDarkBlue);
var kStepperTextH1 = GoogleFonts.rubik(fontSize: 20);

var kButtonText1 = GoogleFonts.rubik(fontSize: 15, color: kColorDarkBlue);
var kButtonText2 = GoogleFonts.rubik(fontSize: 20, color: kColorDarkBlue);
var kButtonText3 = GoogleFonts.rubik(fontSize: 20, color: Colors.white);
var kButtonText4 = GoogleFonts.rubik(fontSize: 12, color: kColorDarkBlue);

double kDefaultButtonSize = 80;
double kSmallerButtonSize = 65;

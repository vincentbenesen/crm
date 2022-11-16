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

// These constants are for the data members of Log class and Record class
const kUserIdLog = 'userId';
const kDateLog = 'date';
const kTypeOfDataLog = 'typeOfData';
const kDataLog = 'data';
const kDocIdLog = 'docId';
const kFieldIdRecord = 'fieldId';
const kTypeRecord = 'type';

// These constants variables are used for TextFormFields labels and methods parameters
const kFirstName = 'firstName';
const kLastName = 'lastName';
const kAddress1 = 'address1';
const kAddress2 = 'address2';
const kCity = 'city';
const kProvince = 'province';
const kPostal = 'postal';
const kPhoneNumber = 'phoneNumber';
const kMobileNumber = 'mobileNumber';
const kEmail = 'email';
const kFullNameTitle = 'Full Name';
const kAddressTitle = 'Address';
const kContactInfoTitle = 'Contact Information';
const kFirstNameLabelText = 'First Name *';
const kLastNameLabelText = 'Last Name *';
const kAddress1LabelText = 'Street Address *';
const kAddress2LabelText = 'Street Address Line 2';
const kCityLabelText = 'City *';
const kProvinceLabelText = 'Province *';
const kPostalLabelText = 'Postal/Zip Code *';
const kPhoneLabelText = 'Phone *';
const kEmailLabelText = 'Email *';
const kMobileLabelText = 'Mobile *';

const kFirstNameHintText = 'Vincent';
const kLastNameHintText = 'Benesen';
const kAddressHintText = '1130 rue Sherbrooke Ouest, Suite 700';
const kCityHintText = 'Montreal';
const kProvinceHintText = 'Quebec';
const kPostalHintText = 'H3A 2M8';
const kPhoneNumberHintText = '123456789';
const kEmailHintText = '123@yahoo.com';

const kEstimateDate = 'estimateDate';
const kFinishDate = 'finishDate';
const kTitle = 'title';

// These constants are used to navigate through the page
const kToLead = '/Leads';
const kToSearchedLeads = '/SearchedLeads';
const kToFilteredLeads = '/FilteredLeads';
const kToPanel = '/Panel';
const kToLeadDetails = '/LeadDetails';
const kToLogin = "/Login";
const kToSignUp = '/SignUp';

// Regex
const kPhoneRegex =
    r"^\s*(?:\+?(\d{1,3}))?[-. (]*(\d{3})[-. )]*(\d{3})[-. ]*(\d{4})(?: *x(\d+))?\s*$";

// These variable are for styling the text
const kColorDarkBlue = Color.fromARGB(255, 56, 91, 133);
const kColorLighterBlue = Color.fromARGB(255, 79, 127, 185);
const kColorDarkerBlue = Color.fromARGB(255, 47, 77, 112);
const kColorPearlWhite = Color.fromARGB(255, 219, 217, 217);
const kColorStar = Colors.amber;
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
var kLeadDetailsActivitiesTitle = GoogleFonts.rubik(
    fontSize: 15, color: kColorDarkBlue, fontWeight: FontWeight.bold);

var kEditLeadTextH1 = GoogleFonts.rubik(fontSize: 25, color: Colors.black);
var kEditLeadTextH2 = GoogleFonts.rubik(fontSize: 18, color: Colors.black);
var kEditLeadLabelStyle1 = const TextStyle(
    color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25);
var kEditLeadLabelStyle2 = const TextStyle(color: Colors.black, fontSize: 15);
var kPanelTextH1 = GoogleFonts.rubik(fontSize: 30, color: Colors.black);
var kNavigationText = GoogleFonts.rubik(fontSize: 18, color: kColorDarkBlue);
var kUserText = GoogleFonts.rubik(fontSize: 14, color: kColorDarkBlue);
var kStepperTextH1 = GoogleFonts.rubik(fontSize: 20);
var kLeadFilterTitle = GoogleFonts.rubik(
    fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white);
var KLeadFilterChoices = GoogleFonts.rubik(fontSize: 15, color: Colors.black);
var kLeadFilterCityChoices =
    GoogleFonts.rubik(fontSize: 15, color: Colors.black);

var kButtonText1 = GoogleFonts.rubik(fontSize: 15, color: kColorDarkBlue);
var kButtonText2 = GoogleFonts.rubik(fontSize: 20, color: kColorDarkBlue);
var kButtonText3 = GoogleFonts.rubik(fontSize: 20, color: Colors.white);
var kButtonText4 = GoogleFonts.rubik(fontSize: 12, color: kColorDarkBlue);

var kProgressText = GoogleFonts.rubik(color: Colors.white);
// Sizes of the the buttons
double kDefaultButtonSize = 80;
double kSmallerButtonSize = 65;

const int kIndex0 = 0;
const int kIndex1 = 1;
const int kIndex2 = 2;
const int kIndex3 = 3;
const int kIndex4 = 4;

// These indexes are used for anaylytic page
const int kRecordIndex = 0;
const int kLogIndex = 1;

var kStateList = [
  'AL',
  'AK',
  'AZ',
  'AR',
  'CA',
  'CO',
  'CT',
  'DE',
  'DC',
  'FL',
  'GA',
  'HI',
  'ID',
  'IL',
  'IN',
  'IA',
  'KS',
  'KY',
  'LA',
  'ME',
  'MD',
  'MA',
  'MI',
  'MN',
  'MS',
  'MO',
  'MT',
  'NE',
  'NV',
  'NH',
  'NJ',
  'NM',
  'NY',
  'NC',
  'ND',
  'OH',
  'OK',
  'OR',
  'PA',
  'RI',
  'SC',
  'SD',
  'TN',
  'TX',
  'UT',
  'VT',
  'VA',
  'WA',
  'WV',
  'WI',
  'WY'
];

List<String> kTypeOfCondoUnitList = [
  'Semi w/2 car on great lot.',
  'Semi',
  '2 bed condos',
  'Noted all',
  'TH',
  'Condo',
  'Senior condos',
  'TD',
  'optional loft',
  'Semi w/1 car',
  'rental',
  'Ret Suite',
  'Retirement home suite',
  'Double garage',
  'Detached bungalow',
  'Bungalow',
  'Detached',
  'Underground parking',
  '1.5 storey TH',
  '1.5 storey TH w/garage',
  'Semi 2 bath 2 bed',
  'Detached bungalow w/garage'
];

List<double> kRatingsList = [5, 4, 3, 2, 1, 0];

List<String> kProgressList = [
  "Choosing a unit",
  "Chose a unit",
  "Money",
  "Have cash",
  "Mortgage",
  "Preapproved",
  "Waiting for approval",
  "Signed",
  "Provide keys"
];

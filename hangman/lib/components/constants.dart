import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
// var kSuccessAlertStyle = AlertStyle(
//   animationType: AnimationType.grow,
//   isCloseButton: false,
//   isOverlayTapDismiss: false,
//   animationDuration: Duration(milliseconds: 500),
//   backgroundColor: Color(0xFF2C1E68),
//   alertBorder: RoundedRectangleBorder(
//     borderRadius: BorderRadius.circular(10.0),
//   ),
//   titleStyle: TextStyle(
//     color: Color(0xFF00e676),
//     fontWeight: FontWeight.bold,
//     fontSize: 30.0,
//     letterSpacing: 1.5,
//     fontFamily: 'PatrickHand'
//   ),
// );
// var kGameOverAlertStyle = AlertStyle(
//   animationType: AnimationType.grow,
//   isCloseButton: false,
//   isOverlayTapDismiss: false,
//   animationDuration: Duration(milliseconds: 450),
//   backgroundColor: Color(0xFF2C1E68),
//   alertBorder: RoundedRectangleBorder(
//     borderRadius: BorderRadius.circular(10.0),
//   ),
//   titleStyle: TextStyle(
//     color: Colors.red,
//     fontWeight: FontWeight.bold,
//     fontSize: 30.0,
//     letterSpacing: 1.5,
//       fontFamily: 'PatrickHand'
//   ),
//   descStyle: TextStyle(
//     color: Colors.lightBlue,
//     fontWeight: FontWeight.bold,
//     fontSize: 25.0,
//     letterSpacing: 1.5,
//       fontFamily: 'PatrickHand'
//   ),
//   descTextAlign: TextAlign.center,
// );

var kHomeScreenTitle= const Text(
  'HANGMAN',
  style: TextStyle(
      color: Colors.white,
      fontFamily: 'PatrickHand',
      fontSize: 58.0,
      fontWeight: FontWeight.w300,
      letterSpacing: 3.0),
);
var kHomeScreenButtons =ElevatedButton.styleFrom(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    minimumSize: const Size(155, 54),
    primary: const Color(0xff1189fe),
    textStyle: const TextStyle(fontFamily: 'PatrickHand',fontSize: 28.0));
var kSuccessAlertStyle=AlertStyle(
  isOverlayTapDismiss: false,
  animationType: AnimationType.grow,
  animationDuration: const Duration(milliseconds: 600),
  backgroundColor: const Color(0xFF2C1E68),
  isCloseButton: false,
  alertBorder: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10.0),
  ),
  titleStyle: const TextStyle(color: Colors.grey,
      // fontWeight: FontWeight.bold,
      fontSize: 25.0,
      // letterSpacing: 1.5,
      fontFamily: 'PatrickHand'

  ),
  descStyle: const TextStyle(color: Colors.green,
      fontWeight: FontWeight.bold,
      fontSize: 43.0,
      letterSpacing: 1.5,
      fontFamily: 'PatrickHand'
  ),
);
var kErrorAlertStyle=AlertStyle(
  isOverlayTapDismiss: false,
  animationType: AnimationType.grow,
  animationDuration: const Duration(milliseconds: 600),
  backgroundColor: const Color(0xFF2C1E68),
  isCloseButton: false,
  alertBorder: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10.0),
  ),
  titleStyle: const TextStyle(color: Colors.grey,
      // fontWeight: FontWeight.bold,
      fontSize: 25.0,
      // letterSpacing: 1.5,
      fontFamily: 'PatrickHand'

  ),
  descStyle: const TextStyle(color: Colors.red,
      fontWeight: FontWeight.bold,
      fontSize: 43.0,
      letterSpacing: 1.5,
      fontFamily: 'PatrickHand'
  ),
);

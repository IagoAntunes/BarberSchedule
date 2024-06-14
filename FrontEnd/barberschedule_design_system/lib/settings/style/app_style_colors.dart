import 'package:barberschedule_design_system/settings/utils/hex_to_color.dart';
import 'package:flutter/material.dart';

abstract class AppStyleColors {
  //Transparent
  static const transparent = Colors.transparent;

  //Default
  static const black = Colors.black;
  static const white = Colors.white;
  static const green = Colors.green;
  static const red = Colors.red;

  //Product
  static final yellowLight = HexToColor.toColor('#DBC170');
  static final yellow = HexToColor.toColor('#B8952E');
  static final yellowDark = HexToColor.toColor('#846F2E');
  static final error = HexToColor.toColor('#B22222'); // Vermelho
  //Base
  static final gray100 = HexToColor.toColor('#F5F4F5');
  static final gray200 = HexToColor.toColor('#B2AFB6');
  static final gray300 = HexToColor.toColor('#98959D');
  static final gray400 = HexToColor.toColor('#7A767F');
  static final gray500 = HexToColor.toColor('#3E3C41');
  static final gray600 = HexToColor.toColor('#2E2C30');
  static final gray700 = HexToColor.toColor('#232225');
  static final gray800 = HexToColor.toColor('#19181B');
  static final gray900 = HexToColor.toColor('#050505');

  static final backgroundColor = HexToColor.toColor('#232225');
  static final primaryDefault = HexToColor.toColor('#DBC170');
  static final secondaryDefault = HexToColor.toColor('#B8952E');
}

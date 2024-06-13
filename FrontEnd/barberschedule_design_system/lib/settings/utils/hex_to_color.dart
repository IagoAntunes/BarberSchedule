import 'dart:ui';

abstract class HexToColor {
  static Color toColor(String code) {
    code = code.replaceAll('#', '');
    return Color(int.parse(code, radix: 16) + 0xFF000000);
  }
}

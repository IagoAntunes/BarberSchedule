import 'package:barberschedule_design_system/settings/style/app_style_colors.dart';
import 'package:barberschedule_design_system/settings/style/app_text_style.dart';
import 'package:flutter/material.dart';

enum CButtonType {
  primary,
  hover,
  disabled,
}

class CButton extends StatelessWidget {
  const CButton({
    super.key,
    this.cButtonType = CButtonType.primary,
    required this.text,
    required this.onPressed,
    this.height,
    this.width,
  });
  final CButtonType cButtonType;
  final String text;
  final Function() onPressed;

  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: height,
      minWidth: width,
      color: _colorButtonByCButtonType(),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: _borderSideByCButtonType(),
      ),
      onPressed: () {
        if (cButtonType == CButtonType.disabled) return;
        onPressed();
      },
      child: Text(
        text,
        style: AppTextStyle.titleSm,
      ),
    );
  }

  Color? _colorButtonByCButtonType() {
    switch (cButtonType) {
      case CButtonType.disabled:
        return AppStyleColors.yellow.withOpacity(0.3);
      default:
        return AppStyleColors.yellow;
    }
  }

  BorderSide _borderSideByCButtonType() {
    switch (cButtonType) {
      case CButtonType.primary:
        return BorderSide.none;
      case CButtonType.hover:
        return BorderSide(
          color: AppStyleColors.yellowLight,
          width: 2.0,
        );
      case CButtonType.disabled:
        return BorderSide.none;
      default:
        return BorderSide.none;
    }
  }
}

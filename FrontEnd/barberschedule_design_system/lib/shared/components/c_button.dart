import 'package:barberschedule_design_system/settings/style/app_style_colors.dart';
import 'package:barberschedule_design_system/settings/style/app_text_style.dart';
import 'package:flutter/material.dart';

enum CButtonType {
  primary,
  hover,
  disabled,
}

enum CButtonState {
  idle,
  disabled,
  loading,
}

class CButton extends StatefulWidget {
  const CButton({
    super.key,
    this.cButtonState,
    this.height,
    this.width,
    required this.text,
    required this.onPressed,
  });
  final ValueNotifier<CButtonState>? cButtonState;
  final String text;
  final Function() onPressed;

  final double? height;
  final double? width;

  @override
  State<CButton> createState() => _CButtonState();
}

class _CButtonState extends State<CButton> {
  CButtonType cButtonType = CButtonType.primary;
  late CButtonState cButtonState;

  void _updateCButtonState() {
    setState(() {
      cButtonState = widget.cButtonState?.value ?? CButtonState.idle;
    });
    if (widget.cButtonState!.value == CButtonState.disabled) {
      cButtonType = CButtonType.disabled;
    } else {
      cButtonType = CButtonType.primary;
    }
  }

  @override
  void initState() {
    super.initState();
    cButtonState = widget.cButtonState?.value ?? CButtonState.idle;
    widget.cButtonState?.addListener(_updateCButtonState);
    if (widget.cButtonState!.value == CButtonState.disabled) {
      cButtonType = CButtonType.disabled;
    } else {
      cButtonType = CButtonType.primary;
    }
  }

  @override
  void dispose() {
    widget.cButtonState?.removeListener(_updateCButtonState);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: widget.cButtonState!,
      builder: (context, value, child) {
        return MaterialButton(
          height: widget.height,
          minWidth: widget.width,
          color: _colorButtonByCButtonType(),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: _borderSideByCButtonType(),
          ),
          onPressed: () {
            if (widget.cButtonState!.value == CButtonState.disabled ||
                widget.cButtonState!.value == CButtonState.loading) return;
            widget.onPressed();
          },
          child: widget.cButtonState!.value == CButtonState.loading
              ? const CircularProgressIndicator()
              : Text(
                  widget.text,
                  style: AppTextStyle.titleSm,
                ),
        );
      },
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

import 'package:barberschedule_design_system/settings/style/app_style_colors.dart';
import 'package:barberschedule_design_system/settings/style/app_text_style.dart';
import 'package:flutter/material.dart';

enum CFormFieldState {
  emptyDefault,
  emptyActive,
  filledDefault,
  filledActive,
}

class CFormField extends StatefulWidget {
  const CFormField({
    super.key,
    this.hintText,
    this.onChanged,
  });
  final String? hintText;
  final void Function(String)? onChanged;
  @override
  State<CFormField> createState() => _CFormFieldState();
}

class _CFormFieldState extends State<CFormField> {
  FocusNode focusNode = FocusNode();
  CFormFieldState cFormFieldState = CFormFieldState.emptyDefault;
  final controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    focusNode.addListener(() {
      if (focusNode.hasFocus && controller.text.isEmpty) {
        cFormFieldState = CFormFieldState.emptyActive;
      } else if (focusNode.hasFocus && controller.text.isNotEmpty) {
        cFormFieldState = CFormFieldState.filledActive;
      } else if (!focusNode.hasFocus && controller.text.isEmpty) {
        cFormFieldState = CFormFieldState.emptyDefault;
      } else if (!focusNode.hasFocus && controller.text.isNotEmpty) {
        cFormFieldState = CFormFieldState.filledDefault;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: widget.onChanged,
      focusNode: focusNode,
      style: hintStyleByType(),
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: hintStyleByType(),
        prefixIcon: const Icon(Icons.account_box_outlined),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: AppStyleColors.yellowDark,
            width: 1.0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: AppStyleColors.gray500,
            width: 1.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: AppStyleColors.yellowDark,
            width: 1.0,
          ),
        ),
      ),
    );
  }

  TextStyle? hintStyleByType() {
    switch (cFormFieldState) {
      case CFormFieldState.emptyDefault:
        return AppTextStyle.textMd.copyWith(
          color: AppStyleColors.gray400,
        );
      case CFormFieldState.emptyActive:
        return AppTextStyle.textMd.copyWith(
          color: AppStyleColors.gray400,
        );
      case CFormFieldState.filledDefault:
        return AppTextStyle.textMd.copyWith(
          color: AppStyleColors.gray200,
        );
      case CFormFieldState.filledActive:
        return AppTextStyle.textMd.copyWith(
          color: AppStyleColors.gray200,
        );
      default:
        return AppTextStyle.textMd.copyWith(
          color: AppStyleColors.gray200,
        );
    }
  }
}

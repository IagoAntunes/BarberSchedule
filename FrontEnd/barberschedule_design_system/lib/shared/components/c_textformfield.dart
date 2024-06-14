import 'package:barberschedule_design_system/settings/style/app_style_colors.dart';
import 'package:barberschedule_design_system/settings/style/app_text_style.dart';
import 'package:flutter/material.dart';

enum CFormFieldState {
  emptyDefault,
  emptyActive,
  filledDefault,
  filledActive,
  error,
}

enum CFormFieldType {
  text,
  password,
}

class CFormField extends StatefulWidget {
  const CFormField({
    super.key,
    this.hintText,
    this.onChanged,
    this.prefixIcon,
    this.cFormFieldType = CFormFieldType.text,
    this.textInputType,
    this.validator,
  });
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final String? hintText;
  final IconData? prefixIcon;
  final CFormFieldType cFormFieldType;
  final TextInputType? textInputType;
  @override
  State<CFormField> createState() => _CFormFieldState();
}

class _CFormFieldState extends State<CFormField> {
  FocusNode focusNode = FocusNode();
  CFormFieldState cFormFieldState = CFormFieldState.emptyDefault;
  final controller = TextEditingController();

  late ValueNotifier obscureText;

  @override
  void initState() {
    super.initState();
    if (widget.cFormFieldType == CFormFieldType.password) {
      obscureText = ValueNotifier<bool>(true);
    } else {
      obscureText = ValueNotifier<bool>(false);
    }

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
      obscureText: obscureText.value,
      style: hintStyleByType(),
      keyboardType: _getKeyboardByType(),
      validator: (value) {
        String? result;
        if (widget.validator != null) {
          result = widget.validator!(value);
        }
        if (result != null) {
          setState(() {
            cFormFieldState = CFormFieldState.error;
          });
        } else {
          setState(() {
            cFormFieldState = CFormFieldState.filledDefault;
          });
        }
        return result;
      },
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: hintStyleByType(),
        prefixIcon: Icon(
          widget.prefixIcon,
          color: cFormFieldState == CFormFieldState.error
              ? Theme.of(context).colorScheme.error
              : null,
        ),
        suffixIcon: widget.cFormFieldType == CFormFieldType.password
            ? IconButton(
                onPressed: () {
                  setState(() {
                    obscureText.value = !obscureText.value;
                  });
                },
                icon: Icon(
                  obscureText.value ? Icons.visibility : Icons.visibility_off,
                  color: AppStyleColors.gray300,
                ),
              )
            : null,
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

  TextInputType? _getKeyboardByType() {
    switch (widget.cFormFieldType) {
      case CFormFieldType.password:
        return TextInputType.visiblePassword;
      default:
        return null;
    }
  }
}

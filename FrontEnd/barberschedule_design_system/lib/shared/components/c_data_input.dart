import 'package:barberschedule_design_system/settings/style/app_style_colors.dart';
import 'package:barberschedule_design_system/settings/style/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum CCDataInputState {
  primary,
  active,
}

class CDataInput extends StatefulWidget {
  const CDataInput({
    super.key,
    this.hintText,
    required this.controller,
    this.preffixIcon,
    required this.changedTime,
  });
  final String? hintText;
  final TextEditingController controller;
  final Widget? preffixIcon;
  final Function() changedTime;
  @override
  State<CDataInput> createState() => _CDataInputState();
}

class _CDataInputState extends State<CDataInput> {
  CCDataInputState cFormFieldState = CCDataInputState.primary;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      style: hintStyleByType(),
      readOnly: true,
      onEditingComplete: () {},
      onTap: () async {
        setState(() {
          cFormFieldState = CCDataInputState.active;
        });
        await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime.now(),
          lastDate:
              DateTime.now().add(const Duration(seconds: 999999999999999999)),
        ).then((value) {
          setState(() {
            cFormFieldState = CCDataInputState.primary;
            if (value != null) {
              widget.controller.text = DateFormat("dd/MM/yyyy").format(value);
              widget.changedTime.call();
            }
          });
        });
      },
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: hintStyleByType(),
        prefixIcon: widget.preffixIcon,
        suffixIcon: Icon(
          cFormFieldState == CCDataInputState.primary
              ? Icons.keyboard_arrow_down
              : Icons.keyboard_arrow_up,
          color: AppStyleColors.gray300,
        ),
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
      default:
        return AppTextStyle.textMd.copyWith(
          color: AppStyleColors.gray200,
        );
    }
  }
}

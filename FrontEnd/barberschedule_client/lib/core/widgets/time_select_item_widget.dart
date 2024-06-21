import 'package:barberschedule_design_system/settings/style/app_style_colors.dart';
import 'package:barberschedule_design_system/settings/style/app_text_style.dart';
import 'package:flutter/material.dart';

enum TimeSelectItemState {
  primary,
  hover,
  selected,
  disabled,
}

class TimeSelectItem extends StatefulWidget {
  const TimeSelectItem({
    super.key,
    required this.text,
    required this.onTap,
    this.initialState = TimeSelectItemState.primary,
  });
  final void Function(ValueNotifier<TimeSelectItemState> newState)? onTap;
  final String text;
  final TimeSelectItemState initialState;
  @override
  State<TimeSelectItem> createState() => _TimeSelectItemState();
}

class _TimeSelectItemState extends State<TimeSelectItem> {
  late ValueNotifier<TimeSelectItemState> state;
  @override
  void initState() {
    super.initState();
    state = ValueNotifier(widget.initialState);
  }

  void updateValue() {
    if (widget.initialState == TimeSelectItemState.selected) {
      state.value = TimeSelectItemState.selected;
    } else {
      state.value = TimeSelectItemState.primary;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: state,
        builder: (context, _, child) {
          updateValue();
          return InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: () {
              widget.onTap!(state);
            },
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _backgroundColorByState(),
                borderRadius: BorderRadius.circular(8),
                border: _boxBorderByState(),
              ),
              child: Text(
                widget.text,
                style: _textStyleByState(),
              ),
            ),
          );
        });
  }

  BoxBorder _boxBorderByState() {
    switch (state.value) {
      case TimeSelectItemState.primary:
        return Border.all(
          color: AppStyleColors.gray500,
          width: 1.0,
        );
      case TimeSelectItemState.hover:
        return Border.all(
          color: AppStyleColors.gray500,
          width: 1.0,
        );
      case TimeSelectItemState.selected:
        return Border.all(
          color: AppStyleColors.yellow,
          width: 1.0,
        );
      case TimeSelectItemState.disabled:
        return Border.all(
          color: AppStyleColors.gray600,
          width: 1.0,
        );
    }
  }

  TextStyle _textStyleByState() {
    switch (state.value) {
      case TimeSelectItemState.primary:
        return AppTextStyle.textMd.copyWith(color: AppStyleColors.gray200);
      case TimeSelectItemState.hover:
        return AppTextStyle.textMd.copyWith(color: AppStyleColors.gray200);
      case TimeSelectItemState.selected:
        return AppTextStyle.textMd.copyWith(color: AppStyleColors.yellow);
      case TimeSelectItemState.disabled:
        return AppTextStyle.textMd.copyWith(color: AppStyleColors.gray500);
    }
  }

  Color _backgroundColorByState() {
    switch (state.value) {
      case TimeSelectItemState.primary:
        return AppStyleColors.gray600;
      case TimeSelectItemState.hover:
        return AppStyleColors.gray500;
      case TimeSelectItemState.selected:
        return AppStyleColors.gray600;
      case TimeSelectItemState.disabled:
        return AppStyleColors.transparent;
    }
  }
}

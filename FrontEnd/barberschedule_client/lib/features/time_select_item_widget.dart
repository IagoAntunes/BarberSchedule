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
    required this.onStateChanged,
  });
  final void Function(TimeSelectItemState) onStateChanged;
  final void Function()? onTap;
  final String text;
  final TimeSelectItemState initialState;

  @override
  State<TimeSelectItem> createState() => _TimeSelectItemState();
}

class _TimeSelectItemState extends State<TimeSelectItem> {
  late TimeSelectItemState state;

  @override
  void initState() {
    super.initState();
    state = widget.initialState;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: state == TimeSelectItemState.disabled
          ? null
          : () {
              if (state == TimeSelectItemState.selected) {
                setState(() {
                  state = TimeSelectItemState.primary;
                });
                widget.onStateChanged.call(state);
              } else if (state == TimeSelectItemState.primary) {
                setState(() {
                  state = TimeSelectItemState.selected;
                });
                widget.onStateChanged.call(state);
              }
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
  }

  BoxBorder _boxBorderByState() {
    switch (state) {
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
    switch (state) {
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
    switch (state) {
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

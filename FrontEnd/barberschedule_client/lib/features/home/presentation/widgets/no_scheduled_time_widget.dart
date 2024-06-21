import 'package:barberschedule_design_system/settings/style/app_style_colors.dart';
import 'package:barberschedule_design_system/settings/style/app_text_style.dart';
import 'package:barberschedule_design_system/shared/components/c_button.dart';
import 'package:flutter/material.dart';

class NoScheduledTime extends StatelessWidget {
  NoScheduledTime({
    super.key,
  });
  final btnLoginState = ValueNotifier(CButtonState.idle);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
          decoration: BoxDecoration(
            border: Border.all(
              color: AppStyleColors.gray500,
            ),
            borderRadius: BorderRadius.circular(8),
            color: AppStyleColors.gray600,
          ),
          width: double.infinity,
          child: Column(
            children: [
              Icon(
                Icons.cut,
                color: AppStyleColors.gray200,
              ),
              Text(
                "Nenhum horario marcado",
                style:
                    AppTextStyle.textSm.copyWith(color: AppStyleColors.gray200),
              ),
              Divider(
                color: AppStyleColors.gray200,
                thickness: 2.0,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

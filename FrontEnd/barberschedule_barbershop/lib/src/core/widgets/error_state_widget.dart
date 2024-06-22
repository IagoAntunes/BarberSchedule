import 'package:barberschedule_design_system/settings/style/app_style_colors.dart';
import 'package:barberschedule_design_system/settings/style/app_text_style.dart';
import 'package:flutter/material.dart';

class ErrorStateWidget extends StatelessWidget {
  const ErrorStateWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
      decoration: BoxDecoration(
        border: Border.all(
          color: AppStyleColors.gray500,
        ),
        borderRadius: BorderRadius.circular(8),
        color: AppStyleColors.gray600,
      ),
      width: double.infinity,
      child: Row(
        children: [
          Icon(
            Icons.error_outline,
            color: Theme.of(context).colorScheme.error,
          ),
          const SizedBox(width: 16),
          Text(
            "Ocorreu um problema",
            style: AppTextStyle.textSm.copyWith(color: AppStyleColors.gray200),
          ),
        ],
      ),
    );
  }
}

import 'package:barberschedule_client/features/home/domain/models/current_order_dto.dart';
import 'package:barberschedule_design_system/settings/style/app_style_colors.dart';
import 'package:barberschedule_design_system/settings/style/app_text_style.dart';
import 'package:flutter/material.dart';

class ScheduledTime extends StatelessWidget {
  const ScheduledTime({
    super.key,
    required this.order,
  });
  final CurrentOrderDto order;
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Column(
                      children: [
                        Icon(
                          Icons.cut,
                          color: AppStyleColors.gray200,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          order.nameBarberShop,
                          style: AppTextStyle.textSm
                              .copyWith(color: AppStyleColors.gray200),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Column(
                      children: [
                        Icon(
                          Icons.date_range,
                          color: AppStyleColors.gray200,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "${DateTime.parse(order.dateTime).day}/${DateTime.parse(order.dateTime).month.toString().padLeft(2, '0')}",
                          style: AppTextStyle.textSm
                              .copyWith(color: AppStyleColors.gray200),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Column(
                      children: [
                        Icon(
                          Icons.schedule,
                          color: AppStyleColors.gray200,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "${DateTime.parse(order.dateTime).hour}:${DateTime.parse(order.dateTime).minute}",
                          style: AppTextStyle.textSm
                              .copyWith(color: AppStyleColors.gray200),
                        ),
                      ],
                    ),
                  ),
                ],
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

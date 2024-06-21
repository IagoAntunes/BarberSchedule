import 'package:barberschedule_design_system/settings/style/app_style_colors.dart';
import 'package:barberschedule_design_system/settings/style/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../domain/models/order_model.dart';

class ItemMarkingHistory extends StatelessWidget {
  const ItemMarkingHistory({
    super.key,
    required this.order,
  });
  final OrderModel order;
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            order.barberShop?.name ?? 'Não Informado',
            style: AppTextStyle.textSm.copyWith(color: AppStyleColors.gray200),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "R\$ ${order.price}",
                style: AppTextStyle.textSm.copyWith(
                  color: AppStyleColors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  Icon(
                    Icons.date_range,
                    color: AppStyleColors.gray200,
                    size: 18,
                  ),
                  Text(
                    DateFormat('dd/MM/yyyy')
                        .format(DateTime.parse(order.dateTime)),
                    style: AppTextStyle.textSm.copyWith(
                      color: AppStyleColors.gray200,
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:barberschedule_client/core/widgets/error_state_widget.dart';
import 'package:barberschedule_client/features/barbershops/presentation/states/barbershops_state.dart';
import 'package:barberschedule_client/features/home/presentation/pages/scheduling_page.dart';
import 'package:barberschedule_design_system/settings/style/app_style_colors.dart';
import 'package:barberschedule_design_system/settings/style/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../barbershops/presentation/blocs/barbershops_cubit.dart';
import '../../domain/models/barbershop_model.dart';

class ListBarberShops extends StatelessWidget {
  ListBarberShops({
    super.key,
  });

  final barberShopsCubit = GetIt.I.get<BarberShopsCubit>();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Barbearias",
            style: AppTextStyle.textSm.copyWith(color: AppStyleColors.gray200),
          ),
          const SizedBox(height: 12),
          BlocBuilder(
            bloc: barberShopsCubit,
            builder: (context, state) {
              return switch (state) {
                LoadingBarberShopsState() => const Center(
                    child: CircularProgressIndicator(),
                  ),
                FailureBarberShopsState() => const ErrorStateWidget(),
                SuccessBarberShopsState state =>
                  SuccessListBarberShops(listBarberShops: state.list),
                _ => Container(),
              };
            },
          )
        ],
      ),
    );
  }
}

class SuccessListBarberShops extends StatelessWidget {
  const SuccessListBarberShops({
    super.key,
    required this.listBarberShops,
  });

  final List<BarberShopModel> listBarberShops;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        itemCount: listBarberShops.length,
        separatorBuilder: (context, index) => const SizedBox(height: 16),
        itemBuilder: (context, index) => InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SchedulingPage(
                  barberShop: listBarberShops[index],
                ),
              ),
            );
          },
          child: Container(
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
                Icon(
                  Icons.store,
                  color: AppStyleColors.gray200,
                ),
                Text(
                  listBarberShops[index].name,
                  style: AppTextStyle.textSm
                      .copyWith(color: AppStyleColors.gray200),
                ),
                Text(
                  listBarberShops[index].description,
                  style: AppTextStyle.textSm
                      .copyWith(color: AppStyleColors.gray400),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "R\$ ${listBarberShops[index].price}",
                      style: AppTextStyle.textSm.copyWith(
                        color: AppStyleColors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.phone,
                          color: AppStyleColors.gray200,
                          size: 18,
                        ),
                        Text(
                          listBarberShops[index].phoneNumber,
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
          ),
        ),
      ),
    );
  }
}

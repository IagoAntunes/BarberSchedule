import 'package:barberschedule_design_system/settings/style/app_style_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../cubits/bottom_nav_cubit.dart';

class CBottomNavigationBar extends StatelessWidget {
  CBottomNavigationBar({super.key});

  final cBottomNavCubit = GetIt.I.get<BottomNavCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: cBottomNavCubit,
      builder: (context, state) {
        return BottomNavigationBar(
          currentIndex: cBottomNavCubit.state.currentIndex,
          unselectedIconTheme: IconThemeData(
            color: AppStyleColors.gray200,
          ),
          unselectedLabelStyle: TextStyle(
            color: AppStyleColors.gray200,
          ),
          onTap: (value) {
            if (value == 0) {
              cBottomNavCubit.changeIndex(value);
            } else if (value == 1) {
              cBottomNavCubit.changeIndex(value);
            }
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today),
              label: 'Historico',
            ),
          ],
        );
      },
    );
  }
}

import 'package:barberschedule_client/core/cubits/bottom_nav_cubit.dart';
import 'package:barberschedule_client/core/widgets/c_bottom_navigation_bar_widget.dart';
import 'package:barberschedule_client/features/home/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../marking_history/presentation/pages/marking_history_page.dart';

class DecideRoutePage extends StatelessWidget {
  DecideRoutePage({super.key});

  final cubit = GetIt.I.get<BottomNavCubit>();

  final list = [
    const HomePage(),
    MarkingHistoryPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: cubit,
      builder: (context, state) {
        return Scaffold(
          body: list[cubit.state.currentIndex],
          bottomNavigationBar: CBottomNavigationBar(),
        );
      },
    );
  }
}

import 'package:barberschedule_client/features/home/presentation/blocs/marking_history_cubit.dart';
import 'package:barberschedule_client/features/home/presentation/blocs/scheduled_time_cubit.dart';
import 'package:barberschedule_client/features/home/presentation/states/home_states.dart';
import 'package:barberschedule_design_system/settings/style/app_style_colors.dart';
import 'package:barberschedule_design_system/settings/style/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../widgets/marking_history_widget.dart';
import '../widgets/no_scheduled_time_widget.dart';
import '../widgets/scheduled_time_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final markingHistoryCubit = GetIt.I.get<MarkingHistoryCubit>();

  final scheduledTimeCubit = GetIt.I.get<ScheduledTimeCubit>();

  @override
  void initState() {
    super.initState();
    markingHistoryCubit.getMarkingHistory();
    scheduledTimeCubit.getNextOrder();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Horario Marcado",
              style:
                  AppTextStyle.textSm.copyWith(color: AppStyleColors.gray200),
            ),
            const SizedBox(height: 12),
            BlocBuilder(
              bloc: scheduledTimeCubit,
              builder: (context, state) {
                return switch (scheduledTimeCubit.state) {
                  LoadingScheduledTimeState() => const Center(
                      child: CircularProgressIndicator(),
                    ),
                  SuccessScheduledTimeState successState =>
                    successState.order == null
                        ? NoScheduledTime()
                        : ScheduledTime(order: successState.order!),
                  _ => Container(),
                };
              },
            ),
            const SizedBox(height: 32),
            MarkingHistory(),
          ],
        ),
      ),
    );
  }
}

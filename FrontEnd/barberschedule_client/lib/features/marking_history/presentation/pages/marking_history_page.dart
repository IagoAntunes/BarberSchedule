import 'package:barberschedule_design_system/settings/style/app_style_colors.dart';
import 'package:barberschedule_design_system/settings/style/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../../core/widgets/error_state_widget.dart';
import '../../../home/presentation/states/marking_history_state.dart';
import '../../../home/presentation/widgets/item_marking_history_widget.dart';
import '../blocs/marking_history_cubit.dart';

class MarkingHistoryPage extends StatefulWidget {
  const MarkingHistoryPage({super.key});

  @override
  State<MarkingHistoryPage> createState() => _MarkingHistoryPageState();
}

class _MarkingHistoryPageState extends State<MarkingHistoryPage> {
  final markingHistoryCubit = GetIt.I.get<MarkingHistoryCubit>();

  @override
  void initState() {
    super.initState();
    markingHistoryCubit.getMarkingHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Historico"),
      ),
      body: BlocBuilder(
        bloc: markingHistoryCubit,
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Histórico de horarios",
                  style: AppTextStyle.textSm
                      .copyWith(color: AppStyleColors.gray200),
                  textAlign: TextAlign.start,
                ),
                const SizedBox(height: 12),
                switch (markingHistoryCubit.state) {
                  LoadingMarkingHistoryState() =>
                    const Center(child: CircularProgressIndicator()),
                  FailureMarkingHistoryState() => const ErrorStateWidget(),
                  (SuccessMarkingHistoryState successState) => successState
                          .markingHistory.isEmpty
                      ? Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 16,
                            horizontal: 32,
                          ),
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
                                "Nenhum historico de horarios marcados",
                                style: AppTextStyle.textSm
                                    .copyWith(color: AppStyleColors.gray200),
                              ),
                            ],
                          ),
                        )
                      : Expanded(
                          child: ListView.separated(
                            itemCount: successState.markingHistory.length,
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 16),
                            itemBuilder: (context, index) => ItemMarkingHistory(
                              order: successState.markingHistory[index],
                            ),
                          ),
                        ),
                  _ => Container(),
                }
              ],
            ),
          );
        },
      ),
    );
  }
}

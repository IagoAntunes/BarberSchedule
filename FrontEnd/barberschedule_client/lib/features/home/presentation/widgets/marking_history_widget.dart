import 'package:barberschedule_design_system/settings/style/app_style_colors.dart';
import 'package:barberschedule_design_system/settings/style/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../blocs/marking_history_cubit.dart';
import '../states/marking_history_state.dart';
import 'item_marking_history_widget.dart';

class MarkingHistory extends StatelessWidget {
  MarkingHistory({
    super.key,
  });
  final markingHistoryCubit = GetIt.I.get<MarkingHistoryCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: markingHistoryCubit,
      builder: (context, state) {
        return Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Histórico de horarios",
                style:
                    AppTextStyle.textSm.copyWith(color: AppStyleColors.gray200),
                textAlign: TextAlign.start,
              ),
              const SizedBox(height: 12),
              switch (markingHistoryCubit.state) {
                LoadingMarkingHistoryState() =>
                  const Center(child: CircularProgressIndicator()),
                FailureMarkingHistoryState() => const Text("oi"),
                (SuccessMarkingHistoryState successState) =>
                  successState.markingHistory.isEmpty
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
    );
  }
}

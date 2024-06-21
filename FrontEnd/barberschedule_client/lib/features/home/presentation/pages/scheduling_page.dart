import 'package:barberschedule_client/core/widgets/time_select_item_widget.dart';
import 'package:barberschedule_design_system/settings/style/app_style_colors.dart';
import 'package:barberschedule_design_system/settings/style/app_text_style.dart';
import 'package:barberschedule_design_system/shared/components/c_data_input.dart';
import 'package:flutter/material.dart';

class SchedulingPage extends StatelessWidget {
  SchedulingPage({super.key});

  final dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Agendamento"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Agende um atendimento",
              style: AppTextStyle.titleMd.copyWith(
                color: AppStyleColors.gray100,
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              "Selecione data, horário e informe o nome do cliente para criar o agendamento",
              style: AppTextStyle.textMd.copyWith(
                color: AppStyleColors.gray300,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              "Data",
              style: AppTextStyle.titleMd.copyWith(
                color: AppStyleColors.gray200,
              ),
            ),
            CDataInput(
              hintText: "Selecione a data",
              controller: dateController,
              preffixIcon: const Icon(Icons.date_range_outlined),
            ),
            const SizedBox(height: 24),
            Text(
              "Horários",
              style: AppTextStyle.titleMd.copyWith(
                color: AppStyleColors.gray200,
              ),
            ),
            Wrap(
              children: [
                for (var i = 0; i < 10; i++)
                  TimeSelectItem(
                    text: 'teste',
                    onTap: () {},
                    onStateChanged: (p0) {
                      //
                    },
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

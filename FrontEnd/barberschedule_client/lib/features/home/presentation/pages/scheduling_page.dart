import 'package:barberschedule_client/core/widgets/time_select_item_widget.dart';
import 'package:barberschedule_client/features/home/domain/models/barbershop_model.dart';
import 'package:barberschedule_client/features/home/presentation/blocs/scheduling_cubit.dart';
import 'package:barberschedule_design_system/settings/style/app_style_colors.dart';
import 'package:barberschedule_design_system/settings/style/app_text_style.dart';
import 'package:barberschedule_design_system/shared/components/c_button.dart';
import 'package:barberschedule_design_system/shared/components/c_data_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

import '../states/scheduling_state.dart';

class SchedulingPage extends StatefulWidget {
  const SchedulingPage({
    super.key,
    required this.barberShop,
  });

  final BarberShopModel barberShop;

  @override
  State<SchedulingPage> createState() => _SchedulingPageState();
}

class _SchedulingPageState extends State<SchedulingPage> {
  final dateController = TextEditingController();

  final cButtonState = ValueNotifier<CButtonState>(CButtonState.idle);

  final schedulingCubit = GetIt.I.get<SchedulingCubit>();

  String chosenTime = '';
  Map<String, bool> mapTimeType = {};
  @override
  void initState() {
    super.initState();
    var list = widget.barberShop.availableTimes.split(';').toList();
    for (var i = 0; i < list.length; i++) {
      mapTimeType[list[i]] = false;
      if (int.parse(list[i].split(':')[0]) < 12) {
        listMorning.add(list[i]);
      } else if (int.parse(list[i].split(':')[0]) > 12 &&
          int.parse(list[i].split(':')[0]) < 17) {
        listAfternoon.add(list[i]);
      } else {
        listNight.add(list[i]);
      }
    }
  }

  final List<String> listMorning = [];

  final List<String> listAfternoon = [];

  final List<String> listNight = [];
  DateTime? dateTime;

  int? selectedPaymentMethod;

  onTapTime(String time) {
    setState(() {
      chosenTime = time;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Agendamento"),
      ),
      body: BlocListener(
        bloc: schedulingCubit,
        listener: (context, state) {
          if (state is SuccessSchedulingListener) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Agendamento realizado com sucesso!")));
            Navigator.pop(context);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Erro ao realizar agendamento!")));
          }
        },
        child: Padding(
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
                changedTime: () {
                  dateTime =
                      DateFormat("dd/MM/yyyy").parse(dateController.text, true);
                },
              ),
              const SizedBox(height: 24),
              Text(
                "Horários",
                style: AppTextStyle.titleMd.copyWith(
                  color: AppStyleColors.gray200,
                ),
              ),
              if (listMorning.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Manhã",
                      style: AppTextStyle.textMd.copyWith(
                        color: AppStyleColors.gray400,
                      ),
                    ),
                    Wrap(
                      spacing: 8.0,
                      children: [
                        for (var i = 0; i < listMorning.length; i++)
                          TimeSelectItem(
                            text: listMorning[i],
                            initialState: chosenTime == listMorning[i]
                                ? TimeSelectItemState.selected
                                : TimeSelectItemState.primary,
                            onTap: (value) {
                              onTapTime(listMorning[i]);
                              if (chosenTime == listMorning[i]) {
                                value.value = TimeSelectItemState.selected;
                              }
                            },
                          ),
                      ],
                    ),
                  ],
                ),
              if (listAfternoon.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    Text(
                      "Tarde",
                      style: AppTextStyle.textMd.copyWith(
                        color: AppStyleColors.gray400,
                      ),
                    ),
                    Wrap(
                      spacing: 8.0,
                      children: [
                        for (var i = 0; i < listAfternoon.length; i++)
                          TimeSelectItem(
                            text: listAfternoon[i],
                            onTap: (value) {
                              onTapTime(listAfternoon[i]);
                            },
                          ),
                      ],
                    ),
                  ],
                ),
              if (listNight.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    Text(
                      "Noite",
                      style: AppTextStyle.textMd.copyWith(
                        color: AppStyleColors.gray400,
                      ),
                    ),
                    Wrap(
                      spacing: 8.0,
                      children: [
                        for (var i = 0; i < listNight.length; i++)
                          TimeSelectItem(
                            text: listNight[i],
                            onTap: (value) {},
                          ),
                      ],
                    ),
                  ],
                ),
              const SizedBox(height: 32),
              Text(
                "Metodo de Pagamento",
                style: AppTextStyle.titleMd.copyWith(
                  color: AppStyleColors.gray200,
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppStyleColors.gray500,
                  ),
                  borderRadius: BorderRadius.circular(8),
                  color: AppStyleColors.gray600,
                ),
                child: DropdownButton(
                  value: selectedPaymentMethod,
                  onChanged: (value) {
                    setState(() {
                      selectedPaymentMethod = value;
                    });
                  },
                  hint: Text(
                    "Selecione o método de pagamento",
                    style: AppTextStyle.textMd.copyWith(
                      color: AppStyleColors.gray300,
                    ),
                  ),
                  items: widget.barberShop.paymentMethods
                      .map(
                        (e) => DropdownMenuItem(
                          value: e.idPaymentMethod,
                          child: Text(
                            e.name,
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
              const Spacer(),
              CButton(
                height: 56,
                cButtonState: cButtonState,
                width: double.infinity,
                text: 'Confirmar',
                onPressed: () {
                  if (dateTime != null &&
                      chosenTime.isNotEmpty &&
                      selectedPaymentMethod != null) {
                    schedulingCubit.scheduler(
                      widget.barberShop.id,
                      widget.barberShop.price,
                      chosenTime,
                      dateTime!,
                      selectedPaymentMethod.toString(),
                    );
                  }
                },
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

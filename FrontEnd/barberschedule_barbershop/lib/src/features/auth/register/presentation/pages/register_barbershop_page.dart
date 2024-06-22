import 'dart:async';
import 'package:barberschedule_design_system/settings/style/app_style_colors.dart';
import 'package:barberschedule_design_system/settings/style/app_text_style.dart';
import 'package:barberschedule_design_system/shared/components/c_button.dart';
import 'package:barberschedule_design_system/shared/components/c_textformfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

import '../../../../../core/widgets/time_select_item_widget.dart';
import '../blocs/register_barbershop_cubit.dart';
import '../blocs/register_state.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final currentStep = ValueNotifier(0);

  final registerCubit = GetIt.I.get<RegisterCubit>();

  @override
  void initState() {
    super.initState();
    registerCubit.getPaymentMethods();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro'),
      ),
      body: BlocConsumer(
        bloc: registerCubit,
        listener: (context, state) {
          if (state is SuccessRegisterListener) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Registro efetuado com sucesso")),
            );
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: SizedBox(
              height: MediaQuery.sizeOf(context).height,
              child: ValueListenableBuilder(
                valueListenable: currentStep,
                builder: (context, value, child) {
                  return Stepper(
                    elevation: 0,
                    controlsBuilder: (context, details) {
                      return Container();
                    },
                    stepIconBuilder: (stepIndex, stepState) {
                      if (currentStep.value > stepIndex) {
                        return const Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 14,
                        );
                      }
                      return null;
                    },
                    currentStep: currentStep.value,
                    type: StepperType.horizontal,
                    steps: [
                      Step(
                        title: Container(),
                        content: PersonalInfoStep(
                          registerCubit: registerCubit,
                          onNext: () {
                            currentStep.value++;
                          },
                        ),
                      ),
                      Step(
                        title: Container(),
                        content: PhotoStep(
                          registerCubit: registerCubit,
                          onNext: () {
                            currentStep.value++;
                          },
                          onBack: () => currentStep.value--,
                        ),
                      ),
                      Step(
                        title: Container(),
                        content: SchedulesStep(
                          registerCubit: registerCubit,
                          onNext: () {
                            currentStep.value++;
                          },
                          onBack: () => currentStep.value--,
                        ),
                      ),
                      Step(
                        title: Container(),
                        content: PaymentMethodsStep(
                          registerCubit: registerCubit,
                          onNext: () {
                            currentStep.value++;
                          },
                          onBack: () => currentStep.value--,
                        ),
                      ),
                      Step(
                        title: Container(),
                        content: ConditionsStep(
                          registerCubit: registerCubit,
                          onBack: () {
                            currentStep.value--;
                          },
                          onNext: () async {
                            showDialog(
                              context: context,
                              builder: (context) => const AlertDialog(
                                title: Text("Carregando"),
                              ),
                            );
                            await registerCubit
                                .registerBarberShop()
                                .then((value) {
                              Navigator.pop(context);
                            });
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

class ConditionsStep extends StatefulWidget {
  const ConditionsStep({
    super.key,
    required this.onNext,
    required this.onBack,
    required this.registerCubit,
  });
  final RegisterCubit registerCubit;
  final void Function() onNext;
  final void Function() onBack;

  @override
  State<ConditionsStep> createState() => _ConditionsStepState();
}

class _ConditionsStepState extends State<ConditionsStep> {
  Timer? timer;
  final cButtonBackState = ValueNotifier(CButtonState.idle);
  final cButtonNextState = ValueNotifier(CButtonState.disabled);

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  startTimer() {
    timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (timer.tick == 3) {
        cButtonNextState.value = CButtonState.idle;
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Aceite dos termos e condições*",
          style: AppTextStyle.textMd.copyWith(
            color: Colors.white,
            fontSize: 24,
          ),
        ),
        const SizedBox(height: 24),
        Text(
          '''
          You are one step away from completing the registeration. to wrap this up, you can agree to our Terms & Conditions.
          We publish the Company name Terms & Conditions so that you know what to expect as you use our services.
          By checking the box below, you agree to these terms.
        ''',
          style: AppTextStyle.textSm.copyWith(
            color: AppStyleColors.gray300,
          ),
          textAlign: TextAlign.justify,
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            CButton(
              height: 48,
              text: 'Voltar',
              cButtonState: cButtonBackState,
              onPressed: () {
                widget.onBack();
              },
            ),
            const SizedBox(width: 8),
            Expanded(
              child: CButton(
                height: 48,
                text: 'Concluir',
                cButtonState: cButtonNextState,
                onPressed: () {
                  widget.onNext();
                },
              ),
            ),
          ],
        )
      ],
    );
  }
}

class PaymentMethodsStep extends StatefulWidget {
  const PaymentMethodsStep({
    super.key,
    required this.onNext,
    required this.onBack,
    required this.registerCubit,
  });
  final RegisterCubit registerCubit;

  final void Function() onNext;
  final void Function() onBack;

  @override
  State<PaymentMethodsStep> createState() => _PaymentMethodsStepState();
}

class _PaymentMethodsStepState extends State<PaymentMethodsStep> {
  final cButtonState = ValueNotifier(CButtonState.idle);

  List<int> chosenPaymentMethods = [];

  TextEditingController priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Financeiro*",
          style: AppTextStyle.textMd.copyWith(
            color: Colors.white,
            fontSize: 24,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 24),
        CFormField(
          controller: priceController,
          hintText: 'Preço',
          prefixIcon: Icons.price_change_outlined,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "*";
            }
            return null;
          },
        ),
        const SizedBox(height: 24),
        Text(
          "Metodos de Pagamento",
          style: AppTextStyle.titleMd.copyWith(
            color: AppStyleColors.gray200,
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.4,
          child: ListView.separated(
            itemCount: widget.registerCubit.listPaymentMethods.length,
            separatorBuilder: (context, index) => const SizedBox(height: 8),
            itemBuilder: (context, index) => InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: () {
                setState(() {
                  chosenPaymentMethods.contains(index)
                      ? chosenPaymentMethods.remove(index)
                      : chosenPaymentMethods.add(index);
                });
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: chosenPaymentMethods.contains(index)
                        ? AppStyleColors.primaryDefault
                        : AppStyleColors.gray500,
                  ),
                  borderRadius: BorderRadius.circular(8),
                  color: AppStyleColors.gray600,
                ),
                child: Text(
                  widget.registerCubit.listPaymentMethods[index].name,
                  style: AppTextStyle.textMd.copyWith(
                    color: AppStyleColors.gray200,
                  ),
                ),
              ),
            ),
          ),
        ),
        Row(
          children: [
            CButton(
              height: 48,
              text: 'Voltar',
              cButtonState: cButtonState,
              onPressed: () {
                widget.onBack();
              },
            ),
            const SizedBox(width: 8),
            Expanded(
              child: CButton(
                height: 48,
                text: 'Proximo',
                cButtonState: cButtonState,
                onPressed: () {
                  widget.registerCubit.barberShopModel.price =
                      priceController.text;
                  widget.registerCubit.barberShopModel.paymentMethods =
                      chosenPaymentMethods;
                  widget.onNext();
                },
              ),
            ),
          ],
        )
      ],
    );
  }
}

class SchedulesStep extends StatefulWidget {
  const SchedulesStep({
    super.key,
    required this.onNext,
    required this.onBack,
    required this.registerCubit,
  });
  final RegisterCubit registerCubit;

  final void Function() onNext;
  final void Function() onBack;

  @override
  State<SchedulesStep> createState() => _SchedulesStepState();
}

class _SchedulesStepState extends State<SchedulesStep> {
  final cButtonState = ValueNotifier(CButtonState.idle);

  List<String> listMorning = [];

  List<String> listAfternoon = [];

  List<String> listNight = [];

  final List<String> chosenTimes = [];

  @override
  void initState() {
    super.initState();
    listMorning = generateTimeSlots("07:00", "11:00", 1);
    listAfternoon = generateTimeSlots("12:00", "17:00", 1);
    listNight = generateTimeSlots("18:00", "23:00", 1);
  }

  List<String> generateTimeSlots(
      String startTime, String endTime, int intervalHours) {
    final List<String> timeSlots = [];
    final format = DateFormat("HH:mm");
    DateTime start = format.parse(startTime);
    final DateTime end = format.parse(endTime);

    while (start.isBefore(end)) {
      timeSlots.add(format.format(start));
      start = start.add(Duration(hours: intervalHours));
    }

    if (format.format(start) == endTime) {
      timeSlots.add(endTime);
    }

    return timeSlots;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Horarios de Atendimento*",
          style: AppTextStyle.textMd.copyWith(
            color: Colors.white,
            fontSize: 24,
          ),
          textAlign: TextAlign.center,
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
                      initialState: chosenTimes.contains(listMorning[i])
                          ? TimeSelectItemState.selected
                          : TimeSelectItemState.primary,
                      onTap: (value) {
                        if (chosenTimes.contains(listMorning[i])) {
                          setState(() {
                            chosenTimes.remove(listMorning[i]);
                          });
                        } else {
                          setState(() {
                            chosenTimes.add(listMorning[i]);
                          });
                        }
                        if (chosenTimes.contains(listMorning[i])) {
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
              const SizedBox(height: 13),
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
                      initialState: chosenTimes.contains(listAfternoon[i])
                          ? TimeSelectItemState.selected
                          : TimeSelectItemState.primary,
                      onTap: (value) {
                        if (chosenTimes.contains(listAfternoon[i])) {
                          setState(() {
                            chosenTimes.remove(listAfternoon[i]);
                          });
                        } else {
                          setState(() {
                            chosenTimes.add(listAfternoon[i]);
                          });
                        }
                        if (chosenTimes.contains(listAfternoon[i])) {
                          value.value = TimeSelectItemState.selected;
                        }
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
              const SizedBox(height: 13),
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
                      initialState: chosenTimes.contains(listNight[i])
                          ? TimeSelectItemState.selected
                          : TimeSelectItemState.primary,
                      onTap: (value) {
                        if (chosenTimes.contains(listNight[i])) {
                          setState(() {
                            chosenTimes.remove(listNight[i]);
                          });
                        } else {
                          setState(() {
                            chosenTimes.add(listNight[i]);
                          });
                        }
                        if (chosenTimes.contains(listNight[i])) {
                          value.value = TimeSelectItemState.selected;
                        }
                      },
                    ),
                ],
              ),
            ],
          ),
        Row(
          children: [
            CButton(
              height: 48,
              text: 'Voltar',
              cButtonState: cButtonState,
              onPressed: () {
                widget.onBack();
              },
            ),
            const SizedBox(width: 8),
            Expanded(
              child: CButton(
                height: 48,
                text: 'Proximo',
                cButtonState: cButtonState,
                onPressed: () {
                  widget.registerCubit.barberShopModel.avaibleTimes =
                      chosenTimes.join(';');
                  widget.onNext();
                },
              ),
            ),
          ],
        )
      ],
    );
  }
}

class PhotoStep extends StatefulWidget {
  const PhotoStep({
    super.key,
    required this.onNext,
    required this.onBack,
    required this.registerCubit,
  });
  final RegisterCubit registerCubit;

  final void Function() onNext;
  final void Function() onBack;

  @override
  State<PhotoStep> createState() => _PhotoStepState();
}

class _PhotoStepState extends State<PhotoStep> {
  final cButtonState = ValueNotifier(CButtonState.idle);

  final String photo = '';

  final stateController = TextEditingController();

  final cityController = TextEditingController();

  final numberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Informações Pessoais*",
          style: AppTextStyle.textMd.copyWith(
            color: Colors.white,
            fontSize: 24,
          ),
        ),
        const SizedBox(height: 24),
        CFormField(
          controller: stateController,
          hintText: 'Estado',
          prefixIcon: Icons.location_city_rounded,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "*";
            }
            return null;
          },
        ),
        const SizedBox(height: 12),
        CFormField(
          controller: cityController,
          hintText: 'Cidade',
          prefixIcon: Icons.location_city_outlined,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "*";
            }
            return null;
          },
        ),
        const SizedBox(height: 12),
        CFormField(
          controller: numberController,
          hintText: 'Numero',
          prefixIcon: Icons.numbers,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "*";
            }
            return null;
          },
        ),
        const SizedBox(height: 24),
        Text(
          "Foto(opcional)",
          style: AppTextStyle.textMd.copyWith(
            color: Colors.white,
            fontSize: 24,
          ),
        ),
        const SizedBox(height: 24),
        InkWell(
          onTap: () {
            //
          },
          borderRadius: BorderRadius.circular(8),
          child: Container(
            height: 48,
            decoration: BoxDecoration(
              color: AppStyleColors.gray600,
              border: Border.all(
                color: AppStyleColors.gray500,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.add_circle_outline,
                  color: AppStyleColors.gray200,
                ),
                const SizedBox(width: 8),
                Text(
                  "Escolha uma foto",
                  style: AppTextStyle.textSm.copyWith(
                    color: AppStyleColors.gray200,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            CButton(
              height: 48,
              text: 'Voltar',
              cButtonState: cButtonState,
              onPressed: () {
                widget.onBack();
              },
            ),
            const SizedBox(width: 8),
            Expanded(
              child: CButton(
                height: 48,
                text: 'Proximo',
                cButtonState: cButtonState,
                onPressed: () {
                  widget.registerCubit.barberShopModel.state =
                      stateController.text;
                  widget.registerCubit.barberShopModel.city =
                      cityController.text;
                  widget.registerCubit.barberShopModel.number =
                      numberController.text;
                  widget.registerCubit.barberShopModel.photo = photo;
                  widget.onNext();
                },
              ),
            ),
          ],
        )
      ],
    );
  }
}

class PersonalInfoStep extends StatefulWidget {
  const PersonalInfoStep({
    super.key,
    required this.onNext,
    required this.registerCubit,
  });
  final RegisterCubit registerCubit;
  final void Function() onNext;

  @override
  State<PersonalInfoStep> createState() => _PersonalInfoStepState();
}

class _PersonalInfoStepState extends State<PersonalInfoStep> {
  final cButtonState = ValueNotifier(CButtonState.disabled);

  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final descriptionController = TextEditingController();

  final emailController = TextEditingController();

  final phoneController = TextEditingController();

  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      onChanged: () {
        if (nameController.text.isNotEmpty &&
            emailController.text.isNotEmpty &&
            phoneController.text.isNotEmpty &&
            passwordController.text.isNotEmpty) {
          cButtonState.value = CButtonState.idle;
        } else {
          cButtonState.value = CButtonState.disabled;
        }
      },
      child: Column(
        children: [
          Text(
            "Informações Pessoais*",
            style: AppTextStyle.textMd.copyWith(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
          const SizedBox(height: 24),
          CFormField(
            controller: nameController,
            hintText: 'Nome',
            prefixIcon: Icons.account_box_outlined,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "*";
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          CFormField(
            controller: descriptionController,
            hintText: 'Descrição',
            prefixIcon: Icons.description_outlined,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "*";
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          CFormField(
            controller: emailController,
            hintText: 'Email',
            prefixIcon: Icons.email_outlined,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "*";
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          CFormField(
            controller: phoneController,
            hintText: 'Telefone',
            prefixIcon: Icons.phone,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "*";
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          CFormField(
            controller: passwordController,
            hintText: 'Senha',
            prefixIcon: Icons.password_outlined,
            cFormFieldType: CFormFieldType.password,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "*";
              }
              return null;
            },
          ),
          const SizedBox(height: 24),
          CButton(
            width: MediaQuery.sizeOf(context).width,
            height: 48,
            text: 'Proximo',
            cButtonState: cButtonState,
            onPressed: () {
              widget.registerCubit.barberShopModel.description =
                  descriptionController.text;
              widget.registerCubit.barberShopModel.name = nameController.text;
              widget.registerCubit.barberShopModel.email = emailController.text;
              widget.registerCubit.barberShopModel.phoneNumber =
                  phoneController.text;
              widget.registerCubit.barberShopModel.password =
                  passwordController.text;
              FocusScope.of(context).unfocus();
              widget.onNext();
            },
          )
        ],
      ),
    );
  }
}

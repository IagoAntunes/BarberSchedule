import 'dart:async';

import 'package:barberschedule_client/features/auth/register/external/datasource/register_client_datasource.dart';
import 'package:barberschedule_client/features/auth/register/infra/repositories/register_client_repository.dart';
import 'package:barberschedule_client/features/auth/register/presentation/blocs/register_client_cubit.dart';
import 'package:barberschedule_client/services/http/http_service.dart';
import 'package:barberschedule_design_system/settings/style/app_style_colors.dart';
import 'package:barberschedule_design_system/settings/style/app_text_style.dart';
import 'package:barberschedule_design_system/shared/components/c_button.dart';
import 'package:barberschedule_design_system/shared/components/c_textformfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/register_state.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  final currentStep = ValueNotifier(0);
  final registerCubit = RegisterCubit(
    repository: RegisterClientRepository(
      dataSource: RegisterClientDataSource(
        httpService: HttpServiceImp(),
      ),
    ),
  );

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
                        title: const Text("Conta"),
                        content: PersonalInfoStep(
                          registerCubit: registerCubit,
                          onNext: () {
                            currentStep.value++;
                          },
                        ),
                      ),
                      Step(
                        title: const Text("Foto"),
                        content: PhotoStep(
                          registerCubit: registerCubit,
                          onNext: () {
                            currentStep.value++;
                          },
                          onBack: () => currentStep.value--,
                        ),
                      ),
                      Step(
                        title: const Text("Condições"),
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
                            await registerCubit.registerClient().then((value) {
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
                  print(widget.registerCubit.registerClientModel.toJson());
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

class PhotoStep extends StatelessWidget {
  PhotoStep({
    super.key,
    required this.onNext,
    required this.onBack,
    required this.registerCubit,
  });
  final RegisterCubit registerCubit;

  final void Function() onNext;
  final void Function() onBack;
  final cButtonState = ValueNotifier(CButtonState.idle);

  final String photo = '';
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
                onBack();
              },
            ),
            const SizedBox(width: 8),
            Expanded(
              child: CButton(
                height: 48,
                text: 'Proximo',
                cButtonState: cButtonState,
                onPressed: () {
                  registerCubit.registerClientModel.photo = photo;
                  onNext();
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
              widget.registerCubit.registerClientModel.name =
                  nameController.text;
              widget.registerCubit.registerClientModel.email =
                  emailController.text;
              widget.registerCubit.registerClientModel.phoneNumber =
                  phoneController.text;
              widget.registerCubit.registerClientModel.password =
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

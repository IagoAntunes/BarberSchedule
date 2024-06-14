import 'package:barberschedule_design_system/settings/style/app_style_colors.dart';
import 'package:barberschedule_design_system/settings/style/app_text_style.dart';
import 'package:barberschedule_design_system/shared/components/c_button.dart';
import 'package:barberschedule_design_system/shared/components/c_textformfield.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  final currentStep = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro'),
      ),
      body: Padding(
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
                      onNext: () {
                        currentStep.value++;
                      },
                    ),
                  ),
                  Step(
                    title: const Text("Foto"),
                    content: PhotoStep(
                      onNext: () {
                        currentStep.value++;
                      },
                      onBack: () => currentStep.value--,
                    ),
                  ),
                  Step(
                    title: const Text("Condições"),
                    content: ConditionsStep(
                      onBack: () {
                        currentStep.value--;
                      },
                      onNext: () {
                        //Termina o registro
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class ConditionsStep extends StatelessWidget {
  const ConditionsStep({
    super.key,
    required this.onNext,
    required this.onBack,
  });

  final void Function() onNext;
  final void Function() onBack;

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
              onPressed: () {
                onBack();
              },
            ),
            const SizedBox(width: 8),
            Expanded(
              child: CButton(
                height: 48,
                text: 'Concluir',
                onPressed: () {
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

class PhotoStep extends StatelessWidget {
  const PhotoStep({
    super.key,
    required this.onNext,
    required this.onBack,
  });

  final void Function() onNext;
  final void Function() onBack;

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
        Container(
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
        const SizedBox(height: 24),
        Row(
          children: [
            CButton(
              height: 48,
              text: 'Voltar',
              onPressed: () {
                onBack();
              },
            ),
            const SizedBox(width: 8),
            Expanded(
              child: CButton(
                height: 48,
                text: 'Proximo',
                onPressed: () {
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

class PersonalInfoStep extends StatelessWidget {
  const PersonalInfoStep({
    super.key,
    required this.onNext,
  });

  final void Function() onNext;

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
        const CFormField(
          hintText: 'Nome',
          prefixIcon: Icons.account_box_outlined,
        ),
        const SizedBox(height: 16),
        const CFormField(
          hintText: 'Email',
          prefixIcon: Icons.email_outlined,
        ),
        const SizedBox(height: 16),
        const CFormField(
          hintText: 'Senha',
          prefixIcon: Icons.password_outlined,
          cFormFieldType: CFormFieldType.password,
        ),
        const SizedBox(height: 24),
        CButton(
          width: MediaQuery.sizeOf(context).width,
          height: 48,
          text: 'Proximo',
          onPressed: () {
            print("ALO ?");
            onNext();
            print("ALO ?");
          },
        )
      ],
    );
  }
}
/*
{
  "email": "string",
  "name": "string",
  "phoneNumber": "string",
  "password": "string",
  "roleName": "string",
  "photo": "string"
}
*/

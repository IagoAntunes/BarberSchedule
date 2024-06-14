import 'package:barberschedule_client/features/auth/presentation/pages/register_page.dart';
import 'package:barberschedule_design_system/settings/style/app_style_colors.dart';
import 'package:barberschedule_design_system/settings/style/app_text_style.dart';
import 'package:barberschedule_design_system/shared/components/c_button.dart';
import 'package:barberschedule_design_system/shared/components/c_textformfield.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  AuthPage({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyleColors.backgroundColor,
      body: SizedBox(
        width: double.infinity,
        height: MediaQuery.sizeOf(context).height,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Bem Vindo",
                        style: AppTextStyle.titleLg.copyWith(
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 64),
                      CFormField(
                        hintText: 'Email',
                        prefixIcon: Icons.email_outlined,
                        validator: (p0) {
                          if (p0 == null || p0.isEmpty) {
                            return 'Campo obrigatório';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      CFormField(
                        hintText: 'Senha',
                        prefixIcon: Icons.password_outlined,
                        cFormFieldType: CFormFieldType.password,
                        validator: (p0) {
                          if (p0 == null || p0.isEmpty) {
                            return 'Campo obrigatório';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 8),
                      Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          onTap: () {
                            //
                          },
                          child: Text(
                            "Esqueci minha senha",
                            style: AppTextStyle.textSm.copyWith(
                              color: AppStyleColors.gray300,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      CButton(
                        width: double.infinity,
                        height: 48,
                        text: 'Login',
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            //
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Não tem uma conta?",
                      style: AppTextStyle.textSm
                          .copyWith(color: AppStyleColors.gray300),
                    ),
                    const SizedBox(width: 8),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RegisterPage(),
                          ),
                        );
                      },
                      child: Text(
                        "Registre-se",
                        style: AppTextStyle.textSm.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:barberschedule_client/features/auth/login/external/datasources/login_client_datasource.dart';
import 'package:barberschedule_client/features/auth/login/infra/repositories/login_client_repository.dart';
import 'package:barberschedule_client/features/auth/login/presentation/blocs/login_cubit.dart';
import 'package:barberschedule_client/features/auth/login/presentation/blocs/login_state.dart';
import 'package:barberschedule_client/features/auth/register/presentation/pages/register_client_page.dart';
import 'package:barberschedule_client/services/http/http_service.dart';
import 'package:barberschedule_design_system/settings/style/app_style_colors.dart';
import 'package:barberschedule_design_system/settings/style/app_text_style.dart';
import 'package:barberschedule_design_system/shared/components/c_button.dart';
import 'package:barberschedule_design_system/shared/components/c_textformfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final _formKey = GlobalKey<FormState>();

  final loginCubit = LoginCubit(
    repository: LoginClientRepository(
      dataSource: LoginClientDataSource(
        httpService: HttpServiceImp(),
      ),
    ),
  );
  final btnLoginState = ValueNotifier(CButtonState.disabled);

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyleColors.backgroundColor,
      body: BlocConsumer(
        listener: (context, state) {
          if (state is LoadingLoginListener) {
            btnLoginState.value = CButtonState.loading;
          } else if (state is FailureLoginListener) {
            btnLoginState.value = CButtonState.idle;
          } else if (state is SuccessLoginListener) {
            btnLoginState.value = CButtonState.idle;
          }
        },
        listenWhen: (previous, current) => current is ILoginListener,
        buildWhen: (previous, current) => current is! ILoginListener,
        bloc: loginCubit,
        builder: (context, state) {
          return SizedBox(
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
                      onChanged: () {
                        if (emailController.text.isNotEmpty &&
                            passwordController.text.isNotEmpty) {
                          btnLoginState.value = CButtonState.idle;
                        } else {
                          btnLoginState.value = CButtonState.disabled;
                        }
                      },
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
                            controller: emailController,
                            hintText: 'Email',
                            prefixIcon: Icons.email_outlined,
                            cFormFieldState: state is LoadingLoginState
                                ? CFormFieldState.disabled
                                : CFormFieldState.enabled,
                            validator: (p0) {
                              if (p0 == null || p0.isEmpty) {
                                return 'Campo obrigatório';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          CFormField(
                            controller: passwordController,
                            hintText: 'Senha',
                            prefixIcon: Icons.password_outlined,
                            cFormFieldState: state is LoadingLoginState
                                ? CFormFieldState.disabled
                                : CFormFieldState.enabled,
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
                            cButtonState: btnLoginState,
                            onPressed: () {
                              FocusScope.of(context).unfocus();
                              loginCubit.doLogin(
                                emailController.text,
                                passwordController.text,
                              );
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
          );
        },
      ),
    );
  }
}

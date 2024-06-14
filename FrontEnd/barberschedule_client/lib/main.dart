import 'dart:io';

import 'package:barberschedule_client/features/auth/auth_cubit.dart';
import 'package:barberschedule_client/features/auth/auth_state.dart';
import 'package:barberschedule_client/features/auth/login/presentation/pages/login_page.dart';
import 'package:barberschedule_design_system/settings/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final authCubit = AuthCubit();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BarberSchedule Client',
      theme: AppTheme.theme,
      home: BlocBuilder<AuthCubit, IAuthState>(
        bloc: authCubit,
        builder: (context, state) {
          if (state.isAuthenticated) {
            return LoginPage();
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

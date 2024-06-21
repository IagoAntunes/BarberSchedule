import 'dart:io';

import 'package:barberschedule_client/core/bindings/app_binding.dart';
import 'package:barberschedule_client/features/auth/auth_cubit.dart';
import 'package:barberschedule_client/features/auth/auth_state.dart';
import 'package:barberschedule_client/features/auth/login/presentation/pages/login_page.dart';
import 'package:barberschedule_client/features/barbershops/presentation/bindings/barbershops_binding.dart';
import 'package:barberschedule_client/features/home/presentation/utils/home_binding.dart';
import 'package:barberschedule_client/features/marking_history/presentation/bindings/marking_history_binding.dart';
import 'package:barberschedule_design_system/settings/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/routes/decide_route_page.dart';

void main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await AppBindings.setupAppBindings();
  await HomeBindings.setupBindings();
  await MarkingHistoryBinding.setupBindings();
  await BarberShopsBindings.setupBindings();
  var sharedPreferences = await SharedPreferences.getInstance();
  var token = sharedPreferences.getString('token');
  GetIt.I.get<AuthCubit>().state.isAuthenticated =
      (token == null || token.isEmpty) ? false : true;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final authCubit = GetIt.I.get<AuthCubit>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BarberSchedule Client',
      theme: AppTheme.theme,
      debugShowCheckedModeBanner: false,
      home: BlocBuilder<AuthCubit, IAuthState>(
        bloc: authCubit,
        builder: (context, state) {
          if (!state.isAuthenticated) {
            return LoginPage();
          } else {
            return DecideRoutePage();
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

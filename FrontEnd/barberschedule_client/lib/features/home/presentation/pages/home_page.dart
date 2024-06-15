import 'package:barberschedule_client/features/auth/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ola Mundio"),
      ),
      body: const Column(
        children: [
          //
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          GetIt.I.get<AuthCubit>().logout();
        },
      ),
    );
  }
}

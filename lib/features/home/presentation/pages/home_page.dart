import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invite_flare/features/home/presentation/blocs/drawer/drawer_cubit.dart';
import 'package:invite_flare/features/home/presentation/presentation.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
      create: (_) => DrawerCubit(),
      child: HomeWrapper(),
    );
}




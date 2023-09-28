import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/presentation/cubit/joke_cubit.dart';
import 'package:news/presentation/cubit/joke_state.dart';
import 'package:news/presentation/views/joke_list_view.dart';
import 'package:news/util/constants/enums.dart';

class HomeView extends StatelessWidget {
  const HomeView({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    JokeCubit cubit = BlocProvider.of<JokeCubit>(context);
    return BlocBuilder<JokeCubit, JokeBaseState>(
      builder: (context, state) {
        switch (state.status) {
          case ApiStatus.loading:
            return const Center(child:  Text("Loading..."));
          case ApiStatus.success:
            return const JokeListView();
          case ApiStatus.failed:
            return Text(state.error ?? "");
          case ApiStatus.initial:
            return const Center(child: Text("Loading"));
        }
      },
      bloc: cubit,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/presentation/cubit/joke_cubit.dart';
import 'package:news/presentation/cubit/joke_state.dart';

class JokeListView extends StatelessWidget {
  const JokeListView({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    JokeCubit cubit = BlocProvider.of<JokeCubit>(context);
    return BlocBuilder<JokeCubit, JokeBaseState>(
      bloc: cubit,
      builder: (context, state) {
        return ListView.builder(
          itemBuilder: (c, index) {
            return Padding(
              padding: const EdgeInsets.only(
                  left: 10.0, right: 10, top: 5, bottom: 5),
              child: Card(
                elevation: 3,
                child: Container(
                  margin: const EdgeInsets.all(10),
                  child: Text(
                    cubit.repo?.joke(index),
                  ),
                ),
              ),
            );
          },
          itemCount: cubit.repo?.jokesCount(),
        );
      },
    );
  }
}

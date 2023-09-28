import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/data/repositries/joke_repo.dart';
import 'package:news/presentation/cubit/joke_cubit.dart';
import 'package:news/presentation/views/home_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  JokeCubit? cubit;
  JokeRepo? repo;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    repo = JokeRepo();
    cubit = JokeCubit(repo: repo);
    cubit?.getJoke(isInitialLoad:true);
    cubit?.repo?.timer.start(
      nextOperation: () {
        cubit?.getJoke(isInitialLoad:false);
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider(
        create: (context) => cubit!,
        child: const HomeView(),
      ),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        cubit?.repo?.timer.start(nextOperation: () {
          cubit?.getJoke(isInitialLoad:false);
        });
        print("app in resumed");
        break;
      case AppLifecycleState.inactive:
        cubit?.repo?.timer.close();
        print("app in inactive");
        break;
      case AppLifecycleState.paused:
        cubit?.repo?.timer.close();
        print("app in paused");
        break;
      case AppLifecycleState.detached:
        print("app in detached");
        break;
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    cubit?.repo?.timer.close();
    cubit?.close();
    super.dispose();
  }
}

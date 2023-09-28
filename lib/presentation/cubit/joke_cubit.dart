import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:news/data/repositries/joke_repo.dart';
import 'package:news/domain/models/m_joke.dart';
import 'package:news/util/constants/enums.dart';
import 'package:news/util/db_manager/db_manager.dart';

import 'joke_state.dart';

class JokeCubit extends Cubit<JokeBaseState> {
  final JokeRepo? repo;
  JokeCubit({this.repo}) : super(const JokeState(status: ApiStatus.initial));

  getJoke({bool isInitialLoad = true}) async {
    if (isInitialLoad) {
      emit(const JokeState(status: ApiStatus.loading));
      repo?.jokes = await DBManager.getJokes();
      if (repo!.jokes.isNotEmpty) {
        return repo?.jokes;
      }
    }
    try {
      Response? response = await repo?.getJoke();
      if (response?.statusCode == 200) {
        MJoke joke = await DBManager.insert(MJoke(title: response?.data));
        repo?.jokes = [joke];
        if (!isInitialLoad) emit(const JokeState(status: ApiStatus.loading));
        emit(const JokeState(status: ApiStatus.success));
      } else {
        emit(const JokeState(status: ApiStatus.failed));
      }
    } catch (e) {
      emit(JokeState(status: ApiStatus.failed, error: e.toString()));
    }
  }
}

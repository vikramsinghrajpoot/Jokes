import 'package:dio/dio.dart';
import 'package:news/data/datasources/remote/api_service.dart';
import 'package:news/domain/models/m_joke.dart';
import 'package:news/util/constants/joke_timer.dart';
import 'package:news/util/db_manager/db_manager.dart';

class JokeRepo {
  ApiService service = ApiService();
  JokeTimer timer = JokeTimer();

  final List<MJoke> _jokes = List<MJoke>.empty(growable: true);
  List<MJoke> get jokes => _jokes;
  set jokes(joke) {
    //When joke list reaches max length remove first and add new to last
    if (_jokes.length >= 10) {
      MJoke j = _jokes[0];
      DBManager.deleteJoke(j.id!);
      _jokes.removeAt(0);
    }
    if (joke.isNotEmpty) {
      _jokes.addAll(joke);
    }
  }

  jokesCount() => _jokes.length;
  joke(index) => _jokes[index].title;

  Future<Response> getJoke() async {
    return service.getJokes();
  }
}

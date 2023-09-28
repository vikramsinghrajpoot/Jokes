import 'package:equatable/equatable.dart';
import 'package:news/util/constants/enums.dart';

class JokeBaseState extends Equatable {
  final String? error;
  final ApiStatus status;
  const JokeBaseState({this.error, this.status = ApiStatus.initial});

  @override
  List<Object> get props => [status];
}

class JokeState extends JokeBaseState {
  const JokeState({status, type, error}) : super(status: status, error: error);

  @override
  List<Object> get props => [status];
}

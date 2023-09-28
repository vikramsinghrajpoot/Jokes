import 'dart:async';

import 'package:news/util/constants/api_urls.dart';

class JokeTimer {
  Timer? _timer;

  start({Function? nextOperation, int seconds = ApiUrls.duration}) {
    if (nextOperation != null) {
      _timer = Timer.periodic(
          const Duration(seconds: ApiUrls.duration), (Timer t) => nextOperation());
    }
  }

  close(){
    _timer?.cancel();
  }
}

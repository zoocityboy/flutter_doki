import 'package:flutter/widgets.dart';
import 'package:flutter_doki/src/flutter_doki.dart';
import 'package:flutter_doki/src/models/badge_state.dart';
import 'package:flutter_doki/src/models/doki_response.dart';

class ViewModel extends ChangeNotifier {
  BadgeState state = BadgeState.init;
  Exception? error;
  DokiResponse? response;
  void _loading() {
    state = BadgeState.loading;
    error = null;
    response = null;
    notifyListeners();
  }

  void load() {
    _loading();
    Doki.fetch().then((value) {
      state = BadgeState.loaded;
      response = value;
      error = null;
      notifyListeners();
    }).catchError((e) {
      state = BadgeState.error;
      error = e;
      response = null;
      notifyListeners();
    });
  }
}

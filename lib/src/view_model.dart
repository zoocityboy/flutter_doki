import 'package:flutter/widgets.dart';
import 'package:flutter_doki/src/flutter_doki.dart';
import 'package:flutter_doki/src/models/badge_state.dart';
import 'package:flutter_doki/src/models/doki_response.dart';

class BadgeViewModel extends ChangeNotifier {
  BadgeState _state = BadgeState.init;
  BadgeState get state => _state;

  Exception? _error;
  Exception? get error => _error;

  DokiResponse? _response;
  DokiResponse? get response => _response;
  @visibleForTesting
  void setValue({DokiResponse? response, Exception? error, BadgeState? state}) {
    if (response != null) _response = response;
    if (error != null) _error = error;
    if (state != null) _state = state;
    notifyListeners();
  }

  final Doki doki = Doki();

  void _loading() {
    _state = BadgeState.loading;
    _error = null;
    _response = null;
    notifyListeners();
  }

  void load() {
    _loading();
    doki.fetch().then((value) {
      _state = BadgeState.loaded;
      _response = value;
      _error = null;
      notifyListeners();
    }).catchError((e) {
      _state = BadgeState.error;
      _error = e;
      _response = null;
      notifyListeners();
    });
  }
}

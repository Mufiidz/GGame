import 'package:flutter/material.dart';
import 'package:ggame/models/home.dart';

import '../../../data/remote/game_repository.dart';
import '../../../data/view_state.dart';
import '../../../models/game.dart';

class HomeViewModel extends ChangeNotifier {
  final GameRepository _gameRepo = GameRepositoryImpl();

  List<Game> _listGame = [];
  List<Game> get listGame => _listGame;

  ViewState _state = ViewState.loading;
  ViewState get state => _state;

  _changeState(ViewState state) {
    _state = state;
    notifyListeners();
  }

  void setListGame(Home home) async {
    if (home.title.toLowerCase() == 'all') {
      _getListAll();
    } else {
      _getListPlatform(home);
    }
  }

  void _getListAll() async {
    _changeState(ViewState.loading);
    try {
      _listGame = await _gameRepo.getListGame();
      _changeState(ViewState.none);
    } catch (e) {
      _changeState(ViewState.error);
    }
    notifyListeners();
  }

  void _getListPlatform(Home home) async {
    _changeState(ViewState.loading);
    try {
      _listGame = await _gameRepo.getListGamebyFilter(
          home.category, home.title.toLowerCase());
      _changeState(ViewState.none);
    } catch (e) {
      _changeState(ViewState.error);
    }
    notifyListeners();
  }
}

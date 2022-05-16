import 'package:flutter/material.dart';

import '../../../data/remote/game_repository.dart';
import '../../../data/view_state.dart';
import '../../../models/game.dart';

class DetailViewModel extends ChangeNotifier {
  final GameRepository _gameRepo = GameRepositoryImpl();

  Game _game = Game(id: 0);
  Game get game => _game;

  ViewState _state = ViewState.loading;
  ViewState get state => _state;

  _changeState(ViewState state) {
    _state = state;
    notifyListeners();
  }

  Future<void> setDetailGame(int id) async {
    _changeState(ViewState.loading);
    try {
      _game = await _gameRepo.getDetailGame(id);
      notifyListeners();
      _changeState(ViewState.none);
    } catch (e) {
      _changeState(ViewState.error);
    }
  }
}

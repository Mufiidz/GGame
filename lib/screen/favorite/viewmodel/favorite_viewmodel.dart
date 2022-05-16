import 'package:flutter/material.dart';
import 'package:ggame/data/local/ggame_db.dart';

import '../../../data/view_state.dart';

class FavoriteViewModel extends ChangeNotifier {
  GgameDb? _ggameDb;

  List<FavoriteData> _listFav = [];
  List<FavoriteData> get listFavorite => _listFav;

  FavoriteData? _favorite;
  FavoriteData? get favorite => _favorite;

  String _error = '';
  String get errorMessage => _error;

  ViewState _state = ViewState.loading;
  ViewState get state => _state;

  bool _isSuccess = false;
  bool get isSuccess => _isSuccess;

  bool _isFavorited = false;
  bool get isFavorited => _isFavorited;

  void initDatabase(GgameDb db) => _ggameDb = db;

  _changeState(ViewState state) {
    _state = state;
    notifyListeners();
  }

  void getListFavorite() {
    _changeState(ViewState.loading);
    _ggameDb?.getListFavorite().then((value) {
      _changeState(ViewState.none);
      _listFav = value;
      notifyListeners();
    }).onError((error, stackTrace) {
      _changeState(ViewState.error);
      _error = error.toString();
      notifyListeners();
    });
    notifyListeners();
  }

  void getFavorite(int id) {
    _changeState(ViewState.loading);
    _ggameDb?.getFavorite(id).then((value) {
      _changeState(ViewState.none);
      _favorite = value;
      notifyListeners();
    }).onError((error, stackTrace) {
      _changeState(ViewState.error);
      _error = error.toString();
      notifyListeners();
    });
  }

  void addFavorite(FavoriteData favorite) {
    _changeState(ViewState.loading);
    _ggameDb?.addFavorite(favorite).then((value) {
      _isSuccess = true;
      _changeState(ViewState.none);
      notifyListeners();
    }).onError((error, stackTrace) {
      _changeState(ViewState.error);
      _error = error.toString();
      notifyListeners();
    });
    gameIsFavorited(favorite.id);
  }

  void gameIsFavorited(int id) {
    _ggameDb?.getFavorite(id).then((value) {
      _favorite = value;
      if (value != null) {
        _isFavorited = true;
      } else {
        _isFavorited = false;
      }
      notifyListeners();
    });
  }

  void deleteFavorite(int id) {
    _changeState(ViewState.loading);
    _ggameDb?.deleteFavorite(id).then((value) {
      _changeState(ViewState.none);
      _isSuccess = true;
      notifyListeners();
    }).onError((error, stackTrace) {
      _changeState(ViewState.error);
      _error = error.toString();
      notifyListeners();
    });
    gameIsFavorited(id);
    getListFavorite();
  }

  void deleteAll() {
    _changeState(ViewState.loading);
    _ggameDb?.deleteAllFavorite().then((value) {
      _changeState(ViewState.none);
      _isSuccess = true;
      notifyListeners();
    }).onError((error, stackTrace) {
      _changeState(ViewState.error);
      _error = error.toString();
      notifyListeners();
    });
    getListFavorite();
  }
}

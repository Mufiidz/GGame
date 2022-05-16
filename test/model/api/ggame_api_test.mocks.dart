// Mocks generated by Mockito 5.1.0 from annotations
// in ggame/test/model/api/ggame_api_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:ggame/data/remote/game_repository.dart' as _i3;
import 'package:ggame/models/game.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeGame_0 extends _i1.Fake implements _i2.Game {}

/// A class which mocks [GameRepositoryImpl].
///
/// See the documentation for Mockito's code generation for more information.
class MockGameRepositoryImpl extends _i1.Mock
    implements _i3.GameRepositoryImpl {
  MockGameRepositoryImpl() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Game> getDetailGame(int? id) =>
      (super.noSuchMethod(Invocation.method(#getDetailGame, [id]),
              returnValue: Future<_i2.Game>.value(_FakeGame_0()))
          as _i4.Future<_i2.Game>);
  @override
  _i4.Future<List<_i2.Game>> getListGame() =>
      (super.noSuchMethod(Invocation.method(#getListGame, []),
              returnValue: Future<List<_i2.Game>>.value(<_i2.Game>[]))
          as _i4.Future<List<_i2.Game>>);
  @override
  _i4.Future<List<_i2.Game>> getListGamebyFilter(
          String? category, String? platform) =>
      (super.noSuchMethod(
              Invocation.method(#getListGamebyFilter, [category, platform]),
              returnValue: Future<List<_i2.Game>>.value(<_i2.Game>[]))
          as _i4.Future<List<_i2.Game>>);
}
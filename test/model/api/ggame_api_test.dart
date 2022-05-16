import 'package:flutter_test/flutter_test.dart';
import 'package:ggame/data/remote/game_repository.dart';
import 'package:ggame/models/game.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'ggame_api_test.mocks.dart';

@GenerateMocks([GameRepositoryImpl])
void main() {
  group('Get Data Ggame from API', () {
    GameRepository gameRepository = MockGameRepositoryImpl();

    test('get All list game', () async {
      when(gameRepository.getListGame())
          .thenAnswer((realInvocation) async => []);
      var listGame = await gameRepository.getListGame();
      expect(listGame, isA<List<Game>>());
    });
    test('get List game by filter', () async {
      when(gameRepository.getListGamebyFilter('shooter', 'pc'))
          .thenAnswer((realInvocation) async {
        var listGame =
            await gameRepository.getListGamebyFilter('shooter', 'pc');
        expect(listGame.isNotEmpty, true);
        listGame = await gameRepository.getListGamebyFilter('shooter', 'web');
        expect(listGame.isNotEmpty, true);
        listGame =
            await gameRepository.getListGamebyFilter('shooter', 'mobile');
        expect(listGame.isEmpty, true);
        return listGame;
      });
    });
    test('get Detail game', () async {
      int id = 2;
      Game gameTest = Game(id: id);
      when(gameRepository.getDetailGame(id))
          .thenAnswer((realInvocation) async => gameTest);
      var game = await gameRepository.getDetailGame(id);
      expect(game, isA<Game>());
      expect(game, gameTest);
    });
  });
}

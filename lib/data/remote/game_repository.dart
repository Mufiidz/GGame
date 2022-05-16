import 'package:ggame/res/string_src.dart';
import 'package:http/http.dart' as http;
import '../../models/game.dart';

abstract class GameRepository {
  Future<List<Game>> getListGame();
  Future<List<Game>> getListGamebyFilter(String? category, String platform);
  Future<Game> getDetailGame(int id);
}

class GameRepositoryImpl implements GameRepository {
  @override
  Future<Game> getDetailGame(int id) async {
    var response = await http.get(_getUrl('${ApiEndPoints.getDetailGame}$id'));
    return gameFromJson(response.body);
  }

  @override
  Future<List<Game>> getListGame() async {
    var response = await http.get(_getUrl(ApiEndPoints.getListGame));
    return listGameFromJson(response.body);
  }

  @override
  Future<List<Game>> getListGamebyFilter(
      String? category, String platform) async {
    var response =
        await http.get(_getUrl('${ApiEndPoints.getListByPlatform}$platform'));
    if (category != null && category.toLowerCase() != 'all') {
      response = await http.get(_getUrl(
          '${ApiEndPoints.getListByPlatform}$platform${ApiEndPoints.byCategory}$category'));
    }
    try {
      return listGameFromJson(response.body);
    } catch (e) {
      return <Game>[];
    }
  }

  Uri _getUrl(String endPoint) => Uri.parse('$baseApi$endPoint');
}

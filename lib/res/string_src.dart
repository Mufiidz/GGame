import 'package:ggame/models/game.dart';

const logo =
    'https://raw.githubusercontent.com/Mufiidz/mufiidz.github.io/main/assets/logo.png';
const baseApi = 'https://www.freetogame.com/api/';
const appName = 'GGame';
const nodata = 'Tidak ada data';
String textShareGame(Game game) =>
    'Yuk kita bermain bersama dengan memainkan game ini ${game.gameUrl}, kamu juga bisa lihat game lainnya di aplikasi GGame atau disini ${game.freetogameProfileUrl}';

class SharedPrefs {
  static String name = 'name';
  static String listCategory = 'listCategory';
}

class ApiEndPoints {
  static String getListGame = 'games';
  static String getListByCategory = 'games?category=';
  static String getListByPlatform = 'games?platform=';
  static String getDetailGame = 'game?id=';
  static String getListByPlatformMultitag = 'filter?tag=';
  static String byCategory = '&category=';
}

import 'package:flutter/material.dart';
import 'package:ggame/data/local/ggame_db.dart';
import 'package:ggame/res/string_src.dart';
import 'package:ggame/screen/detail/viewmodel/detail_viewmodel.dart';
import 'package:ggame/screen/favorite/viewmodel/favorite_viewmodel.dart';
import 'package:ggame/utils/app_route.dart';
import 'package:provider/provider.dart';

import 'screen/home/viewmodel/home_viewmodel.dart';
import 'screen/profile/viewmodel/profile_viewmodel.dart';
import 'screen/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider.value(value: GgameDb()),
        ChangeNotifierProvider.value(value: HomeViewModel()),
        ChangeNotifierProvider.value(value: DetailViewModel()),
        ChangeNotifierProxyProvider<GgameDb, FavoriteViewModel>(
            create: (context) => FavoriteViewModel(),
            update: (context, db, notifier) => notifier!..initDatabase(db)),
        ChangeNotifierProvider.value(value: ProfileViewModel()),
      ],
      child: MaterialApp(
        title: appName,
        navigatorKey: AppRoute.navigatorKey,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}

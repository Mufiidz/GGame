import 'package:flutter/material.dart';
import 'package:ggame/screen/detail/components/desc_detail.dart';
import 'package:ggame/screen/detail/components/header_detail.dart';
import 'package:ggame/screen/detail/components/info_detail.dart';
import 'package:ggame/screen/detail/components/link_detail.dart';
import 'package:ggame/screen/detail/components/requirment_detail.dart';
import 'package:ggame/screen/detail/components/screenshoots_detail.dart';
import 'package:ggame/screen/favorite/favorite_screen.dart';
import 'package:ggame/screen/favorite/viewmodel/favorite_viewmodel.dart';
import 'package:ggame/utils/app_route.dart';
import 'package:ggame/widgets/state_widget.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../models/game.dart';
import '../../res/string_src.dart';
import 'viewmodel/detail_viewmodel.dart';

class DetailScreen extends StatefulWidget {
  final int id;
  const DetailScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late FavoriteViewModel _favoriteViewModel;
  @override
  void initState() {
    super.initState();
    _favoriteViewModel = context.read<FavoriteViewModel>()
      ..gameIsFavorited(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    context.read<DetailViewModel>().setDetailGame(widget.id);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer<DetailViewModel>(
        builder: (context, viewmodel, child) {
          Game game = viewmodel.game;
          return StateWidget(
            state: viewmodel.state,
            child: NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) => [
                      SliverAppBar(
                        pinned: true,
                        expandedHeight: 200,
                        title: Text(
                          innerBoxIsScrolled ? game.title : '',
                          style: TextStyle(
                              color: innerBoxIsScrolled
                                  ? Colors.black
                                  : Colors.white),
                        ),
                        elevation: 0,
                        backgroundColor: Colors.white,
                        iconTheme: IconThemeData(
                            color: innerBoxIsScrolled
                                ? Colors.black
                                : Colors.white),
                        actions: [
                          IconButton(
                              onPressed: () => Share.share(textShareGame(game)),
                              icon: const Icon(Icons.share)),
                          Selector<FavoriteViewModel, bool>(
                              selector: (context, viewmodel) =>
                                  viewmodel.isFavorited,
                              builder: (context, isFavorited, child) {
                                return IconButton(
                                    onPressed: () => onChangeFavorite(
                                        isFavorited, context, game),
                                    icon: Icon(
                                      isFavorited
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: isFavorited ? Colors.red : null,
                                    ));
                              })
                        ],
                        flexibleSpace: FlexibleSpaceBar(
                          background: game.thumbnail.isNotEmpty
                              ? Image.network(
                                  game.thumbnail,
                                  fit: BoxFit.fill,
                                )
                              : Container(
                                  decoration: const BoxDecoration(
                                      gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          colors: [
                                      Color.fromARGB(255, 13, 71, 161),
                                      Color.fromARGB(255, 21, 102, 194),
                                      Color.fromARGB(255, 66, 165, 245)
                                    ]))),
                        ),
                      )
                    ],
                body: Padding(
                  padding: const EdgeInsets.only(
                    right: 16,
                    left: 16,
                  ),
                  child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      itemCount: listDetail(game).length,
                      separatorBuilder: (BuildContext context, int index) =>
                          const SizedBox(
                            height: 10,
                          ),
                      itemBuilder: (BuildContext context, int index) =>
                          listDetail(game)[index]),
                )),
          );
        },
      ),
    );
  }

  List<Widget> listDetail(Game game) {
    return [
      HeaderDetail(game: game),
      InfoDetail(
        listInfo: game.toAdditionalInfo(),
      ),
      DescDetail(title: game.title, desc: game.description),
      ScreenshootDetail(screenshots: game.screenshots ?? []),
      RequirmentDetail(
        listRequirement: game.minimumSystemRequirements?.toListRequire() ?? [],
      ),
      LinkDetail(
        officialLink: game.gameUrl,
        link: game.freetogameProfileUrl,
      ),
      const SizedBox(
        height: 5,
      )
    ];
  }

  onChangeFavorite(bool isFavorite, BuildContext context, Game game) {
    if (isFavorite) {
      _favoriteViewModel.deleteFavorite(game.id);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('${game.title} deleted from favorite'),
        backgroundColor: Colors.red,
      ));
    } else {
      _favoriteViewModel.addFavorite(game.toFavorite());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('${game.title} added to favorite'),
        backgroundColor: Colors.teal,
        action: SnackBarAction(
            label: 'Lihat',
            textColor: Colors.white,
            onPressed: () => AppRoute.to(const FavoriteScreen())),
      ));
    }
  }
}

import 'package:flutter/material.dart';
import 'package:ggame/data/local/ggame_db.dart';
import 'package:ggame/res/string_src.dart';
import 'package:ggame/widgets/item_game.dart';
import 'package:ggame/screen/favorite/viewmodel/favorite_viewmodel.dart';
import 'package:ggame/widgets/state_widget.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<FavoriteViewModel>().getListFavorite();
    return Consumer<FavoriteViewModel>(
      builder: (context, viewmodel, child) => Scaffold(
          body: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                    SliverAppBar(
                      pinned: true,
                      elevation: 0,
                      expandedHeight: 200,
                      flexibleSpace: FlexibleSpaceBar(
                        title: const Text('Favorite'),
                        background: Container(
                            decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    colors: [
                              Color.fromARGB(255, 13, 71, 161),
                              Color.fromARGB(255, 21, 102, 194),
                              Color.fromARGB(255, 66, 165, 245)
                            ]))),
                      ),
                      actions: [
                        IconButton(
                            onPressed: () => viewmodel.deleteAll(),
                            tooltip: 'Clear All',
                            icon: const Icon(Icons.clear_all))
                      ],
                    )
                  ],
              body: StateWidget(
                state: viewmodel.state,
                child: viewmodel.listFavorite.isEmpty
                    ? const Center(
                        child: Text(nodata),
                      )
                    : ListView.builder(
                        itemCount: viewmodel.listFavorite.length,
                        itemBuilder: (context, index) {
                          FavoriteData favoriteData =
                              viewmodel.listFavorite[index];
                          return ItemGame(
                            favorite: favoriteData,
                          );
                        }),
              ))),
    );
  }
}

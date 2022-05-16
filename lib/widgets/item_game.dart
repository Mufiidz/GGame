import 'package:flutter/material.dart';
import 'package:ggame/data/local/ggame_db.dart';
import 'package:ggame/screen/detail/detail_screen.dart';
import 'package:ggame/utils/app_route.dart';

class ItemGame extends StatelessWidget {
  final FavoriteData favorite;
  const ItemGame({Key? key, required this.favorite}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Card(
        elevation: 10,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: InkWell(
          onTap: () => AppRoute.to(DetailScreen(
            id: favorite.id,
          )),
          child: size.width < 600
              ? Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Image.network(
                      favorite.image,
                      fit: BoxFit.fill,
                    ),
                    Container(
                      width: size.width,
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [
                            Colors.black,
                            Colors.black45,
                            Colors.black38
                          ])),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          favorite.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                )
              : Row(
                  children: [
                    Image.network(favorite.image),
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            favorite.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 25),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            favorite.shortDesc,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 18, color: Colors.grey),
                          )
                        ],
                      ),
                    ))
                  ],
                ),
        ),
      ),
    );
  }
}

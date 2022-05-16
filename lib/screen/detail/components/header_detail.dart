import 'package:flutter/material.dart';

import '../../../models/game.dart';

class HeaderDetail extends StatelessWidget {
  final Game game;
  const HeaderDetail({Key? key, required this.game}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          game.title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(game.toReleaseDate(format: 'dd MMMM yyyy')),
        const SizedBox(
          height: 5,
        ),
        Chip(
            backgroundColor: Colors.blue,
            label: Text(
              game.genre,
              style: const TextStyle(color: Colors.white),
          )),
        const SizedBox(
          height: 5,
        ),
        Text(game.shortDescription)
      ],
    );
  }
}

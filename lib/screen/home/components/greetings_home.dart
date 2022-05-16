import 'package:flutter/material.dart';

import '../../../utils/app_route.dart';
import '../../favorite/favorite_screen.dart';
import '../../profile/profile_screen.dart';

class GreetingsHome extends StatelessWidget {
  final String name;
  const GreetingsHome({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome, $name',
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
              const Text(
                'Main apa sekarang?',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              const SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
        IconButton(
            onPressed: () => AppRoute.to(const FavoriteScreen()),
            icon: const Icon(
              Icons.favorite,
              color: Colors.white,
              semanticLabel: 'Favorite',
            )),
        IconButton(
            onPressed: () => AppRoute.to(const ProfileScreen()),
            icon: const Icon(
              Icons.account_circle,
              color: Colors.white,
              semanticLabel: 'Profile',
            ))
      ],
    );
  }
}

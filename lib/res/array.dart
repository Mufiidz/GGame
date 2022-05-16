import 'dart:ui';

import 'package:ggame/screen/profile/category_profile_screen.dart';
import 'package:ggame/screen/profile/name_profile_screen.dart';

import '../models/settings.dart';

final List<String> listCategory = [
  'MORPG',
  'Shooter',
  'Strategy',
  'MOBA',
  'Racing',
  'Sports',
  'Social',
  'Sandbox',
  'Open-World',
  'Survival',
  'PVP',
  'Zombie',
  'First-Person',
  'Third-Person',
  'Tank',
  'Sailing',
  'Superhero',
  'Card',
  'Battle-Royale',
  'MMO',
  'MMOFPS',
  '3D',
  '2D',
  'Anime',
  'Fantasy',
  'Sci-Fi',
  'Fighting',
  'Action-RPG',
  'Action',
  'Military',
  'Martial-Arts',
  'Low-Spec',
  'Horror',
];

final List<String> listDropDown = ['All', 'Pc', 'Browser'];

final List<Color> baseGradient = [
  const Color.fromARGB(255, 13, 71, 161),
  const Color.fromARGB(255, 21, 102, 194),
  const Color.fromARGB(255, 66, 165, 245)
];

final List<Settings> listSettings = [
  Settings(title: 'Change Name', destination: const NameProfileScreen()),
  Settings(title: 'Change Category', destination: const CategoryProfileScreen())
];

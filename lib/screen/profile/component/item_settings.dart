import 'package:flutter/material.dart';
import 'package:ggame/models/settings.dart';
import 'package:ggame/utils/app_route.dart';

class ItemSettings extends StatelessWidget {
  final Settings settings;
  const ItemSettings({Key? key, required this.settings}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Card(
          elevation: 10,
          child: ListTile(
            onTap: () => AppRoute.to(settings.destination),
            title: Text(
              settings.title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            trailing: const Icon(Icons.chevron_right),
          ),
        ),
      ),
    );
  }
}

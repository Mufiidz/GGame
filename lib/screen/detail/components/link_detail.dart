import 'package:flutter/material.dart';
import 'package:linkwell/linkwell.dart';

class LinkDetail extends StatelessWidget {
  final String officialLink;
  final String link;
  const LinkDetail({Key? key, required this.officialLink, required this.link})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Visit Link',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        const SizedBox(
          height: 10,
        ),
        LinkWell(
          "Official Website : $officialLink.",
        ),
        const SizedBox(
          height: 10,
        ),
        LinkWell(
          "Freetogame website: $link.",
        )
      ],
    );
  }
}

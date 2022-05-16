import 'package:flutter/material.dart';
import 'package:ggame/models/screenshot.dart';

import '../../../utils/app_route.dart';
import '../../../widgets/photo_screen.dart';

class ScreenshootDetail extends StatelessWidget {
  final List<Screenshot> screenshots;
  const ScreenshootDetail({Key? key, required this.screenshots})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Screenshoots',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        const SizedBox(
          height: 10,
        ),
        screenshots.isEmpty
            ? SizedBox(
                width: size.width,
                height: 200,
                child: const Center(child: Text('Tidak ada data')),
              )
            : SizedBox(
                height: 200,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: screenshots.length,
                    itemBuilder: (context, index) {
                      Screenshot screenshot = screenshots[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Card(
                          elevation: 6,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: InkWell(
                            onTap: () => AppRoute.to(PhotoScreen(linkImage: screenshot.image)),
                            child: Image.network(
                              screenshot.image,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      );
                    }),
              ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

import '../../../models/info.dart';

class InfoDetail extends StatelessWidget {
  final List<Info> listInfo;
  const InfoDetail({Key? key, required this.listInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Additional Information',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        const SizedBox(
          height: 10,
        ),
        listInfo.isEmpty
            ? SizedBox(
                width: size.width,
                height: 200,
                child: const Center(
                    child: Text(
                  'Tidak ada info yang diberikan',
                  textAlign: TextAlign.center,
                )),
              )
            : SizedBox(
                height: 200,
                child: GridView.builder(
                    itemCount: listInfo.length,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: size.width <= 600 ? 1.8 : 3.8),
                    itemBuilder: (context, index) {
                      var info = listInfo[index];
                      return Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                info.title,
                                style: const TextStyle(color: Colors.grey),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                info.desc,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontSize: 15),
                              )
                            ],
                          ),
                        ),
                      );
                    }),
              )
      ],
    );
  }
}

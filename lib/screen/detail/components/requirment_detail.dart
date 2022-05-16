import 'package:flutter/material.dart';

import '../../../models/info.dart';

class RequirmentDetail extends StatelessWidget {
  final List<Info> listRequirement;
  const RequirmentDetail({Key? key, required this.listRequirement})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Minimum Requirment',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        const SizedBox(
          height: 10,
        ),
        listRequirement.isEmpty
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
              height: 280,
              child: ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: listRequirement.length,
                itemBuilder: (context, index) {
                  var info = listRequirement[index];
                  return Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 3),
                          child: Text(
                            '${info.title}:',
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          info.desc.isNotEmpty ? info.desc : '-',
                          style: const TextStyle(fontSize: 15),
                        ),
                      )
                    ],
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(),
              ),
            )
      ],
    );
  }
}

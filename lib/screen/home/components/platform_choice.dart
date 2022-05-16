import 'package:flutter/material.dart';

import '../../../res/array.dart';

class PlatformChoice extends StatefulWidget {
  final Function(String)? selectedPlatform;
  const PlatformChoice({Key? key, this.selectedPlatform}) : super(key: key);

  @override
  State<PlatformChoice> createState() => _PlatformChoiceState();
}

class _PlatformChoiceState extends State<PlatformChoice> {
  String _selectedItem = listDropDown[0];
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      child: Card(
        elevation: 10,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: DropdownButtonFormField<String>(
              value: _selectedItem,
              alignment: Alignment.center,
              decoration: const InputDecoration(
                enabledBorder: InputBorder.none,
              ),
              items: listDropDown
                  .map((item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: const TextStyle(fontSize: 15),
                        ),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedItem = value ?? _selectedItem;
                  if (widget.selectedPlatform != null) {
                    widget.selectedPlatform!(_selectedItem);
                  }
                });
              }),
        ),
      ),
    );
  }
}

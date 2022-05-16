import 'package:flutter/material.dart';

class ChoiceHome extends StatefulWidget {
  final List<String> listCategory;
  final Function(String)? selected;
  const ChoiceHome({Key? key, required this.listCategory, this.selected})
      : super(key: key);

  @override
  State<ChoiceHome> createState() => _ChoiceHomeState();
}

class _ChoiceHomeState extends State<ChoiceHome> {
  String _selectedCategory = 'All';
  String _selectedBefore = 'All';
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 60,
        child: ListView.separated(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            String title = widget.listCategory[index];
            return ChoiceChip(
                label: Text(
                  title,
                  style: const TextStyle(color: Colors.white),
                ),
                selectedColor: Colors.blue,
                elevation: 0,
                backgroundColor: Colors.grey,
                selected: _selectedCategory == title,
                onSelected: (_) => setState(() {
                      _selectedCategory = title;
                      if (widget.selected != null && _selectedCategory != _selectedBefore) {
                        widget.selected!(_selectedCategory);
                        _selectedBefore = _selectedCategory;
                      }
                    }));
          },
          itemCount:
              widget.listCategory.length,
          separatorBuilder: (BuildContext context, int index) => const SizedBox(
            width: 5,
          ),
        ));
  }
}

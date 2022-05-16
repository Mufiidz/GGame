import 'package:flutter/material.dart';
import 'package:ggame/screen/home/home_screen.dart';
import 'package:ggame/screen/interest/components/name_form_field.dart';
import 'package:ggame/screen/profile/viewmodel/profile_viewmodel.dart';
import 'package:ggame/utils/app_route.dart';
import 'package:ggame/res/array.dart';
import 'package:provider/provider.dart';

class InterestScreen extends StatefulWidget {
  const InterestScreen({Key? key}) : super(key: key);

  @override
  State<InterestScreen> createState() => _InterestScreenState();
}

class _InterestScreenState extends State<InterestScreen> {
  final _formKey = GlobalKey<FormState>();
  final List<String> _selectedCategory = <String>[];
  String _name = '';

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var viewmodel = context.read<ProfileViewModel>();
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Name',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                const SizedBox(
                  height: 5,
                ),
                Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: NameFormField(
                      name: (name) => _name = name,
                    )),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Category',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                const SizedBox(
                  height: 20,
                ),
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 5,
                  runSpacing: 5,
                  children: _listOfChips(),
                ),
              ],
            ),
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: size.width,
                height: size.width >= 400 ? 60 : null,
                child: Card(
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState?.save();
                            viewmodel.setName(_name);
                            viewmodel.setListInterest(_selectedCategory);
                            AppRoute.to(const HomeScreen());
                          }
                        },
                        child: const Text('Save')),
                  ),
                ),
              ))
        ],
      ),
    );
  }

  List<Widget> _listOfChips() {
    List<Widget> filter = [];
    Widget chip = Container();
    for (var item in listCategory.getRange(0, 15)) {
      var isSelected = _selectedCategory.contains(item);
      chip = FilterChip(
          label: Text(item),
          selectedColor: Colors.blue,
          labelStyle:
              TextStyle(color: isSelected ? Colors.white : Colors.black),
          selected: isSelected,
          checkmarkColor: Colors.white,
          elevation: isSelected ? 6 : 0,
          onSelected: (isSelected) {
            setState(() {
              if (_selectedCategory.contains(item)) {
                _selectedCategory.remove(item);
              } else {
                _selectedCategory.add(item);
              }
            });
          });
      filter.add(chip);
    }
    return filter;
  }
}

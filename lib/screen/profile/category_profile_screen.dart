import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/app_route.dart';
import '../../res/array.dart';
import 'viewmodel/profile_viewmodel.dart';

class CategoryProfileScreen extends StatefulWidget {
  const CategoryProfileScreen({Key? key}) : super(key: key);

  @override
  State<CategoryProfileScreen> createState() => _CategoryProfileScreenState();
}

class _CategoryProfileScreenState extends State<CategoryProfileScreen> {
  List<String> _selectedCategory = <String>[];
  late ProfileViewModel _viewModel;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    _viewModel = context.watch<ProfileViewModel>();
    context.select<ProfileViewModel, List<String>>(
        (value) => _selectedCategory = value.listInterest);
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: const Text('Change Category'),
              centerTitle: true,
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Choose your Favorite Category',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 5,
                      runSpacing: 5,
                      children: _listOfChips(),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                        width: size.width,
                        height: 40,
                        child: ElevatedButton(
                            onPressed: () => _onSaved(),
                            child: const Text('Save')))
                  ],
                ),
              ),
            )));
  }

  List<Widget> _listOfChips() {
    List<Widget> filter = [];
    Widget chip = Container();
    for (var item in listCategory) {
      var isSelected = _selectedCategory.contains(item);
      chip = FilterChip(
          label: Text(item),
          selectedColor: Colors.blue,
          labelStyle:
              TextStyle(color: isSelected ? Colors.white : Colors.black),
          selected: isSelected,
          checkmarkColor: Colors.white,
          elevation: isSelected ? 6 : 0,
          onSelected: (isSelected) => _viewModel.setSelectedCategory(item));
      filter.add(chip);
    }
    return filter;
  }

  _onSaved() {
    _viewModel.setListInterest(_selectedCategory);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      backgroundColor: Colors.teal,
      content: Text('Berhasil memperbarui category'),
      duration: Duration(seconds: 3),
    ));
    AppRoute.back();
  }
}

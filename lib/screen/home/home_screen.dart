import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:ggame/data/view_state.dart';
import 'package:ggame/models/home.dart';
import 'package:ggame/widgets/item_game.dart';
import 'package:ggame/screen/home/components/greetings_home.dart';
import 'package:ggame/res/array.dart';
import 'package:ggame/screen/home/components/platform_choice.dart';
import 'package:ggame/screen/profile/viewmodel/profile_viewmodel.dart';
import 'package:ggame/widgets/state_widget.dart';
import 'package:provider/provider.dart';

import 'components/choice_home.dart';
import 'viewmodel/home_viewmodel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> _listCategory = [];
  String _selectedItem = listDropDown[0];
  String _selectedCategory = 'All';
  late HomeViewModel _vm;
  bool _showFab = false;
  late ScrollController _scrollController;
  final Duration _duration = const Duration(microseconds: 300);

  @override
  void initState() {
    super.initState();
    Provider.of<HomeViewModel>(context, listen: false)
        .setListGame(Home(_selectedItem));
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    _vm = context.watch<HomeViewModel>();
    context.read<ProfileViewModel>().getProfile();
    return Scaffold(
      body: Container(
        width: size.width,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter, colors: baseGradient)),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      Selector<ProfileViewModel, String>(
                          builder: (context, name, child) =>
                              GreetingsHome(name: name),
                          selector: (context, viewmodel) => viewmodel.name),
                      PlatformChoice(
                        selectedPlatform: (selectedPlatform) {
                          _selectedItem = selectedPlatform;
                          _vm.setListGame(Home(_selectedItem,
                              listCategory: _listCategory,
                              category: _selectedCategory));
                        },
                      ),
                      Selector<ProfileViewModel, List<String>>(
                          builder: (context, listCategory, child) {
                            _listCategory = listCategory;
                            return ChoiceHome(
                              listCategory: listCategory,
                              selected: (selectedCategory) {
                                _selectedCategory = selectedCategory;
                                _vm.setListGame(Home(_selectedItem,
                                    listCategory: listCategory,
                                    category: selectedCategory));
                              },
                            );
                          },
                          selector: (context, viewmodel) =>
                              viewmodel.listInterest)
                    ],
                  ),
                ),
              ],
            ),
            NotificationListener<UserScrollNotification>(
              onNotification: (notification) {
                final ScrollDirection direction = notification.direction;
                setState(() {
                  if (direction == ScrollDirection.reverse) {
                    _showFab = false;
                  } else if (direction == ScrollDirection.forward) {
                    _showFab = true;
                  }
                });
                return true;
              },
              child: DraggableScrollableSheet(
                  initialChildSize: 0.55,
                  minChildSize: 0.55,
                  builder: (context, scrollController) {
                    _scrollController = scrollController;
                    return Container(
                      width: size.width,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30))),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Selector<HomeViewModel, ViewState>(
                          selector: (context, viewmodel) => viewmodel.state,
                          builder: (context, state, child) {
                            return StateWidget(
                              state: state,
                              child: _vm.listGame.isEmpty
                                  ? const Center(
                                      child: Text('Tidak ada data'),
                                    )
                                  : ListView.builder(
                                      controller: scrollController,
                                      physics: const BouncingScrollPhysics(),
                                      itemCount: _vm.listGame.length,
                                      itemBuilder: (context, index) {
                                        var game = _vm.listGame[index];
                                        return ItemGame(
                                          favorite: game.toFavorite(),
                                        );
                                      }),
                            );
                          },
                        ),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
      floatingActionButton: AnimatedSlide(
        duration: _duration,
        offset: _showFab ? Offset.zero : const Offset(0, 5),
        child: AnimatedOpacity(
          duration: _duration,
          opacity: _showFab ? 1 : 0,
          child: FloatingActionButton.small(
            onPressed: () => _scrollToTop(),
            child: const Icon(Icons.arrow_upward),
          ),
        ),
      ),
    );
  }

  void _scrollToTop() {
    _scrollController.animateTo(0,
        duration: const Duration(seconds: 1), curve: Curves.linear);
    setState(() {
      _showFab = false;
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}

import 'package:flutter/material.dart';
import 'package:ggame/screen/favorite/viewmodel/favorite_viewmodel.dart';
import 'package:ggame/screen/profile/component/item_settings.dart';
import 'package:ggame/res/array.dart';
import 'package:ggame/screen/splash_screen.dart';
import 'package:ggame/utils/app_route.dart';
import 'package:provider/provider.dart';

import 'viewmodel/profile_viewmodel.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    var viewmodel = context.read<ProfileViewModel>()..getProfile();
    var favViemodel = context.read<FavoriteViewModel>();
    return Scaffold(
        body: Stack(children: [
      SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            width: size.width,
            height: 200,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter, colors: baseGradient)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Center(
                child: Selector<ProfileViewModel, String>(
                  selector: (context, viewmodel) => viewmodel.name,
                  builder: (context, name, child) {
                    return Text(
                      name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white),
                    );
                  },
                ),
              ),
            ),
          ),
          const Padding(
              padding: EdgeInsets.only(top: 20, left: 16, bottom: 10),
              child: Text(
                'Setting',
                style: TextStyle(color: Colors.grey, fontSize: 16),
              )),
          ItemSettings(settings: listSettings[0]),
          ItemSettings(settings: listSettings[1]),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: GestureDetector(
                  onTap: () => _deleteProfile(viewmodel, context, favViemodel),
                  child: const Text(
                    'Remove my data',
                    style: TextStyle(color: Colors.grey),
                  )),
            ),
          )
        ]),
      ),
      SizedBox(
        height: 60,
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text('Profile'),
          centerTitle: true,
        ),
      )
    ]));
  }

  _deleteProfile(ProfileViewModel viewmodel, BuildContext context, FavoriteViewModel favViemodel) {
    viewmodel.deleteProfile();
    favViemodel.deleteAll();
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.red,
        content: Text('Berhasil menghapus data'),
        duration: Duration(seconds: 3),
      ));
    Future.delayed(const Duration(seconds: 3), () {
      AppRoute.clearAll(const SplashScreen());
    });
  }
}

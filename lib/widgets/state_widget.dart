import 'package:flutter/material.dart';
import 'package:ggame/data/view_state.dart';
import 'package:ggame/widgets/loading_widget.dart';

class StateWidget extends StatelessWidget {
  final ViewState state;
  final String? errorMsg;
  final Widget? child;
  const StateWidget({Key? key, required this.state, this.child, this.errorMsg})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (state == ViewState.loading) {
      return const LoadingWidget();
    } else if (state == ViewState.error) {
      return Center(child: Text(errorMsg ?? 'Terjadi Kesalahan'),);
    } else {
      return child ?? Container();
    }
  }
}

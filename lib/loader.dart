import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class Loader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height - 216,
        width: MediaQuery.of(context).size.width,
        child: SpinKitFadingCircle(
          size: 50,
          color: Colors.grey[500],
        ),
      ),
    );
  }
}

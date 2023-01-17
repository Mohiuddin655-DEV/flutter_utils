import 'package:flutter/material.dart';
import 'package:flutter_utils/core/widgets/lottie_view.dart';

import '../../../core/utils/enums/src_type.dart';

class LottieViewPage extends StatelessWidget {
  const LottieViewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: LottieView(
          src: imageUrl(SrcType.asset),
          width: size.width,
          height: size.height,
          //margin: const EdgeInsets.all(24),
          //borderRadius: BorderRadius.circular(10),
          //background: Colors.black,
          //foreground: Colors.red.withOpacity(0.5),
          //srcType: SrcType.network,
          //cacheMode: false,
          //fit: BoxFit.cover,
        ),
      ),
    );
  }
}

dynamic imageUrl(SrcType type) {
  switch (type) {
    case SrcType.detect:
      return "";
    case SrcType.asset:
      return "assets/images/background_shimmer.json";
    case SrcType.file:
      return "";
    case SrcType.memory:
      return "";
    case SrcType.network:
      //return "https://assets7.lottiefiles.com/packages/lf20_a7djbqn2.json";
      //return "https://assets7.lottiefiles.com/packages/lf20_LKXG6QRgtE.json";
      return "https://assets7.lottiefiles.com/packages/lf20_y6ogyrb1.json";
  }
}

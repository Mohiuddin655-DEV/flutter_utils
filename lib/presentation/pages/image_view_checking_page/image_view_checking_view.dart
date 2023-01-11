import 'package:flutter/material.dart';
import 'package:flutter_utils/core/widgets/image_view.dart';

class ImageViewPage extends StatelessWidget {
  const ImageViewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: ImageView(
          src: imageUrl(SrcType.asset),
          width: size.width * 0.5,
          //margin: const EdgeInsets.all(24),
          borderRadius: BorderRadius.circular(10),
          background: Colors.black,
          //foreground: Colors.red.withOpacity(0.5),
          //srcType: SrcType.network,
          //cacheMode: false,
          fit: BoxFit.cover,
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
      return "assets/images/image.jpeg";
    case SrcType.file:
      return "";
    case SrcType.memory:
      return "";
    case SrcType.network:
      return "https://i.ytimg.com/vi/q-OOARyubng/hq720.jpg?sqp=-oaymwEcCOgCEMoBSFXyq4qpAw4IARUAAIhCGAFwAcABBg==&rs=AOn4CLCC7sEk5GHTRbwOpY8FmeBviVOlaQ";
  }
}

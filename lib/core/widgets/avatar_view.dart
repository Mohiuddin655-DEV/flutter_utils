import 'package:flutter/material.dart';

class AvatarView extends StatelessWidget {
  final double width, height;
  final String url;
  final Color? background;

  const AvatarView({
    Key? key,
    this.width = 40,
    this.height = 40,
    required this.url,
    this.background,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: background ?? Colors.grey.withOpacity(0.5),
        shape: BoxShape.circle,
      ),
      child: Image.network(
        url,
        fit: BoxFit.fill,
      ),
    );
  }
}

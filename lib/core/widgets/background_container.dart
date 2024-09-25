import 'package:figma_news_app/core/utils/image_paths.dart';
import 'package:flutter/material.dart';

class BackgroundContainer extends StatelessWidget {
  const BackgroundContainer({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(ImagePaths.background),
          fit: BoxFit.cover,
        ),
      ),
      child: child,
    );
  }
}
